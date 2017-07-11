//
//  RecentMessagesCell.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RecentMessagesCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let dataSource = RxCollectionViewSectionedReloadDataSource<SectionViewModelType<MessageBubbleViewModel>>()

    let disposeBag: DisposeBag = DisposeBag()

    var viewModel: RecentMessagesViewModel! {
        didSet {
            viewModel.messagesCards
                .drive(collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setup()
    }
}

// MARK: Setup

extension RecentMessagesCell {

    func setup() {
        setupCollectionView()
        setupReactiveCollectionView()
    }

    func setupCollectionView() {
        guard let collectionView = collectionView else { return }
        collectionView.register(R.nib.messageBubbleCell)
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumInteritemSpacing = 27
    }

    func setupReactiveCollectionView() {
        dataSource.configureCell = { (_, collectionView, indexPath, viewModel) in
            guard let cell: MessageBubbleCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.messageBubbleCell, for: indexPath) else { fatalError() }
            cell.viewModel = viewModel
            return cell
        }
    }
}

// MARK: CollectionViewDelegateFlowLayout

extension RecentMessagesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 201)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectoinViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 18.5, bottom: 8, right: 18.5)
    }
}
