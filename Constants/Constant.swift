//
//  Constant.swift
//  Netflix
//
//  Created by Amirkhouzam on 19/01/2022.
//

import UIKit
import Alamofire

let widthint = Int(UIScreen.main.bounds.width)
let heightint = Int(UIScreen.main.bounds.height)

let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

//MARK: - URL MOVIES
let trendingmovies = "/trending/movie/day"
let categorypopular = "/movie/popular"
let categorynowplaying = "/movie/now_playing"
let categorytoprated = "/movie/top_rated"
let categoryupcoming = "/movie/upcoming"



//MARK: - Search url
let searchmovie = "https://api.themoviedb.org/3/search/movie?api_key=9bf3ee16cadd8a8f4cd76be582e80814&query="
let searchtvs = "https://api.themoviedb.org/3/search/tv?api_key=9bf3ee16cadd8a8f4cd76be582e80814&query="

//MARK: - Base urls
let generateaccesstoken = "/authentication/token/new"
let tmdbapikey = "?api_key=9bf3ee16cadd8a8f4cd76be582e80814"
let header = ["Content-Type":"application/json;charset=utf-8"]
let httpheader = HTTPHeaders(header)
let youtubeapikey = "&key=AIzaSyAtO4VgBCf0nx0YCebFIdbngUGeNhVH9Uk"
let youtubebaseurl = "https://youtube.googleapis.com/youtube/v3/search?q="
let baseurl = "https://api.themoviedb.org/3"

//MARK: - TVURLS

let topratedtv = "/tv/top_rated"
let populartv = "/tv/popular"
let trendingtv = "/trending/tv/day"

//MARK: - Image url

let imageurl = "https://image.tmdb.org/t/p/w500"

//let sss = "https://api.themoviedb.org/3/movie/popular?api_key=9bf3ee16cadd8a8f4cd76be582e80814"
