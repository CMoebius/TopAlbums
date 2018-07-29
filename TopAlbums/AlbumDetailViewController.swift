//
//  AlbumDetailViewController.swift
//  TopAlbums
//
//  Created by Christopher Morris on 7/29/18.
//  Copyright © 2018 Christopher Morris. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {

	var album: Album?

	@IBOutlet weak var art: UIImageView!
	@IBOutlet weak var albumName: UILabel!
	@IBOutlet weak var artistName: UILabel!
	@IBOutlet weak var genre: UILabel!
	@IBOutlet weak var releaseDate: UILabel!
	@IBOutlet weak var copyright: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		if let album = album
		{
			if let url = URL(string: album.artworkUrl100)
			{
				if let data = try? Data(contentsOf: url)
				{
					art.image = UIImage(data: data)
				}
			}

			albumName.text = album.name
			artistName.text = album.artistName

			let genres = album.genres.map { (genre) -> String in
				return genre.name
			}.joined(separator: ", ")
			genre.text = genres

			let df = DateFormatter()
			df.dateFormat = "yyyy-MM-dd"
			if let date = df.date(from: album.releaseDate)
			{
				df.dateStyle = .medium
				df.timeStyle = .none
				releaseDate.text = "Released \(df.string(from: date))"
			}
			copyright.text = album.copyright
		}
    }

	@IBAction func iTunesStore(_ sender: UIButton)
	{
		if let album = album,
			let url = URL(string: album.url)
		{
			if UIApplication.shared.canOpenURL(url)
			{
				UIApplication.shared.open(url, options: [:], completionHandler: nil)
			}
		}
	}

	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
