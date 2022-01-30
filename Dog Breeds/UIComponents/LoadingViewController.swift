//
//  LoadingViewController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 30/01/22.
//

import UIKit

class LoadingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = Settings.shadowColor
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        backgroundView.addSubview(activity)
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }
}
