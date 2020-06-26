//
//  infoViewController.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 11.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

// CETTE VUE N'EST PLUS UTILISEE

import UIKit
class infoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sources.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sources[row]
    }
    
    
    @IBOutlet weak var colorSettingsLabel: UILabel!
    @IBOutlet weak var colorSettingsSwitch: UISwitch!
    @IBOutlet weak var sourceSettingsLabel: UILabel!
    @IBOutlet weak var sourceSettingsPicker: UIPickerView!
    
    var sources: [String] = [String]()
    let urlSource: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeColors()
        
        self.sourceSettingsPicker.dataSource = self
        self.sourceSettingsPicker.delegate = self
        
        sources = ["Marmiton", "750g", "Cuisine AZ", "Journal des femmes"]
        
        sourceSettingsPicker.reloadAllComponents()
        
        if UserDefaults.standard.string(forKey: "PAD_SOURCE") == nil {
            SettingsBundleHelper.SetSource(source: "Marmiton")
        }
        
        switch UserDefaults.standard.string(forKey: "PAD_SOURCE") {
        case "Marmiton":
            sourceSettingsPicker.selectRow(0, inComponent: 0, animated: true)
        case "750g":
            sourceSettingsPicker.selectRow(1, inComponent: 0, animated: true)
        case "Cuisine AZ":
            sourceSettingsPicker.selectRow(2, inComponent: 0, animated: true)
        case "Journal des femmes":
            sourceSettingsPicker.selectRow(3, inComponent: 0, animated: true)
        default:
            sourceSettingsPicker.selectRow(0, inComponent: 0, animated: true)
        }
        
        print(UserDefaults.standard.string(forKey: "PAD_SOURCE")!)
        
        if UserDefaults.standard.bool(forKey: "PAD_COLORS") == true {
            colorSettingsSwitch.isOn = true
        }
        else {
            colorSettingsSwitch.isOn = false
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            SettingsBundleHelper.SetSource(source: "Marmiton")
        case 1:
            SettingsBundleHelper.SetSource(source: "750g")
        case 2:
            SettingsBundleHelper.SetSource(source: "Cuisine AZ")
        case 3:
            SettingsBundleHelper.SetSource(source: "Journal des femmes")
        default:
            SettingsBundleHelper.SetSource(source: "Marmiton")
            
        }
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
        
        colorSettingsLabel.textColor = color2
        
        self.view.backgroundColor = color1
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
            
            colorSettingsLabel.textColor = color2
            
            self.view.backgroundColor = color1
        }
    }
    
    @IBAction func colorSwitched(_ sender: Any) {
        if colorSettingsSwitch.isOn == true {
            SettingsBundleHelper.SetColors(yesorno: true)
        }
        else {
            SettingsBundleHelper.SetColors(yesorno: false)
        }
    }

}
