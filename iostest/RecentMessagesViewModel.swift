//
//  RecentMessagesViewModel.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxSwift
import RxCocoa

class RecentMessagesViewModel: ViewModel {

    let disposeBag: DisposeBag = DisposeBag()

    init() {
        mockDataIntoCollectionView()
    }

    fileprivate var messages: Variable<[MessageBubbleCell]> = Variable([])
    fileprivate var items: [MessageBubbleViewModel] = []

    var messagesModels: Observable<[SectionViewModelType<MessageBubbleViewModel>]> {
        return messages.asObservable().viewModels(viewModel: self)
            .map { return [SectionViewModelType(viewModels: $0)] }
    }

    var messagesCards: Driver<[SectionViewModelType<MessageBubbleViewModel>]> {
        return messagesModels
            .do(onNext: { sections in
                if let sections = sections.first {
                    self.items = sections.items
                }
            }).asDriver(onErrorJustReturn: [])
    }

    func mockDataIntoCollectionView() {
        var items: [MessageBubbleCell] = []
        for _ in 0...10 {
            let cell = R.nib.messageBubbleCell.firstView(owner: nil)
            cell?.viewModel = MessageBubbleViewModel()
            items.append(cell!)
        }
        self.messages.value = items
    }
}
