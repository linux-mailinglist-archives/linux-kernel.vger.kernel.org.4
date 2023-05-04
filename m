Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB76F6C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjEDNI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEDNIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:08:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E939646A9;
        Thu,  4 May 2023 06:08:50 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21D506600010;
        Thu,  4 May 2023 14:08:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683205729;
        bh=GJSYOPkdFlhsRKsWNt6m9dt4W323iZx32hQQnfJYSUQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dIPWLqHzrBfhPZdr6laCK/hyY51pxm0mdE3nzMT2lqUNybo+cwYxM8qyb+hkwR9Zo
         YjfVj5QsV7evRW1ZLTx0d03BAsj0VTAdEolDQey8HiM3o10dHHCrrdgz0YcuatN9aw
         Y3fxAFF70bwsLHZ6bE+HHKr9tzAkh1vGPca1WjVQoQqeEkR+om4pLYFmPKcmWWag15
         DJFeo7HP6gkp6CRVKZh6gqcm48nwK9D/SYGAGEb3ExWSZo/miIOpbqoNLbTd9TiDMM
         WwTATh9D3M5PxvRImsE1ntCK+CZPOWNs5fyjwEkqN8CGNz7rUq4ja+0FrOT64J3Nb4
         4tYTsm1FntnFg==
Message-ID: <bf7887148260a721ee9fdb1a66470fef95c56062.camel@collabora.com>
Subject: Re: [PATCH v3] media: mediatek: vcodec: support stateless hevc
 decoder
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?ISO-8859-1?Q?N=EDcolas?= "F . R . A . Prado" 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Thu, 04 May 2023 09:08:40 -0400
In-Reply-To: <20230504115701.17012-1-yunfei.dong@mediatek.com>
References: <20230504115701.17012-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 04 mai 2023 =C3=A0 19:57 +0800, Yunfei Dong a =C3=A9crit=C2=A0:
> Add mediatek hevc decoder linux driver which use the stateless API in MT8=
195.
>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
> Changed from v2:
> - fix one build warning.
> - add the dependency patch.

You forgot to include it. This should be a 2 patches serie now, possibly wi=
th a
cover letter.

