import UIKit
import SnapKit
import RxSwift
import CoinKit

class CoinController: UIViewController {
    private let disposeBag = DisposeBag()
    private let coinKit: Kit
    private var coins = [Coin]()

    private let tableView = UITableView(frame: .zero, style: .plain)

    init(coinKit: Kit) {
        self.coinKit = coinKit

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
        tableView.register(CoinCell.self, forCellReuseIdentifier: String(describing: CoinCell.self))

        initCoins()
    }

    private func initCoins() {
        coins = Array(coinKit.coins.prefix(20))

        tableView.reloadData()
    }

}

extension CoinController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CoinCell.self)) {
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CoinCell, coins.count > indexPath.row else {
            return
        }

        let coin = coins[indexPath.row]

        cell.topTitle = coin.id
        cell.middleTitle = coin.title
        cell.bottomTitle = coin.code
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

}
