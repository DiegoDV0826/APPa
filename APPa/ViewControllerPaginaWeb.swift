//
//  ViewControllerPaginaWeb.swift
//  APPa
//
//  Created on 21/04/21.
//

import UIKit
import AVFoundation

class ViewControllerPaginaWeb: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate  {
    

    
    var audioPlayer: AVAudioPlayer?
    
    
    var info: [String] = []
    var info2: [String] = []
    var correctInfo: [String] = []
    var correct: Bool = false

    
    
    var source : IndexPath = []
    var indexDelete : IndexPath = []
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var referencia: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstCollectionView.dragDelegate = self
        self.firstCollectionView.dropDelegate = self
        self.firstCollectionView.dragInteractionEnabled = true
        
        self.secondCollectionView.dragDelegate = self
        self.secondCollectionView.dropDelegate = self
        self.secondCollectionView.dragInteractionEnabled = true
        self.secondCollectionView.reorderingCadence = .fast
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            let width = UIScreen.main.bounds.width
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            layout.itemSize = CGSize(width: width / 2, height: width / 2)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            secondCollectionView!.collectionViewLayout = layout
        
        delete.isHidden = true
        referencia.isHidden = true
        loadData()

    }
    
    func loadData(){
        let num = correctInfo.count - 1
        var numbers = Array(0...num)
        numbers.shuffle()
        for item in numbers {
            info.append(correctInfo[item])
        }
    }

    @IBAction func mostrarInstrucciones(_ sender: Any) {
        let alerta = UIAlertController(title: "Información", message: "Arrastra los elementos en el orden correcto segun el tipo de referencia elegida", preferredStyle: .alert)

        let accion = UIAlertAction(title: "Entendido", style: .cancel, handler: nil)
        
        alerta.addAction(accion)
        
        present(alerta, animated: true, completion: nil)
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
        let alerta = UIAlertController(title: "Información", message: "Debes ubicar los campos en el bloque superior en el orden correcto", preferredStyle: .alert)

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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == firstCollectionView {
            let size = info[indexPath.row].count
            let wid = size * 8 + 12
            return CGSize(width: wid, height: 30)
        }
        else {
            let size = info2[indexPath.row].count
            if size < 6 {
                let wid = size * 8 + 8
                return CGSize(width: wid, height: 30)
            }
            let wid = size * 7 + 8
            return CGSize(width: wid, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionView {
            return info.count
        }
        return info2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            cell.configure(with: info[indexPath.row])
            cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 5
            return cell
        }
        else {
            let cell2 = secondCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            cell2.backgroundColor = UIColor(white: 1, alpha: 0)
            cell2.configure(with: info2[indexPath.row])
            cell2.infoLbl.textColor = UIColor.black
            return cell2
        }
    }
    
    //Re order items whithin the same collection view
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView)
    {
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath
        {
            var dIndexPath = destinationIndexPath
            if dIndexPath.row >= collectionView.numberOfItems(inSection: 0)
            {
                dIndexPath.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            collectionView.performBatchUpdates({
                if collectionView === self.secondCollectionView
                {
                    self.info2.remove(at: sourceIndexPath.row)
                    self.info2.insert(item.dragItem.localObject as! String, at: dIndexPath.row)
                }
                else
                {
                    self.info.remove(at: sourceIndexPath.row)
                    self.info.insert(item.dragItem.localObject as! String, at: dIndexPath.row)
                }
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [dIndexPath])
            })
            coordinator.drop(items.first!.dragItem, toItemAt: dIndexPath)
            isCorrect()
        }
    }
    
    //Copy cell from collection 1 in collection 2
    private func copyItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView)
    {
        collectionView.performBatchUpdates({
            var indexPaths = [IndexPath]()
            for (index, item) in coordinator.items.enumerated()
            {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                if collectionView === self.secondCollectionView
                {
                    self.info2.insert(item.dragItem.localObject as! String, at: indexPath.row)
                }
                else
                {
                    self.info.insert(item.dragItem.localObject as! String, at: indexPath.row)
                    info2.remove(at: source.row)
                    secondCollectionView.deleteItems(at: [source])
                }
                indexPaths.append(indexPath)
            }
            collectionView.insertItems(at: indexPaths)
            isCorrect()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem]
    {
        let item = collectionView == firstCollectionView ? self.info[indexPath.row] : self.info2[indexPath.row]
        source = indexPath
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool
    {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        if collectionView === self.firstCollectionView
        {
            if collectionView.hasActiveDrag
            {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
            else
            {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
        }
        else
        {
            if collectionView.hasActiveDrag
            {
                if referencia.isHidden {
                    return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
                }
                else {
                    return UICollectionViewDropProposal(operation: .forbidden)
                }
            }
            else
            {
                if referencia.isHidden {
                    return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
                }
                else {
                    return UICollectionViewDropProposal(operation: .forbidden)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath
        {
            destinationIndexPath = indexPath
        }
        else
        {
            // Get last index path of table view.
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        switch coordinator.proposal.operation
        {
        case .move:
            self.reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            break
            
        case .copy:
            self.copyItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == secondCollectionView {
            delete.isHidden = false
            indexDelete = indexPath
        }
    }
    
    @IBAction func deleteItem(_ sender: UIButton) {
        info2.remove(at: indexDelete.row)
        secondCollectionView.deleteItems(at: [indexDelete])
        delete.isHidden = true
        isCorrect()
    }
    
    func isCorrect(){
        correct = true
        var ref: String = "Referencia final: "
        if info2.count == correctInfo.count {
            for i in 0..<correctInfo.count {
                ref = ref + info2[i] + " "
                if correctInfo[i] != info2[i] {
                    correct = false
                }
            }
            if correct {
                secondCollectionView.backgroundColor = UIColor.green.withAlphaComponent(0.35)
                delete.isHidden = true
                referencia.isHidden = false
                referencia.text = ref
            }
        }
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
            return false
    }
    
}
