//
//  ViewController.swift
//  album art
//
//  Created by Adolfo Lozano Mendez on 3/02/18.
//  Copyright © 2018 Adolfo Lozano Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnAddClick(_ sender: Any) {
        performSegue(withIdentifier: "showDetailViewController", sender: self)
    }
    
}

