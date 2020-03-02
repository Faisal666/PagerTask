//
//  BankCell.swift
//  PagerApp
//
//  Created by Faisal AlSaadi on 3/2/20.
//  Copyright © 2020 Faisal AlSaadi. All rights reserved.
//

import UIKit

class BankCell: UICollectionViewCell {
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
        customizeCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubViews() {
        initTitleLabel()
    }
    
    private func customizeCell() {
        self.backgroundColor = .white
    }
    
    private func initTitleLabel() {
        titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.anchor(centerX: centerXAnchor, centerY: centerYAnchor)
    }
    
    func setupModel(title: String) {
        titleLabel.text = title
    }
}
