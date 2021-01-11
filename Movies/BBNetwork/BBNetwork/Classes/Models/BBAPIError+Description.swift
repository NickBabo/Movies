public extension BBAPIError {

    var localizedDescription: String {
        switch self {
        case .noResponse: return BBLocalized.string(.noResponseDescription)
        case .noData: return BBLocalized.string(.noDataDescription)
        case .invalidBaseURL: return BBLocalized.string(.invalidBaseURLDescription)
        case .decodingError: return BBLocalized.string(.decodingErrorDescription)
        case .error(let statusCode):
            return BBLocalized.formatted(string: .statusCodeErrorDescription,
                                         arguments: [statusCode.description])
        }
    }
}
