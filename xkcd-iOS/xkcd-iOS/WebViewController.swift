//
//  WebViewController.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView = WKWebView()
    var comic: RelevantComic?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        setupWebView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        webView.frame = view.bounds
    }

    func setupWebView() {
        guard let comic = comic else {
            return
        }
        let pamam = comic.title.replacingOccurrences(of: " ", with: "_")
        guard let url = URL(string: "\(Environment.detailWebUrl)/\(pamam)") else {
            return
        }

        webView.load(URLRequest(url: url))
        view.addSubview(webView)
    }
    

    func setviewData(comic: RelevantComic?) {
        self.comic = comic
    }

    @objc func shareButtonTapped() {
        guard let comic = comic else {
            return
        }

        let pamam = comic.title.replacingOccurrences(of: " ", with: "_")
        guard let url = URL(string: "\(Environment.detailWebUrl)/\(pamam)") else {
            return
        }

        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)

    }
}
