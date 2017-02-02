//
//  RoundImageView.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import UIKit
import Kingfisher
import JGProgressHUD
import GradientCircularProgress

class RoundImageView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    var view: UIView!
    
    var nibName: String = "RoundImageView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        updateUI()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        }
        return UIView()
    }
    
    func loadImage(url: URL) {
        let progress = GradientCircularProgress()
        let progressView = progress.showAtRatio(frame: imageView.frame, style: BlueIndicatorStyle())
        view.addSubview(progressView!)
        
        imageView.kf.setImage(with: url, progressBlock: { (currentSize, allSize) in
            progress.updateRatio(CGFloat(currentSize) / CGFloat(allSize))
        }) { (image, error, cacheType, url) in
            progressView?.isHidden = true
            progress.dismiss(progress: progressView!)
        }
    }
    
    func updateUI() {
        self.layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    }
}
