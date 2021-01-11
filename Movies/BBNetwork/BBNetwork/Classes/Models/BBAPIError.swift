import Foundation

/// Enumeration defining the possible errors to be returned in the completion of a request.
public enum BBAPIError: Error, Equatable {
    case noResponse
    case noData
    /// Returned when BBNetwork is unable to decode the data response into the specified object.
    /// You can utilize the `BBNetwork.request(...)` to bypass the decoding step.
    case decodingError
    /// Returned when BBNetwork is unable to fetch the base URL to be used.
    /// The base URL must be configured in a `.xcconfig` file by defining the `BB_BASE_URL` variable.
    case invalidBaseURL
    /// Returned when the response's status code is not a success code.
    /// - Parameter statusCode: The status code received in the response
    case error(_ statusCode: Int)
}
