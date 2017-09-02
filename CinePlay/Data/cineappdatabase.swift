//
//  cineappdatabase.swift
//  CinePlay
//
//  Created by wesley on 8/31/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import SQLite

class CinePlayDB {
    
    private let favorites = Table("favorites")
    private let id = Expression<Int64>("id")
    private let movie_id = Expression<Int64>("movie_id")
    
    static let instance = CinePlayDB()
    private let db: Connection?
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/CinePlay.sqlite3")
            
            createTable()
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    func createTable() {
        do {
            try db!.run(favorites.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(movie_id, unique: true)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func addFavorite(fmovie_id: Int64) -> Int64? {
        do {
            let insert = favorites.insert(movie_id <- fmovie_id)
            let id = try db!.run(insert)
            
            return id
        } catch {
            print("Insert failed")
            return nil
        }
    }
    
    func getFavorites() -> [Favorite] {
        var favorites = [Favorite]()
        
        do {
            for favorite in try db!.prepare(self.favorites) {
                favorites.append(Favorite(
                    id: favorite[id],
                    movie_id: favorite[movie_id]))
            }
        } catch {
            print("Select failed")
        }
        
        return favorites
    }
    
    func deletefavorite(fmovie_id: Int64) -> Bool {
        do {
            let favorite = favorites.filter(movie_id == fmovie_id)
            try db!.run(favorite.delete())
            return true
        } catch {
            
            print("Delete failed")
        }
        return false
    }
    
}
