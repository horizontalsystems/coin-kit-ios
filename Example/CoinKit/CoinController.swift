import UIKit
import SnapKit
import RxSwift
import CoinKit

class CoinController: UIViewController {
    private let disposeBag = DisposeBag()
    private let coinKit: CoinKit
    private var coinTypes = [CoinType]()

    private let tableView = UITableView(frame: .zero, style: .plain)

    init() {
        coinKit = try! CoinKit.instance()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Coins"


        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinIdCell.self, forCellReuseIdentifier: String(describing: CoinIdCell.self))

        initCoins()
    }

    private func initCoins() {
        coinTypes = [.bitcoin,
                     .bitcoinCash,
                     .dash,
                     .ethereum,
                     .erc20(address: "0xeb269732ab75a6fd61ea60b06fe994cd32a83549"),
                     .binance(symbol: "CAS-167")]

        tableView.reloadData()
    }

}

extension CoinController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coinTypes.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CoinIdCell.self)) {
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CoinIdCell, coinTypes.count > indexPath.row else {
            return
        }

        let coinId = coinTypes[indexPath.row].rawValue
        cell.idTitle = coinId
        cell.geckoTitle = coinKit.providerId(id: coinId, providerName: "coingecko")
        cell.compareTitle = coinKit.providerId(id: coinId, providerName: "cryptocompare")

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

}
