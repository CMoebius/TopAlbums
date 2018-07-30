//
//  Model.swift
//  TopAlbums
//
//  Created by Christopher Morris on 7/28/18.
//  Copyright © 2018 Christopher Morris. All rights reserved.
//

import Foundation

struct RSSFeedError: LocalizedError
{
	var localizedDescription: String { return message }

	private var message: String

	init(message: String)
	{
		self.message = message
	}
}

class Model
{
	var rss: iTunesRSSResults?
	
	var albumCount: Int
	{
		get {
			return rss?.feed.results.count ?? 0
		}
	}

	func getAlbums(completion: ((Error?)->())?){
		if let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/10/explicit.json")
		{
			let task = URLSession.shared.dataTask(with: url) {(data, response, error) in

				guard error == nil else
				{
					completion?(error)
					return
				}

				guard let data = data else
				{
					let error = RSSFeedError(message: "Error getting feed data: No Data Returned")
					completion?(error)
					return
				}

				do
				{
					self.rss = try JSONDecoder().decode(iTunesRSSResults.self, from: data)

					completion?(nil)
				}
				catch let jsonError
				{
					completion?(jsonError)
				}
			}

			task.resume()
		}
	}
}
