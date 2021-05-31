//
//  LibroEditorViewController.swift
//  APPa
//
//  Created by user189869 on 5/15/21.
//


import UIKit
import AVFoundation

class LibroEditorViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfLugar: UITextField!
    @IBOutlet weak var tfEditorial: UITextField!
    @IBOutlet weak var tfAno: UITextField!
    @IBOutlet weak var tfTitulo: UITextField!
    @IBOutlet weak var tfEdicion: UITextField!
    
    var nombre : String = ""
    var lugar : String = ""
    var editorial : String = ""
    var ano : String = ""
    var titulo : String = ""
    var edicion : String = ""
    
    var bNombre : Bool = false
    var bLugar : Bool = false
    var bEditorial : Bool = false
    var bAno : Bool = false
    var bTitulo : Bool = false
    var bEdicion : Bool = false
    var bTodos : Bool = false
    
    var pressed : Bool = false
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nombre = tfNombre.text!
        lugar = tfLugar.text!
        editorial = tfEditorial.text!
        ano = tfAno.text!
        titulo = tfTitulo.text!
        edicion = tfEdicion.text!
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitarTeclado))
        view.addGestureRecognizer(tap)
        //Mover View por teclado
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        tfNombre.delegate = self
        tfLugar.delegate = self
        tfEditorial.delegate = self
        tfAno.delegate = self
        tfTitulo.delegate = self
        tfEdicion.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //var vistaPopOver
        if segue.identifier == "autor"{
            let vistaPopOver = segue.destination as! AutorViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "lugar"{
            let vistaPopOver = segue.destination as! LugarViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "editorial"{
            let vistaPopOver = segue.destination as! EditorialViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "ano"{
            let vistaPopOver = segue.destination as! AnoViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "titulo"{
            let vistaPopOver = segue.destination as! TituloViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "edicion"{
            let vistaPopOver = segue.destination as! EdicionViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "pagina"{
            let vistaPopOver = segue.destination as! PaginaViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "drag"{
            let vistaDrag = segue.destination as! ViewControllerPaginaWeb
            var arrAux: [String] = []
            arrAux.append(tfNombre.text! + "(Ed.).")
            if tfAno.text != ""{
                arrAux.append("(" + tfAno.text! + ").")
            }else {
                arrAux.append("(s.f.).")
            }
            arrAux.append(tfTitulo.text! + ".")
            if tfEdicion.text != "" {
                arrAux.append("(" + tfEdicion.text! + ").")
            }
            if tfLugar.text != "" {
                arrAux.append(tfLugar.text! + ": ")
            }
            arrAux.append(tfEditorial.text! + ".")
            vistaDrag.correctInfo = arrAux
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
        let alerta = UIAlertController(title: "Información", message: "Debes llenar los campos con el formato correcto, en caso de no contar con algun dato, deja el espacio sin llenar. Para ver ejemplos pulsa el botón de información de cada campo", preferredStyle: .alert)

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
        tfLugar.backgroundColor = UIColor.white
        tfEditorial.backgroundColor = UIColor.white
        tfAno.backgroundColor = UIColor.white
        tfTitulo.backgroundColor = UIColor.white
        tfEdicion.backgroundColor = UIColor.white
    }
    
    @IBAction func btnContinuar(_ sender: UIButton) {
        nombre = tfNombre.text!
        lugar = tfLugar.text!
        editorial = tfEditorial.text!
        ano = tfAno.text!
        titulo = tfTitulo.text!
        edicion = tfEdicion.text!
        
        if nombre == "" {
            tfNombre.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bNombre = false
        } else {
            tfNombre.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bNombre = true
        }
        if lugar == "" {
            tfLugar.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bLugar = true
        } else {
            tfLugar.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bLugar = true
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
        if edicion == "" {
            tfEdicion.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bEdicion = false
        } else {
            tfEdicion.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bEdicion = true
        }
        
        if(bNombre == true && bLugar == true && bEditorial == true && bAno == true && bTitulo == true && bEdicion == true){
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
    
    //Método para poder mover el view con el teclado
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfTitulo || textField == tfEdicion{
            pressed = true
        } else {
            pressed = false
        }
    }
    
    @objc func KeyboardWillChange(notification: Notification ) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if (notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification) && pressed {
            view.frame.origin.y = -keyboardReact.height
            
        } else {
            view.frame.origin.y = 0
        }
    }
}
