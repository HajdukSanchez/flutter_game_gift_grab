/// Types of movements Santa component can handle
enum SantaMovementStateType {
  /// No movement at all
  idle,

  /// Move to the left
  slideLeft,

  /// Move to the right
  slideRight,

  ///  No movement and is frozen
  frozen,
}
