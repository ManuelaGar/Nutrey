//
//  FormularioViewController.swift
//  Nutrey
//
//  Created by Manuela Garcia on 19/05/18.
//  Copyright © 2018 Manuela Garcia. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class FormularioViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellidos: UITextField!
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var edadDD: UITextField!
    @IBOutlet weak var edadMM: UITextField!
    @IBOutlet weak var edadAños: UITextField!
    @IBOutlet weak var pesoEnKg: UITextField!
    
    var sexo = ""
    var edadMeses = ""
    var fechaDeNacimiento = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombre.delegate = self
        apellidos.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func sexoMasculinoPressed(_ sender: AnyObject) {
        sexo = "Masculino"
    }
    
    @IBAction func sexoFemeninoPressed(_ sender: AnyObject) {
        sexo = "Femenino"
    }
    
    // MARK: - Guardar la información del usuario en Firebase y continuar
    
    @IBAction func continuarPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        nombre.isEnabled = false
        apellidos.isEnabled = false
        ID.isEnabled = false
        edadDD.isEnabled = false
        edadMM.isEnabled = false
        edadAños.isEnabled = false
        pesoEnKg.isEnabled = false
        
        let currentDate = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let currentYear = (currentDate?.component(NSCalendar.Unit.year, from: Date()))
        
        edadMeses = String(Int(edadMM.text!)! + (currentYear! - Int(edadAños.text!)!)*12)
        
        fechaDeNacimiento = "\(edadDD.text!)/\(edadMM.text!)/\(edadAños.text!)"
        
        let usuariosDB = Database.database().reference().child("Usuarios")

        let usuarioDiccionario =
            [
                "Email": Auth.auth().currentUser?.email,
                 "Nombre": nombre.text!,
                 "Apellidos": apellidos.text!,
                 "ID": ID.text!,
                 "Edad_en_meses": edadMeses,
                 "Fecha_de_nacimiento": fechaDeNacimiento,
                 "Sexo": sexo,
                 "Peso_en_kg": pesoEnKg.text!,
                 //TODO: Incluir codigo para localizar al usuario
                 "Ubicacion": ""
            ]
        
        usuariosDB.childByAutoId().setValue(usuarioDiccionario) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                print("Usuario guardado con exito")
                
                self.nombre.isEnabled = true
                self.apellidos.isEnabled = true
                self.ID.isEnabled = true
                self.edadDD.isEnabled = true
                self.edadMM.isEnabled = true
                self.edadAños.isEnabled = true
                self.pesoEnKg.isEnabled = true
                
                self.nombre.text = ""
                self.apellidos.text = ""
                self.ID.text = ""
                self.edadDD.text = ""
                self.edadMM.text = ""
                self.edadAños.text = ""
                self.pesoEnKg.text = ""
                self.sexo = ""
                self.edadMeses = ""
            }
        }
        
        performSegue(withIdentifier: "goToMediciones", sender: self)
    }
    
    @IBAction func salirPressed(_ sender: AnyObject) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("Error, hubo un problema al salir.")
        }
    }
    
}
