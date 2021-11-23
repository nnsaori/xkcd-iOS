//
//  DetailViewController.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var imageView: NetworkImageView!

    var comic: RelevantComic?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Detail", style: .plain, target: self, action: #selector(detailButtonTapped))

        setViewData()
    }

    func setViewData(comic: RelevantComic?) {
        self.comic = comic
    }

    private func setViewData() {
        guard let comic = comic else {
            return
        }

        self.title = comic.title
        imageView.downloadImage(fromURL: comic.image)
    }

    @objc func detailButtonTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WebViewController.self)) as! WebViewController
        vc.setviewData(comic: comic)

        self.navigationController?.pushViewController(vc, animated: true)

    }
}
