//
//  RootTableViewController.swift
//  Test157
//
//  Created by Andrey on 07.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController
{
    var validationError = false
    var sections: [ [String] ] = []
    var labelsAndPlaceHolders: [String:String] = [:]
    // decode Data from file or create new Order
    var newOrder: Order = LibraryAPI.sharedInstance.getOrder()
    
    enum CellTag: Int {
        // order by tableview
        // user
        case Gender = 1
        case FirstName = 3
        case LastName = 2
        case MiddleName = 4
        case Email = 6
        case Phone = 5
        // car
        case Vin = 7
        case Year = 8
        case ClassId = 9
        case City = 10
        case ShowRoomId = 11
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        labelsAndPlaceHolders = newOrder.labelsAndPlaceHolders()
        sections = [ newOrder.userLabels , newOrder.carLabels ]
    }
    
    // MARK: - Storyboard
    
    @IBAction func submitPressed(_ sender: Any)
    {
        validate ()
    }
    
    // MARK: - Functions
    
    func reuseIdentifier (for label: String) -> String {
        var identifier = ""
        switch label {
        case Localization.Label.User.lastName,
             Localization.Label.User.firstName,
             Localization.Label.User.middleName,
             Localization.Label.User.phone,
             Localization.Label.User.email,
             Localization.Label.Car.vin :
            
            identifier = Storyboard.CellId.TextInput
            
        case Localization.Label.User.gender:
            
            identifier = Storyboard.CellId.Segment
            
        case Localization.Label.Car.year,
             Localization.Label.Car.classId,
             Localization.Label.Car.city,
             Localization.Label.Car.showRoomId :
            
            identifier = Storyboard.CellId.Detail
            
        default:
            identifier = Storyboard.CellId.TextInput
        }
        return identifier
    }
    
    func configureCell (cell: UITableViewCell , label: String) {
        
        if labelsAndPlaceHolders.isEmpty {
            return
        }
        
        switch cell.reuseIdentifier! {
        case Storyboard.CellId.TextInput :
            if let configuredCell = cell as? TextInputTableViewCell {
                
                configuredCell.label.text = label
                configuredCell.textField.tag = tag(label: label)
                configuredCell.textField.delegate = self
                var text = ""
                switch label {
                case Localization.Label.User.lastName:
                    text = newOrder.user.lastName
                case Localization.Label.User.firstName:
                    text = newOrder.user.firstName
                case Localization.Label.User.middleName:
                    text = newOrder.user.middleName
                case Localization.Label.User.phone:
                    text = newOrder.user.phone
                case Localization.Label.User.email:
                    text = newOrder.user.email
                case Localization.Label.Car.vin:
                    text = newOrder.car.vin
                default:
                    break
                }
                configuredCell.textField.text = text
                
                var placeHolderColor = Constants.ActivityColor.Inactive
                
                if validationError && configuredCell.textField.text!.isEmpty {
                    placeHolderColor = Constants.ActivityColor.Empty
                }
                
                configuredCell.textField.attributedPlaceholder = NSAttributedString(
                    string: labelsAndPlaceHolders[label]!,
                    attributes: [NSForegroundColorAttributeName: placeHolderColor])
                
                // for VIN cell
                if label == Localization.Label.User.phone  { // "VIN"
                    configuredCell.textField.keyboardType = .numberPad
                } else {
                    configuredCell.textField.keyboardType = .default
                }
            }
        case Storyboard.CellId.Segment :
            if let configuredCell = cell as? SegmentTableViewCell {
                
                configuredCell.label.text = label
                configuredCell.segment.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for: [.valueChanged , .touchUpInside])
                configuredCell.segment.layer.cornerRadius = 0.0
                configuredCell.segment.layer.borderColor = UIColor.white.cgColor
                configuredCell.segment.layer.borderWidth = 1.5
            }
        case Storyboard.CellId.Detail :
            
            if let configuredCell = cell as? DetailTableViewCell {
                configuredCell.label.text = label
                
                var text = ""
                if !newOrder.validate().incorrectLabels.contains(label) {
                    
                    switch label {
                    case Localization.Label.Car.year:
                        text = newOrder.car.year
                    case Localization.Label.Car.classId:
                        text = newOrder.car.clas.name
                    case Localization.Label.Car.showRoomId:
                        text = newOrder.car.showRoom.name
                    case Localization.Label.Car.city:
                        text = newOrder.car.city.name
                    default:
                        break
                    }
                    configuredCell.detailLabel.textColor = Constants.ActivityColor.Active
                } else {
                    text = labelsAndPlaceHolders[label]!
                    configuredCell.detailLabel.textColor = validationError ? Constants.ActivityColor.Empty : Constants.ActivityColor.Inactive
                }
                configuredCell.detailLabel.text = text
                configuredCell.detailLabel.tag = tag(label: label)
            }
        default: break
        }
    }
    
    // tag from label cell
    func tag(label: String) -> Int {
        switch label {
        // user
        case Localization.Label.User.firstName:
            return CellTag.FirstName.rawValue
        case Localization.Label.User.lastName:
            return CellTag.LastName.rawValue
        case Localization.Label.User.email:
            return CellTag.Email.rawValue
        case Localization.Label.User.middleName:
            return CellTag.MiddleName.rawValue
        case Localization.Label.User.phone:
            return CellTag.Phone.rawValue
        case Localization.Label.User.gender:
            return CellTag.Gender.rawValue
        // car
        case Localization.Label.Car.vin:
            return CellTag.Vin.rawValue
        case Localization.Label.Car.city:
            return CellTag.City.rawValue
        case Localization.Label.Car.classId:
            return CellTag.ClassId.rawValue
        case Localization.Label.Car.showRoomId:
            return CellTag.ShowRoomId.rawValue
        case Localization.Label.Car.year:
            return CellTag.Year.rawValue
        default:
            return 0
        }
    }
    
    func validate ()
    {
        let validation = newOrder.validate()
        validationError = !validation.isValid
        
        if validationError {
            alertMessage(title: Localization.Alert.Title.emptyOrder , with: Localization.Alert.Message.fillAllRows)
            
            for label in validation.incorrectLabels
            {
                switch label
                {
                case Localization.Label.User.firstName,
                     Localization.Label.User.lastName,
                     Localization.Label.User.middleName,
                     Localization.Label.User.email,
                     Localization.Label.User.phone,
                     Localization.Label.Car.vin:
                    
                    let view = self.tableView.viewWithTag(tag(label: label))
                    let textField = view as! UITextField
                    let text = textField.text!
                    let textPlaceholder = textField.placeholder!
                    textField.attributedPlaceholder = NSAttributedString(
                        string: textPlaceholder,
                        attributes: [NSForegroundColorAttributeName: Constants.ActivityColor.Empty] )
                    if !text.isEmpty {
                        textField.attributedText = NSAttributedString(string: text,
                                                                      attributes: [NSForegroundColorAttributeName: Constants.ActivityColor.Empty])
                    }
                case Localization.Label.Car.year,
                     Localization.Label.Car.city,
                     Localization.Label.Car.classId,
                     Localization.Label.Car.showRoomId:
                    
                    let view = self.tableView.viewWithTag(tag(label: label))
                    let detailLabel = view as! UILabel
                    detailLabel.textColor = Constants.ActivityColor.Empty
                    
                default:
                    break
                }
            }
        } else {
            postToServer ()
        }
    }
    
    func postToServer ()
    {
            LibraryAPI.sharedInstance.workSheets(with: newOrder) {
                response, error in
                
                if error == nil {
                    let HTTPURLResponse = response as! HTTPURLResponse
                    print("statusCode \(HTTPURLResponse.statusCode)")

                    if HTTPURLResponse.statusCode == 204 {
                        self.saveOrder()
                        self.alertMessage(title: Localization.Alert.Title.success, with:Localization.Alert.Message.orderAccepted )
                    } else {
                        self.alertMessage(title: Localization.Alert.Title.error, with: Localization.Alert.Message.serverError)
                    }
                } else {
                    self.alertMessage(title:  Localization.Alert.Title.error, with: error!.localizedDescription)
                }
            }
    }
    
    func alertMessage (title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Localization.Alert.Title.ok, style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // encode Data to file if submission successful
    func saveOrder () {
        LibraryAPI.sharedInstance.saveOrder()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sections.isEmpty { return 0 }
        
        return sections[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let label = sections[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(for: label), for: indexPath)
        configureCell(cell: cell, label: label)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row > 0 {

            if indexPath.row == 4  && newOrder.car.validate().incorrectLabels.contains(Localization.Label.Car.city) {
                alertMessage(title: Localization.Alert.Title.emptyCity, with: Localization.Alert.Message.chooseCity )
                tableView.deselectRow(at: indexPath, animated: true)
                return
            }
            performSegue(withIdentifier: Storyboard.Segue.Detail, sender: sections[1][indexPath.row])
        }
    }
    
    // MARK: - Navigation

    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationvc = segue.destination
        if let navcon = destinationvc as? UINavigationController {
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        
        if let detailVC = destinationvc as? DetailTableViewController {
            
            if let detailName = sender as? String {
                detailVC.detailName = detailName
                
                if detailName == Localization.Label.Car.showRoomId {
                    detailVC.detailId = newOrder.car.city.id
                }
            }
        }
    }
    
    // MARK: - Segmented Control
    
    func segmentedControlValueChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            newOrder.user.gender = User.Gender.Male.rawValue
        } else {
            newOrder.user.gender = User.Gender.Female.rawValue
        }
    }
}

