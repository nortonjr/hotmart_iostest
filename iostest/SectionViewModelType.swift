//
//  SectionViewModelType.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxDataSources

final class SectionedViewModelType<T> {

    let title: String?
    fileprivate let viewModels: [T]

    init(title: String? = nil, viewModels: [T]) {
        self.title = title
        self.viewModels = viewModels
    }
}

extension SectionedViewModelType: SectionModelType {

    typealias Item = T

    var items: [Item] {
        return viewModels
    }

    convenience init(original: SectionedViewModelType, items: [Item]) {
        self.init(title: original.title, viewModels: items)
    }
}
