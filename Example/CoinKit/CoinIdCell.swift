import UIKit

class CoinIdCell: UITableViewCell {
    private let idLabel = UILabel()
    private let geckoLabel = UILabel()
    private let compareLabel = UILabel()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(idLabel)
        idLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(16)
            maker.top.equalToSuperview().inset(8)
        }

        idLabel.font = .boldSystemFont(ofSize: 14)
        idLabel.textColor = .black

        contentView.addSubview(geckoLabel)
        geckoLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(32)
            maker.top.equalTo(idLabel.snp.bottom).offset(4)
        }

        geckoLabel.font = .systemFont(ofSize: 13)
        geckoLabel.textColor = .black

        contentView.addSubview(compareLabel)
        compareLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(32)
            maker.top.equalTo(geckoLabel.snp.bottom).offset(4)
        }

        compareLabel.font = .systemFont(ofSize: 13)
        compareLabel.textColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var idTitle: String? {
        get { idLabel.text }
        set { idLabel.text = newValue }
    }

    var geckoTitle: String? {
        get { geckoLabel.text }
        set { geckoLabel.text = "CoinGecko: \(newValue ?? "N/A")" }
    }

    var compareTitle: String? {
        get { compareLabel.text }
        set { compareLabel.text = "CryptoCompare: \(newValue ?? "N/A")" }
    }

}
