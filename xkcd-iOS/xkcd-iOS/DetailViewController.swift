//
//  DetailViewController.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: NetworkImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var altLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    var comic: RelevantComic?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "safari"), style: .plain, target: self, action: #selector(detailButtonTapped)),
//            UIBarButtonItem(image: UIImage(systemName: "suit.heart"), style: .plain, target: self, action: #selector(detailButtonTapped))
        ]

        scrollView.maximumZoomScale = 10.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self

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
        idLabel.text = "#\(comic.number)"
        dateLabel.text = "\(comic.date)"
        altLabel.text = comic.titletext
    }

    @objc func detailButtonTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WebViewController.self)) as! WebViewController
        vc.setviewData(comic: comic)

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
