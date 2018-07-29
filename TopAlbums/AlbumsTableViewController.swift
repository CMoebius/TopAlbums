//
//  AlbumsTableViewController.swift
//  TopAlbums
//
//  Created by Christopher Morris on 7/29/18.
//  Copyright © 2018 Christopher Morris. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

	let model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

//		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AlbumCell")

		model.getAlbums(completion: { (error) in

			if let rss = self.model.rss
			{
				// We're in a background thread, update the UI on the main thread.
				DispatchQueue.main.async {
					self.navigationItem.title = rss.feed.title
					self.tableView.reloadData()
				}
			}
		})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return model.albumCount > 0 ? model.albumCount : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		var cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell")
		if cell == nil
		{
			cell = UITableViewCell(style: .subtitle, reuseIdentifier: "AlbumCell")
		}

		cell?.selectionStyle = .none

		if model.albumCount == 0
		{
			cell?.textLabel?.text = "Getting Information..."
		}
		else
		{
			if let album = model.rss?.feed.results[indexPath.row]
			{
				cell?.accessoryType = .disclosureIndicator
				cell?.textLabel?.text = album.name
				cell?.detailTextLabel?.text = album.artistName

				if let url = URL(string: album.artworkUrl100)
				{
					if let data = try? Data(contentsOf: url)
					{
						cell?.imageView?.image = UIImage(data: data)
					}
				}
			}
		}

        return cell!
	}

    // MARK: - Navigation

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		if model.albumCount > 0
		{
			self.performSegue(withIdentifier: "AlbumDetail", sender: tableView)
		}
	}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "AlbumDetail"
		{
			if let indexPath = tableView.indexPathForSelectedRow
			{
				if let album = model.rss?.feed.results[indexPath.row]
				{
					let vc = segue.destination as! AlbumDetailViewController
					vc.album = album
				}
			}
		}
    }
}