// MARK: - TextField delegate

extension RootTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField.tag == CellTag.Phone.rawValue {
            
            if let number = Int(string) {
                if number < 0 && number > 9 { return false }
            } else {
                if string != "" { return false }
            }
            
            var text = HelpfulFunctions.cleanPhoneNumber(textField.text! + string)
            if string == "" && text.characters.count > 0 {
                text.remove(at: text.index(before: text.endIndex))
            }
            text = HelpfulFunctions.phoneNumber(from: text)
            textField.text = text
            if text.characters.count == Constants.PhoneNumberLimit {
                textField.resignFirstResponder()
            }
            
            return false
        }
        
        if textField.tag == CellTag.Vin.rawValue {
            var text = textField.text!
            var count = text.characters.count
            if count <= Constants.VINNumberLimit {
                
                text += string
                count = text.characters.count
                
                if count > Constants.VINNumberLimit {
                    text = textField.text!
                }
            }
            
            if string == "" && count > 0 {
                text.remove(at: text.index(before: text.endIndex))
            }
            
            textField.text = text
            
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textField.attributedText = NSAttributedString(string: textField.text!,
                                                      attributes: [NSForegroundColorAttributeName: Constants.ActivityColor.Active])
        
        switch textField.tag {
        case CellTag.LastName.rawValue:
            newOrder.user.lastName = textField.text!
        case CellTag.FirstName.rawValue:
            newOrder.user.firstName = textField.text!
        case CellTag.MiddleName.rawValue:
            newOrder.user.middleName = textField.text!
        case CellTag.Phone.rawValue:
            newOrder.user.phone = textField.text!
        case CellTag.Email.rawValue:
            newOrder.user.email = textField.text!
        case CellTag.Vin.rawValue:
            newOrder.car.vin = textField.text!

        default:
            break
        }
    }
}
