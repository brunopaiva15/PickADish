//
//  sourceTableViewController.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 18.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

import UIKit
import AUPickerCell


class sourceTableViewController: UITableViewController, AUPickerCellDelegate {
    func auPickerCell(_ cell: AUPickerCell, didPick row: Int, value: Any) {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sources = ["Marmiton", "750g", "Cuisine AZ", "Journal des femmes"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeColors()
    }
    
    var sources: [String] = [String]()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AUPickerCell(type: .default, reuseIdentifier: "PickerDefaultCell")
        cell.delegate = self
        cell.separatorInset = UIEdgeInsets.zero
        cell.values = sources
        switch UserDefaults.standard.string(forKey: "PAD_SOURCE") {
            case "Marmiton":
                cell.selectedRow = 0
            case "750g":
                cell.selectedRow = 1
            case "Cuisine AZ":
                cell.selectedRow = 2
            case "Journal des femmes":
                cell.selectedRow = 3
            default:
                cell.selectedRow = 0
            }
            cell.leftLabel.text = "Source des recettes"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if let cell = tableView.cellForRow(at: indexPath) as? AUPickerCell {
        return cell.height
      }
      return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      if let cell = tableView.cellForRow(at: indexPath) as? AUPickerCell {
        cell.selectedInTableView(tableView)
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

}
