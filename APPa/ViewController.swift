//
//  ViewController.swift
//  APPa
//
//  Created by user189869 on 4/18/21.
//

import UIKit
import MediaPlayer
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var btnComenzar: UIButton!
    
    
    var audioPlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actualizaInterfaz()
        //UILabel.appearance().font = UIFont(name: "Roboto", size: 30)
        // Do any additional setup after loading the view.
    }
    
    func actualizaInterfaz(){
        let defaults = UserDefaults.standard
        let theme = defaults.bool(forKey: "fondo")
        print(theme)
        if theme {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
        else{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
        let sound = defaults.bool(forKey: "sonido")
        let slider = MPVolumeView().subviews.first(where: { $0 is UISlider }) as? UISlider
        if sound{
            slider?.setValue(100, animated: false)
        }
        else{
            slider?.setValue(0, animated: false)
        }
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

