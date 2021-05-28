//
//  CapituloLibroViewController.swift
//  APPa
//
//  Created by user189869 on 5/15/21.
//

import UIKit
import AVFoundation

class CapituloLibroViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    
    @IBOutlet weak var tfAutor: UITextField!
    @IBOutlet weak var tfLugar: UITextField!
    @IBOutlet weak var tfEditorial: UITextField!
    @IBOutlet weak var tfAno: UITextField!
    @IBOutlet weak var tfTituloLibro: UITextField!
    @IBOutlet weak var tfEdicion: UITextField!
    @IBOutlet weak var tfAutorCapitulo: UITextField!
    @IBOutlet weak var tfTituloCapitulo: UITextField!
    @IBOutlet weak var tfPagina: UITextField!
    
    var autor : String = ""
    var lugar : String = ""
    var editorial : String = ""
    var ano : String = ""
    var titulolibro : String = ""
    var edicion : String = ""
    var autorcapitulo : String = ""
    var titulocapitulo : String = ""
    var pagina : String = ""
    
    var bAutor : Bool = false
    var bLugar : Bool = false
    var bEditorial : Bool = false
    var bAno : Bool = false
    var bTituloLibro : Bool = false
    var bEdicion : Bool = false
    var bPagina : Bool = false
    var bAutorCapitulo : Bool = false
    var bTituloCapitulo : Bool = false
    var bTodos : Bool = false
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        autor = tfAutor.text!
        lugar = tfLugar.text!
        editorial = tfEditorial.text!
        ano = tfAno.text!
        titulolibro = tfTituloLibro.text!
        edicion = tfEdicion.text!
        autorcapitulo = tfAutorCapitulo.text!
        titulocapitulo = tfTituloCapitulo.text!
        pagina = tfPagina.text!
        
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
        }else if segue.identifier == "edicion"{
            let vistaPopOver = segue.destination as! PaginaViewController
            vistaPopOver.popoverPresentationController!.delegate = self
        }else if segue.identifier == "drag"{
            let vistaDrag = segue.destination as! ViewControllerPaginaWeb
            var arrAux: [String] = []
            arrAux.append(tfAutor.text!)
            if tfAno.text != ""{
                arrAux.append("(" + tfAno.text! + ").")
            }else {
                arrAux.append("(s.f.).")
            }
            arrAux.append(tfTituloCapitulo.text! + ".")
            arrAux.append("En " + tfAutorCapitulo.text!)
            if tfEdicion.text != "" {
                arrAux.append("(" + tfEdicion.text! + ").")
            }
            else{
                arrAux.append(" (Ed.)." )
            }
            arrAux.append(tfTituloLibro.text!)
            arrAux.append(" (" + tfPagina.text! + ").")
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
                audioPlayer?.play()
            } catch {
                
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfAutor.backgroundColor = UIColor.white
        tfLugar.backgroundColor = UIColor.white
        tfEditorial.backgroundColor = UIColor.white
        tfAno.backgroundColor = UIColor.white
        tfTituloLibro.backgroundColor = UIColor.white
        tfEdicion.backgroundColor = UIColor.white
        tfAutorCapitulo.backgroundColor = UIColor.white
        tfTituloCapitulo.backgroundColor = UIColor.white
        tfPagina.backgroundColor = UIColor.white
    }
    
    @IBAction func btnContinuar(_ sender: UIButton) {
        autor = tfAutor.text!
        lugar = tfLugar.text!
        editorial = tfEditorial.text!
        ano = tfAno.text!
        titulolibro = tfTituloLibro.text!
        edicion = tfEdicion.text!
        autorcapitulo = tfAutorCapitulo.text!
        titulocapitulo = tfTituloCapitulo.text!
        pagina = tfPagina.text!
        
        if autor == "" {
            tfAutor.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bAutor = false
        } else {
            tfAutor.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bAutor = true
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
        if titulolibro == "" {
            tfTituloLibro.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bTituloLibro = false
            
        } else {
            tfTituloLibro.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bTituloLibro = true
        }
        if edicion == "" {
            tfEdicion.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bEdicion = false
        } else {
            tfEdicion.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bEdicion = true
        }
        if autorcapitulo == "" {
            tfAutorCapitulo.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bAutorCapitulo = false
        } else {
            tfAutorCapitulo.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bAutorCapitulo = true
        }
        if titulocapitulo == "" {
            tfTituloCapitulo.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bTituloCapitulo = false
        } else {
            tfTituloCapitulo.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bTituloCapitulo = true
        }
        if pagina == "" {
            tfPagina.backgroundColor = UIColor.red.withAlphaComponent(0.35)
            bPagina = false
        } else {
            tfPagina.backgroundColor = UIColor.green.withAlphaComponent(0.35)
            bPagina = true
        }
        
        if(bAutor == true && bLugar == true && bEditorial == true && bAno == true && bTituloLibro == true && bEdicion == true && bPagina == true && bAutorCapitulo == true && bTituloCapitulo == true){
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