>=20
> Changed from v1:
> - fix build error when build 32bit system.
> - hevc fluster test result: 132/147 (not support: 10bit =3D> 11 and resol=
ution =3D> 4).
> ---
> Depends on patch:
> [1]: media: uapi: HEVC: Add num_delta_pocs_of_ref_rps_idx field.
>      https://urldefense.com/v3/__https://patchwork.linuxtv.org/project/li=
nux-media/list/?series=3D10330__;!!CTRNKA9wMg0ARbw!kHcaxDBW0LK9u0d6zlYnW8Fu=
QyhjipuwJYJBZ_9Pk-PwFUpgzr_vlEXEIYOLbmcxZOsp119WUcnFqeGvBlzIZu0ScsaT0O80Sg$
>=20
>  .../media/platform/mediatek/vcodec/Makefile   |    1 +
>  .../vcodec/mtk_vcodec_dec_stateless.c         |   59 +-
>  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |    1 +
>  .../vcodec/vdec/vdec_hevc_req_multi_if.c      | 1101 +++++++++++++++++
>  .../platform/mediatek/vcodec/vdec_drv_if.c    |    4 +
>  .../platform/mediatek/vcodec/vdec_drv_if.h    |    1 +
>  6 files changed, 1166 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc=
_req_multi_if.c
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/Makefile b/drivers/me=
dia/platform/mediatek/vcodec/Makefile
> index 93e7a343b5b0..d24b452d0fb3 100644
> --- a/drivers/media/platform/mediatek/vcodec/Makefile
> +++ b/drivers/media/platform/mediatek/vcodec/Makefile
> @@ -13,6 +13,7 @@ mtk-vcodec-dec-y :=3D vdec/vdec_h264_if.o \
>  		vdec/vdec_h264_req_if.o \
>  		vdec/vdec_h264_req_common.o \
>  		vdec/vdec_h264_req_multi_if.o \
> +		vdec/vdec_hevc_req_multi_if.o \
>  		mtk_vcodec_dec_drv.o \
>  		vdec_drv_if.o \
>  		vdec_vpu_if.o \
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statel=
ess.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> index 0c2ef1686397..7b3eb0ccb522 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> @@ -107,11 +107,63 @@ static const struct mtk_stateless_control mtk_state=
less_controls[] =3D {
>  		},
>  		.codec_type =3D V4L2_PIX_FMT_VP9_FRAME,
>  	},
> +	{
> +		.cfg =3D {
> +			.id =3D V4L2_CID_STATELESS_HEVC_SPS,
> +		},
> +		.codec_type =3D V4L2_PIX_FMT_HEVC_SLICE,
> +	},
> +	{
> +		.cfg =3D {
> +			.id =3D V4L2_CID_STATELESS_HEVC_PPS,
> +		},
> +		.codec_type =3D V4L2_PIX_FMT_HEVC_SLICE,
> +	},
> +	{
> +		.cfg =3D {
> +			.id =3D V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
> +		},
> +		.codec_type =3D V4L2_PIX_FMT_HEVC_SLICE,
> +	},
> +	{
> +		.cfg =3D {
> +			.id =3D V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
> +		},
> +		.codec_type =3D V4L2_PIX_FMT_HEVC_SLICE,
> +	},
> +	{
> +		.cfg =3D {
> +			.id =3D V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
> +			.def =3D V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
> +			.max =3D V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
> +			.menu_skip_mask =3D
> +				BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE),
> +		},
> +		.codec_type =3D V4L2_PIX_FMT_HEVC_SLICE,
> +	},
> +	{
> +		.cfg =3D {
> +			.id =3D V4L2_CID_STATELESS_HEVC_DECODE_MODE,
> +			.min =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
> +			.def =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
> +			.max =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
> +		},
> +		.codec_type =3D V4L2_PIX_FMT_HEVC_SLICE,
> +	},
> +	{
> +		.cfg =3D {
> +			.id =3D V4L2_CID_STATELESS_HEVC_START_CODE,
> +			.min =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
> +			.def =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
> +			.max =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
> +		},
> +		.codec_type =3D V4L2_PIX_FMT_HEVC_SLICE,
> +	},
>  };
> =20
>  #define NUM_CTRLS ARRAY_SIZE(mtk_stateless_controls)
> =20
> -static struct mtk_video_fmt mtk_video_formats[5];
> +static struct mtk_video_fmt mtk_video_formats[6];
> =20
>  static struct mtk_video_fmt default_out_format;
>  static struct mtk_video_fmt default_cap_format;
> @@ -356,6 +408,7 @@ static void mtk_vcodec_add_formats(unsigned int fourc=
c,
>  	case V4L2_PIX_FMT_H264_SLICE:
>  	case V4L2_PIX_FMT_VP8_FRAME:
>  	case V4L2_PIX_FMT_VP9_FRAME:
> +	case V4L2_PIX_FMT_HEVC_SLICE:
>  		mtk_video_formats[count_formats].fourcc =3D fourcc;
>  		mtk_video_formats[count_formats].type =3D MTK_FMT_DEC;
>  		mtk_video_formats[count_formats].num_planes =3D 1;
> @@ -412,6 +465,10 @@ static void mtk_vcodec_get_supported_formats(struct =
mtk_vcodec_ctx *ctx)
>  		mtk_vcodec_add_formats(V4L2_PIX_FMT_VP9_FRAME, ctx);
>  		out_format_count++;
>  	}
> +	if (ctx->dev->dec_capability & MTK_VDEC_FORMAT_HEVC_FRAME) {
> +		mtk_vcodec_add_formats(V4L2_PIX_FMT_HEVC_SLICE, ctx);
> +		out_format_count++;
> +	}
> =20
>  	if (cap_format_count)
>  		default_cap_format =3D mtk_video_formats[cap_format_count - 1];
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> index 15d2cb171b89..1f4c5774ec47 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> @@ -347,6 +347,7 @@ enum mtk_vdec_format_types {
>  	MTK_VDEC_FORMAT_H264_SLICE =3D 0x100,
>  	MTK_VDEC_FORMAT_VP8_FRAME =3D 0x200,
>  	MTK_VDEC_FORMAT_VP9_FRAME =3D 0x400,
> +	MTK_VDEC_FORMAT_HEVC_FRAME =3D 0x1000,
>  	MTK_VCODEC_INNER_RACING =3D 0x20000,
>  };
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_=
if.c
> new file mode 100644
> index 000000000000..785ec09668fb
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.=
c
> @@ -0,0 +1,1101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Yunfei Dong <yunfei.dong@mediatek.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "../mtk_vcodec_util.h"
> +#include "../mtk_vcodec_dec.h"
> +#include "../mtk_vcodec_intr.h"
> +#include "../vdec_drv_base.h"
> +#include "../vdec_drv_if.h"
> +#include "../vdec_vpu_if.h"
> +
> +/* the size used to store hevc wrap information */
> +#define VDEC_HEVC_WRAP_SZ (532 * SZ_1K)
> +
> +#define HEVC_MAX_MV_NUM 32
> +
> +/* get used parameters for sps/pps */
> +#define GET_HEVC_VDEC_FLAG(cond, flag) \
> +	{ dst_param->cond =3D ((src_param->flags & flag) ? (1) : (0)); }
> +#define GET_HEVC_VDEC_PARAM(param) \
> +	{ dst_param->param =3D src_param->param; }
> +
> +/**
> + * enum vdec_hevc_core_dec_err_type  - core decode error type
> + *
> + * @TRANS_BUFFER_FULL: trans buffer is full
> + * @SLICE_HEADER_FULL: slice header buffer is full
> + */
> +enum vdec_hevc_core_dec_err_type {
> +	TRANS_BUFFER_FULL =3D 1,
> +	SLICE_HEADER_FULL,
> +};
> +
> +/**
> + * struct mtk_hevc_dpb_info  - hevc dpb information
> + *
> + * @y_dma_addr:     Y plane physical address
> + * @c_dma_addr:     CbCr plane physical address
> + * @reference_flag: reference picture flag (short/long term reference pi=
cture)
> + * @field:          field picture flag
> + */
> +struct mtk_hevc_dpb_info {
> +	dma_addr_t y_dma_addr;
> +	dma_addr_t c_dma_addr;
> +	int reference_flag;
> +	int field;
> +};
> +
> +/*
> + * struct mtk_hevc_sps_param  - parameters for sps
> + */
> +struct mtk_hevc_sps_param {
> +	unsigned char video_parameter_set_id;
> +	unsigned char seq_parameter_set_id;
> +	unsigned short pic_width_in_luma_samples;
> +	unsigned short pic_height_in_luma_samples;
> +	unsigned char bit_depth_luma_minus8;
> +	unsigned char bit_depth_chroma_minus8;
> +	unsigned char log2_max_pic_order_cnt_lsb_minus4;
> +	unsigned char sps_max_dec_pic_buffering_minus1;
> +	unsigned char sps_max_num_reorder_pics;
> +	unsigned char sps_max_latency_increase_plus1;
> +	unsigned char log2_min_luma_coding_block_size_minus3;
> +	unsigned char log2_diff_max_min_luma_coding_block_size;
> +	unsigned char log2_min_luma_transform_block_size_minus2;
> +	unsigned char log2_diff_max_min_luma_transform_block_size;
> +	unsigned char max_transform_hierarchy_depth_inter;
> +	unsigned char max_transform_hierarchy_depth_intra;
> +	unsigned char pcm_sample_bit_depth_luma_minus1;
> +	unsigned char pcm_sample_bit_depth_chroma_minus1;
> +	unsigned char log2_min_pcm_luma_coding_block_size_minus3;
> +	unsigned char log2_diff_max_min_pcm_luma_coding_block_size;
> +	unsigned char num_short_term_ref_pic_sets;
> +	unsigned char num_long_term_ref_pics_sps;
> +	unsigned char chroma_format_idc;
> +	unsigned char sps_max_sub_layers_minus1;
> +	unsigned char separate_colour_plane;
> +	unsigned char scaling_list_enabled;
> +	unsigned char amp_enabled;
> +	unsigned char sample_adaptive_offset;
> +	unsigned char pcm_enabled;
> +	unsigned char pcm_loop_filter_disabled;
> +	unsigned char long_term_ref_pics_enabled;
> +	unsigned char sps_temporal_mvp_enabled;
> +	unsigned char strong_intra_smoothing_enabled;
> +	unsigned char reserved[5];
> +};
> +
> +/*
> + * struct mtk_hevc_pps_param  - parameters for pps
> + */
> +struct mtk_hevc_pps_param {
> +	unsigned char pic_parameter_set_id;
> +	unsigned char num_extra_slice_header_bits;
> +	unsigned char num_ref_idx_l0_default_active_minus1;
> +	unsigned char num_ref_idx_l1_default_active_minus1;
> +	char init_qp_minus26;
> +	unsigned char diff_cu_qp_delta_depth;
> +	char pps_cb_qp_offset;
> +	char pps_cr_qp_offset;
> +	unsigned char num_tile_columns_minus1;
> +	unsigned char num_tile_rows_minus1;
> +	unsigned char column_width_minus1[20];
> +	unsigned char row_height_minus1[22];
> +	char pps_beta_offset_div2;
> +	char pps_tc_offset_div2;
> +	unsigned char log2_parallel_merge_level_minus2;
> +	char dependent_slice_segment_enabled;
> +	char output_flag_present;
> +	char sign_data_hiding_enabled;
> +	char cabac_init_present;
> +	char constrained_intra_pred;
> +	char transform_skip_enabled;
> +	char cu_qp_delta_enabled;
> +	char pps_slice_chroma_qp_offsets_present;
> +	char weighted_pred;
> +	char weighted_bipred;
> +	char transquant_bypass_enabled;
> +	char pps_flag_tiles_enabled;
> +	char entropy_coding_sync_enabled;
> +	char loop_filter_across_tiles_enabled;
> +	char pps_loop_filter_across_slices_enabled;
> +	char deblocking_filter_override_enabled;
> +	char pps_disable_deflocking_filter;
> +	char lists_modification_present;
> +	char slice_segment_header_extersion_present;
> +	char deblocking_filter_control_present;
> +	char uniform_spacing;
> +	char reserved[6];
> +};
> +
> +/*
> + * struct mtk_hevc_slice_header_param  - parameters for slice header
> + */
> +struct mtk_hevc_slice_header_param {
> +	unsigned int	slice_type;
> +	unsigned int	num_active_ref_layer_pics;
> +	int		slice_qp;
> +	int		slice_qp_delta_cb;
> +	int		slice_qp_delta_cr;
> +	int		num_ref_idx[3];
> +	unsigned int	col_ref_idx;
> +	unsigned int	five_minus_max_num_merge_cand;
> +	int		slice_deblocking_filter_beta_offset_div2;
> +	int		slice_deblocking_filter_tc_offset_div2;
> +	unsigned char	sao_enable_flag;
> +	unsigned char	sao_enable_flag_chroma;
> +	unsigned char	cabac_init_flag;
> +	unsigned char	slice_tmvp_flags_present;
> +	unsigned char	col_from_l0_flag;
> +	unsigned char	mvd_l1_zero_flag;
> +	unsigned char	slice_loop_filter_across_slices_enabled_flag;
> +	unsigned char	deblocking_filter_disable_flag;
> +	unsigned int	slice_reg0;
> +	unsigned int	slice_reg1;
> +	unsigned int	slice_reg2;
> +	unsigned int	num_rps_curr_temp_list;
> +	unsigned int	ref_list_mode;
> +	int		str_num_delta_pocs;
> +	int		str_num_negtive_pos_pics;
> +	int		num_long_term;
> +	int		num_long_term_sps;
> +	unsigned int	max_cu_width;
> +	unsigned int	max_cu_height;
> +	unsigned int	num_entry_point_offsets;
> +	unsigned int    last_lcu_x_in_tile[17];
> +	unsigned int    last_lcu_y_in_tile[17];
> +	unsigned char   nal_unit_type;
> +};
> +
> +/*
> + * struct slice_api_hevc_scaling_matrix  - parameters for scaling list
> + */
> +struct slice_api_hevc_scaling_matrix {
> +	unsigned char scaling_list_4x4[6][16];
> +	unsigned char scaling_list_8x8[6][64];
> +	unsigned char scaling_list_16x16[6][64];
> +	unsigned char scaling_list_32x32[2][64];
> +	unsigned char scaling_list_dc_coef_16x16[6];
> +	unsigned char scaling_list_dc_coef_32x32[2];
> +};
> +
> +/*
> + * struct slice_hevc_dpb_entry  - each dpb information
> + */
> +struct slice_hevc_dpb_entry {
> +	u64 timestamp;
> +	unsigned char flags;
> +	unsigned char field_pic;
> +	int pic_order_cnt_val;
> +};
> +
> +/*
> + * struct slice_api_hevc_decode_param - parameters for decode.
> + */
> +struct slice_api_hevc_decode_param {
> +	struct slice_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
> +	int pic_order_cnt_val;
> +	unsigned short short_term_ref_pic_set_size;
> +	unsigned short long_term_ref_pic_set_size;
> +	unsigned char num_active_dpb_entries;
> +	unsigned char num_poc_st_curr_before;
> +	unsigned char num_poc_st_curr_after;
> +	unsigned char num_poc_lt_curr;
> +	unsigned char poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
> +	unsigned char poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
> +	unsigned char poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
> +	unsigned char num_delta_pocs_of_ref_rps_idx;
> +	int flags;
> +};
> +
> +/**
> + * struct hevc_fb - hevc decode frame buffer information
> + *
> + * @vdec_fb_va: virtual address of struct vdec_fb
> + * @y_fb_dma:   dma address of Y frame buffer (luma)
> + * @c_fb_dma:   dma address of C frame buffer (chroma)
> + * @poc:        picture order count of frame buffer
> + * @reserved:   for 8 bytes alignment
> + */
> +struct hevc_fb {
> +	u64 vdec_fb_va;
> +	u64 y_fb_dma;
> +	u64 c_fb_dma;
> +	s32 poc;
> +	u32 reserved;
> +};
> +
> +/**
> + * struct vdec_hevc_slice_lat_dec_param  - parameters for decode current=
 frame
> + *
> + * @sps:            hevc sps syntax parameters
> + * @pps:            hevc pps syntax parameters
> + * @slice_header:   hevc slice header syntax parameters
> + * @scaling_matrix: hevc scaling list parameters
> + * @decode_params:  decoder parameters of each frame used for hardware d=
ecode
> + * @hevc_dpb_info:  dpb reference list
> + */
> +struct vdec_hevc_slice_lat_dec_param {
> +	struct mtk_hevc_sps_param sps;
> +	struct mtk_hevc_pps_param pps;
> +	struct mtk_hevc_slice_header_param slice_header;
> +	struct slice_api_hevc_scaling_matrix scaling_matrix;
> +	struct slice_api_hevc_decode_param decode_params;
> +	struct mtk_hevc_dpb_info hevc_dpb_info[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
> +};
> +
> +/**
> + * struct vdec_hevc_slice_info - decode information
> + *
> + * @wdma_end_addr_offset: wdma end address offset
> + * @timeout:              Decode timeout: 1 timeout, 0 no timeount
> + * @vdec_fb_va:           VDEC frame buffer struct virtual address
> + * @crc:                  Used to check whether hardware's status is rig=
ht
> + */
> +struct vdec_hevc_slice_info {
> +	/* LAT dec addr */
> +	u64 wdma_end_addr_offset;
> +	u64 timeout;
> +	u64 vdec_fb_va;
> +	u32 crc[8];
> +};
> +
> +/*
> + * struct vdec_vp9_slice_mem - memory address and size
> + */
> +struct vdec_hevc_slice_mem {
> +	union {
> +		u64 buf;
> +		dma_addr_t dma_addr;
> +	};
> +	union {
> +		size_t size;
> +		dma_addr_t dma_addr_end;
> +		u64 padding;
> +	};
> +};
> +
> +/**
> + * struct vdec_av1_slice_fb - frame buffer for decoding
> + * @y:  current y buffer address info
> + * @c:  current c buffer address info
> + */
> +struct vdec_hevc_slice_fb {
> +	struct vdec_hevc_slice_mem y;
> +	struct vdec_hevc_slice_mem c;
> +};
> +
> +/**
> + * struct vdec_hevc_slice_vsi - shared memory for decode information exc=
hange
> + *        between SCP and Host.
> + *
> + * @bs:                 input buffer info
> + *
> + * @ube:                ube buffer
> + * @trans:              transcoded buffer
> + * @err_map:            err map buffer
> + * @slice_bc:           slice bc buffer
> + * @wrap:               temp buffer
> + *
> + * @fb:                 current y/c buffer
> + * @mv_buf_dma:         HW working motion vector buffer
> + * @dec:                decode information (AP-R, VPU-W)
> + * @hevc_slice_params:  decode parameters for hw used
> + */
> +struct vdec_hevc_slice_vsi {
> +	/* used in LAT stage */
> +	struct vdec_hevc_slice_mem bs;
> +
> +	struct vdec_hevc_slice_mem ube;
> +	struct vdec_hevc_slice_mem trans;
> +	struct vdec_hevc_slice_mem err_map;
> +	struct vdec_hevc_slice_mem slice_bc;
> +	struct vdec_hevc_slice_mem wrap;
> +
> +	struct vdec_hevc_slice_fb fb;
> +	struct vdec_hevc_slice_mem mv_buf_dma[HEVC_MAX_MV_NUM];
> +	struct vdec_hevc_slice_info dec;
> +	struct vdec_hevc_slice_lat_dec_param hevc_slice_params;
> +};
> +
> +/**
> + * struct vdec_hevc_slice_share_info - shared information used to exchan=
ge
> + *                                     message between lat and core
> + *
> + * @sps:               sequence header information from user space
> + * @dec_params:        decoder params from user space
> + * @hevc_slice_params: decoder params used for hardware
> + * @trans_start:       trans start dma address
> + * @trans_end:         trans end dma address
> + */
> +struct vdec_hevc_slice_share_info {
> +	struct v4l2_ctrl_hevc_sps sps;
> +	struct v4l2_ctrl_hevc_decode_params dec_params;
> +	struct vdec_hevc_slice_lat_dec_param hevc_slice_params;
> +	struct vdec_hevc_slice_mem trans;
> +};
> +
> +/**
> + * struct vdec_hevc_slice_inst - hevc decoder instance
> + *
> + * @slice_dec_num:      how many picture be decoded
> + * @ctx:                point to mtk_vcodec_ctx
> + * @pred_buf:           HW working predication buffer
> + * @mv_buf:             HW working motion vector buffer
> + * @vpu:                VPU instance
> + * @vsi:                vsi used for lat
> + * @vsi_core:           vsi used for core
> + * @wrap_addr:          wrap address used for hevc
> + *
> + * @hevc_slice_param:   the parameters that hardware use to decode
> + *
> + * @resolution_changed: resolution changed
> + * @realloc_mv_buf:     reallocate mv buffer
> + * @cap_num_planes:     number of capture queue plane
> + */
> +struct vdec_hevc_slice_inst {
> +	unsigned int slice_dec_num;
> +	struct mtk_vcodec_ctx *ctx;
> +	struct mtk_vcodec_mem mv_buf[HEVC_MAX_MV_NUM];
> +	struct vdec_vpu_inst vpu;
> +	struct vdec_hevc_slice_vsi *vsi;
> +	struct vdec_hevc_slice_vsi *vsi_core;
> +	struct mtk_vcodec_mem wrap_addr;
> +
> +	struct vdec_hevc_slice_lat_dec_param hevc_slice_param;
> +
> +	unsigned int resolution_changed;
> +	unsigned int realloc_mv_buf;
> +	unsigned int cap_num_planes;
> +};
> +
> +static unsigned int vdec_hevc_get_mv_buf_size(unsigned int width, unsign=
ed int height)
> +{
> +	int unit_size =3D (width / 16) * (height / 16) + 8;
> +
> +	return 64 * unit_size;
> +}
> +
> +static void *vdec_hevc_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
> +{
> +	struct v4l2_ctrl *ctrl =3D v4l2_ctrl_find(&ctx->ctrl_hdl, id);
> +
> +	if (!ctrl)
> +		return ERR_PTR(-EINVAL);
> +
> +	return ctrl->p_cur.p;
> +}
> +
> +static void vdec_hevc_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
> +				    struct slice_api_hevc_decode_param *decode_params,
> +				    struct mtk_hevc_dpb_info *hevc_dpb_info)
> +{
> +	const struct slice_hevc_dpb_entry *dpb;
> +	struct vb2_queue *vq;
> +	struct vb2_buffer *vb;
> +	int index;
> +
> +	vq =3D v4l2_m2m_get_vq(ctx->m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE=
);
> +	for (index =3D 0; index < V4L2_HEVC_DPB_ENTRIES_NUM_MAX; index++) {
> +		dpb =3D &decode_params->dpb[index];
> +		if (index >=3D decode_params->num_active_dpb_entries)
> +			continue;
> +
> +		vb =3D vb2_find_buffer(vq, dpb->timestamp);
> +		if (!vb) {
> +			dev_err(&ctx->dev->plat_dev->dev,
> +				"Reference invalid: dpb_index(%d) timestamp(%lld)",
> +				index, dpb->timestamp);
> +			continue;
> +		}
> +
> +		hevc_dpb_info[index].field =3D dpb->field_pic;
> +
> +		hevc_dpb_info[index].y_dma_addr =3D vb2_dma_contig_plane_dma_addr(vb, =
0);
> +		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes =3D=3D 2)
> +			hevc_dpb_info[index].c_dma_addr =3D vb2_dma_contig_plane_dma_addr(vb,=
 1);
> +		else
> +			hevc_dpb_info[index].c_dma_addr =3D
> +				hevc_dpb_info[index].y_dma_addr + ctx->picinfo.fb_sz[0];
> +	}
> +}
> +
> +static void vdec_hevc_copy_sps_params(struct mtk_hevc_sps_param *dst_par=
am,
> +				      const struct v4l2_ctrl_hevc_sps *src_param)
> +{
> +	GET_HEVC_VDEC_PARAM(video_parameter_set_id);
> +	GET_HEVC_VDEC_PARAM(seq_parameter_set_id);
> +	GET_HEVC_VDEC_PARAM(pic_width_in_luma_samples);
> +	GET_HEVC_VDEC_PARAM(pic_height_in_luma_samples);
> +	GET_HEVC_VDEC_PARAM(bit_depth_luma_minus8);
> +	GET_HEVC_VDEC_PARAM(bit_depth_chroma_minus8);
> +	GET_HEVC_VDEC_PARAM(log2_max_pic_order_cnt_lsb_minus4);
> +	GET_HEVC_VDEC_PARAM(sps_max_dec_pic_buffering_minus1);
> +	GET_HEVC_VDEC_PARAM(sps_max_num_reorder_pics);
> +	GET_HEVC_VDEC_PARAM(sps_max_latency_increase_plus1);
> +	GET_HEVC_VDEC_PARAM(log2_min_luma_coding_block_size_minus3);
> +	GET_HEVC_VDEC_PARAM(log2_diff_max_min_luma_coding_block_size);
> +	GET_HEVC_VDEC_PARAM(log2_min_luma_transform_block_size_minus2);
> +	GET_HEVC_VDEC_PARAM(log2_diff_max_min_luma_transform_block_size);
> +	GET_HEVC_VDEC_PARAM(max_transform_hierarchy_depth_inter);
> +	GET_HEVC_VDEC_PARAM(max_transform_hierarchy_depth_intra);
> +	GET_HEVC_VDEC_PARAM(pcm_sample_bit_depth_luma_minus1);
> +	GET_HEVC_VDEC_PARAM(pcm_sample_bit_depth_chroma_minus1);
> +	GET_HEVC_VDEC_PARAM(log2_min_pcm_luma_coding_block_size_minus3);
> +	GET_HEVC_VDEC_PARAM(log2_diff_max_min_pcm_luma_coding_block_size);
> +	GET_HEVC_VDEC_PARAM(num_short_term_ref_pic_sets);
> +	GET_HEVC_VDEC_PARAM(num_long_term_ref_pics_sps);
> +	GET_HEVC_VDEC_PARAM(chroma_format_idc);
> +	GET_HEVC_VDEC_PARAM(sps_max_sub_layers_minus1);
> +
> +	GET_HEVC_VDEC_FLAG(separate_colour_plane,
> +			   V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE);
> +	GET_HEVC_VDEC_FLAG(scaling_list_enabled,
> +			   V4L2_HEVC_SPS_FLAG_SCALING_LIST_ENABLED);
> +	GET_HEVC_VDEC_FLAG(amp_enabled,
> +			   V4L2_HEVC_SPS_FLAG_AMP_ENABLED);
> +	GET_HEVC_VDEC_FLAG(sample_adaptive_offset,
> +			   V4L2_HEVC_SPS_FLAG_SAMPLE_ADAPTIVE_OFFSET);
> +	GET_HEVC_VDEC_FLAG(pcm_enabled,
> +			   V4L2_HEVC_SPS_FLAG_PCM_ENABLED);
> +	GET_HEVC_VDEC_FLAG(pcm_loop_filter_disabled,
> +			   V4L2_HEVC_SPS_FLAG_PCM_LOOP_FILTER_DISABLED);
> +	GET_HEVC_VDEC_FLAG(long_term_ref_pics_enabled,
> +			   V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT);
> +	GET_HEVC_VDEC_FLAG(sps_temporal_mvp_enabled,
> +			   V4L2_HEVC_SPS_FLAG_SPS_TEMPORAL_MVP_ENABLED);
> +	GET_HEVC_VDEC_FLAG(strong_intra_smoothing_enabled,
> +			   V4L2_HEVC_SPS_FLAG_STRONG_INTRA_SMOOTHING_ENABLED);
> +}
> +
> +static void vdec_hevc_copy_pps_params(struct mtk_hevc_pps_param *dst_par=
am,
> +				      const struct v4l2_ctrl_hevc_pps *src_param)
> +{
> +	int i;
> +
> +	GET_HEVC_VDEC_PARAM(pic_parameter_set_id);
> +	GET_HEVC_VDEC_PARAM(num_extra_slice_header_bits);
> +	GET_HEVC_VDEC_PARAM(num_ref_idx_l0_default_active_minus1);
> +	GET_HEVC_VDEC_PARAM(num_ref_idx_l1_default_active_minus1);
> +	GET_HEVC_VDEC_PARAM(init_qp_minus26);
> +	GET_HEVC_VDEC_PARAM(diff_cu_qp_delta_depth);
> +	GET_HEVC_VDEC_PARAM(pps_cb_qp_offset);
> +	GET_HEVC_VDEC_PARAM(pps_cr_qp_offset);
> +	GET_HEVC_VDEC_PARAM(num_tile_columns_minus1);
> +	GET_HEVC_VDEC_PARAM(num_tile_rows_minus1);
> +	GET_HEVC_VDEC_PARAM(init_qp_minus26);
> +	GET_HEVC_VDEC_PARAM(diff_cu_qp_delta_depth);
> +	GET_HEVC_VDEC_PARAM(pic_parameter_set_id);
> +	GET_HEVC_VDEC_PARAM(num_extra_slice_header_bits);
> +	GET_HEVC_VDEC_PARAM(num_ref_idx_l0_default_active_minus1);
> +	GET_HEVC_VDEC_PARAM(num_ref_idx_l1_default_active_minus1);
> +	GET_HEVC_VDEC_PARAM(pps_beta_offset_div2);
> +	GET_HEVC_VDEC_PARAM(pps_tc_offset_div2);
> +	GET_HEVC_VDEC_PARAM(log2_parallel_merge_level_minus2);
> +
> +	for (i =3D 0; i < 20; i++)
> +		dst_param->column_width_minus1[i] =3D src_param->column_width_minus1[i=
];
> +	for (i =3D 0; i < 22; i++)
> +		dst_param->row_height_minus1[i] =3D src_param->row_height_minus1[i];
> +
> +	GET_HEVC_VDEC_FLAG(dependent_slice_segment_enabled,
> +			   V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED);
> +	GET_HEVC_VDEC_FLAG(output_flag_present,
> +			   V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT);
> +	GET_HEVC_VDEC_FLAG(sign_data_hiding_enabled,
> +			   V4L2_HEVC_PPS_FLAG_SIGN_DATA_HIDING_ENABLED);
> +	GET_HEVC_VDEC_FLAG(cabac_init_present,
> +			   V4L2_HEVC_PPS_FLAG_CABAC_INIT_PRESENT);
> +	GET_HEVC_VDEC_FLAG(constrained_intra_pred,
> +			   V4L2_HEVC_PPS_FLAG_CONSTRAINED_INTRA_PRED);
> +	GET_HEVC_VDEC_FLAG(transform_skip_enabled,
> +			   V4L2_HEVC_PPS_FLAG_TRANSFORM_SKIP_ENABLED);
> +	GET_HEVC_VDEC_FLAG(cu_qp_delta_enabled,
> +			   V4L2_HEVC_PPS_FLAG_CU_QP_DELTA_ENABLED);
> +	GET_HEVC_VDEC_FLAG(pps_slice_chroma_qp_offsets_present,
> +			   V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT);
> +	GET_HEVC_VDEC_FLAG(weighted_pred,
> +			   V4L2_HEVC_PPS_FLAG_WEIGHTED_PRED);
> +	GET_HEVC_VDEC_FLAG(weighted_bipred,
> +			   V4L2_HEVC_PPS_FLAG_WEIGHTED_BIPRED);
> +	GET_HEVC_VDEC_FLAG(transquant_bypass_enabled,
> +			   V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED);
> +	GET_HEVC_VDEC_FLAG(pps_flag_tiles_enabled,
> +			   V4L2_HEVC_PPS_FLAG_TILES_ENABLED);
> +	GET_HEVC_VDEC_FLAG(entropy_coding_sync_enabled,
> +			   V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED);
> +	GET_HEVC_VDEC_FLAG(loop_filter_across_tiles_enabled,
> +			   V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED);
> +	GET_HEVC_VDEC_FLAG(pps_loop_filter_across_slices_enabled,
> +			   V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED);
> +	GET_HEVC_VDEC_FLAG(deblocking_filter_override_enabled,
> +			   V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_OVERRIDE_ENABLED);
> +	GET_HEVC_VDEC_FLAG(pps_disable_deflocking_filter,
> +			   V4L2_HEVC_PPS_FLAG_PPS_DISABLE_DEBLOCKING_FILTER);
> +	GET_HEVC_VDEC_FLAG(lists_modification_present,
> +			   V4L2_HEVC_PPS_FLAG_LISTS_MODIFICATION_PRESENT);
> +	GET_HEVC_VDEC_FLAG(slice_segment_header_extersion_present,
> +			   V4L2_HEVC_PPS_FLAG_SLICE_SEGMENT_HEADER_EXTENSION_PRESENT);
> +	GET_HEVC_VDEC_FLAG(deblocking_filter_control_present,
> +			   V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT);
> +	GET_HEVC_VDEC_FLAG(uniform_spacing,
> +			   V4L2_HEVC_PPS_FLAG_UNIFORM_SPACING);
> +}
> +
> +static void vdec_hevc_copy_scaling_matrix(struct slice_api_hevc_scaling_=
matrix *dst_matrix,
> +					  const struct v4l2_ctrl_hevc_scaling_matrix *src_matrix)
> +{
> +	memcpy(dst_matrix, src_matrix, sizeof(*src_matrix));
> +}
> +
> +static void
> +vdec_hevc_copy_decode_params(struct slice_api_hevc_decode_param *dst_par=
ams,
> +			     const struct v4l2_ctrl_hevc_decode_params *src_params,
> +			     const struct v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_M=
AX])
> +{
> +	struct slice_hevc_dpb_entry *dst_entry;
> +	const struct v4l2_hevc_dpb_entry *src_entry;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dst_params->dpb); i++) {
> +		dst_entry =3D &dst_params->dpb[i];
> +		src_entry =3D &dpb[i];
> +
> +		dst_entry->timestamp =3D src_entry->timestamp;
> +		dst_entry->flags =3D src_entry->flags;
> +		dst_entry->field_pic =3D src_entry->field_pic;
> +		dst_entry->pic_order_cnt_val =3D src_entry->pic_order_cnt_val;
> +
> +		dst_params->poc_st_curr_before[i] =3D src_params->poc_st_curr_before[i=
];
> +		dst_params->poc_st_curr_after[i] =3D src_params->poc_st_curr_after[i];
> +		dst_params->poc_lt_curr[i] =3D src_params->poc_lt_curr[i];
> +	}
> +
> +	dst_params->pic_order_cnt_val =3D src_params->pic_order_cnt_val;
> +	dst_params->short_term_ref_pic_set_size =3D src_params->short_term_ref_=
pic_set_size;
> +	dst_params->long_term_ref_pic_set_size =3D src_params->long_term_ref_pi=
c_set_size;
> +	dst_params->num_active_dpb_entries =3D src_params->num_active_dpb_entri=
es;
> +	dst_params->num_poc_st_curr_before =3D src_params->num_poc_st_curr_befo=
re;
> +	dst_params->num_poc_st_curr_after =3D src_params->num_poc_st_curr_after=
;
> +	dst_params->num_delta_pocs_of_ref_rps_idx =3D src_params->num_delta_poc=
s_of_ref_rps_idx;
> +	dst_params->num_poc_lt_curr =3D src_params->num_poc_lt_curr;
> +	dst_params->flags =3D src_params->flags;
> +}
> +
> +static int vdec_hevc_slice_fill_decode_parameters(struct vdec_hevc_slice=
_inst *inst,
> +						  struct vdec_hevc_slice_share_info *share_info)
> +{
> +	struct vdec_hevc_slice_lat_dec_param *slice_param =3D &inst->vsi->hevc_=
slice_params;
> +	const struct v4l2_ctrl_hevc_decode_params *dec_params;
> +	const struct v4l2_ctrl_hevc_scaling_matrix *src_matrix;
> +	const struct v4l2_ctrl_hevc_sps *sps;
> +	const struct v4l2_ctrl_hevc_pps *pps;
> +
> +	dec_params =3D
> +		vdec_hevc_get_ctrl_ptr(inst->ctx, V4L2_CID_STATELESS_HEVC_DECODE_PARAM=
S);
> +	if (IS_ERR(dec_params))
> +		return PTR_ERR(dec_params);
> +
> +	src_matrix =3D
> +		vdec_hevc_get_ctrl_ptr(inst->ctx, V4L2_CID_STATELESS_HEVC_SCALING_MATR=
IX);
> +	if (IS_ERR(src_matrix))
> +		return PTR_ERR(src_matrix);
> +
> +	sps =3D vdec_hevc_get_ctrl_ptr(inst->ctx, V4L2_CID_STATELESS_HEVC_SPS);
> +	if (IS_ERR(sps))
> +		return PTR_ERR(sps);
> +
> +	pps =3D vdec_hevc_get_ctrl_ptr(inst->ctx, V4L2_CID_STATELESS_HEVC_PPS);
> +	if (IS_ERR(pps))
> +		return PTR_ERR(pps);
> +
> +	vdec_hevc_copy_sps_params(&slice_param->sps, sps);
> +	vdec_hevc_copy_pps_params(&slice_param->pps, pps);
> +	vdec_hevc_copy_scaling_matrix(&slice_param->scaling_matrix, src_matrix)=
;
> +
> +	memcpy(&share_info->sps, sps, sizeof(*sps));
> +	memcpy(&share_info->dec_params, dec_params, sizeof(*dec_params));
> +
> +	slice_param->decode_params.num_poc_st_curr_before =3D dec_params->num_p=
oc_st_curr_before;
> +	slice_param->decode_params.num_poc_st_curr_after =3D dec_params->num_po=
c_st_curr_after;
> +	slice_param->decode_params.num_poc_lt_curr =3D dec_params->num_poc_lt_c=
urr;
> +	slice_param->decode_params.num_delta_pocs_of_ref_rps_idx =3D
> +		dec_params->num_delta_pocs_of_ref_rps_idx;
> +
> +	return 0;
> +}
> +
> +static void vdec_hevc_slice_fill_decode_reflist(struct vdec_hevc_slice_i=
nst *inst,
> +						struct vdec_hevc_slice_lat_dec_param *slice_param,
> +						struct vdec_hevc_slice_share_info *share_info)
> +{
> +	struct v4l2_ctrl_hevc_decode_params *dec_params =3D &share_info->dec_pa=
rams;
> +
> +	vdec_hevc_copy_decode_params(&slice_param->decode_params, dec_params,
> +				     share_info->dec_params.dpb);
> +
> +	vdec_hevc_fill_dpb_info(inst->ctx, &slice_param->decode_params,
> +				slice_param->hevc_dpb_info);
> +}
> +
> +static int vdec_hevc_slice_alloc_mv_buf(struct vdec_hevc_slice_inst *ins=
t,
> +					struct vdec_pic_info *pic)
> +{
> +	unsigned int buf_sz =3D vdec_hevc_get_mv_buf_size(pic->buf_w, pic->buf_=
h);
> +	struct mtk_vcodec_mem *mem;
> +	int i, err;
> +
> +	mtk_v4l2_debug(3, "allocate mv buffer size =3D 0x%x", buf_sz);
> +	for (i =3D 0; i < HEVC_MAX_MV_NUM; i++) {
> +		mem =3D &inst->mv_buf[i];
> +		if (mem->va)
> +			mtk_vcodec_mem_free(inst->ctx, mem);
> +		mem->size =3D buf_sz;
> +		err =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
> +		if (err) {
> +			mtk_vcodec_err(inst, "failed to allocate mv buf");
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void vdec_hevc_slice_free_mv_buf(struct vdec_hevc_slice_inst *ins=
t)
> +{
> +	int i;
> +	struct mtk_vcodec_mem *mem;
> +
> +	for (i =3D 0; i < HEVC_MAX_MV_NUM; i++) {
> +		mem =3D &inst->mv_buf[i];
> +		if (mem->va)
> +			mtk_vcodec_mem_free(inst->ctx, mem);
> +	}
> +}
> +
> +static void vdec_hevc_slice_get_pic_info(struct vdec_hevc_slice_inst *in=
st)
> +{
> +	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	u32 data[3];
> +
> +	data[0] =3D ctx->picinfo.pic_w;
> +	data[1] =3D ctx->picinfo.pic_h;
> +	data[2] =3D ctx->capture_fourcc;
> +	vpu_dec_get_param(&inst->vpu, data, 3, GET_PARAM_PIC_INFO);
> +
> +	ctx->picinfo.buf_w =3D ALIGN(ctx->picinfo.pic_w, VCODEC_DEC_ALIGNED_64)=
;
> +	ctx->picinfo.buf_h =3D ALIGN(ctx->picinfo.pic_h, VCODEC_DEC_ALIGNED_64)=
;
> +	ctx->picinfo.fb_sz[0] =3D inst->vpu.fb_sz[0];
> +	ctx->picinfo.fb_sz[1] =3D inst->vpu.fb_sz[1];
> +	inst->cap_num_planes =3D
> +		ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes;
> +
> +	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
> +			 ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> +			 ctx->picinfo.buf_w, ctx->picinfo.buf_h);
> +	mtk_vcodec_debug(inst, "Y/C(%d, %d)", ctx->picinfo.fb_sz[0],
> +			 ctx->picinfo.fb_sz[1]);
> +
> +	if (ctx->last_decoded_picinfo.pic_w !=3D ctx->picinfo.pic_w ||
> +	    ctx->last_decoded_picinfo.pic_h !=3D ctx->picinfo.pic_h) {
> +		inst->resolution_changed =3D true;
> +		if (ctx->last_decoded_picinfo.buf_w !=3D ctx->picinfo.buf_w ||
> +		    ctx->last_decoded_picinfo.buf_h !=3D ctx->picinfo.buf_h)
> +			inst->realloc_mv_buf =3D true;
> +
> +		mtk_v4l2_debug(1, "resChg: (%d %d) : old(%d, %d) -> new(%d, %d)",
> +			       inst->resolution_changed,
> +			       inst->realloc_mv_buf,
> +			       ctx->last_decoded_picinfo.pic_w,
> +			       ctx->last_decoded_picinfo.pic_h,
> +			       ctx->picinfo.pic_w, ctx->picinfo.pic_h);
> +	}
> +}
> +
> +static void vdec_hevc_slice_get_crop_info(struct vdec_hevc_slice_inst *i=
nst,
> +					  struct v4l2_rect *cr)
> +{
> +	cr->left =3D 0;
> +	cr->top =3D 0;
> +	cr->width =3D inst->ctx->picinfo.pic_w;
> +	cr->height =3D inst->ctx->picinfo.pic_h;
> +
> +	mtk_vcodec_debug(inst, "l=3D%d, t=3D%d, w=3D%d, h=3D%d",
> +			 cr->left, cr->top, cr->width, cr->height);
> +}
> +
> +static int vdec_hevc_slice_setup_lat_buffer(struct vdec_hevc_slice_inst =
*inst,
> +					    struct mtk_vcodec_mem *bs,
> +					    struct vdec_lat_buf *lat_buf,
> +					    bool *res_chg)
> +{
> +	struct mtk_vcodec_mem *mem;
> +	struct mtk_video_dec_buf *src_buf_info;
> +	struct vdec_hevc_slice_share_info *share_info;
> +	int i, err;
> +
> +	inst->vsi->bs.dma_addr =3D (u64)bs->dma_addr;
> +	inst->vsi->bs.size =3D bs->size;
> +
> +	src_buf_info =3D container_of(bs, struct mtk_video_dec_buf, bs_buffer);
> +	lat_buf->src_buf_req =3D src_buf_info->m2m_buf.vb.vb2_buf.req_obj.req;
> +	v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &lat_buf->ts_info=
, true);
> +
> +	*res_chg =3D inst->resolution_changed;
> +	if (inst->resolution_changed) {
> +		mtk_vcodec_debug(inst, "- resolution changed -");
> +		if (inst->realloc_mv_buf) {
> +			err =3D vdec_hevc_slice_alloc_mv_buf(inst, &inst->ctx->picinfo);
> +			inst->realloc_mv_buf =3D false;
> +			if (err)
> +				return err;
> +		}
> +		inst->resolution_changed =3D false;
> +	}
> +
> +	for (i =3D 0; i < HEVC_MAX_MV_NUM; i++) {
> +		mem =3D &inst->mv_buf[i];
> +		inst->vsi->mv_buf_dma[i].dma_addr =3D mem->dma_addr;
> +		inst->vsi->mv_buf_dma[i].size =3D mem->size;
> +	}
> +
> +	inst->vsi->ube.dma_addr =3D lat_buf->ctx->msg_queue.wdma_addr.dma_addr;
> +	inst->vsi->ube.size =3D lat_buf->ctx->msg_queue.wdma_addr.size;
> +
> +	inst->vsi->err_map.dma_addr =3D lat_buf->wdma_err_addr.dma_addr;
> +	inst->vsi->err_map.size =3D lat_buf->wdma_err_addr.size;
> +
> +	inst->vsi->slice_bc.dma_addr =3D lat_buf->slice_bc_addr.dma_addr;
> +	inst->vsi->slice_bc.size =3D lat_buf->slice_bc_addr.size;
> +
> +	inst->vsi->trans.dma_addr_end =3D inst->ctx->msg_queue.wdma_rptr_addr;
> +	inst->vsi->trans.dma_addr =3D inst->ctx->msg_queue.wdma_wptr_addr;
> +
> +	share_info =3D lat_buf->private_data;
> +	share_info->trans.dma_addr =3D inst->vsi->trans.dma_addr;
> +	share_info->trans.dma_addr_end =3D inst->vsi->trans.dma_addr_end;
> +
> +	mtk_vcodec_debug(inst, "lat: ube addr/size(0x%llx 0x%llx) err:0x%llx",
> +			 inst->vsi->ube.buf,
> +			 inst->vsi->ube.padding,
> +			 inst->vsi->err_map.buf);
> +
> +	mtk_vcodec_debug(inst, "slice addr/size(0x%llx 0x%llx) trans start/end(=
(0x%llx 0x%llx))",
> +			 inst->vsi->slice_bc.buf,
> +			 inst->vsi->slice_bc.padding,
> +			 inst->vsi->trans.buf,
> +			 inst->vsi->trans.padding);
> +
> +	return 0;
> +}
> +
> +static int vdec_hevc_slice_setup_core_buffer(struct vdec_hevc_slice_inst=
 *inst,
> +					     struct vdec_hevc_slice_share_info *share_info,
> +					     struct vdec_lat_buf *lat_buf)
> +{
> +	struct mtk_vcodec_mem *mem;
> +	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> +	struct vb2_v4l2_buffer *vb2_v4l2;
> +	struct vdec_fb *fb;
> +	u64 y_fb_dma, c_fb_dma;
> +	int i;
> +
> +	fb =3D ctx->dev->vdec_pdata->get_cap_buffer(ctx);
> +	if (!fb) {
> +		mtk_vcodec_err(inst, "fb buffer is NULL");
> +		return -EBUSY;
> +	}
> +
> +	y_fb_dma =3D (u64)fb->base_y.dma_addr;
> +	if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes =3D=3D 1)
> +		c_fb_dma =3D
> +			y_fb_dma + inst->ctx->picinfo.buf_w * inst->ctx->picinfo.buf_h;
> +	else
> +		c_fb_dma =3D (u64)fb->base_c.dma_addr;
> +
> +	mtk_vcodec_debug(inst, "[hevc-core] y/c addr =3D 0x%llx 0x%llx", y_fb_d=
ma,
> +			 c_fb_dma);
> +
> +	inst->vsi_core->fb.y.dma_addr =3D y_fb_dma;
> +	inst->vsi_core->fb.y.size =3D ctx->picinfo.fb_sz[0];
> +	inst->vsi_core->fb.c.dma_addr =3D c_fb_dma;
> +	inst->vsi_core->fb.y.size =3D ctx->picinfo.fb_sz[1];
> +
> +	inst->vsi_core->dec.vdec_fb_va =3D (unsigned long)fb;
> +
> +	inst->vsi_core->ube.dma_addr =3D lat_buf->ctx->msg_queue.wdma_addr.dma_=
addr;
> +	inst->vsi_core->ube.size =3D lat_buf->ctx->msg_queue.wdma_addr.size;
> +
> +	inst->vsi_core->err_map.dma_addr =3D lat_buf->wdma_err_addr.dma_addr;
> +	inst->vsi_core->err_map.size =3D lat_buf->wdma_err_addr.size;
> +
> +	inst->vsi_core->slice_bc.dma_addr =3D lat_buf->slice_bc_addr.dma_addr;
> +	inst->vsi_core->slice_bc.size =3D lat_buf->slice_bc_addr.size;
> +
> +	inst->vsi_core->trans.dma_addr =3D share_info->trans.dma_addr;
> +	inst->vsi_core->trans.dma_addr_end =3D share_info->trans.dma_addr_end;
> +
> +	inst->vsi_core->wrap.dma_addr =3D inst->wrap_addr.dma_addr;
> +	inst->vsi_core->wrap.size =3D inst->wrap_addr.size;
> +
> +	for (i =3D 0; i < HEVC_MAX_MV_NUM; i++) {
> +		mem =3D &inst->mv_buf[i];
> +		inst->vsi_core->mv_buf_dma[i].dma_addr =3D mem->dma_addr;
> +		inst->vsi_core->mv_buf_dma[i].size =3D mem->size;
> +	}
> +
> +	vb2_v4l2 =3D v4l2_m2m_next_dst_buf(ctx->m2m_ctx);
> +	v4l2_m2m_buf_copy_metadata(&lat_buf->ts_info, vb2_v4l2, true);
> +
> +	return 0;
> +}
> +
> +static int vdec_hevc_slice_init(struct mtk_vcodec_ctx *ctx)
> +{
> +	struct vdec_hevc_slice_inst *inst;
> +	int err, vsi_size;
> +
> +	inst =3D kzalloc(sizeof(*inst), GFP_KERNEL);
> +	if (!inst)
> +		return -ENOMEM;
> +
> +	inst->ctx =3D ctx;
> +
> +	inst->vpu.id =3D SCP_IPI_VDEC_LAT;
> +	inst->vpu.core_id =3D SCP_IPI_VDEC_CORE;
> +	inst->vpu.ctx =3D ctx;
> +	inst->vpu.codec_type =3D ctx->current_codec;
> +	inst->vpu.capture_type =3D ctx->capture_fourcc;
> +
> +	ctx->drv_handle =3D inst;
> +	err =3D vpu_dec_init(&inst->vpu);
> +	if (err) {
> +		mtk_vcodec_err(inst, "vdec_hevc init err=3D%d", err);
> +		goto error_free_inst;
> +	}
> +
> +	vsi_size =3D round_up(sizeof(struct vdec_hevc_slice_vsi), VCODEC_DEC_AL=
IGNED_64);
> +	inst->vsi =3D inst->vpu.vsi;
> +	inst->vsi_core =3D
> +		(struct vdec_hevc_slice_vsi *)(((char *)inst->vpu.vsi) + vsi_size);
> +
> +	inst->resolution_changed =3D true;
> +	inst->realloc_mv_buf =3D true;
> +
> +	inst->wrap_addr.size =3D VDEC_HEVC_WRAP_SZ;
> +	err =3D mtk_vcodec_mem_alloc(ctx, &inst->wrap_addr);
> +	if (err)
> +		goto error_free_inst;
> +
> +	mtk_vcodec_debug(inst, "lat struct size =3D %d,%d,%d,%d vsi: %d\n",
> +			 (int)sizeof(struct mtk_hevc_sps_param),
> +			 (int)sizeof(struct mtk_hevc_pps_param),
> +			 (int)sizeof(struct vdec_hevc_slice_lat_dec_param),
> +			 (int)sizeof(struct mtk_hevc_dpb_info),
> +			 vsi_size);
> +	mtk_vcodec_debug(inst, "lat hevc instance >> %p, codec_type =3D 0x%x",
> +			 inst, inst->vpu.codec_type);
> +
> +	return 0;
> +error_free_inst:
> +	kfree(inst);
> +	return err;
> +}
> +
> +static void vdec_hevc_slice_deinit(void *h_vdec)
> +{
> +	struct vdec_hevc_slice_inst *inst =3D h_vdec;
> +	struct mtk_vcodec_mem *mem;
> +
> +	mtk_vcodec_debug_enter(inst);
> +
> +	vpu_dec_deinit(&inst->vpu);
> +	vdec_hevc_slice_free_mv_buf(inst);
> +
> +	mem =3D &inst->wrap_addr;
> +	if (mem->va)
> +		mtk_vcodec_mem_free(inst->ctx, mem);
> +
> +	vdec_msg_queue_deinit(&inst->ctx->msg_queue, inst->ctx);
> +	kfree(inst);
> +}
> +
> +static int vdec_hevc_slice_core_decode(struct vdec_lat_buf *lat_buf)
> +{
> +	int err, timeout;
> +	struct mtk_vcodec_ctx *ctx =3D lat_buf->ctx;
> +	struct vdec_hevc_slice_inst *inst =3D ctx->drv_handle;
> +	struct vdec_hevc_slice_share_info *share_info =3D lat_buf->private_data=
;
> +	struct vdec_vpu_inst *vpu =3D &inst->vpu;
> +
> +	mtk_vcodec_debug(inst, "[hevc-core] vdec_hevc core decode");
> +	memcpy(&inst->vsi_core->hevc_slice_params, &share_info->hevc_slice_para=
ms,
> +	       sizeof(share_info->hevc_slice_params));
> +
> +	err =3D vdec_hevc_slice_setup_core_buffer(inst, share_info, lat_buf);
> +	if (err)
> +		goto vdec_dec_end;
> +
> +	vdec_hevc_slice_fill_decode_reflist(inst, &inst->vsi_core->hevc_slice_p=
arams,
> +					    share_info);
> +	err =3D vpu_dec_core(vpu);
> +	if (err) {
> +		mtk_vcodec_err(inst, "core decode err=3D%d", err);
> +		goto vdec_dec_end;
> +	}
> +
> +	/* wait decoder done interrupt */
> +	timeout =3D mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIV=
ED,
> +					       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
> +	if (timeout)
> +		mtk_vcodec_err(inst, "core decode timeout: pic_%d",
> +			       ctx->decoded_frame_cnt);
> +	inst->vsi_core->dec.timeout =3D !!timeout;
> +
> +	vpu_dec_core_end(vpu);
> +	mtk_vcodec_debug(inst, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x=
 0x%x",
> +			 ctx->decoded_frame_cnt,
> +			 inst->vsi_core->dec.crc[0], inst->vsi_core->dec.crc[1],
> +			 inst->vsi_core->dec.crc[2], inst->vsi_core->dec.crc[3],
> +			 inst->vsi_core->dec.crc[4], inst->vsi_core->dec.crc[5],
> +			 inst->vsi_core->dec.crc[6], inst->vsi_core->dec.crc[7]);
> +
> +vdec_dec_end:
> +	vdec_msg_queue_update_ube_rptr(&lat_buf->ctx->msg_queue, share_info->tr=
ans.dma_addr_end);
> +	ctx->dev->vdec_pdata->cap_to_disp(ctx, !!err, lat_buf->src_buf_req);
> +	mtk_vcodec_debug(inst, "core decode done err=3D%d", err);
> +	ctx->decoded_frame_cnt++;
> +	return 0;
> +}
> +
> +static int vdec_hevc_slice_lat_decode(void *h_vdec, struct mtk_vcodec_me=
m *bs,
> +				      struct vdec_fb *fb, bool *res_chg)
> +{
> +	struct vdec_hevc_slice_inst *inst =3D h_vdec;
> +	struct vdec_vpu_inst *vpu =3D &inst->vpu;
> +
> +	int err, timeout =3D 0;
> +	unsigned int data[2];
> +	struct vdec_lat_buf *lat_buf;
> +	struct vdec_hevc_slice_share_info *share_info;
> +
> +	if (vdec_msg_queue_init(&inst->ctx->msg_queue, inst->ctx,
> +				vdec_hevc_slice_core_decode,
> +				sizeof(*share_info)))
> +		return -ENOMEM;
> +
> +	/* bs NULL means flush decoder */
> +	if (!bs) {
> +		vdec_msg_queue_wait_lat_buf_full(&inst->ctx->msg_queue);
> +		return vpu_dec_reset(vpu);
> +	}
> +
> +	lat_buf =3D vdec_msg_queue_dqbuf(&inst->ctx->msg_queue.lat_ctx);
> +	if (!lat_buf) {
> +		mtk_vcodec_debug(inst, "failed to get lat buffer");
> +		return -EAGAIN;
> +	}
> +
> +	share_info =3D lat_buf->private_data;
> +	err =3D vdec_hevc_slice_fill_decode_parameters(inst, share_info);
> +	if (err)
> +		goto err_free_fb_out;
> +
> +	err =3D vdec_hevc_slice_setup_lat_buffer(inst, bs, lat_buf, res_chg);
> +	if (err)
> +		goto err_free_fb_out;
> +
> +	err =3D vpu_dec_start(vpu, data, 2);
> +	if (err) {
> +		mtk_vcodec_debug(inst, "lat decode err: %d", err);
> +		goto err_free_fb_out;
> +	}
> +
> +	if (IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability)) {
> +		memcpy(&share_info->hevc_slice_params, &inst->vsi->hevc_slice_params,
> +		       sizeof(share_info->hevc_slice_params));
> +		vdec_msg_queue_qbuf(&inst->ctx->dev->msg_queue_core_ctx, lat_buf);
> +	}
> +
> +	/* wait decoder done interrupt */
> +	timeout =3D mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIV=
ED,
> +					       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
> +	if (timeout)
> +		mtk_vcodec_err(inst, "lat decode timeout: pic_%d", inst->slice_dec_num=
);
> +	inst->vsi->dec.timeout =3D !!timeout;
> +
> +	err =3D vpu_dec_end(vpu);
> +	if (err =3D=3D SLICE_HEADER_FULL || err =3D=3D TRANS_BUFFER_FULL) {
> +		if (!IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability))
> +			vdec_msg_queue_qbuf(&inst->ctx->msg_queue.lat_ctx, lat_buf);
> +		inst->slice_dec_num++;
> +		mtk_vcodec_err(inst, "lat dec fail: pic_%d err:%d", inst->slice_dec_nu=
m, err);
> +		return -EINVAL;
> +	}
> +
> +	share_info->trans.dma_addr_end =3D inst->ctx->msg_queue.wdma_addr.dma_a=
ddr +
> +		inst->vsi->dec.wdma_end_addr_offset;
> +	vdec_msg_queue_update_ube_wptr(&lat_buf->ctx->msg_queue, share_info->tr=
ans.dma_addr_end);
> +
> +	if (!IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability)) {
> +		memcpy(&share_info->hevc_slice_params, &inst->vsi->hevc_slice_params,
> +		       sizeof(share_info->hevc_slice_params));
> +		vdec_msg_queue_qbuf(&inst->ctx->dev->msg_queue_core_ctx, lat_buf);
> +	}
> +	mtk_vcodec_debug(inst, "dec num: %d lat crc: 0x%x 0x%x 0x%x", inst->sli=
ce_dec_num,
> +			 inst->vsi->dec.crc[0], inst->vsi->dec.crc[1], inst->vsi->dec.crc[2])=
;
> +
> +	inst->slice_dec_num++;
> +	return 0;
> +err_free_fb_out:
> +	vdec_msg_queue_qbuf(&inst->ctx->msg_queue.lat_ctx, lat_buf);
> +	mtk_vcodec_err(inst, "slice dec number: %d err: %d", inst->slice_dec_nu=
m, err);
> +	return err;
> +}
> +
> +static int vdec_hevc_slice_decode(void *h_vdec, struct mtk_vcodec_mem *b=
s,
> +				  struct vdec_fb *unused, bool *res_chg)
> +{
> +	struct vdec_hevc_slice_inst *inst =3D h_vdec;
> +
> +	if (!h_vdec || inst->ctx->dev->vdec_pdata->hw_arch =3D=3D MTK_VDEC_PURE=
_SINGLE_CORE)
> +		return -EINVAL;
> +
> +	return vdec_hevc_slice_lat_decode(h_vdec, bs, unused, res_chg);
> +}
> +
> +static int vdec_hevc_slice_get_param(void *h_vdec, enum vdec_get_param_t=
ype type,
> +				     void *out)
> +{
> +	struct vdec_hevc_slice_inst *inst =3D h_vdec;
> +
> +	switch (type) {
> +	case GET_PARAM_PIC_INFO:
> +		vdec_hevc_slice_get_pic_info(inst);
> +		break;
> +	case GET_PARAM_DPB_SIZE:
> +		*(unsigned int *)out =3D 6;
> +		break;
> +	case GET_PARAM_CROP_INFO:
> +		vdec_hevc_slice_get_crop_info(inst, out);
> +		break;
> +	default:
> +		mtk_vcodec_err(inst, "invalid get parameter type=3D%d", type);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +const struct vdec_common_if vdec_hevc_slice_multi_if =3D {
> +	.init		=3D vdec_hevc_slice_init,
> +	.decode		=3D vdec_hevc_slice_decode,
> +	.get_param	=3D vdec_hevc_slice_get_param,
> +	.deinit		=3D vdec_hevc_slice_deinit,
> +};
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c b/drive=
rs/media/platform/mediatek/vcodec/vdec_drv_if.c
> index f3807f03d880..0bde1eb04015 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
> @@ -49,6 +49,10 @@ int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned =
int fourcc)
>  		ctx->dec_if =3D &vdec_vp9_slice_lat_if;
>  		ctx->hw_id =3D IS_VDEC_LAT_ARCH(hw_arch) ? MTK_VDEC_LAT0 : MTK_VDEC_CO=
RE;
>  		break;
> +	case V4L2_PIX_FMT_HEVC_SLICE:
> +		ctx->dec_if =3D &vdec_hevc_slice_multi_if;
> +		ctx->hw_id =3D MTK_VDEC_LAT0;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drive=
rs/media/platform/mediatek/vcodec/vdec_drv_if.h
> index 076306ff2dd4..ef3a0762fdc8 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
> @@ -61,6 +61,7 @@ extern const struct vdec_common_if vdec_vp8_if;
>  extern const struct vdec_common_if vdec_vp8_slice_if;
>  extern const struct vdec_common_if vdec_vp9_if;
>  extern const struct vdec_common_if vdec_vp9_slice_lat_if;
> +extern const struct vdec_common_if vdec_hevc_slice_multi_if;
> =20
>  /**
>   * vdec_if_init() - initialize decode driver

