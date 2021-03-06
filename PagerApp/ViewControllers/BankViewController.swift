//
//  BankViewController.swift
//  PagerApp
//
//  Created by Faisal AlSaadi on 3/2/20.
//  Copyright © 2020 Faisal AlSaadi. All rights reserved.
//

import UIKit

class BankViewController: UIViewController {
    private var containerView: UIView!
    private var collectionView: UICollectionView!
    private var bottomBorderLeadingConstrains: NSLayoutConstraint!
    private var currView: ViewType = .control
    private var stackView: UIStackView!
    private var stackViewBackgroundImageView: UIImageView!
    private var controlButton: UIButton!
    private var statementsButton: UIButton!
    private var chargeButton: UIButton!
    private var iconImageView: UIImageView!
    private var bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private enum ViewType: Int, CaseIterable {
        case control = 0, statements, charge
        
        var description: String {
            get {
                switch self {
                case .control:
                    return "Balance Control"
                case .statements:
                    return "Statement and transaction"
                case .charge:
                    return "Balance and charge"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackViewBackgroundImageView?.roundCorners(corners: [.topRight, .topLeft], radius: 9)
    }
    
    private func initSubviews() {
        initStackButtons(&controlButton, type: .control)
        initStackButtons(&statementsButton, type: .statements)
        initStackButtons(&chargeButton, type: .charge)
        initIconImage()
        initCollectionView()
        initStackViewBackgroundImageView()
        initStackView()
        initBottomBorder()
        setButtons()
        setupViews()
        self.view.backgroundColor = .lightGray
    }
    
    private func initStackButtons(_ button: inout UIButton?, type: ViewType) {
        button = UIButton()
        button?.setTitle(type.description, for: .normal)
        button?.setTitleColor(.white, for: .normal)
        button?.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button?.titleLabel?.numberOfLines = 2
        button?.titleLabel?.lineBreakMode = .byWordWrapping
        button?.titleLabel?.textAlignment = .center
    }
    
    private func initIconImage(){
        iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "add-story-icon")
        iconImageView.contentMode = .scaleAspectFit
    }
    
    private func setButtons() {
        controlButton?.isSelected = true
        controlButton?.addTarget(self, action: #selector(controlButtonClicked), for: .touchUpInside)
        statementsButton?.addTarget(self, action: #selector(statementsButtonClicked), for: .touchUpInside)
        chargeButton?.addTarget(self, action: #selector(chargeButtonClicked), for: .touchUpInside)
    }
    
    private func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .gray
        collectionView.layer.cornerRadius = 9
        collectionView.clipsToBounds = true
        registerCells()
        view.addSubview(collectionView)
    }
    
    private func registerCells(){
        collectionView.register(BankCell.self, forCellWithReuseIdentifier: "bankCell")
    }
    
    private func initStackView() {
        stackView = UIStackView(arrangedSubviews: [createButtonIconView(button: controlButton, image: UIImage(named: "add-story-icon") ?? UIImage()),
                                                   createButtonIconView(button: statementsButton, image: UIImage(named: "add-story-icon") ?? UIImage()),
                                                   createButtonIconView(button: chargeButton, image: UIImage(named: "add-story-icon") ?? UIImage())])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
    }
    
    private func initStackViewBackgroundImageView() {
        stackViewBackgroundImageView = UIImageView()
        stackViewBackgroundImageView.image = UIImage(named: "Image1")
        stackViewBackgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(stackViewBackgroundImageView)
    }
    
    private func createButtonIconView(button: UIButton, image: UIImage) -> UIView {
        let view = UIView()
        view.addSubview(button)
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.anchor(leading: view.leadingAnchor, centerY: view.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0), size: CGSize(width: 16, height: 16))
        button.anchor(top: view.topAnchor, leading: imageView.trailingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        return view
    }
    
    private func initBottomBorder() {
        stackView.addSubview(bottomBorder)
    }
    
    private func setupViews() {
        stackView.anchor(top: collectionView.topAnchor,
                         leading: collectionView.leadingAnchor,
                         trailing: collectionView.trailingAnchor,
                         size: CGSize(width: 0, height: 60.0))
        
        bottomBorderLeadingConstrains = bottomBorder.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0)
        bottomBorderLeadingConstrains.isActive = true
        let borderHeight: CGFloat = 2.0
        bottomBorder.anchor(top: nil, leading: nil, bottom: stackView.bottomAnchor, trailing: nil,
                            size: CGSize(width: floor((view.frame.width * 0.8) / 3), height: borderHeight))
        
        collectionView.anchor(centerX: self.view.centerXAnchor,
                              centerY: self.view.centerYAnchor,
                              size: CGSize(width: view.frame.width * 0.8,
                                           height: view.frame.height * 0.5))
        stackViewBackgroundImageView.anchor(top: stackView.topAnchor,
                                            leading: stackView.leadingAnchor,
                                            bottom: bottomBorder.bottomAnchor,
                                            trailing: stackView.trailingAnchor)
    }
    
    @objc func controlButtonClicked(sender: UIButton) {
        controlButton.isSelected = true
        statementsButton.isSelected = false
        chargeButton.isSelected = false
        scrollToCell(viewType: .control)
    }
    
    @objc func statementsButtonClicked(sender: UIButton) {
        controlButton.isSelected = false
        statementsButton.isSelected = true
        chargeButton.isSelected = false
        scrollToCell(viewType: .statements)
    }
    
    @objc func chargeButtonClicked(sender: UIButton) {
        controlButton.isSelected = false
        statementsButton.isSelected = false
        chargeButton.isSelected = true
        scrollToCell(viewType: .charge)
    }
    
    private func scrollToCell(viewType: ViewType) {
        currView = viewType
        collectionView.scrollToItem(at: IndexPath(item: viewType.rawValue, section: 0), at: .left, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat  = scrollView.contentOffset.x / 3
        bottomBorderLeadingConstrains.constant = offset
        
        if offset == 0 {
            controlButton.isSelected = true
            statementsButton.isSelected = false
            chargeButton.isSelected = false
        } else if offset == view.frame.width / 3 {
            controlButton.isSelected = false
            statementsButton.isSelected = true
            chargeButton.isSelected = false
        } else if offset == view.frame.width * (2 / 3) {
            controlButton.isSelected = false
            statementsButton.isSelected = false
            chargeButton.isSelected = true
        }
    }
}

extension BankViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bankCell", for: indexPath) as! BankCell
        if let description = ViewType(rawValue: indexPath.item)?.description {
            cell.setupModel(title: description)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.height - 60
        let width: CGFloat = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
    }
}
