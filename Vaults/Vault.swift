//
//  Vault.swift
//  VaultKit
//
//  Created by Tomas Basham on 02/12/2016.
//  Copyright © 2016 tomasbasham.co.uk. All rights reserved.
//

/// Abstract vault protocol.
///
/// A store is an object containing all of the data for records loaded
/// from the persistence layer. It also acts as the interface between
/// your application and an instnace of `Adapter`
///
///     import Vaults
///
///     struct BaseVault<A: Adapter, T: Model>: Vault {
///
///       ...
///     }
///
/// An application will typically have a vault for each `Model` and
/// `Adapter` combination. This allows a logical separation between
/// model types which may have different storage requirements.
///
/// Because static stored properties are not supported in generics
/// types it is not possible to implement a singleton approach when
/// making a vault available in your application. Instead another
/// type is required to store the singleton.
///
///    import Vaults
///
///    struct KeyedArchiveVault: BaseVault<KeyedArchiveAdapter, Culture> {
///
///      static let shared = KeyedArchiveVault(KeyedArchiveAdapter(pathComponent: "culture"))
///    }
///
/// A store is an abstract base class that you should adopt in your
/// application to customise access to you persistence layer.
public protocol Vault {

  /// A placeholder name to a type that is used as part of the protocol.
  /// The actual type will be specified when the protocol is adopted.
  /// This should be used to represent a type that conforms to the
  /// `Model` protcol.
  ///
  /// Using an associated type allows the implementation of a vault to
  /// replace `ModelType` with the type that it actually represents.
  associatedtype ModelType

  /// A placeholder name to a type that is used as part of the protocol.
  /// The actual type will be specified when the protocol is adopted.
  /// This should be used to represent a type that conforms to the
  /// `Adapter` protcol.
  ///
  /// Using an associated type allows the implementation of a vault to
  /// replace `AdapterType` with the type that it actually represents.
  associatedtype AdapterType

  /// Return an instance of the adapter for the model. The adapter is
  /// the object responsible for translating actions performed on the
  /// store to actions specific to the persistence layer. The
  /// persistence layer can be anything from a REST API to key archiver.
  var adapter: AdapterType? { get }

  /// Return an instance of the serialiser for the model. The serialiser
  /// is the object responsible for translating a data payload to and
  /// from a format accepted by the persistence layer. The persistence
  /// layer can be anything from a REST API to key archiver.
  // var serializer: SerializerType? { get }

  /// Asks the adapter's method to find the records for the given model.
  /// The models are retuned to the completion handler when returned
  /// from the adapter.
  ///
  /// - Parameter completionHandler: The block to be executed when the persistence layer returns. The block takes 2 arguments:
  /// - Parameter records: An array of objects conforming to the `Model` protocol
  /// - Parameter error: An error if one ocurred
  func findAll(completionHandler: (_ records: [ModelType]?, _ error: AdapterError?) -> Void)

  /// Asks the adapter's method to find a record for the given model
  /// and identifier combination. The model is returned to the
  /// completion handler when returned from the adapter.
  ///
  /// The completion handler will always return the same model for a
  /// given identifier.
  ///
  /// - Parameter id: Unique identifier for a record
  /// - Parameter completionHandler: The block to be executed when the persistence layer returns. The block takes 2 arguments:
  /// - Parameter record: An object conforming to the `Model` protocol that has the specified id
  /// - Parameter error: An error if one ocurred
  func findRecord(id: String, completionHandler: (_ record: ModelType?, _ error: AdapterError?) -> Void)

  /// Perform a persistence action on the store depending up the state
  /// of the model.
  ///
  /// - Parameter saveRequest: An instance of `SaveRequest` which holds a `MutableModel` and the operation type to perform
  func execute(_ saveRequest: SaveRequest)
}

extension Notification.Name {

  /// Notify observers that an update has been made to a vault.
  public static let vaultDidUpdate = Notification.Name("vaultDidUpdate")
}
