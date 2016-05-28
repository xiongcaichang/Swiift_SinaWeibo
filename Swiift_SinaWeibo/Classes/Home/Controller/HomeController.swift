//
//  HomeController.swift
//  Swiift_SinaWeibo
//
//  Created by bear on 16/5/19.
//  Copyright © 2016年 bear. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeController: BaseTableViewController {
    
    
    
    
     let myRefresh = CCRefreshControl()
    
    lazy var statusListViewModel:StatusListViewModel? =  StatusListViewModel();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorLoginView.updateUI("关注一些人,回到这里看看有什么惊喜", imageName: "visitordiscover_feed_image_smallicon",isHome: true)
        
         setHomeNav();
        
        tabBarItem.badgeValue="10"
        
        if UserAccountViewModel.shareUserAccountViewModel.userLogin {
            tableView .registerClass(StatusCell.self, forCellReuseIdentifier: "HomeTableCell")
            

            self.tableView.rowHeight = UITableViewAutomaticDimension;
            self.tableView.estimatedRowHeight = 350;
            
            self.tableView.separatorStyle = .None
            
            tableView.addSubview(myRefresh)
            
            myRefresh.addTarget(self, action: #selector(HomeController.loadHomeData), forControlEvents: .ValueChanged)
            
            
      
           

        }
        
    }
    
    
    
    
    
    
    /**
     加载网络数据
     */
    @objc   func loadHomeData() {
        
        statusListViewModel?.statusViewModelArray.removeAll()
        
        statusListViewModel?.loadHomeData({ (isSucess) in
            
        
            
            if isSucess {
                self.tableView.reloadData();
                
                self.myRefresh.endRefreshing()
            }else{
                
                
                SVProgressHUD.showErrorWithStatus("错误")
            }
        })
        
               
    }
    



    

}



extension HomeController{
    
    
    

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.statusListViewModel!.statusViewModelArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:StatusCell = tableView.dequeueReusableCellWithIdentifier("HomeTableCell", forIndexPath: indexPath)  as! StatusCell
        
        
        let  statusViewModel = self.statusListViewModel!.statusViewModelArray[indexPath.row] ?? nil
        
        
        cell.statusViewModel=statusViewModel
        
        
        if indexPath.row == (self.statusListViewModel?.statusViewModelArray.count)!-1 {
            loadHomeData();
        }
        
        
        return cell;
    }
    
    
    
    
}


// MARK: - 导航相关
extension   HomeController{
    
    
    func setHomeNav() {
        self.navigationItem.rightBarButtonItem=UIBarButtonItem.createBarButtonItem("navigationbar_pop", title: "", target: self, action: #selector(popNext))
    }
    
    @objc  private  func popNext()  {
        
        self.navigationController!.pushViewController(DetailViewController(), animated: true)
    }
    
}
