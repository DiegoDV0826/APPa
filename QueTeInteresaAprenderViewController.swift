//
//  QueTeInteresaAprenderViewController.swift
//  APPa
//
//  Created by user189869 on 5/13/21.
//

import UIKit
import AVFoundation

class QueTeInteresaAprenderViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "¿Qué te interesa aprender?";
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
            return false
    }
}
