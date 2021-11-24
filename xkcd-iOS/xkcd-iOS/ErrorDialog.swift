//
//  ErrorDialog.swift
//  xkcd-iOS
//
//  Created by Saori Kurimoto on 2021/11/23.
//

import UIKit

protocol ErrorDialogViewController {
    func showErrorDialog(title: String, error: Error?, onOkPressed: (() -> Void)?)
}

extension ErrorDialogViewController where Self: UIViewController {

    func showErrorDialog(title: String, error: Error?, onOkPressed: (() -> Void)?) {
        var message: String {
            if let comicsError = error as? ComicsError {
                return comicsError.rawValue
            }
            return "Please try again"
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let handler = onOkPressed ?? {
            alert.dismiss(animated: false, completion: nil)
        }
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            handler()
        }
        alert.addAction(action)

        self.present(alert, animated: true)
    }
}

