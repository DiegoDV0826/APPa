//
//  LibroElectronicoViewController.swift
//  APPa
//
//  Created by user189869 on 5/15/21.
//

import UIKit
import AVFoundation

class LibroElectronicoViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
}

