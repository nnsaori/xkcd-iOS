//
//  DetailViewController.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit

class DetailViewController: UIViewController, ErrorDialogViewController {

    @IBOutlet weak var imageView: NetworkImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var altLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    let favoriteOffimage = UIImage(systemName: "suit.heart")
    let favoriteOnimage = UIImage(systemName: "suit.heart.fill")

    var comic: RelevantComic?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "safari"), style: .plain, target: self, action: #selector(detailButtonTapped))
        ]

        scrollView.maximumZoomScale = 10.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self

        loadViewData()
        loadFavoriteData()
    }

    func setViewData(comic: RelevantComic?) {
        self.comic = comic
    }

    private func loadViewData() {
        guard let comic = comic else {
            return
        }

        self.title = comic.title
        imageView.downloadImage(fromURL: comic.image)
        idLabel.text = "#\(comic.number)"
        dateLabel.text = "\(comic.date)"
        altLabel.text = comic.titletext
    }

    private func loadFavoriteData() {
        guard let comic = comic else {
            return
        }

        Task {
            do {
                let favorites = try await FavoriteManager().getFavorites().compactMap{ $0 }

                if favorites.contains(where: { $0.number == comic.number }) {
                    favoriteImageView.image = favoriteOnimage
                } else {
                    favoriteImageView.image = favoriteOffimage
                }
            } catch {
                showErrorDialog(title: "Error", error: error) { }
            }
        }
    }

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let comic = comic else {
            return
        }

        favoriteButton.isEnabled = false

        switch favoriteImageView.image {
        case favoriteOnimage:
            Task {
                do {
                    let _ = try await FavoriteManager().remove(comic: comic)
                    favoriteImageView.image = favoriteOffimage
                    favoriteButton.isEnabled = true
                } catch {
                    showErrorDialog(title: "Error", error: error) { }
                }
            }

        case favoriteOffimage:
            Task {
                do {
                    let _ = try await FavoriteManager().add(comic: comic)
                    favoriteImageView.image = favoriteOnimage
                    favoriteButton.isEnabled = true
                } catch {
                    showErrorDialog(title: "Error", error: error) { }
                }
            }

        default:
            break
        }
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
