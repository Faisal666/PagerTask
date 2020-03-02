//
//  BoardingViewController.swift
//  PagerApp
//
//  Created by Faisal AlSaadi on 3/2/20.
//  Copyright © 2020 Faisal AlSaadi. All rights reserved.
//

import UIKit

class BoardingViewController: UIPageViewController {

    lazy var pagesViewControllers: [UIViewController] = {
        return [
            SinglePageViewController(image: #imageLiteral(resourceName: "Image1.jpg"), subTitle: "Page one"),
            SinglePageViewController(image: #imageLiteral(resourceName: "Image2.jpg"), subTitle: "Page two"),
            SinglePageViewController(image: #imageLiteral(resourceName: "Image3.jpg"), subTitle: "Page theree"),
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageController()
    }
    
    private func setupPageController() {
        self.delegate = self
        self.dataSource = self
        self.setViewControllers([pagesViewControllers[0]], direction: .forward, animated: true, completion: nil)
        self.view.backgroundColor = .white
    }
}

extension BoardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var prevoiusIndex: Int = pagesViewControllers.firstIndex(of: viewController) ?? 0
        prevoiusIndex -= 1
        guard prevoiusIndex >= 0 else {
            return nil
        }
        return pagesViewControllers[prevoiusIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var nextIndex: Int = pagesViewControllers.firstIndex(of: viewController) ?? 0
        nextIndex += 1
        guard nextIndex < pagesViewControllers.count else {
            return nil
        }
        return pagesViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pagesViewControllers.count
    }
}
