//
//  SearchResultView.swift
//  ImageSearchDemo
//
//  created by Suman on 11/25/17.
//  Copyright © 2017 suman. All rights reserved.
//

import UIKit
import AlamofireImage

protocol SearchResultViewDelegate: class {
    func resultView(sender: SearchResultView, didSelectResult resultItem:SearchItemModel)
}

class SearchResultView: UIView, UITableViewDataSource, UITableViewDelegate{
    
    weak var delegate:SearchResultViewDelegate?
    @IBOutlet weak var tableView: UITableView!
    var resultItems:[SearchItemModel] = []
    
        
    public func updateView(items:[SearchItemModel]) -> Void {
        self.resultItems = items;
        self.tableView.reloadData()
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell") as UITableViewCell!
        
        let item = self.resultItems[indexPath.row]
        cell.textLabel?.text = item.title
        cell.imageView?.image = nil
        
        cell.imageView?.af_setImage(withURL: URL(string:(item.imageModel?.thumbnailLink)!)!, completion: { (response) -> Void in
            cell.setNeedsLayout()
        })
        return cell
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.resultItems.count;
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results:"
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.resultView(sender: self, didSelectResult: self.resultItems[indexPath.row])
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
