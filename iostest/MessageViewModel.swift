//
//  MessageViewModel.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxSwift
import RxCocoa

class MessageViewModel: ViewModel {

    let disposeBag: DisposeBag = DisposeBag()

    var viewModel: RecentMessagesViewModel!
    var messages: Variable<[MessageBubbleCell]>

    init(messages: [MessageBubbleCell], viewModel: RecentMessagesViewModel) {
        self.viewModel = viewModel
        self.messages = Variable(messages)
    }
}
