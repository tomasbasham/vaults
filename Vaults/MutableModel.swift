//
//  MutableModel.swift
//  VaultKit
//
//  Created by Tomas Basham on 02/12/2016.
//  Copyright © 2016 tomasbasham.co.uk. All rights reserved.
//

/// Ambstract mutable model protocol.
///
/// A mutable model is an object representing data within your
/// applications domain. Unlike the `Model` protocol which should be
/// used for immutable object, this protocol allows properties to be
/// mutable.
///
///     import Vaults
///
///     struct MyModel: MutableModel {
///
///       var identifier: String?
///     }
///
/// To insert, update or remove a model from the store it must be
/// submitted to the vault as a mutable model wrapped within a
/// save request object.
public protocol MutableModel {

  /// A unique string used to distinguish between updates and
  /// inserts. When a save request object is submitted the presence
  /// of the identiier is checked. If it exists then the record is
  /// considered dirty and is updated, otherwise it is inserted as a
  /// new record and given a unique identifier.
  var identifier: String? { get set }

  /// The is the way to create a immutable instance of the record
  /// that can be sent to the persistence layer. From this point it
  /// is expected that the record have a unique identifier that will
  /// remain unchanged whilst the record exists.
  func copy() -> Model?
}
