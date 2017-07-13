//
//  MenuItemCell.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 12/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum MenuItemStyle: String {
    case white, lightGrey
}

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var menuCounter: UILabel!

    var tapHandler: ((MenuActionType) -> Void)?

    @IBAction func menuTap(_ sender: Any) {
        tapHandler?(viewModel.type)
    }
    let disposeBag = DisposeBag()

    var viewModel: MenuItemViewModel! {
        didSet {
            viewModel.title
                .drive(menuTitle.rx.text)
                .disposed(by: disposeBag)

            viewModel.image
                .drive(menuIcon.rx.image)
                .disposed(by: disposeBag)

            viewModel.counter
                .filter { $0 > 0 }
                .map { " \($0) " }
                .drive(menuCounter.rx.text)
                .disposed(by: disposeBag)

            viewModel.counter
                .filter { $0 <= 0 }
                .map { _ in return true }
                .drive(menuCounter.rx.isHidden)
                .disposed(by: disposeBag)

            setupAppearence(style: viewModel.style)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

//        containerView.rx.tap
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: Layout

extension MenuItemCell {

    func setupAppearence(style: MenuItemStyle) {
        switch style {
        case .white:
            containerView.backgroundColor = UIColor.white
            menuTitle.tintColor = Stylesheet.Color.mediumGrey
            break
        case .lightGrey:
            containerView.backgroundColor = Stylesheet.Color.lightGrey
            menuTitle.tintColor = Stylesheet.Color.greyishBrown
            break
        }
    }
}
