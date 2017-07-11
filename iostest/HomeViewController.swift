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
import SnapKit

class HomeViewController: UIViewController {

    @IBOutlet weak var  tableView: UITableView!

    let disposeBag: DisposeBag = DisposeBag()

    fileprivate let dataSource = RxTableViewSectionedReloadDataSource<StaticCellSectionModelType>()
    fileprivate var tableCells: Variable<[UITableViewCell]> = Variable([])
    fileprivate var staticCells: [UITableViewCell] = []
    var viewModel: HomeViewModel!
    var totalHeight: CGFloat = 0.0
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
        tableView.estimatedRowHeight = 200
        tableView.delegate = self

        let dashboardHeaderCell: DashboardHeaderCell = R.nib.dashboardHeaderCell.firstView(owner: self)!
        staticCells.append(dashboardHeaderCell)
        totalHeight = totalHeight + dashboardHeaderCell.frame.size.height

        let recentMessagesCell: RecentMessagesCell = R.nib.recentMessagesCell.firstView(owner: self)!
        recentMessagesCell.viewModel = RecentMessagesViewModel()
        staticCells.append(recentMessagesCell)
        totalHeight = totalHeight + recentMessagesCell.frame.size.height

        let salesReceiptsContainerCell: SalesReceiptsContainerCell = R.nib.salesReceiptsContainerCell.firstView(owner: self)!
        staticCells.append(salesReceiptsContainerCell)

        tableCells.value = staticCells
    }

    fileprivate func setupReactiveTableView() {

        dataSource.configureCell = { (_, tableView, indexPath, cell) in

            guard let containerCell = cell as? SalesReceiptsContainerCell else { return cell }

            containerCell.tableViewHeightConstraint.constant = tableView.frame.size.height - self.totalHeight

            return containerCell
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
//        switch indexPath.item {
//        case 1:
//            return staticCells[0].frame.size.height
//        case 2:
//            return staticCells[1].frame.size.height
//        case 3:
//            return (tableView.frame.height) - (staticCells[0].frame.height + staticCells[1].frame.height)
//        default:
//            return 44
//        }
//    }
}
