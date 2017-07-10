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
        setup()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: Setup

extension HomeViewController {

    fileprivate func setup() {

        setupTableView()
        setupReactiveTableView()
    }

    fileprivate func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorInset = .zero
        tableView.delegate = self

        var staticCells: [UITableViewCell] = []

        let dashboardHeaderCell: DashboardHeaderCell = R.nib.dashboardHeaderCell.firstView(owner: self)!
        staticCells.append(dashboardHeaderCell)

        let recentMessagesCell: RecentMessagesCell = R.nib.recentMessagesCell.firstView(owner: self)!
        recentMessagesCell.viewModel = RecentMessagesViewModel()
        staticCells.append(recentMessagesCell)

        let salesReceiptsContainerCell: SalesReceiptsContainerCell = R.nib.salesReceiptsContainerCell.firstView(owner: self)!
        staticCells.append(salesReceiptsContainerCell)

        tableCells.value = staticCells
    }

    fileprivate func setupReactiveTableView() {
        dataSource.configureCell = { (_, _, _, cell) in
            return cell
        }

        tableCells.asObservable()
            .map { [StaticCellSectionModelType(cells: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag )
    }
}

// MARK: Table View delegate

extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }
}
