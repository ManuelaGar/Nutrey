//
//  IniciarSesionViewController.swift
//  Nutrey
//
//  Created by Manuela Garcia on 19/05/18.
//  Copyright © 2018 Manuela Garcia. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func iniciarSesionPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        
    }
    

}
