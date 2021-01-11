import BBNetwork

struct ServiceMock: BBServiceProtocol, Buildable {

    var path: String = "example/path"
    var method: BBHTTPMethod = .get
    var parameters: Encodable? = ParameterMock()
    var headers: [String: String]? = ["header": "example"]
    var queryParameters: [String: String]?
    var needsToken: Bool = false
}

class ParameterMock: Encodable {
    var parameter: String = "Example"
}
