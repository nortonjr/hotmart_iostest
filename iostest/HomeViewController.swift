//
//  HomeViewController.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HomeViewController: UIViewController {

    @IBOutlet weak var  tableView: UITableView!

    let disposeBag: DisposeBag = DisposeBag()

    fileprivate let dataSource = RxTableViewSectionedReloadDataSource<StaticCellSectionModelType>()
    fileprivate var tableCells: Variable<[UITableViewCell]> = Variable([])

    var viewModel: HomeViewModel!
}

// MARK: Life Cycle

extension HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        setup()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: Setup

extension HomeViewController {

    fileprivate func setup() {

//        setupBinds()
        setupTableView()
        setupReactiveTableView()
    }

    fileprivate func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 141
        tableView.separatorInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)

        var staticCells: [UITableViewCell] = []

        let dashboardHeaderCell: DashboardHeaderCell = R.nib.dashboardHeaderCell.firstView(owner: self)!
        staticCells.append(dashboardHeaderCell)

        let recentMessagesCell: RecentMessagesCell = R.nib.recentMessagesCell.firstView(owner: self)!
        staticCells.append(recentMessagesCell)

        let salesReceiptCell: SaleReceiptCell = R.nib.saleReceiptCell.firstView(owner: self)!
        staticCells.append(salesReceiptCell)

        tableCells.value = staticCells
    }

    fileprivate func setupReactiveTableView() {
        dataSource.configureCell =  { (_, _, _, cell) in
            return cell
        }

        tableCells.asObservable()
            .map { [StaticCellSectionModelType(cells: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag )
    }
}
