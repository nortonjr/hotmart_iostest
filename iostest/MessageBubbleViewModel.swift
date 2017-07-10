//
//  MessageBubbleViewModel.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxSwift
import RxCocoa

class MessageBubbleViewModel: ViewModel {

    let disposeBag: DisposeBag = DisposeBag()

    init() { }

    var userName: Driver<String> {
        return .just("")
    }

    var profilePicture: Driver<UIImage> {
        return .just(UIImage())
    }
}
