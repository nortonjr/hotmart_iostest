//
//  SalesViewController.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 11/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SalesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    fileprivate let dataSource = RxTableViewSectionedReloadDataSource<StaticCellSectionModelType>()
    fileprivate let tableCells: Variable<[UITableViewCell]> = Variable([])

    let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

// MARK: Setup

extension SalesViewController {

    func setup() {
        setupTableView()
        setupReactiveTableView()
    }

    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorInset = .zero

        var staticCells: [UITableViewCell] = []

        for _ in 0...30 {
            let receiptCell: SaleReceiptCell = R.nib.saleReceiptCell.firstView(owner: self)!
            staticCells.append(receiptCell)
        }
        tableCells.value = staticCells
    }

    func setupReactiveTableView() {
        dataSource.configureCell = { (_, tableView, indexPath, cell) in
            guard let receiptCell = cell as? SaleReceiptCell else { return cell }

            if (indexPath.item % 2) == 0 {
                receiptCell.containerView.backgroundColor = 0xf4f4f4.color
            }
            else {
                receiptCell.containerView.backgroundColor = UIColor.white
            }
            return receiptCell
        }

        tableCells.asObservable()
            .map { [StaticCellSectionModelType(cells: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
