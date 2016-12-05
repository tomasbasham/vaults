//
//  Adapter.swift
//  VaultKit
//
//  Created by Tomas Basham on 02/12/2016.
//  Copyright © 2016 tomasbasham.co.uk. All rights reserved.
//

/// A type representing an error value that can be thrown.
///
/// Special subtypes of `Error` the are specifc to the Adapter domain.
/// They can be used to represent an error in Swift’s error handling
/// system.
public enum AdapterError: Error {

  /// Thrown when the adapter is forced to abourt a transaction.
  case Abort(String)

  /// Thrown when a model is given an id which already exists in a vault.
  case Conflict(String)

  /// Thrown when an adpter transaction results in a forbidden action.
  case Forbidden(String)

  /// Thrown when a transaction was unable to process a request because the content was not semantically correct or meaningful.
  case Invalid(String)

  /// Thrown when no model can be found.
  case NotFound(String)

  /// Thrown when there is a generic server error.
  case Server(String)

  /// Thrown when an adapter transactin timesout.
  case Timeout(String)

  /// Thrown when an adapter transaction results in an unauthroised action.
  case Unauthorized(String)
}

/// Abstract adapter protocol.
///
/// An adapter is an object that receives requests from a vault and
/// translates them into the appropriate action to take against your
/// persistence layer. The persistence layer is usually an HTTP API,
/// but may be anything, such as an ephemeral local storage. Typically
/// the adapter is not invoked directly instead its functionality is
/// accessed through the vault.
///
///     import Vaults
///
///     struct MyAdapter: Adapter {
///
///       ...
///     }
///
/// An Adapter is an abstract base class that you should adopt in
/// your application to customise access to your persistence layer.
/// For an example implementation see `KeyedArchiveAdapter`.
public protocol Adapter {

  /// Find the records for the model to which this adapter
  /// belongs, returning them as a simple collection.
  ///
  /// - Returns: An array of objects conforming to the `Model` protocol
  func findAll() -> [Model]?

  /// Find a record with a given id for the model to which
  /// this adapter belongs.
  ///
  /// - Parameter id: Unique identifier for a record
  /// - Returns: An object conforming to the `Model` protocol that has the specified id
  func findRecord(_ id: String) -> Model?

  /// Commit changes to the persistence store.
  ///
  /// - Parameter models: An array of objects conforming to the `Model` protocol
  func commit(models: [Model])
}

/// Abstract adapter protocol.
///
/// An adapter is an object that receives requests from a vault and
/// translates them into the appropriate action to take against your
/// persistence layer. The persistence layer is usually an HTTP API,
/// but may be anything, such as an ephemeral local storage. Typically
/// the adapter is not invoked directly instead its functionality is
/// accessed through the vault.
///
///     import Vaults
///
///     struct MyQueryingAdapter: QueryingAdapter {
///       ...
///     }
///
/// To search for specific records using attributes beyond the records
/// unique id an adapter needs to query the persistence layer.
public protocol QueryingAdapter: Adapter {

  /// The store will call query when multiple records are
  /// expected to be returned from a single query.
  ///
  /// - Parameter properties: A dictionary of key/value pairs defining model properties
  /// - Returns: An array of objects conforming to the `Model` protocol
  func query(_ properties: [String: AnyObject]) -> [Model]?

  /// The store will call query record when a single record is
  /// expected from a query.
  ///
  /// - Parameter properties: A dictionary of key/value pairs defining model properties
  /// - Returns: An object confirming to the `Model` protocol
  func queryRecord(_ properties: [String: AnyObject]) -> Model?
}

/// Abstract adapter protocol.
///
/// An adapter is an object that receives requests from a vault and
/// translates them into the appropriate action to take against your
/// persistence layer. The persistence layer is usually an HTTP API,
/// but may be anything, such as an ephemeral local storage. Typically
/// the adapter is not invoked directly instead its functionality is
/// accessed through the vault.
///
///     import Vaults
///
///     struct MyCoalescingAdapter: CoalescingAdapter {
///       ...
///     }
///
/// To improve the network performance of your application, you can
/// optimize your adapter by implementing these lower-level methods
public protocol CoalescingAdapter: Adapter {

  /// The store will call find many instead of multiple find
  /// record requests to find multiple records simultaneously
  /// when coalesceFindRequests is true.
  ///
  /// - Parameter ids: An array of unique identifiers for a record
  /// - Return: An array of objects conforming to the `Model` protocol with the specified identifiers
  func findMany(_ ids: [String]) -> [Model]?
}
