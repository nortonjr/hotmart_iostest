//
//  StaticCellSectionModelType.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import RxDataSources

final class StaticCellSectionModelType {

    fileprivate var cells: [UITableViewCell]

    init(cells: [UITableViewCell]) {
        self.cells = cells
    }
}

extension StaticCellSectionModelType: SectionModelType {

    typealias Item = UITableViewCell

    var items: [Item] {
        return cells
    }

    convenience init(original: StaticCellSectionModelType, items: [Item]) {
        self.init(cells: items)
    }
}
