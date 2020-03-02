//
//  SinglePageViewController.swift
//  PagerApp
//
//  Created by Faisal AlSaadi on 3/2/20.
//  Copyright © 2020 Faisal AlSaadi. All rights reserved.
//

import UIKit

class SinglePageViewController: UIViewController {
    
    private var imageView: UIImageView!
    private var subTitleLabel: UILabel!
    private var stackView: UIStackView!
    
    init(image: UIImage, subTitle: String) {
        super.init(nibName: nil, bundle: nil)
        initSubViews()
        setupData(image: image, subTitle: subTitle)
        customizeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func customizeView() {
        self.view.backgroundColor = .white
    }
    
    private func initSubViews() {
        initImageView()
        initSubTitleLabel()
        initStackView()
        setupViews()
    }
    
    private func initImageView() {
        imageView = UIImageView()
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    private func initSubTitleLabel() {
        subTitleLabel = UILabel()
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = .darkGray
    }
    
    private func initStackView() {
        stackView = UIStackView(arrangedSubviews: [imageView, subTitleLabel])
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        self.view.addSubview(stackView)
    }
    
    private func setupViews() {
        stackView.anchor(centerX: self.view.centerXAnchor, centerY: self.view.centerYAnchor)
        imageView.anchor(size: CGSize(width: 200, height: 200))
    }
    
    private func setupData(image: UIImage, subTitle: String) {
        imageView.image = image
        subTitleLabel.text = subTitle
    }
}
