import Foundation
import BBNetwork

class BBNetworkDelegateMock: BBNetworkDelegate {

    func getToken() -> String? {
        "token_mock"
    }
}
