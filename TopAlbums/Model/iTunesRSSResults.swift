//
//  iTunesRSSResults.swift
//  TopAlbums
//
//  Created by Christopher Morris on 7/29/18.
//  Copyright © 2018 Christopher Morris. All rights reserved.
//

import Foundation


struct Genre: Codable
{
	var genreId: String
	var name: String
	var url: String
}

struct Album: Codable
{
	var artistName: String
	var releaseDate: String
	var name: String
	var kind: String
	var copyright: String
	var artworkUrl100: String
	var genres: [Genre]
	var url: String
}

struct iTunesRSSResults: Codable
{
	struct iTunesRSSFeed: Codable
	{
		var title: String
		var copyright: String
		var results: [Album]
	}

	var feed: iTunesRSSFeed
}
