//
//  favoriteTableViewController.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 20.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

import UIKit

class favouriteTableViewController: UITableViewController {
    
    var favourites = UserDefaults.standard.object(forKey: "PAD_FAVOURITES") as? [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        cell.textLabel?.text = favourites![indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SettingsBundleHelper.DeleteDishFromFavourites(index: indexPath.row)
            favourites!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        
        changeColors()
    }
    
    func changeColors() {
        var color1: UIColor
        var color2: UIColor
        
        if #available(iOS 13.0, *) {
            color1 = UIColor.systemBackground
        } else {
            color1 = UIColor.white
        }
    
        let ciColor = CIColor(color: color1)
    
        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue
        
        color2 = UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
        
        navigationController?.navigationBar.barTintColor = color1
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color2]
        navigationController?.navigationBar.tintColor = color2
        self.view.backgroundColor = color1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Plats favoris"
    }
}
