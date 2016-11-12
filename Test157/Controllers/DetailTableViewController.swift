//
//  DetailTableViewController.swift
//  Test157
//
//  Created by Andrey on 07.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController
{
    var dataSource = [String]()
    var data = [ListObject]()
    
    func generateDates () {
        let year = Calendar.current.component(.year, from: Date())
        let yearFrom = year - 15
        let yearTo = year - 2
        for i in yearFrom ... yearTo {
            dataSource.append("\(i)")
        }
    }
    
    var detailName: String? { didSet { self.navigationItem.title = detailName } }
    var detailId: Int?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        //   tableView.backgroundView = indicator
        
        if let name = detailName { fetchData(from: name) }
    }
    
//    override func viewWillAppear(_ animated: Bool)
//    {
//            if dataSource.isEmpty { indicator.startAnimating() }
//    }
    
    // MARK: - Function
    
    func listObjectsHandler (list: [ListObject], error: Error?)
    {
        if error == nil  {
            if !list.isEmpty
            {
                dataSource.removeAll()
                data = list
                for clas in data {
                    self.dataSource.append(clas.name)
                }
                //indicator.stopAnimating()
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                self.tableView.reloadData()
                return
            }
        }
     //   indicator.stopAnimating()
    }
    
    func fetchData (from name: String)
    {
        switch name {
        case Localization.ListObjectsTitle.Year:
            generateDates ()
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            // indicator.stopAnimating()
        case Localization.ListObjectsTitle.Class:
            LibraryAPI.sharedInstance.classes() { classes, error in
                self.listObjectsHandler(list: classes, error: error)
            }
        case Localization.ListObjectsTitle.City:
            LibraryAPI.sharedInstance.cities() { cities, error in
                self.listObjectsHandler(list: cities, error: error)
            }
        case Localization.ListObjectsTitle.ShowRoom:
            if let cityId = detailId {
                LibraryAPI.sharedInstance.showRooms(for: cityId) { showRooms, error in
                    self.listObjectsHandler(list: showRooms, error: error)
                }
            }
        default:
            break
        }
    }
    
    func configureCell (cell: UITableViewCell, indexPath: IndexPath)
    {
        cell.textLabel?.text = "\(dataSource[indexPath.row])"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CellId.Detail2, for: indexPath)
        
        // Configure the cell
        configureCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: Storyboard.Segue.UnwindToRoot, sender: indexPath.row)
    }
    
    // MARK: - Storyboard
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var destinationvc = segue.destination
        if let navcon = destinationvc as? UINavigationController {
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        
        if let rootVC = destinationvc as? RootTableViewController {
            
            guard let selectedIndex = sender as? Int else {
                return
            }
            
            let cell = rootVC.tableView.cellForRow(at: rootVC.tableView.indexPathForSelectedRow!) as! DetailTableViewCell
            
            let selectedName = dataSource[selectedIndex]
            
            cell.detailLabel.text = selectedName
            cell.detailLabel.textColor = Constants.ActivityColor.Active
            
            switch detailName! {
            case Localization.Label.Car.year:

                if detailName! == Localization.Label.Car.year {
                    rootVC.newOrder.car.year = selectedName
                }
            case Localization.Label.Car.city:
                
                rootVC.newOrder.car.city = data[selectedIndex]
                
                // clean showroom if changing city
                rootVC.newOrder.car.showRoom = ListObject()
                let tag = rootVC.tag(label: Localization.Label.Car.showRoomId)
                let view = rootVC.tableView.viewWithTag(tag)
                let detailLabel = view as! UILabel
                detailLabel.textColor = Constants.ActivityColor.Inactive
                detailLabel.text = rootVC.labelsAndPlaceHolders[Localization.Label.Car.showRoomId]
                
            case Localization.Label.Car.classId:
                rootVC.newOrder.car.clas = data[selectedIndex]
                
            case Localization.Label.Car.showRoomId:
                rootVC.newOrder.car.showRoom =  data[selectedIndex]
                
            default: break
            }
            
            
        }
    }
}
