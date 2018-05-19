//
//  RegistroViewController.swift
//  Nutrey
//
//  Created by Manuela Garcia on 19/05/18.
//  Copyright © 2018 Manuela Garcia. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegistroViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registrarsePressed(_ sender: AnyObject) {
        SVProgressHUD.show()
    }
    


}
