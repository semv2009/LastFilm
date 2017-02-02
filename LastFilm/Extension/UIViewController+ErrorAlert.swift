//
//  UIViewController+ErrorAlert.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorAlert(error: Error) {
        let err = error as NSError
        let message = WebError.titleError(code: err.code)
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
