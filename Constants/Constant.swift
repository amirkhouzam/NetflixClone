//
//  Constant.swift
//  Netflix
//
//  Created by Amirkhouzam on 19/01/2022.
//

import UIKit
import Alamofire

let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

//MARK: - URL MOVIES
let trendingmovies = "/trending/movie/day"
let categorypopular = "/movie/popular"
let categorylatest = "/movie/latest"
let categorynowplaying = "/movie/now_playing"
let categorytoprated = "/movie/top_rated"
let categoryupcoming = "/movie/upcoming"
let generateaccesstoken = "/authentication/token/new"

let sss = "https://api.themoviedb.org/3/movie/popular?api_key=9bf3ee16cadd8a8f4cd76be582e80814"

//MARK: - Search url
let searchurl = "https://api.themoviedb.org/3/search/movie?api_key=9bf3ee16cadd8a8f4cd76be582e80814&query="

//MARK: - Base urls
let apikey = "?api_key=9bf3ee16cadd8a8f4cd76be582e80814"
let header = ["Content-Type":"application/json;charset=utf-8"]
let httpheader = HTTPHeaders(header)

let imageurl = "https://image.tmdb.org/t/p/w500"
let baseurl = "https://api.themoviedb.org/3"
//MARK: - TVURLS
let topratedtv = "/tv/top_rated"
let populartv = "/tv/popular"
let trendingtv = "/trending/tv/day"
