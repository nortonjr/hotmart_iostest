//
//  Random.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 10/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import Foundation

extension Int {
    public static func randomNumber(length len: Int = 16) -> Int {
        var rand: Int = 0
        #if os(Linux)
            rand = Int(random() % len)
        #else
            rand = Int(arc4random_uniform(UInt32(len)))
        #endif
        return rand
    }
}
