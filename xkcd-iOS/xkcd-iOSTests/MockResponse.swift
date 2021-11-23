//
//  MockResponse.swift
//  xkcd-iOSTests
//
//  Created by Saori Kurimoto on 2021/11/23.
//

import Foundation

class MockResponse {
    static let searchComicSuccessMockData = """
            {
                "success": true,
                "message": "",
                "results": [
                    {
                        "number": 1127,
                        "title": "Congress",
                        "titletext": "It'd be great if some news network started featuring partisan hack talking heads who were all Federalists and Jacksonians, just to see how long it took us to catch on.",
                        "url": "xkcd.com/1127",
                        "image": "https://imgs.xkcd.com/comics/congress.png",
                        "date": "2012-10-29"
                    },
                    {
                        "number": 1727,
                        "title": "Number of Computers",
                        "titletext": "They try to pad their numbers in the annual reports by counting Galileo's redundant systems as multiple computers, but they're falling behind badly either way.",
                        "url": "xkcd.com/1727",
                        "image": "https://imgs.xkcd.com/comics/number_of_computers.png",
                        "date": "2016-08-31"
                    }
                ]
            }
            """

    static let currentComicSuccessMockData = """
            {"month": "11", "num": 2545, "link": "", "year": "2021", "news": "", "safe_title": "Bayes' Theorem", "transcript": "", "alt": "P((B|A)|(A|B)) represents the probability that you'll mix up the order of the terms when using Bayesian notation.", "img": "https://imgs.xkcd.com/comics/bayes_theorem.png", "title": "Bayes' Theorem", "day": "22"}
            """

}
