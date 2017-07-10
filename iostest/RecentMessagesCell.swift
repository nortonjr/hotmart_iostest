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
    fileprivate let dataSource = RxCollectionViewSectionedReloadDataSource<SectionViewModelType<MessageViewModel>>()

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

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumInteritemSpacing = 20
    }

    func setupReactiveCollectionView() {
        dataSource.configureCell = { (_, collectionView, indexPath, viewModel) in
            guard let cell: MessageBubbleCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.messageBubbleCell, for: indexPath) else { fatalError() }

            return cell
        }
    }
}

// MARK: CollectionViewDelegateFlowLayout

extension RecentMessagesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 70)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectoinViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
}

// MARK: UIScrollViewDelegate

extension RecentMessagesCell: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let visibleCell = collectionView.visibleCells.first, let indexPath = collectionView.indexPath(for: visibleCell) else { return }
        let selectedIndex = selectVisibleCell() ?? indexPath
//        selectModelAt(index: selectedIndex.item)
    }

//    func selectModelAt(index: Int) {
//        guard let model = try? dataSource.model(at: IndexPath(item: index, section: 0)), let vm = model as? HomeNewsViewModel else { return }
//        select(viewModel: vm)
//    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let visibleCell = collectionView.visibleCells.first, let indexPath = collectionView.indexPath(for: visibleCell) else { return }
        let selectedIndex = selectVisibleCell() ?? indexPath
//        selectModelAt(index: selectedIndex.item)
    }

//    func select(viewModel newsViewModel: HomeNewsViewModel) {
//        guard let index = viewModel.index(of: newsViewModel), collectionView.numberOfSections > 0 else { return }
//
//        let numberOfItems = collectionView.numberOfItems(inSection: 0)
//        if numberOfItems == 1 {
//            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
//        }
//        else if numberOfItems > index {
//            collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
//        }
//    }

    func selectVisibleCell() -> IndexPath? {
        var visibleRect = CGRect()

        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        let visibleIndexPath: IndexPath? = collectionView.indexPathForItem(at: visiblePoint)
        
        return visibleIndexPath
    }
}
