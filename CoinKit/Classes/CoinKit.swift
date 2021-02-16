import RxSwift


public class CoinKit {
    private let coinProviderManager: CoinProviderManager
    private let storage: GrdbStorage

    private init(coinProviderManager: CoinProviderManager, storage: GrdbStorage) {
        self.coinProviderManager = coinProviderManager
        self.storage = storage
    }

    private static func databaseDirectoryUrl() throws -> URL {
        let fileManager = FileManager.default

        let url = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("coin-kit", isDirectory: true)

        try fileManager.createDirectory(at: url, withIntermediateDirectories: true)

        return url
    }

}

extension CoinKit {

    static var bundle: Bundle? {
        Bundle(for: CoinKit.self).url(forResource: "CoinKit", withExtension: "bundle").flatMap { Bundle(url: $0) }
    }

}

extension CoinKit {

    public static func instance() throws -> CoinKit {
        let storage = try GrdbStorage(databaseDirectoryUrl: databaseDirectoryUrl(), databaseFileName: "coin-kit-db")
        let coinProvider = CoinExternalIdProvider(parser: JsonParser())
        let coinProviderManager = CoinProviderManager(coinProvider: coinProvider, storage: storage)

        return CoinKit(coinProviderManager: coinProviderManager, storage: storage)
    }

}

extension CoinKit {

    public func providerId(id: String, providerName: String) -> String? {
        coinProviderManager.providerId(id: id, providerName: providerName)
    }

    public func id(providerId: String, providerName: String) -> String? {
        coinProviderManager.id(providerId: providerId, providerName: providerName)
    }

}
