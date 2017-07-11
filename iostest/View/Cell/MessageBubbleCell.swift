//
//  MessageBubbleCell.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MessageBubbleCell: UICollectionViewCell {

    @IBOutlet weak var profileContainer: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileInitial: UILabel!

    let disposeBag: DisposeBag = DisposeBag()

    var viewModel: MessageBubbleViewModel! {
        didSet {
            viewModel.userName
                .drive(userName.rx.text)
                .disposed(by: disposeBag)

            viewModel.backgroundColor
                .drive(profileContainer.rx.backgroundColor)
                .disposed(by: disposeBag)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        profileContainer.layer.cornerRadius = self.profileContainer.frame.size.width / 2
        profileContainer.clipsToBounds = true
    }
}
