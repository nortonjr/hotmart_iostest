//
//  ViewModel.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 08/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ViewModel { }

protocol RxDisposableCompatible {
    var disposeBag: DisposeBag { get }
}
