//
//  SaveRequest.swift
//  VaultKit
//
//  Created by Tomas Basham on 02/12/2016.
//  Copyright © 2016 tomasbasham.co.uk. All rights reserved.
//

/// A type representing an action taken on a model.
///
/// There are two available request types that can be specified
/// when making a save request. These are `additive` - to insert or
/// update a model, and `destructive` - to remove a model from a
/// vault.
public enum SaveRequestType {

  /// Adding or updating a model in a vault.
  case additive

  /// Removing a model from a vault.
  case destructive
}

/// Save request type.
///
/// A save request represents an action to be performed on a vault.
/// It is meant as a simple wrapper around a mutable model and a
/// save request type  acton.
///
///     import Vaults
///
///     let saveRequest = SaveRequest(model: myModel)
///     let removeSaveRequst = SaveRequest(model: myModel, type: .destructive)
///
/// When submitting a save request to a vault, it is the responsbility
/// of the vault to determine what action should be taken and how this
/// relates to the associated adapter.
public struct SaveRequest {

  /// The mutable model wanting to be inserted, updated or removed.
  public var model: MutableModel

  /// The action to perform on a vault.
  public var type: SaveRequestType

  public init(model: MutableModel, type: SaveRequestType = .additive) {
    self.model = model
    self.type = type
  }
}
