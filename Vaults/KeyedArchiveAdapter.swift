//
//  KeyedArchiveAdapter.swift
//  VaultKit
//
//  Created by Tomas Basham on 02/12/2016.
//  Copyright © 2016 tomasbasham.co.uk. All rights reserved.
//

/// Concrete Keyed Archive adapter implementation.
///
/// The Keyed Archive adapter allows a vault to archive and unarchive
/// records via `NSKeyedArchiver` and `NSKeyedUnarchiver` respectivley.
/// If your application intends to store records locally then it may use
/// the Keyed Archive adapter.
///
/// For this adapter to work each instance of a `Model` but conform to
/// the NSCoding protocol.
///
/// # Customisations
///
/// ## Path Component Customisation
///
/// Path component dicates the file path where the adapter will encode
/// and decode records and is set with the `pathComponent` property on
/// initialisation. After initialisation of a `KeyedArchiveAdapter` the
/// path component cannot be changed.
public struct KeyedArchiveAdapter: Adapter {

  let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  let pathComponent: String

  /// Dynamically generate the the archiving path by appending
  /// the store adapter path component to the sandboxed
  /// documents directory.
  var archiveURL: URL {
    return documentsDirectory.appendingPathComponent(pathComponent)
  }

  public init(pathComponent: String) {
    self.pathComponent = pathComponent
  }

  /// Retrieve all models from the archive. The records will
  /// be created through the NSCoding protocol methods on the
  /// model instance.
  ///
  /// - Returns: An array of objects conforming to the `Model` protocol
  public func findAll() -> [Model]? {
    return NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? [Model]
  }

  /// Filter model records returned from the archive by id. It
  /// should only match a single model, given each model must
  /// have a unique identifer.
  ///
  /// - Parameter id: Unique identifier for a record
  /// - Returns: An object conforming to the `Model` protocol that has the specified id
  public func findRecord(_ id: String) -> Model? {
    return findAll()?.filter({ $0.identifier == id }).first
  }

  /// Encode and archive all records through the NSCoding
  /// protocol methods on the model instance.
  ///
  /// - Parameter models: An array of objects conforming to the `Model` protocol
  public func commit(models: [Model]) {
    NSKeyedArchiver.archiveRootObject(models, toFile: archiveURL.path)
  }
}
