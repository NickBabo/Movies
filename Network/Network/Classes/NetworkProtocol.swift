import Foundation

/// Main interface to be used for performing requests.
/// Utilize the `NetworkProtocol.request(_:responseType:completion:)` to execute requests.
public protocol NetworkProtocol {
    /// The delegate object that will be called to handle operations outside of the Network module's scope,
    /// such as authentication token handling. Please use the method `Network.set(delegate:)` to setup this delegate.
    var delegate: NetworkDelegate? { get set }
    //swiftlint:disable line_length
    /// Executes a request that is configured using the given Service as reference. The base URL for the request will be fetched from the main Bundle (and will return a .invalidBaseURL error should it not be found). After the request is executed, once the Module receives a response, it will execute the given completion. A request is deemed successful if the status code on it's response is between 200 and 299. This method's `Result.success` completion returns and already decoded object, of the type passed in the `responseType` parameter. A `APIError.decodingError` will be returned if the decoding is not successful.
    /// - Parameter service: The service that will be used to configure the URLRequest to be executed. Must conform to `ServiceProtocol`.
    /// - Parameter responseType: The type in which the response data will be attempted to be decoded into. If the decoding is not successful, the completion will be executed with a failure and a `APIError.decodingError` will be returned.
    /// - Parameter completion: The completion that will be executed once a response is obtained. A request is deemed successful if the status code on it's response is between 200 and 299.
    func request<T: Decodable>(_ service: ServiceProtocol,
                               responseType: T.Type,
                               completion: @escaping (Result<T, APIError>) -> Void)
}

/// Protocol defining objects that can perform a request given a `ServiceProtocol` to serve as reference.
public protocol ServiceRequester {
    /// See `Network.request(_:_:)`
    func request(_ service: ServiceProtocol, _ completion: @escaping APIResult)
}

public extension NetworkProtocol where Self: ServiceRequester {
    func request<T: Decodable>(_ service: ServiceProtocol,
                               responseType: T.Type,
                               completion: @escaping (Result<T, APIError>) -> Void) {

        self.request(service) { result in
            switch result {
            case .success(let data):
                if let object: T = self.decode(data) {
                    completion(.success(object))
                } else {
                    completion(.failure(.decodingError))
                }
            case .failure(let error):
                NetworkLogger.log(error: error)
                completion(.failure(error))
            }
        }
    }

    private func decode<T: Decodable>(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let object = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        return object
    }
}
