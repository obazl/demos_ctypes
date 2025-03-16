open Ctypes

(* obazl: *)
module Types = Type_description.Types(Zstd_CtypesTYPE)
(* dune: *)
(* module Types = Types_generated *)

module Functions (F : Cstubs.FOREIGN) = struct
  open F

  let version_number = foreign "ZSTD_versionNumber" (void @-> returning int)
  let compress_bound = foreign "ZSTD_compressBound" (size_t @-> returning size_t)
  let get_error_name = foreign "ZSTD_getErrorName" (size_t @-> returning string)
  let is_error = foreign "ZSTD_isError" (size_t @-> returning bool)

  let get_frame_content_size = foreign "ZSTD_getFrameContentSize" (string @-> size_t @-> returning ullong)

  let compress = foreign "ZSTD_compress" (ptr void @-> size_t @-> string @-> size_t @-> int @-> returning size_t)
  let decompress = foreign "ZSTD_decompress" (ptr void @-> size_t @-> string @-> size_t @-> returning size_t)

  let cctx : [`CCtx] structure typ = structure "ZSTD_CCtx_s"
  let create_cctx = foreign "ZSTD_createCCtx" (void @-> returning (ptr cctx))
  let free_cctx = foreign "ZSTD_freeCCtx" (ptr cctx @-> returning size_t)

  let compress_cctx = foreign "ZSTD_compressCCtx" (ptr cctx @-> ptr void @-> size_t @-> string @-> size_t @-> int @-> returning size_t)

  let dctx : [`DCtx] structure typ = structure "ZSTD_DCtx_s"
  let create_dctx = foreign "ZSTD_createDCtx" (void @-> returning (ptr dctx))
  let free_dctx = foreign "ZSTD_freeDCtx" (ptr dctx @-> returning size_t)

  let decompress_dctx = foreign "ZSTD_decompressDCtx" (ptr dctx @-> ptr void @-> size_t @-> string @-> size_t @-> returning size_t)

  let compress_using_dict = foreign "ZSTD_compress_usingDict" (ptr cctx @-> ptr void @-> size_t @-> string @-> size_t @->
    string @-> size_t @-> int @-> returning size_t)

  let decompress_using_dict = foreign "ZSTD_decompress_usingDict" (ptr dctx @-> ptr void @-> size_t @-> string @-> size_t @->
    string @-> size_t @-> returning size_t)
end
