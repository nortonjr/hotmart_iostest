//
//  MessagesViewController.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 11/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MessagesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let dataSource = RxCollectionViewSectionedReloadDataSource<SectionViewModelType<MessageBubbleViewModel>>()

    let disposeBag: DisposeBag = DisposeBag()

    var viewModel: RecentMessagesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        viewModel.messagesCards
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: Setup

extension MessagesViewController {

    func setup() {
        setupCollectionView()
        setupReactiveCollectionView()
    }

    func setupCollectionView() {
        guard let collectionView = collectionView else { return }

        collectionView.register(R.nib.messageBubbleCell)
        collectionView.delegate = self

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumInteritemSpacing = 27
        flowLayout.minimumLineSpacing = 8
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

extension MessagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18.5, bottom: 0, right: 18.5)
    }
}
