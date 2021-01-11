import Foundation

/// The delegate protocol grouping all required behaviours that the main application must implement
/// in order to serve the Network with the needed informatioon
public typealias NetworkDelegate = NetworkTokenDelegate

/// Protocol to be implemented by classes responsible for handling token authentication.
/// This protocol must be implemented outside of the Network module's scope.
/// This delegate is a part of the NetworkDelegate.
public protocol NetworkTokenDelegate: AnyObject {

    /// Bearer Token. Method called when the `Network`` needs an authentication token to perform a request.
    func getToken() -> String?
}
