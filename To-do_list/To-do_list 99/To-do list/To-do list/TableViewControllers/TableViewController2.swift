//
//  TableViewController2.swift
//  To-do list
//
//  Created by Elizaveta Ulanova on 23.10.2020.
//  Copyright © 2020 Elizaveta Ulanova. All rights reserved.
//

import UIKit

class TableViewController2: UIViewController {
    
    //MARK: - IBOutlet

    @IBOutlet var tableView2: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    
    //MARK: - Properties
    
    var listInfoItems: [ListInfo] = []
    var selectedCell: IndexPath?
    let userDefaults = UserDefaults.standard
    let encoder = JSONEncoder()
    var editItem: String?
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //выгрузка элементов
        if let savedListInfoItems = userDefaults.object(forKey: "listInfoItemsData") as? Data {
            let decoder = JSONDecoder()
            if let loadedListInfoItems = try? decoder.decode(ListInfo.self, from: savedListInfoItems) {
                self.listInfoItems.append(ListInfo(cellName: loadedListInfoItems.cellName, cellInfo: loadedListInfoItems.cellInfo))
            }
        }
        
        self.listInfoItems.append(ListInfo(cellName: "Название:", cellInfo: "Новое задание"))
        self.listInfoItems.append(ListInfo(cellName: "Дата создания:", cellInfo: ""))
        self.listInfoItems.append(ListInfo(cellName: "Сделать до:", cellInfo: ""))
        self.listInfoItems.append(ListInfo(cellName: "Статус:", cellInfo: "undone"))
        self.listInfoItems.append(ListInfo(cellName: "Файл 1:", cellInfo: "file1"))
        self.listInfoItems.append(ListInfo(cellName: "Файл 2:", cellInfo: "file2"))
        self.listInfoItems.append(ListInfo(cellName: "Файл 3:", cellInfo: "file3"))
        self.listInfoItems.append(ListInfo(cellName: "Описание:", cellInfo: "Разновидность соуса чили. В состав соуса сирача входят такие ингридиенты, как перец чили, уксус, чеснок, сахар и соль."))
        
    }
    
    @objc func tapDone() {
        if let datePicker = self.dateTextField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            //self.dateTextField.text = dateformatter.string(from: datePicker.date)
            //self.editItem! = dateformatter.string(from: datePicker.date)
        }
       self.dateTextField.resignFirstResponder()
    }
}

extension TableViewController2: UITableViewDelegate {
}

extension TableViewController2: UITableViewDataSource {
    
    //MARK: - Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // возращает количество строк в секции
        return listInfoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //возвращает элемент UITableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID2", for: indexPath) as? ListInfoCell
            else {
                fatalError()
        }
        
        let listInfoItem = listInfoItems[indexPath.row]
        cell.nameLabel.text = listInfoItem.cellName
        cell.infoLabel.text = listInfoItem.cellInfo
        //сохранение элементов
        if let encoded = try? self.encoder.encode(self.listInfoItems) {
            self.userDefaults.set(encoded, forKey: "listInfoItemsData")
            
        }
        
        return cell
    }
    
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCell = indexPath
        let alertController = UIAlertController (title: "Редактировать", message: nil, preferredStyle: .alert)
        let listInfoItem = listInfoItems[indexPath.row]
        
        if (listInfoItem.cellName == "Дата создания:" || listInfoItem.cellName == "Сделать до:") {
            alertController.addTextField
                {
                    (dateTextField) in
                    dateTextField.setInputViewDatePicker(target: self, selector: #selector(self.tapDone))
                    }
            let alertAction3 = UIAlertAction (title: "OK", style:.default)
            { (alert) in
                self.listInfoItems[indexPath.row].cellInfo = self.editItem!
                self.tableView2.reloadData()
            }
            alertController.addAction (alertAction3)
            present (alertController, animated: true, completion: nil)
        }
        else {
        
            alertController.addTextField {
                (textField) in
                textField.placeholder = "Введите текст"
            }
        
            let alertAction1 = UIAlertAction (title: "Отмена", style:.default)
            { (alert) in
            }
        
            let alertAction2 = UIAlertAction (title: "Изменить", style:.cancel)
            { (alert) in
                self.editItem = alertController.textFields![0].text
                self.listInfoItems[indexPath.row].cellInfo = self.editItem!
                self.tableView2.reloadData()
            }
            alertController.addAction (alertAction1)
            alertController.addAction (alertAction2)
            present (alertController, animated: true, completion: nil)
        }
    }
    
}
