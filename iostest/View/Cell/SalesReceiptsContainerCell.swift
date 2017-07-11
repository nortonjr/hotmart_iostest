//
//  SalesReceiptsContainerCell.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class SalesReceiptsContainerCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    let disposeBag: DisposeBag = DisposeBag()

    fileprivate let dataSource = RxTableViewSectionedReloadDataSource<StaticCellSectionModelType>()
    fileprivate let tableCells: Variable<[UITableViewCell]> = Variable([])

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: Setup

extension SalesReceiptsContainerCell {

    fileprivate func setup() {
        setupTableView()
        setupReactiveTableView()
    }

    fileprivate func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorInset = .zero

        var staticCells: [UITableViewCell] = []

        for _ in 0...20 {
            let receiptCell: SaleReceiptCell = R.nib.saleReceiptCell.firstView(owner: self)!
            staticCells.append(receiptCell)
        }
        tableCells.value = staticCells
    }

    fileprivate func setupReactiveTableView() {
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
