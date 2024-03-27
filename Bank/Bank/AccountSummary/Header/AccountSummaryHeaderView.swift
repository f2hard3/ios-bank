//
//  AccountSummaryHeaderView.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/26.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func setupViews() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self)
        
        let shakyBellView = ShakeyBellView()
        shakyBellView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        addSubview(shakyBellView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = CustomColors.appColor
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shakyBellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shakyBellView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(model: AccountSummaryHeaderModel) {
        welcomeLabel.text = model.welcomeMessage
        nameLabel.text = model.name
        dateLabel.text = model.dateFormmated
    }
}
