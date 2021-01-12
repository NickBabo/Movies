protocol BBRequestExecuterProtocol {
    func execute(request: URLRequest, completion: BBAPIResult?)
}

final class BBRequestExecuter: BBRequestExecuterProtocol {
    private var successCodes: Range<Int> = 200..<299

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session
    }

    func execute(request: URLRequest, completion: BBAPIResult?) {
        BBNetworkLogger.log(request: request)

        let dataTask = session.task(with: request) { data, response, error in
            DispatchQueue.main.async {

                guard let response = response as? HTTPURLResponse else {
                    completion?(.failure(.noResponse))
                    return
                }

                BBNetworkLogger.log(data: data, response: response)

                guard self.successCodes.contains(response.statusCode) else {
                    completion?(.failure(.error(response.statusCode)))
                    return
                }

                guard let data = data else {
                    completion?(.failure(.noData))
                    return
                }

                completion?(.success(data))
            }
        }

        DispatchQueue.global().async {
            dataTask.resume()
        }
    }

}
