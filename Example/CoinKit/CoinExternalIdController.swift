import UIKit
import SnapKit
import RxSwift
import CoinKit

class CoinExternalIdController: UIViewController {
    private let disposeBag = DisposeBag()
    private let coinKit: CoinKit
    private var coinTypes = [CoinType]()

    private let tableView = UITableView(frame: .zero, style: .plain)

    init(coinKit: CoinKit) {
        self.coinKit = coinKit

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Coin Ids"

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinCell.self, forCellReuseIdentifier: String(describing: CoinCell.self))

        initCoins()
    }

    private func initCoins() {
        coinTypes = [.bitcoin,
                     .bitcoinCash,
                     .dash,
                     .ethereum,
                     .erc20(address: "0xeb269732ab75a6fd61ea60b06fe994cd32a83549"),
                     .bep2(symbol: "CAS-167"),
                     .binanceSmartChain,
                     .bep20(address: "0x78650b139471520656b9e7aa7a5e9276814a38e9")
        ]

        tableView.reloadData()
    }

}

extension CoinExternalIdController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coinTypes.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CoinCell.self)) {
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CoinCell, coinTypes.count > indexPath.row else {
            return
        }

        let coinId = coinTypes[indexPath.row].rawValue
        cell.topTitle = coinId
        cell.middleTitle = "CoinGecko: \(coinKit.providerId(id: coinId, provider: .coinGecko) ?? "N/A")"
        cell.bottomTitle = "CryptoCompare: \(coinKit.providerId(id: coinId, provider: .cryptoCompare) ?? "N/A")"

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

}
