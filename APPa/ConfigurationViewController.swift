//
//  ConfigurationViewController.swift
//  APPa
//
//  Created by user189690 on 4/21/21.
//

import UIKit
import MediaPlayer

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var swFondo: UISwitch!
    @IBOutlet weak var swSonido: UISwitch!
    @IBOutlet weak var scLetra: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(guardarDatosInterfaz), name: UIApplication.didEnterBackgroundNotification, object: app)
        // Do any additional setup after loading the view.
        actualizaInterfaz()
        
    }
    
    @IBAction func guardarDatosInterfaz(){
        let defaults = UserDefaults.standard
        defaults.setValue(swFondo.isOn, forKey: "fondo")
        defaults.setValue(swSonido.isOn, forKey: "sonido")
        defaults.setValue(scLetra.selectedSegmentIndex, forKey: "letra")
        if swFondo.isOn{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
        else{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
        let slider = MPVolumeView().subviews.first(where: { $0 is UISlider }) as? UISlider
        if swSonido.isOn{
            slider?.setValue(100, animated: false)
        }
        else{
            slider?.setValue(0, animated: false)
        }
    }
    
    func actualizaInterfaz(){
        let defaults = UserDefaults.standard
        swFondo.isOn = defaults.bool(forKey: "fondo")
        swSonido.isOn = defaults.bool(forKey: "sonido")
        scLetra.selectedSegmentIndex =		 defaults.integer(forKey: "letra")
    }
    override func viewWillDisappear(_ animated: Bool) {
        guardarDatosInterfaz()
    }
    @IBAction func nightMode(_ sender: Any) {
        if swFondo.isOn{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
        else{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
    @IBAction func soundON(_ sender: Any) {
        let slider = MPVolumeView().subviews.first(where: { $0 is UISlider }) as? UISlider
        if swSonido.isOn{
            slider?.setValue(100, animated: false)
        }
        else{
            slider?.setValue(0, animated: false)
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

}
