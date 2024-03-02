//
//  CocktailDetailController.swift
//  CocktailBook
//
//  Created by Nagarjuna on 3/2/24.
//

import UIKit

class CocktailDetailController: UIViewController {

    @IBOutlet weak var tableview:UITableView!
    var cocktail:Cocktail?
    @IBOutlet weak var favoriteBtn:UIButton!
    @IBOutlet weak var backBtn:UIButton!
    var titlestr:String? = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
        // Do any additional setup after loading the view.
    }
    
   func setupUI(){
        
        let defaults = UserDefaults.standard
        let array = defaults.stringArray(forKey:"favid") ?? [String]()
        if array.count > 0{
            if array.contains(String(cocktail!.id)){
                favoriteBtn.setImage(UIImage(named:"heartselect"), for: .normal)
            }else{
                favoriteBtn.setImage(UIImage(named:"heart"), for: .normal)
            }
        }
        tableview.estimatedRowHeight = 50// the estimated row height ..the closer the better
        tableview.rowHeight = UITableView.automaticDimension
       self.backBtn.setTitle("< \(String(describing: titlestr!))", for: .normal)
        
    }
    
    @IBAction func favBtnAction(id:UIButton){
        let defaults = UserDefaults.standard
        var array = defaults.stringArray(forKey:"favid") ?? [String]()
        if array.count > 0{
            if array.contains(String(cocktail!.id)){
                favoriteBtn.setImage(UIImage(named:"heart"), for: .normal)

                if let index = array.firstIndex(of:(String(cocktail!.id))){
                    array.remove(at: index)
                }
                
            }else{
                favoriteBtn.setImage(UIImage(named:"heartselect"), for: .normal)

                array.append(String(cocktail!.id))

            }
        } else {
            array.append(String(cocktail!.id))
        }
        
        defaults.set(array, forKey: "favid")
    }
    
    @IBAction func backBtnAction(id:UIButton){
        
        self.navigationController?.popViewController(animated: true)
        
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

extension CocktailDetailController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return cocktail?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = ""
        if indexPath.section == 0{
            cellIdentifier = "cocktailImageCell"
        }else{
            cellIdentifier = "cocktailRecepeCell"
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if indexPath.section == 0{
            let cocktailDescriptionLabel = cell.viewWithTag(104) as! UILabel
            cocktailDescriptionLabel.text = cocktail?.longDescription ?? ""
            let cocktaiImageview = cell.viewWithTag(103) as! UIImageView
            cocktaiImageview.image = UIImage(named:cocktail!.imageName)
            
        }else{
            let recepedetailLabel = cell.viewWithTag(107) as! UILabel
            recepedetailLabel.text = cocktail!.ingredients[indexPath.row]
            let arrowimage = cell.viewWithTag(106) as! UIImageView
            arrowimage.image = UIImage(named:"arrow")

        }
        
        
        return  cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 77
        }
        
        return 30
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerIdentifier = ""
        if section == 0{
            headerIdentifier = "imageHeaderCell"
        }else{
            headerIdentifier = "receipeHeaderCell"
        }
        let headerView = tableView.dequeueReusableCell(withIdentifier: headerIdentifier)!
        if section == 0{
            let cocktailTitleLabel = headerView.viewWithTag(100) as! UILabel
            cocktailTitleLabel.text = cocktail?.name ?? ""
            let timeLabel = headerView.viewWithTag(102) as! UILabel
            timeLabel.text = "\(cocktail?.preparationMinutes ?? 0) minutes"
            let timericon = headerView.viewWithTag(101) as! UIImageView
        }else{
            let receipeTitlelLabel = headerView.viewWithTag(105) as! UILabel
            receipeTitlelLabel.text = "Ingredients"
        }
        
        return headerView
        
        
        
    }
}
