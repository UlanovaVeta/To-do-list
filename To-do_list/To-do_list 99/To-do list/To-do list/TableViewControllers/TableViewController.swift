//
//  TableViewController.swift
//  To-do list
//
//  Created by Elizaveta Ulanova on 23.10.2020.
//  Copyright © 2020 Elizaveta Ulanova. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - IBOutlet
    
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    
    var rowsWhichAreChecked = [NSIndexPath]()
    let userDefaults = UserDefaults.standard
    let encoder = JSONEncoder()
    var mainListItems: [MainListInfo] = []
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelection = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //выгрузка элементов
        if let savedMainListItems = userDefaults.object(forKey: "mainListItemsData") as? Data {
            let decoder = JSONDecoder()
            if let loadedMainListItems = try? decoder.decode(MainListInfo.self, from: savedMainListItems) {
                self.mainListItems.append(MainListInfo(name: loadedMainListItems.name, checked: loadedMainListItems.checked))
            }
        }

        self.mainListItems.append(MainListInfo(name: "Новое задание", checked: false))
        
        navigationItem.rightBarButtonItem = .init(title: "editing", style: .done, target: self, action: #selector(toggleEditing))
        navigationItem.rightBarButtonItem = .init(title: "+", style: .done, target: self, action: #selector(addRow))
    }
    
   @objc func addRow() {
        let alertController = UIAlertController (title: "Добавить задание", message: nil, preferredStyle: .alert)
    
        alertController.addTextField
        { (textField) in
            textField.placeholder = "Название задание"
        }
    
        let alertAction1 = UIAlertAction (title: "Отмена", style:.default)
        { (alert) in
        }
    
        let alertAction2 = UIAlertAction (title: "Создать", style:.cancel)
        { (alert) in
            let newItem = alertController.textFields![0].text
            self.mainListItems.insert(MainListInfo(name: newItem!, checked: false), at: 0)
            self.tableView.insertRows(at: [.init(row: 0, section: 0)], with: .automatic)
        }
    
        alertController.addAction (alertAction1)
        alertController.addAction (alertAction2)
        present (alertController, animated: true, completion: nil)
    
        //сохранение элементов
        if let encoded = try? encoder.encode(mainListItems) {
            userDefaults.set(encoded, forKey: "mainListItemsData")
        }
    }
    
    @objc func toggleEditing() {
        tableView.isEditing.toggle()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.00
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // возращает количество строк в секции
        return mainListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //возвращает элемент UITableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath ) as? MainListCell else {
            fatalError()
        }
        
        let mainListItem = mainListItems[indexPath.row]
        mainListItem.onAction = {
            [weak self] in
            let viewController = self?.storyboard?.instantiateViewController(withIdentifier: "TableViewController2")
            self?.navigationController?.pushViewController(viewController!, animated: true)
        }
        
        cell.mainListItem = mainListItem
        cell.checkboxLabel.text = mainListItem.name
        
        let isRowChecked = rowsWhichAreChecked.contains(indexPath as NSIndexPath)
        
        if (isRowChecked == true)
        {
            cell.checkboxButton.isChecked = true
            mainListItem.checked = true
            cell.checkboxButton.buttonClicked(sender: cell.checkboxButton)
        } else {
            cell.checkboxButton.isChecked = false
            mainListItem.checked = false
            cell.checkboxButton.buttonClicked(sender: cell.checkboxButton)
        }
        
        //сохранение элементов
        if let encoded = try? encoder.encode(mainListItems) {
            userDefaults.set(encoded, forKey: "mainListItemsData")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! MainListCell
        cell.contentView.backgroundColor = UIColor.white
        // cross checking for checked rows
        if(rowsWhichAreChecked.contains(indexPath as NSIndexPath) == false){
            cell.checkboxButton.isChecked = true
            mainListItems[indexPath.row].checked = true
            cell.checkboxButton.buttonClicked(sender: cell.checkboxButton)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! MainListCell
        cell.checkboxButton.isChecked = false
        mainListItems[indexPath.row].checked = false
        cell.checkboxButton.buttonClicked(sender: cell.checkboxButton)
        // remove the indexPath from rowsWhichAreCheckedArray
        if let checkedItemIndex = rowsWhichAreChecked.firstIndex(of: indexPath as NSIndexPath){
            rowsWhichAreChecked.remove(at: checkedItemIndex)
        }
     
    }
    
   private func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return.init(actions: [UIContextualAction(style: .destructive, title: "Удалить", handler: {(action, view, completion) in
            self.mainListItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            
            //сохранение элементов
            if let encoded = try? self.encoder.encode(self.mainListItems) {
                self.userDefaults.set(encoded, forKey: "mainListItemsData")
                
            }
            
            completion(true)
        })])
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = mainListItems.remove(at: sourceIndexPath.row)
        mainListItems.insert(item, at: destinationIndexPath.row)
    }
    
}
