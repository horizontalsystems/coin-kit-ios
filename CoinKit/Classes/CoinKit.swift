import RxSwift

public class CoinKit {
    private var disposeBag = DisposeBag()
    private let coinManager: CoinManager
    private let coinExternalIdManager: CoinProviderManager
    private let storage: GrdbStorage

    public var coinMigrationObservable: Observable<[Coin]>? {
        didSet {
            subscribeMigration()
        }
    }

    private init(coinManager: CoinManager, coinExternalIdManager: CoinProviderManager, storage: GrdbStorage) {
        self.coinManager = coinManager
        self.coinExternalIdManager = coinExternalIdManager

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

    private func subscribeMigration() {
        disposeBag = DisposeBag()

        coinMigrationObservable?.subscribe(onNext:{ [weak self] coins in
            if !coins.isEmpty {
                self?.coinManager.save(coins: coins)
            }
        }).disposed(by: disposeBag)
    }

}

extension CoinKit {

    static var bundle: Bundle? {
        Bundle(for: CoinKit.self).url(forResource: "CoinKit", withExtension: "bundle").flatMap { Bundle(url: $0) }
    }

    public static func defaultCoins(testNet: Bool) -> [Coin] {
        (try? CoinProvider(parser: JsonParser(), testNet: testNet).defaultCoins().coins) ?? []
    }

}

extension CoinKit {

    public static func instance(testNet: Bool = false) throws -> CoinKit {
        let storage = try GrdbStorage(databaseDirectoryUrl: databaseDirectoryUrl(), databaseFileName: "coin-kit-db")

        let coinProvider = CoinProvider(parser: JsonParser(), testNet: testNet)
        let coinManager = CoinManager(coinProvider: coinProvider, storage: storage)

        let coinExternalIdProvider = CoinExternalIdProvider(parser: JsonParser())
        let coinExternalIdManager = CoinProviderManager(coinProvider: coinExternalIdProvider, storage: storage)

        return CoinKit(coinManager: coinManager, coinExternalIdManager: coinExternalIdManager, storage: storage)
    }

}

extension CoinKit {

    public func providerId(id: String, provider: Provider) -> String? {
        coinExternalIdManager.providerId(id: id, providerName: provider.rawValue)
    }

    public func id(providerId: String, provider: Provider) -> String? {
        coinExternalIdManager.id(providerId: providerId, providerName: provider.rawValue)
    }

    public var coins: [Coin] {
        coinManager.coins
    }

    public func save(coin: Coin) {
        coinManager.save(coins: [coin])
    }

    public func coin(id: String) -> Coin? {
        coinManager.coin(id: id)
    }

    public func coin(type: CoinType) -> Coin? {
        coinManager.coin(id: type.id)
    }

}
