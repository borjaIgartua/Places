//
//  InfoViewController.swift
//  Places
//
//  Created by Borja Igartua on 06.06.18.
//  Copyright © 2018 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var iconsLabel: UILabel!
    @IBOutlet weak var iconMessageLabel: ActiveLabel!
    
    override func loadView() {
        super.loadView()

        if (self.presentingViewController != nil) {
            let closeButton = UIBarButtonItem(image: UIImage(named: "cross"), style: .plain, target: self, action: #selector(self.dissmiss))
            self.navigationItem.setRightBarButton(closeButton, animated: false)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Attributions"
        self.iconsLabel.text = "Icons"
        self.iconMessageLabel.numberOfLines = 0
        self.iconMessageLabel.textColor = UIColor.darkGray

        let customType = ActiveType.custom(pattern: "\\sFreepik\\b")
        iconMessageLabel.customColor[customType] = UIColor.steelBlue
        iconMessageLabel.customSelectedColor[customType] = UIColor.lightGray

        iconMessageLabel.handleCustomTap(for: customType) { element in
            self.openUrlString(urlString: "http://www.freepik.com")
        }

        let customFlatIconType = ActiveType.custom(pattern: "\\sFlaticon\\b")
        iconMessageLabel.customColor[customFlatIconType] = UIColor.steelBlue
        iconMessageLabel.customSelectedColor[customFlatIconType] = UIColor.lightGray
        iconMessageLabel.handleCustomTap(for: customFlatIconType) { element in
            self.openUrlString(urlString: "http://www.flaticon.com")
        }

        iconMessageLabel.enabledTypes = [customType, customFlatIconType]
        self.iconMessageLabel.text = "Icons made by Freepik from Flaticon"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        iconsLabel.translatesAutoresizingMaskIntoConstraints = false
        iconMessageLabel.translatesAutoresizingMaskIntoConstraints = false


        iconsLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        iconsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        iconsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true

        iconMessageLabel.topAnchor.constraint(equalTo: self.iconsLabel.bottomAnchor, constant: 15).isActive = true
        iconMessageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        iconMessageLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
    }

    // MARK: - User iteraction
    @objc func dissmiss() {
        self.dismiss(animated: true, completion: nil)
    }

    func openUrlString(urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
