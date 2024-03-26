//
//  AccountSummaryCell.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/26.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    @IBOutlet weak var accountTypeLabel: UILabel!
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
        let dollarString = NSMutableAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSMutableAttributedString(string: cents, attributes: centAttributes)
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
    
}
