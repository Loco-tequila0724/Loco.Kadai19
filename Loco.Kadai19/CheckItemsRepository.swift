import Foundation

struct CheckItem: Codable {
    var name: String
    var isChecked: Bool
}

struct CheckItemsRepository {
    private let checkItemKey = "checkItemKey"

    func save(item: [CheckItem]) -> Bool {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? jsonEncoder.encode(item) else { return false }
        UserDefaults.standard.set(data, forKey: checkItemKey)
        return true
    }

    func load() -> [CheckItem]? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = UserDefaults.standard.data(forKey: checkItemKey),
            let checkItem = try? jsonDecoder.decode([CheckItem].self, from: data) else { return nil }
        return checkItem
    }
}
