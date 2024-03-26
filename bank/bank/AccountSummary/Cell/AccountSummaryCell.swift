//
//  AccountSummaryCell.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/26.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var balanceAmountLabel: UILabel!
         
    static let identifier = "AccountSummaryCell"
    static let height: CGFloat = 112
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "929,466", cents: "23")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1), ]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttribute)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
    
    func configure(with accountModel: AccountModel) {
        accountTypeLabel.text = accountModel.accountType.rawValue
        accountNameLabel.text = accountModel.accountName
//        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: <#T##String#>, cents: <#T##String#>)
        
        switch accountModel.accountType {
        case .Banking:
            underlineView.backgroundColor = CustomColors.appColor
            balanceLabel.text = "Currenct balance"
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Balance"
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}
