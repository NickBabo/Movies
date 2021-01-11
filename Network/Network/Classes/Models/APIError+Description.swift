public extension APIError {

    var localizedDescription: String {
        switch self {
        case .noResponse: return Localized.string(.noResponseDescription)
        case .noData: return Localized.string(.noDataDescription)
        case .invalidBaseURL: return Localized.string(.invalidBaseURLDescription)
        case .decodingError: return Localized.string(.decodingErrorDescription)
        case .error(let statusCode):
            return Localized.formatted(string: .statusCodeErrorDescription,
                                         arguments: [statusCode.description])
        }
    }
}
