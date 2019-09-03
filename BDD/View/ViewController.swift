//
//  ViewController.swift
//  BDD
//
//  Created by Leonardo Reis on 02/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stockField: UITextField! {
        didSet { stockField?.addDoneToolbar() }
    }
    @IBOutlet weak var quantityField: UITextField! {
        didSet { quantityField?.addDoneToolbar() }
    }
    @IBOutlet weak var selectedCurrenciesCollection: UICollectionView!
    var selectedCurrencies: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stockField.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7568627451, blue: 0.8509803922, alpha: 1)
        stockField.layer.borderWidth = 1
        stockField.layer.cornerRadius = 8
        stockField.attributedPlaceholder = NSAttributedString(string: "Ex. APPL", attributes:
            [NSAttributedString.Key.foregroundColor: UIColor(cgColor: #colorLiteral(red: 0.8392156863, green: 0.8509803922, blue: 0.8941176471, alpha: 0.3))])
        quantityField.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7568627451, blue: 0.8509803922, alpha: 1)
        quantityField.layer.borderWidth = 1
        quantityField.layer.cornerRadius = 8
        quantityField.text = "1"
        //NavigationController
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.07058823529, green: 0.07843137255, blue: 0.1294117647, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = "Consult"
        self.navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(cgColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))]
        //CollectionView
        self.selectedCurrenciesCollection.delegate = self
        self.selectedCurrenciesCollection.dataSource = self
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.selectedCurrencies.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell",
                                                                for: indexPath)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCurrencyCell",
                                                                for: indexPath) as? EmptyCurrencyCollectionViewCell
                else {
                    fatalError()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Selected")
    }
}

extension UITextField {
    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any,
        action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Ok", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}
