//
//  Presentable.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {

    func toPresent() -> UIViewController? {
        return self
    }
}
