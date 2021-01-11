import Foundation

extension Bundle {

    enum BundleInfoKey: String {
        case baseURL = "BB_BASE_URL"
    }

    func getInfo<T>(for key: BundleInfoKey) -> T? {
        self.infoDictionary?[key.rawValue] as? T
    }
}
