//
//  ViewController.swift
//  album art
//
//  Created by Adolfo Lozano Mendez on 3/02/18.
//  Copyright © 2018 Adolfo Lozano Mendez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mTableView: UITableView!
    
    var picturesArray = [Paint]()
    var selectedPicture : Paint?
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.retrieveInfo), name: NSNotification.Name(rawValue:"paintingCreated"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        mTableView.delegate = self
        mTableView.dataSource = self
        
        retrieveInfo()
    }
    
    @objc func retrieveInfo(){
        
        self.picturesArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pictures")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    let painting = Paint()
                    painting.name = result.value(forKey: "name") as! String
                    painting.comment = result.value(forKey: "detail") as! String
                    painting.image = UIImage(data: result.value(forKey: "image") as! Data)!
                    
                    picturesArray.append(painting)
                    
                    self.mTableView.reloadData()
                }
            }
        } catch {
            print("there was an error")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picturesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = picturesArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPicture = picturesArray[indexPath.row]
        self.performSegue(withIdentifier: "showDetailViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetailViewController"){
            let destination = segue.destination as! DetailViewController
            destination.selectedPicture = selectedPicture
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnAddClick(_ sender: Any) {
        selectedPicture = nil
        performSegue(withIdentifier: "showDetailViewController", sender: self)
    }
    
}

