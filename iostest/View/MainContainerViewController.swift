//
//  MainContainerViewController.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainContainerViewController: UIViewController {

    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var contentView: UIView!

    let disposeBag: DisposeBag = DisposeBag()

    var viewModel: MainContainerViewModel!

    weak var presentingView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        tabBar.rx.didSelectItem
            .subscribe(onNext: { (selectedItem) in
                self.viewModel.selectedTabBar(tab: selectedItem.tag)
            })
            .disposed(by: disposeBag)
    }

    func setup() {
        setupTabBarItems()
        setupTabBarSeparators()
        setupNavbarAppearence()

        showDashboard()
    }

    func showDashboard() {
        guard let view = presentingView else { return }
        view.frame = contentView.bounds
        contentView.addSubview(view)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: Layout

extension MainContainerViewController {

    fileprivate func setupNavbarAppearence() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.ic_dehaze(), style: .plain, target: self, action: #selector(showMenu))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }

    fileprivate func setupTabBarItems() {
        let messagesItem = tabBarItemFactory(image: R.image.ico_mensagem()!, tag: 0)
        let salesItem = tabBarItemFactory(image: R.image.ico_minhas_vendas()!, tag: 1)
        let notificationItem = tabBarItemFactory(image: R.image.ico_notificacoes()!, tag: 2)

        self.tabBar.items = [messagesItem, salesItem, notificationItem]
    }

    fileprivate func setupTabBarSeparators() {
        guard let itemsCountInt = self.tabBar.items?.count else { return }

        let itemsCountCGF = CGFloat(itemsCountInt)

        let screen = UIScreen.main.bounds
        let screenWidth = screen.size.width

        let itemWidth = screenWidth / itemsCountCGF
        let itemHeight = self.tabBar.frame.size.height * 0.60

        let separatorWidth = 0.5

        for i in 0...2 {
            let separator = UIView(frame: CGRect(x: itemWidth * CGFloat(i + 1), y: (tabBar.frame.size.height - itemHeight)/2, width: CGFloat(separatorWidth), height: itemHeight))

            separator.backgroundColor = UIColor.lightGray

            self.tabBar.addSubview(separator)
        }
    }

    func showMenu() {
        viewModel.coordinator.presentMenu()
    }

    fileprivate func tabBarItemFactory(image: UIImage, tag: Int) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: nil, image: image, tag: tag)
        tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 4, bottom: -4, right: -4)

        return tabBarItem
    }
}
