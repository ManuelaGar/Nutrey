//
//  Formulario2ViewController.swift
//  Nutrey
//
//  Created by Manuela Garcia on 20/05/18.
//  Copyright © 2018 Manuela Garcia. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class Formulario2ViewController: UIViewController {

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellidos: UITextField!
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var fechaNacimiento: UITextField!
    @IBOutlet weak var sexo: UITextField!
    @IBOutlet weak var pesoEnKg: UITextField!
    
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Funcion para leer la informacion del usuario desde Firebase (falta probarla)
    
    func retrieveUserInfo() {
        let usuarioDB = Database.database().reference().child("Usuarios")
        usuarioDB.ref.observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.exists() {return}
            print(snapshot)
            print(snapshot.value!)
        }
        
        ref.child("Usuarios").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.nombre.text = snapshot.childSnapshot(forPath: "Nombre").value as? String
            self.apellidos.text = snapshot.childSnapshot(forPath: "Apellidos").value as? String
            self.ID.text = snapshot.childSnapshot(forPath: "ID").value as? String
            self.fechaNacimiento.text = snapshot.childSnapshot(forPath: "Fecha_de_nacimiento").value as? String
            self.sexo.text = snapshot.childSnapshot(forPath: "Sexo").value as? String
            self.pesoEnKg.text = snapshot.childSnapshot(forPath: "Peso_en_kg").value as? String
            
        })
    }
    
    // MARK: - Guardar la información actualizada del usuario en Firebase y continuar (falta probar)
    
    @IBAction func continuarPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        nombre.isEnabled = false
        apellidos.isEnabled = false
        ID.isEnabled = false
        fechaNacimiento.isEnabled = false
        pesoEnKg.isEnabled = false
        

        ref.child("Usuarios").child(userID!).updateChildValues(
            [
                "Nombre": nombre.text!,
                "Apellidos": apellidos.text!,
                "ID": ID.text!,
                "Fecha_de_nacimiento": fechaNacimiento,
                "Sexo": sexo,
                "Peso_en_kg": pesoEnKg.text!
            ])
        
        print("Usuario actualizado y guardado con exito")
        
        performSegue(withIdentifier: "goToMediciones", sender: self)
        
    }
    
}
