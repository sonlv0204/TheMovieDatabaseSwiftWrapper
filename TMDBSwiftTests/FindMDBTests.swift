//
//  FindMDBTests.swift
//  TMDBSwift
//
//  Created by George Kye on 2017-05-14.
//  Copyright © 2017 George. All rights reserved.
//

import XCTest
@testable import TMDBSwift

class FindMDBTests: XCTestCase {

  var key = "8a7a49369d1af6a70ec5a6787bbfcf79"
  
  
  //MARK: CollectionMDB Test
  
  func testFind() {
    var data: FindMDB?
    let expectation = self.expectation(description: "Wait for data to load.")

    FindMDB.find(key, id: "nm3592338", external_source: .imdb_id, completion: {
      find in
      data = find.1
      expectation.fulfill()
    })
//    
    waitForExpectations(timeout: 30, handler: nil)
    XCTAssertNotNil(data)
    guard let findData = data else { return }
    XCTAssertNotNil(findData.person_results)
    
    let person = findData.person_results?[0]
    XCTAssertEqual(person?.id, 1223786)
    XCTAssertEqual(person?.name, "Emilia Clarke")
    
    //Test known for movies
    let knownForMoviesIndex = person?.known_for.movies?.index(where: {
      $0.id == 87101
    })
     XCTAssertNotNil(knownForMoviesIndex)
    let terminatorMovie = person?.known_for.movies?[knownForMoviesIndex!]
    
    XCTAssertEqual(terminatorMovie?.original_title, "Terminator Genisys")
    XCTAssertEqual(terminatorMovie?.release_date, "2015-06-23")
    XCTAssertEqual(terminatorMovie?.id, 87101)
    
    //Test known for tv
    
    
    let knownForTVIndex = person?.known_for.tvShows?.index(where: {
      $0.id == 1399
    })
    XCTAssertNotNil(knownForTVIndex)
    let gameOfThronesTV = person?.known_for.tvShows?[knownForTVIndex!]
    
    XCTAssertEqual(gameOfThronesTV?.original_name, "Game of Thrones")
    XCTAssertEqual(gameOfThronesTV?.id, 1399)
    XCTAssertEqual(gameOfThronesTV?.first_air_date, "2011-04-17")
    
  }
  
}
