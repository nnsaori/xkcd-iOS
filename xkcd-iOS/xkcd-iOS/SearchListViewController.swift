//
//  ViewController.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit

class SearchListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }

    private var comickList: [RelevantComic?] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "xkcd comic"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200

        loadCurrentComics()
    }

    private func loadCurrentComics() {
        Task {
            do {
                let comic = try await NetworkManager.shared.getCurrentComics()

                if let comic = comic {
                    let relevantComic = convertToRelevantComic(comic: comic)    // convert the data type for CollectionView datasource.
                    comickList = [relevantComic]
                    if !comickList.isEmpty {
                        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                    tableView.reloadSections(IndexSet(integer: 0), with: .automatic)

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
    private func loadComics(keyword: String?) {
        Task {
            do {
                let response = try await NetworkManager.shared.getComics(keyword: keyword)

                if let comic = response {
                    comickList = comic.results

                    if !comickList.isEmpty {
                        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                    tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
                // TODO: Not found
                // TODO: ローディング
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
                             url: "\(Environment.comicUrlString)/\(comic.num)",
                             image: comic.img,
                             date: "\(comic.year)-\(comic.month)-\(comic.day)")

    }
}

extension SearchListViewController: UITableViewDelegate,  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comickList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: SearchTableViewCell.self), for: indexPath) as! SearchTableViewCell
        if let comic = comickList[indexPath.row] {
            cell.configureCell(comic: comic)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        vc.setViewData(comic: self.comickList[indexPath.row])

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        if let keyword = searchBar.text, !keyword.isEmpty {
            // show search result
            loadComics(keyword: searchBar.text)
        } else {
            // show the initial data
            loadCurrentComics()
        }

        searchBar.resignFirstResponder()
    }
}

