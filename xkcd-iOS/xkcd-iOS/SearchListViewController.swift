//
//  ViewController.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit

class SearchListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }

    private var comickList: [RelevantComic?] = []
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "xkcd comic"
        collectionView.delegate = self
        collectionView.dataSource = self

        loadCurrentComics()
    }

    private func loadCurrentComics() {
        Task {
            do {
                let comic = try await NetworkManager.shared.getCurrentComics()

                if let comic = comic {
                    let relevantComic = convertToRelevantComic(comic: comic)    // convert the data type for CollectionView datasource.
                    comickList = [relevantComic]
                    collectionView.reloadData()
                }
                // TODO: Not found view
                // TODO: loading
            } catch {
                print(error.localizedDescription)

                // TODO: ローディング
                // TODO: アラート
            }
        }
    }

    private func convertToRelevantComic(comic: XkcdComic) -> RelevantComic {
        return RelevantComic(number: comic.num,
                             title: comic.title,
                             titletext: comic.alt,
                             url: "\(NetworkManager.comicUrl)/\(comic.num)",
                             image: comic.img,
                             date: "\(comic.year)-\(comic.month)-\(comic.day)")

    }
}

extension SearchListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comickList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ComicsCollectionViewCell.self), for: indexPath) as! ComicsCollectionViewCell
        if let comic = comickList[indexPath.row] {
            cell.configureCell(comic)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: detail view
    }
}

extension SearchListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        
        Task {
            do {
                let response = try await NetworkManager.shared.getComics(keyword: searchBar.text)

                if let comic = response {
                    comickList = comic.results
                    collectionView.reloadData()
                }
                // TODO: Not found
                // TODO: ローディング
            } catch {
                print(error.localizedDescription)

                // TODO: ローディング
                // TODO: アラート
            }
        }

        searchBar.resignFirstResponder()
    }


}

