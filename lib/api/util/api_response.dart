class ApiResponse<T> {
  final int status;
  final String? message;
  final String? error;
  final T? data;

  ApiResponse({
    required this.status,
    required this.message,
    this.error,
    this.data,
  });

  factory ApiResponse.success(T data, {String message = 'Success', int status = 200}) {
    return ApiResponse(
      status: status,
      message: message,
      error: null,
      data: data,
    );
  }

  factory ApiResponse.error(String errorMessage, {int status = 500}) {
    return ApiResponse(
      status: status,
      message: null,
      error: errorMessage,
      data: null,
    );
  }
}