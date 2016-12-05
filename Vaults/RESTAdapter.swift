//
//  RESTAdapter.swift
//  VaultKit
//
//  Created by Tomas Basham on 02/12/2016.
//  Copyright © 2016 tomasbasham.co.uk. All rights reserved.
//

/// Concrete REST adapter implementation.
///
/// The REST adapter allows a vault to communicate with a HTTP server
/// by transmitting JSON via URLSession. If your application intends
/// to consume a RESTful API then it should use the REST adapter.
///
/// It is assumed the JSON that is exchanged is JSONAPI conventional
/// as it would otherwise be impossible to implement a solution to
/// cater for many different requirements.
///
/// # Customisations
///
/// ## Endpoint Path Customisation
///
/// Endpoint paths can be prefixed with a namespace by setting the
/// `namespace` property on the adapter on initialisation. After
/// initialisation of a `RESTAdapter` the namespace cannot be
/// changed.
///
/// ## Host Customisation
///
/// The host can be configured by setting the `host` property on
/// the adapter on initialisation/ After initialisation of a
/// `RESTAdapter` the host cannot be changed.
public struct RESTAdapter: QueryingAdapter, CoalescingAdapter {

  let host: String
  let namespace: String

  public init(host: String, namespace: String = "/") {
    self.host = host
    self.namespace = namespace
  }

  /// Retrieve all models from the archive. The records will
  /// be created through the NSCoding protocol methods on the
  /// model instance.
  ///
  /// - Returns: An array of objects conforming to the `Model` protocol
  public func findAll() -> [Model]? {
    return nil
  }

  /// Filter model records returned from the archive by id. It
  /// should only match a single model, given each model must
  /// have a unique identifer.
  ///
  /// - Parameter id: Unique identifier for a record
  /// - Returns: An object conforming to the `Model` protocol that has the specified id
  public func findRecord(_ id: String) -> Model? {
    return nil
  }

  /// Filter model records returned from the archive by id. It
  /// will return models that match any of the identifiers
  /// passed into the method.
  ///
  /// - Parameter ids: An array of unique identifiers for a record
  /// - Returns: An array of objects conforming to the `Model` protocol that have the specified ids
  public func findMany(_ ids: [String]) -> [Model]? {
    return nil
  }

  /// Query the persistence layer for a series of models which
  /// each satisfy the properties passed into the method.
  ///
  /// - Parameter properties: A dictionary of key/value pairs defining model properties
  /// - Returns: An array of objects conforming to the `Model` protocol
  public func query(_ properties: [String: AnyObject]) -> [Model]? {
    return nil
  }

  /// Query the persistence layer for a single model which
  /// satisifes the properties passed into the model.
  ///
  /// - Parameter properties: A dictionary of key/value pairs defining model properties
  /// - Returns: An object conforming to the `Model` protocol
  public func queryRecord(_ properties: [String: AnyObject]) -> Model? {
    return nil
  }

  /// Encode and archive all records through the NSCoding
  /// protocol methods on the model instance.
  ///
  /// - Parameter models: An array of objects conforming to the `Model` protocol
  public func commit(models: [Model]) {
    return
  }
}
