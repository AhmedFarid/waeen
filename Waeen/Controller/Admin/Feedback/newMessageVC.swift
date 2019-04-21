//
//  newMessageVC.swift
//  Waeen
//
//  Created by farid on 3/13/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class newMessageVC: UIViewController {

    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var messageTF: UITextView!
    @IBOutlet weak var sendBtn: roundedBtn!
    
    var x :String?
    var type = ""
    var namesz = ""
    var namess = ""
    var titless = ""
    var messagess = ""
    
    var singleItem: messages?
    
    var names = [newMasseges]()
    var types = ["parent","supervisor"]
    
    var typeString: String?
    var nameString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createtypePiker()
        textEnabeld()
        viewMasseges()
        if helper.getAPIToken().role == "parent" {
            self.typeTF.text = "admin"
            self.nameTf.text = helper.getAPIToken().name ?? ""
            self.typeTF.isEnabled = false
            self.nameTf.isEnabled = false
        }
    }
    
    func viewMasseges() {
        if x == nil{
        self.typeTF.text = type
        self.nameTf.text = singleItem?.receiver
        self.titleTF.text = singleItem?.title
        self.messageTF.text = singleItem?.body
            
            if singleItem != nil{
                self.typeTF.isEnabled = false
                self.nameTf.isEnabled = false
                self.titleTF.isEnabled = false
                self.messageTF.isEditable = false
                self.sendBtn.isHidden = true
            }
        }else {
            self.typeTF.text = type
            self.nameTf.text = namess
            self.titleTF.text = titless
            self.messageTF.text = messagess
            self.typeTF.isEnabled = false
            self.nameTf.isEnabled = false
            self.titleTF.isEnabled = false
            self.messageTF.isEditable = false
            self.sendBtn.isHidden = true
        }
    }
    
    @objc private func handleRefreshSentMasseges() {
        API_Masseges.typeMessage(type: typeString ?? ""){ (error: Error?, names: [newMasseges]?) in
            if let names = names {
                self.names = names
                print("xxx\(self.names)")
                self.textEnabeld()
            }
        }
        
    }
    
    func textEnabeld() {
        if names.isEmpty == true {
            nameTf.isEnabled = false
            nameTf.isEnabled = false
            //prandTF.isEnabled = false
        }else {
            nameTf.isEnabled = true
            nameTf.isEnabled = true
            //prandTF.isEnabled = true
        }
    }
    
    func createtypePiker(){
        let typePiker = UIPickerView()
        typePiker.delegate = self
        typePiker.dataSource = self
        typePiker.tag = 0
        typeTF.inputView = typePiker
        typePiker.reloadAllComponents()
    }
    
    func createnamePiker(){
        let namePiker = UIPickerView()
        namePiker.delegate = self
        namePiker.dataSource = self
        namePiker.tag = 1
        nameTf.inputView = namePiker
        handleRefreshSentMasseges()
        namePiker.reloadAllComponents()
    }
    
    
    @IBAction func sendBtn(_ sender: Any) {
        
        
        
        guard let name = typeTF.text, !name.isEmpty else {
            let messages = NSLocalizedString("enter type", comment: "hhhh")
            let title = NSLocalizedString("message", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        guard let phone = nameTf.text, !phone.isEmpty else {
            let messages = NSLocalizedString("enter name", comment: "hhhh")
            let title = NSLocalizedString("message", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        guard let email = titleTF.text, !email.isEmpty else {
            let messages = NSLocalizedString("Enter Title", comment: "hhhh")
            let title = NSLocalizedString("message", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        guard let message = messageTF.text, !message.isEmpty else {
            let messages = NSLocalizedString("enter message", comment: "hhhh")
            let title = NSLocalizedString("message", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        if helper.getAPIToken().role == "admin" {
        
                API_Masseges.sendmassage(type: typeString ?? "", id: namesz, title: titleTF.text ?? "", body: messageTF.text ?? "" ){ (error: Error?, success, data) in
                    if success {
                        let title = NSLocalizedString("Added", comment: "profuct list lang")
                        self.showAlert(title: title, message: data ?? "")
                    }else {
                        print("Error")
                    }
                }
        }else {
            API_Parents.sendmassage(title: titleTF.text ?? "", body: messageTF.text ?? "" ){ (error: Error?, success, data) in
                if success {
                    let title = NSLocalizedString("Added", comment: "profuct list lang")
                    self.showAlert(title: title, message: data ?? "")
                }else {
                    print("Error")
                }
            }
        }
        
    }
}

extension newMessageVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return types.count
        }else {
            return names.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return types[row]
        }else{
            return names[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            typeString = types[row]
            typeTF.text = typeString
            handleRefreshSentMasseges()
            self.view.endEditing(false)
            nameTf.text = ""
            createnamePiker()
        }else {
            nameString = names[row].name
            self.namesz = names[row].id
            nameTf.text = nameString
            self.view.endEditing(false)
        }
    }
}

