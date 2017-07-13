//
//  MenuItem.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 12/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MenuItem: ViewModel {
    var title: Driver<String> { get }
    var image: Driver<UIImage> { get }
    var counter: Driver<Int> { get }
}
