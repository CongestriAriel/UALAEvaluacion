//
//  BookListViewController.swift
//  UALATest
//
//  Created by Ariel Congestri on 30/09/2019.
//  Copyright © 2019 Ariel Congestri. All rights reserved.
//

import UIKit

protocol PresenterDelgate: class {
    func dataSourceWasUpdated()
}

class BookListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: BookListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
    }

    func configureCollection() {
       collectionView.register(UINib(nibName: "BookListCell", bundle: nil), forCellWithReuseIdentifier: "BookListCell")
    }

    @IBAction func changeOrderButtonDidTouchUpInside(_ sender: Any) {
        presenter.isAsendingOrder = !presenter.isAsendingOrder
        presenter.sortArray(asending: presenter.isAsendingOrder)
    }

    @IBAction func changeViewMode(_ sender: Any) {
        presenter.isListView = !presenter.isListView
    }
    
    @IBAction func showAllButonDidTouchUpInside(_ sender: Any) {
        presenter.filteringLogic = 0
    }
    
    @IBAction func showAvailable(_ sender: Any) {
        presenter.filteringLogic = 1
    }

    @IBAction func showNonAvailables(_ sender: Any) {
        presenter.filteringLogic = 2
    }
    
    
}
extension BookListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.itemsForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookListCell", for: indexPath)
        (cell as? BookListCell)?.configure(With: presenter.itemFor(IndexPath: indexPath))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItemAt(IndexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ViewControllerFactory.bookDetail(object: presenter.itemForDetailAt(IndexPath: indexPath)), animated: true)
    }
}
extension BookListViewController: PresenterDelgate {
    func dataSourceWasUpdated() {
        collectionView.reloadData()
    }
}
