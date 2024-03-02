import UIKit
class MainScreenViewController: UIViewController {
    
    private let cocktailsAPI: CocktailsAPIDeligate = FakeCocktailsAPI()
    
    private var viewModel = CocktailViewModel()
    
    @IBOutlet var titleLable:UILabel!
    @IBOutlet var optionsView:UIView!
    @IBOutlet var allBtn:UIButton!
    @IBOutlet var alcoholicBtn:UIButton!
    @IBOutlet var nonalcoholicBtn:UIButton!
    @IBOutlet var tableview:UITableView!

    var cocktails:[Cocktail] = [Cocktail]()
    var allCocktails:[Cocktail] = [Cocktail]()
    var nonAlcoholicCocktails:[Cocktail] = [Cocktail]()
    var alcoholicCocktails:[Cocktail] = [Cocktail]()
    var favCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        

        viewModel.fetchCocktails()
        setupUI()
        tableview.estimatedRowHeight = 50// the estimated row height ..the closer the better
        tableview.rowHeight = UITableView.automaticDimension
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.rearrangeCocktails()
        }


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       rearrangeCocktails()
        
    }
    

    @IBAction func optionBtnClicked(_ sender:UIButton) {
        
        
        cocktails = [Cocktail]()
        if sender.tag == 101{
            // all  action
            allBtn.backgroundColor = UIColor.lightGray
            alcoholicBtn.backgroundColor = UIColor.white
            nonalcoholicBtn.backgroundColor = UIColor.white
            cocktails = allCocktails
            titleLable.text = "All cocktails"
            self.rearrangeCocktails()


        }else if(sender.tag == 102){
            // alchohol action
            allBtn.backgroundColor = UIColor.white
            alcoholicBtn.backgroundColor = UIColor.lightGray
            nonalcoholicBtn.backgroundColor = UIColor.white
            cocktails = filterCocktails(byType:"alcoholic")
            self.rearrangeCocktails()
            titleLable.text = "Alcoholic cocktails"



            
        }else{
            // non-alchohol action
            allBtn.backgroundColor = UIColor.white
            alcoholicBtn.backgroundColor = UIColor.white
            nonalcoholicBtn.backgroundColor = UIColor.lightGray
            cocktails = filterCocktails(byType:"non-alcoholic")
            self.rearrangeCocktails()
            titleLable.text = "Non-Alcoholic cocktails"

        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                    // Change the background color to red after the delay
                  self.tableview.reloadData()
            
                }
        
      
        
        
        
    }
    
    func filterCocktails(byType type: String) -> [Cocktail] {
        cocktails = [Cocktail]()
        let filteredCocktails = allCocktails.filter { $0.type.lowercased() == type.lowercased() }
        print(filteredCocktails)

        return filteredCocktails
    }
    
    func rearrangeCocktails(){
        let defaults = UserDefaults.standard
        let array = defaults.stringArray(forKey:"favid") ?? [String]()

        if array.count > 0{
            var favCocktail = [Cocktail]()
            var unfavCocktail = [Cocktail]()

            for cocktailObj in cocktails{
                if array.contains(String(cocktailObj.id)){
                    favCocktail.append(cocktailObj)
                }else{
                    unfavCocktail.append(cocktailObj)
                }
            }
            defaults.set(favCocktail.count, forKey: "favCount")

            cocktails = favCocktail.sorted() + unfavCocktail.sorted()
            DispatchQueue.main.async {
                self.tableview.reloadData()

            }
        }
    }

    
    
    
    
    
// setup ui
    
    func setupUI(){
        // Set corner radius
               optionsView.layer.cornerRadius = 10
               // Set border width and color
              optionsView.layer.borderWidth = 2
        optionsView.layer.borderColor = UIColor.lightGray.cgColor
        allBtn.backgroundColor = UIColor.lightGray


    }
    

}
extension MainScreenViewController:CocktailViewModelDelegate{
    
    func cocktailsUpdated(_ cocktails: [Cocktail]) {
        print(cocktails[0].name)
        
        DispatchQueue.main.async {
            self.allCocktails = cocktails.sorted()
            self.cocktails = cocktails.sorted()
            self.tableview.reloadData()
        }
       
        
    }
    
}
extension MainScreenViewController:UITableViewDataSource,UITableViewDelegate{
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CocktailCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CocktailCell else {
            return UITableViewCell()
        }
        favCount = UserDefaults.standard.integer(forKey: "favCount")
        cell.titleLable.text = cocktails[indexPath.row].name
        cell.shortDescriptionLbl.text = cocktails[indexPath.row].shortDescription
        if indexPath.row < favCount{
            cell.favImage.image = UIImage(named:"heartselect")
        }else{
            cell.favImage.image = UIImage(named:"")

        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stoaryboard = UIStoryboard(name:"Cocktail", bundle: nil)
        let cocktaildetailVC = stoaryboard.instantiateViewController(withIdentifier:"CocktailDetailController") as! CocktailDetailController
        cocktaildetailVC.cocktail = cocktails[indexPath.row]
        cocktaildetailVC.titlestr = titleLable.text ?? ""
        self.navigationController?.pushViewController(cocktaildetailVC, animated:true)
    }
    
    
    
    
}
