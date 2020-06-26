//
//  settingsTableViewController.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 11.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

import UIKit
import AUPickerCell

class settingsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        recetteInput.text = myPickerData[row]
        SettingsBundleHelper.SetSource(source: recetteInput.text!)
    }
    
    @IBOutlet weak var colorSettingsLabel: UILabel!
    @IBOutlet weak var colorSettingsSwitch: UISwitch!
    @IBOutlet weak var tapticSettingsLabel: UILabel!
    @IBOutlet weak var tapticSettingsSwitch: UISwitch!
    @IBOutlet weak var sourceSettingsLabel: UILabel!
    @IBOutlet weak var lighterColorsLabel: UILabel!
    @IBOutlet weak var lighterColorsSwitch: UISwitch!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var apparenceTableView: UITableViewCell!
    @IBOutlet weak var apparence2TableView: UITableViewCell!
    @IBOutlet weak var systemeTableView: UITableViewCell!
    @IBOutlet weak var aproposTableView: UITableViewCell!
    @IBOutlet weak var apropos2TableView: UITableViewCell!
    @IBOutlet weak var platsTableView: UITableViewCell!
    @IBOutlet weak var recetteInput: UITextField!
    @IBOutlet weak var slideLabel: NSLayoutConstraint!
    @IBOutlet weak var slideSwitch: UISwitch!
    @IBOutlet weak var openInAppSwitch: UISwitch!
    @IBOutlet weak var systeme2TableView: UITableViewCell!
    @IBOutlet weak var navigationTableView: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        if UserDefaults.standard.bool(forKey: "PAD_COLORS") == true {
            colorSettingsSwitch.isOn = true
        }
        else {
            colorSettingsSwitch.isOn = false
        }
        
        if UserDefaults.standard.bool(forKey: "PAD_LIGHTER_COLORS") == true {
            lighterColorsSwitch.isOn = true
        }
        else {
            lighterColorsSwitch.isOn = false
        }
        
        if UserDefaults.standard.bool(forKey: "PAD_TAPTIC") == true {
            tapticSettingsSwitch.isOn = true
        }
        else {
            tapticSettingsSwitch.isOn = false
        }
        
        if UserDefaults.standard.bool(forKey: "PAD_SLIDE") == true {
            slideSwitch.isOn = true
        }
        else {
            slideSwitch.isOn = false
        }
        
        if UserDefaults.standard.bool(forKey: "PAD_OPENINAPP") == true {
            openInAppSwitch.isOn = true
        }
        else {
            openInAppSwitch.isOn = false
        }
        
        if #available(iOS 13.0, *) {
        changeColors()
        }
        
        enum UIUserInterfaceIdiom : Int {
            case unspecified

            case phone
            case pad
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            tapticSettingsSwitch.isEnabled = false
            tapticSettingsSwitch.isOn = false
        }
        
        apparenceTableView.selectionStyle = .none
        apparence2TableView.selectionStyle = .none
        systemeTableView.selectionStyle = .none
        systeme2TableView.selectionStyle = .none
        platsTableView.selectionStyle = .none
        aproposTableView.selectionStyle = .none
        apropos2TableView.selectionStyle = .none
        navigationTableView.selectionStyle = .none
        
        let thePicker = UIPickerView()
        thePicker.delegate = self
        recetteInput.delegate = self
        recetteInput.inputView = thePicker
        recetteInput.inputView?.backgroundColor = .clear
        recetteInput.borderStyle = .none
        recetteInput.tintColor = .clear
        
        let pickerAccessory = UIToolbar()

        recetteInput.inputAccessoryView = pickerAccessory

        pickerAccessory.autoresizingMask = .flexibleHeight
        pickerAccessory.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Fait", style: .done, target: self, action: #selector(pickerViewDone(_:)))
        ]
        
        switch UserDefaults.standard.string(forKey: "PAD_SOURCE") {
        case "Marmiton":
            recetteInput.text = "Marmiton"
            thePicker.selectRow(0, inComponent: 0, animated: true)
        case "750g":
            recetteInput.text = "750g"
            thePicker.selectRow(1, inComponent: 0, animated: true)
        case "Cuisine AZ":
            recetteInput.text = "Cuisine AZ"
            thePicker.selectRow(2, inComponent: 0, animated: true)
        case "Journal des femmes":
            recetteInput.text = "Journal des femmes"
            thePicker.selectRow(3, inComponent: 0, animated: true)
        default:
            recetteInput.text = "Marmiton"
            thePicker.selectRow(0, inComponent: 0, animated: true)
        }
    }
        
    @objc
     func pickerViewDone(_ sender: UIBarButtonItem) {
            recetteInput.resignFirstResponder()
        }
    
    let myPickerData = [String](arrayLiteral: "Marmiton", "750g", "Cuisine AZ", "Journal des femmes")
    
    override func viewWillAppear(_ animated: Bool) {
        changeColors()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }

    @IBAction func colorSwitched(_ sender: Any) {
        if colorSettingsSwitch.isOn == true {
            SettingsBundleHelper.SetColors(yesorno: true)
            lighterColorsSwitch.isEnabled = true
        }
        else {
            SettingsBundleHelper.SetColors(yesorno: false)
            SettingsBundleHelper.SetLighterColors(yesorno: false)
            lighterColorsSwitch.isOn = false
            lighterColorsSwitch.isEnabled = false
        }
    }
    
    @IBAction func tapticSwitched(_ sender: Any) {
        if tapticSettingsSwitch.isOn == true {
            SettingsBundleHelper.SetTaptic(yesorno: true)
        }
        else {
            SettingsBundleHelper.SetTaptic(yesorno: false)
        }
    }
    
    @IBAction func slideSwitched(_ sender: Any) {
        if slideSwitch.isOn == true {
            SettingsBundleHelper.SetSlide(yesorno: true)
        }
        else {
            SettingsBundleHelper.SetSlide(yesorno: false)
        }
    }
    
    @IBAction func lighterColorsSwitched(_ sender: Any) {
        if lighterColorsSwitch.isOn == true {
            SettingsBundleHelper.SetLighterColors(yesorno: true)
            SettingsBundleHelper.SetColors(yesorno: true)
            colorSettingsSwitch.isOn = true
        }
        else {
            SettingsBundleHelper.SetLighterColors(yesorno: false)
        }
    }
    
    @IBAction func openInAppSwitched(_ sender: Any) {
        if openInAppSwitch.isOn == true {
            SettingsBundleHelper.SetOpenLinkInApp(yesorno: true)
        }
        else {
            SettingsBundleHelper.SetOpenLinkInApp(yesorno: false)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        
        changeColors()
    }
    
    func changeColors() {
        if #available(iOS 13.0, *) {
        let color1 = UIColor.systemBackground
        var color2: UIColor
        
        let ciColor = CIColor(color: color1)
        
        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue
        
        color2 = UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color2]
        navigationController?.navigationBar.tintColor = color2
        }
        else
        {
            let color1 = UIColor.white
            var color2: UIColor
            
            let ciColor = CIColor(color: color1)
            
            let compRed: CGFloat = 1.0 - ciColor.red
            let compGreen: CGFloat = 1.0 - ciColor.green
            let compBlue: CGFloat = 1.0 - ciColor.blue
            
            color2 = UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
            
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color2]
            navigationController?.navigationBar.tintColor = color2
        }
    }
    
    @IBAction func websiteTapped(_ sender: Any) {
        guard let url = URL(string: "https://brunopaiva.ch") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func privacyTapped(_ sender: Any) {
        guard let url = URL(string: "https://brunopaiva.ch/confidentialite") else { return }
        UIApplication.shared.open(url)
    }
    
}
