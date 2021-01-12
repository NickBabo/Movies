import Foundation

/// The delegate protocol grouping all required behaviours that the main application must implement
/// in order to serve the BBNetwork with the needed informatioon
public typealias BBNetworkDelegate = BBNetworkTokenDelegate

/// Protocol to be implemented by classes responsible for handling token authentication.
/// This protocol must be implemented outside of the BBNetwork module's scope.
/// This delegate is a part of the BBNetworkDelegate.
public protocol BBNetworkTokenDelegate: AnyObject {

    /// Bearer Token. Method called when the `BBNetwork`` needs an authentication token to perform a request.
    func getToken() -> String?
}
