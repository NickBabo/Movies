import Foundation

/// Protocol that represents a service (or request) that can be executed by the BBNetwork module.
public protocol BBServiceProtocol {
    /// Represents the resource's path, excluding the base URL.
    var path: String { get }
    /// Represents the resource's HTTP method to be used.
    var method: BBHTTPMethod { get }
    /// Represents the data that will be encoded into the body of the request.
    var parameters: Encodable? { get }
    /// Represents the dictionary that will be passed as Headers of the request.
    var headers: [String: String]? { get }
    /// Represents the dictionary of parameters that will be added to the end of the path, as query parameters.
    var queryParameters: [String: String]? { get }
    /// The `needsToken` determines if a service needs the `Authorization` header to be sent.
    /// If `true`, an implementation of the `BBNetworkDelegate`'s method `getToken()` will be called
    /// in order to create the correct Authorization header.
    var needsToken: Bool { get }
}
