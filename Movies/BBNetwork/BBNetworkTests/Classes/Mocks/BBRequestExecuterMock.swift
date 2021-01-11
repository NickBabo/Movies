@testable import BBNetwork

final class BBRequestExecuterMock: BBRequestExecuterProtocol {

    var calledWithRequest: URLRequest?

    private var mockedResult: Result<Data, BBAPIError>?

    func mock(_ result: Result<Data, BBAPIError>?) {
        self.mockedResult = result
    }

    func execute(request: URLRequest, completion: BBAPIResult?) {
        self.calledWithRequest = request

        if let mockedResult = mockedResult {
            completion?(mockedResult)
        }
    }
}
