//
//  LibroElectronicoViewController.swift
//  APPa
//
//  Created by user189869 on 5/15/21.
//

import UIKit
import AVFoundation

class LibroElectronicoViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDOI: UITextField!
    @IBOutlet weak var tfTitulo: UITextField!
    @IBOutlet weak var tfAno: UITextField!
    @IBOutlet weak var tfEditorial: UITextField!
    
    var nombre : String = ""
    var DOI : String = ""
    var editorial : String = ""
    var ano : String = ""
    var titulo : String = ""
    
    var bNombre : Bool = false
    var bDOI : Bool = false
    var bEditorial : Bool = false
    var bAno : Bool = false
    var bTitulo : Bool = false
    var bTodos : Bool = false
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nombre = tfNombre.text!
        DOI = tfDOI.text!
        editorial = tfEditorial.text!
        ano = tfAno.text!
        titulo = tfTitulo.text!
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitarTeclado))
        view.addGestureRecognizer(tap)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //var vistaPopOver
        if segue.identifier == "autor"{
            let vistaPopOver = segue.destination as! AutorViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "url"{
            let vistaPopOver = segue.destination as! URLViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "ano"{
            let vistaPopOver = segue.destination as! AnoViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }
        else if segue.identifier == "editorial"{
            let vistaPopOver = segue.destination as! EditorialViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "titulo"{
            let vistaPopOver = segue.destination as! TituloViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func Info(_ sender: UIButton) {
        let alerta = UIAlertController(title: "Información", message: "Debes llenar los campos con el formato correcto,en caso de no contar con algun dato, deja el espacio sin llenar. Para ver ejemplos pulsa el boton de informacion de cada campo", preferredStyle: .alert)

        let accion = UIAlertAction(title: "Entendido", style: .cancel, handler: nil)
        
        alerta.addAction(accion)
        
        present(alerta, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            let pathToSound = Bundle.main.path(forResource: "button", ofType: "mp3")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                let defaults = UserDefaults.standard
                let sound = defaults.bool(forKey: "sonido")
                if sound {
                    audioPlayer?.play()
                }
            } catch {
                
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfNombre.backgroundColor = UIColor.white
        tfDOI.backgroundColor = UIColor.white
        tfEditorial.backgroundColor = UIColor.white
        tfAno.backgroundColor = UIColor.white
        tfTitulo.backgroundColor = UIColor.white
    }
    
    @IBAction func btnContinuar(_ sender: UIButton) {
        nombre = tfNombre.text!
        DOI = tfDOI.text!
        editorial = tfEditorial.text!
        ano = tfAno.text!
        titulo = tfTitulo.text!
        
        if nombre == "" {
            tfNombre.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bNombre = false
        } else {
            tfNombre.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bNombre = true
        }
        if DOI == "" {
            tfDOI.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bDOI = false
        } else {
            tfDOI.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bDOI = true
        }
        if editorial == "" {
            tfEditorial.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bEditorial = false
        } else {
            tfEditorial.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bEditorial = true
        }
        if ano == "" {
            tfAno.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bAno = true
        } else {
            tfAno.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bAno = true
        }
        if titulo == "" {
            tfTitulo.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bTitulo = false
            
        } else {
            tfTitulo.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bTitulo = true
        }
        
        if(bNombre == true && bDOI == true && bEditorial == true && bAno == true && bTitulo == true){
            bTodos = true
        } else {
            bTodos = false
            let alerta = UIAlertController(title: "Incorrecto", message: "Debes llenar los campos marcados con rojo de forma correcta", preferredStyle: .alert)

            let accion = UIAlertAction(title: "Entendido", style: .cancel, handler: nil)
            
            alerta.addAction(accion)
            
            present(alerta, animated: true, completion: nil)
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
            return false
    }
    
    @IBAction func quitarTeclado(){
        view.endEditing(true)
    }
}

