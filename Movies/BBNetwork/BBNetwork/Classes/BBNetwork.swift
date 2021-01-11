import Foundation

/// A customization of `Swift.Result` type which returns a `Data` object on success and a `BBAPIError` on failure
public typealias BBAPIResult = (Result<Data, BBAPIError>) -> Void

/// Object utilized for configuring and executing requests. Access it by using the `BBNetwork.shared` property.
public class BBNetwork: BBNetworkProtocol {

    private let referenceBundle: Bundle
    private let requestExecuter: BBRequestExecuterProtocol
    /// The delegate object that will be called to handle operations outside of the BBNetwork module's scope,
    /// such as authentication token handling. Please use the method `BBNetwork.set(delegate:)` to setup this delegate.
    public weak var delegate: BBNetworkDelegate?

    private static var sharedInstance: BBNetworkProtocol = {
        let session = URLSession(configuration: sessionConfig)
        return BBNetwork(requestExecuter: BBRequestExecuter(session: session))
    }()

    /// Singleton instance of BBNetwork. Use this shared instance to communicate with the `BBNetwork` module.
    public static var shared: BBNetworkProtocol {
        sharedInstance
    }

    private(set) static var sessionConfig: URLSessionConfiguration = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60.0
        sessionConfig.timeoutIntervalForResource = 80.0
        return sessionConfig
    }()

    var baseURL: URL? {
        guard let url: String = referenceBundle.getInfo(for: .baseURL),
            let baseURL = URL(string: url) else {
                return nil
        }
        return baseURL
    }

    init(requestExecuter: BBRequestExecuterProtocol,
         bundle: Bundle = .main) {
        self.requestExecuter = requestExecuter
        self.referenceBundle = bundle
    }

    /// Sets up a delegate object for the BBNetwork's shared instance.
    /// - Parameter delegate: An object conforming to the `BBNetworkDelegate` protocol.
    /// Responsible for handling anything needed for a request that is outside the BBNetwork module's scope,
    /// such as authentication token handling.
    public static func set(delegate: BBNetworkDelegate) {
        BBNetwork.sharedInstance.delegate = delegate
    }
}

// MARK: BBNetwork - ServiceRequester

extension BBNetwork: ServiceRequester {

    /// Executes a request based on the service passed. The service must conform to `BBServiceProtocol`.
    /// - Parameter service: Service object. Serves for configuring the request to be executed.
    /// - Parameter completion: The completion that will be executed when BBNetwork receives a response.
    /// This completion will return a data object on it's success case.
    /// If you wish to receive an already decoded object,
    /// please use the `BBNetworkProtocol.request(_:responseType:completion:)` function
    public func request(_ service: BBServiceProtocol,
                        _ completion: @escaping (Result<Data, BBAPIError>) -> Void) {

        guard let baseURL = baseURL else {
            completion(.failure(.invalidBaseURL))
            return
        }

        let request = BBRequestConfigurator(baseURL: baseURL,
                                            delegate: delegate).configure(service)

        requestExecuter.execute(request: request,
                                completion: completion)
    }
}
