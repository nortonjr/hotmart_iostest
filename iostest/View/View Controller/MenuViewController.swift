//
//  MenuViewController.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 12/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MenuViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()

    fileprivate let dataSource = RxTableViewSectionedReloadDataSource<SectionViewModelType<MenuItem>>()
    fileprivate let tableCells: Variable<[UITableViewCell]> = Variable([])

    var viewModel: MenuViewModel!

    override func viewWillLayoutSubviews() {
        avatar.layer.cornerRadius = self.avatar.frame.size.width/2
        avatar.clipsToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

// MARK: Setup

extension MenuViewController {

    func setup() {
        setupTableView()
        setupReactiveTableView()
    }

    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorInset = .zero

        tableView.register(R.nib.menuItemCell)
    }

    func setupReactiveTableView() {
        dataSource.configureCell = { (_, tableView, indexPath, viewModel) in
            if let viewModel = viewModel as? MenuItemViewModel {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.menuItemCell, for: indexPath)!

                cell.viewModel = viewModel

                cell.tapHandler = { [unowned self] action in
                    self.viewModel.executeAction(type: action)
                }

                return cell
            }

            return UITableViewCell()
        }

        viewModel.items
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
