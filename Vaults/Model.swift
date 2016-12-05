//
//  Model.swift
//  VaultKit
//
//  Created by Tomas Basham on 02/12/2016.
//  Copyright © 2016 tomasbasham.co.uk. All rights reserved.
//

/// Abstract model protocol.
///
/// A model is an object representing data within your applications
/// domain. It serves only to provide an `identifier` requirement on
/// any object that conforms to this protocol.
///
///     import Vaults
///
///     struct MyModel: Model {
///
///       let identifier: String
///     }
///
/// Furthermore it can be used as a type such that a `Vault` object
/// can be instantiated to accept any object providing it conforms
/// to this protocol, thus allowing a generic constraint that must
/// be handled internally by the vault.
public protocol Model {

  /// A unique string used to distinguish between updates and
  /// inserts. When a save request object is submitted the presence
  /// of the identifier is checked. If it exists then the record is
  /// considered dirty and is updated, otherwise it is inserted as a
  /// new record and given a unique identifier.
  var identifier: String { get }
}

/// Model equality function.
///
/// A model is said to be equal to another is both their identifiers
/// are equal. This is true since each record must satisfy identifier
/// uniqueness.
///
/// - Parameter lhs: A `Model` instance
/// - Parameter rhs: A `Model` instance
/// - Returns: `true` if the models are equal, otherwise `false`
public func ==(lhs: Model, rhs: Model) -> Bool {
  return lhs.identifier == rhs.identifier
}
