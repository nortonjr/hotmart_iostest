//
//  ObservableType+MessageViewModel.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxSwift

extension ObservableType where E == [MessageBubbleCell] {

    func viewModels(viewModel: RecentMessagesViewModel) -> Observable<[MessageViewModel]> {
        return map { (messages) in
            return messages.map { message in
                return MessageViewModel(messages: [message], viewModel: viewModel)
            }
        }
    }
}
