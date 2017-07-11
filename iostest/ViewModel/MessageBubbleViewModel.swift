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
    let possibleNames: [String] = ["Pedro Matos", "Valéria Ciqueira", "Maria Carol", "Flávia de Alcantara", "Norton Pigozzo", "Obi Wan", "Luke Skywalker", "Rey"]
    let possibleColors: [UIColor] = [Stylesheet.Color.mainBlue, Stylesheet.Color.mainGreen, Stylesheet.Color.mainPurple, Stylesheet.Color.mainRed]

    var selectedColor: UIColor!
    var selectedName: String!

    init() {
        let nameIndex = Int.randomNumber(length: possibleNames.count)
        selectedName = possibleNames[nameIndex]
        let colorIndex = Int.randomNumber(length: possibleColors.count)
        selectedColor = possibleColors[colorIndex]
    }

    var userName: Driver<String> {
        return .just(selectedName)
    }

    var profilePicture: Driver<UIImage> {
        return .just(UIImage())
    }

    var backgroundColor: Driver<UIColor> {
        return .just(selectedColor)
    }
}
