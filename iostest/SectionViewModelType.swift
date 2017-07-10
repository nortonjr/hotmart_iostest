//
//  SectionViewModelType.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxDataSources

final class SectionViewModelType<T> {

    let title: String?
    fileprivate let viewModels: [T]

    init(title: String? = nil, viewModels: [T]) {
        self.title = title
        self.viewModels = viewModels
    }
}

extension SectionViewModelType: SectionModelType {

    typealias Item = T

    var items: [Item] {
        return viewModels
    }

    convenience init(original: SectionViewModelType, items: [Item]) {
        self.init(title: original.title, viewModels: items)
    }
}
