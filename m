Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91C76F4319
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjEBLxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEBLxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:53:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA42049E7
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:53:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4edcdfa8638so4422115e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683028391; x=1685620391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+vglhm+bDOJd4J/XyU1wbi0B7CYN6778bxrbgNwu8M=;
        b=XpbJ0Jmb7b9iJiwUNXj980qlB0TLLKK5sJgEucCQyCrkpTSZ9jEyN6awif0qLS3ETi
         nt3AtmxIdP3Wxi7fz5FPLH2byBEIOrIKdGrJtP5yg816D65k5XkCeSf6K7Hlbo44IP5i
         4R1C4aYGcmh5x62dO06f7Xhh8ZdgBLvvuvqsOVpMHBu4MtkBryfFg7GMy+0W7g0B5k4W
         HmOeu8DosClTVGXwq0+kWLCxwvM3RJPtPjcun7S4ca8zFX/jUSiNzZBG3FiEq5kPJPI4
         C1QpO75fwREFLYcfpWQ7jSwJ0ORX5tuWYQI0b+cGBH+81bbKry4lv9sbnBmaaLJsVsuG
         dW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683028391; x=1685620391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+vglhm+bDOJd4J/XyU1wbi0B7CYN6778bxrbgNwu8M=;
        b=btgd5rgQD2p22tls4ucKwOyleZS7ggfmxFoYXPvPICjjRY1SdvxKhj/p10yf09aHcY
         qPH0RdEuTjMWKxewKP/qjbffhOjYahCh0+FLJZVLWsiMt29j5ifnO85A8NexPPhplOFn
         8qZqCTtphS2kuT2Nwo83h7br7PLJUl3Nhl3djWPWM5aslj5LkdYFNOMDAUr3njiDVZnv
         OPvmHxe8rmnNopCXNvviQ0/RSbbebG09oelJnvjkSVPEY3Dz4VbGrsmicIM7/XHgM1b7
         hZLs5G4o1Ib4DOXY4pPZYAL6vo9GEKgoAM821nxWplNzKe/ADDwZoNL0+7V2b1YAy/HA
         yrzw==
X-Gm-Message-State: AC+VfDw1yy7T3/3j4VtY70Xe1hXQdOalUPzxIAmcsUkDwHRmOQOtlPdo
        b/z0kDCBBcRraxYlctZDnB2KiQ==
X-Google-Smtp-Source: ACHHUZ4ISG19cH2dnrwpmI8cD5vPRDXErDC4hzJR3u8iZqSJ/XhHRvR86NiEt9QrNEd4xrEiJkOyEQ==
X-Received: by 2002:ac2:4438:0:b0:4b3:d6e1:26bb with SMTP id w24-20020ac24438000000b004b3d6e126bbmr4633699lfl.29.1683028390665;
        Tue, 02 May 2023 04:53:10 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id c20-20020ac25314000000b004f00d7fcf0fsm2693850lfh.26.2023.05.02.04.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:53:10 -0700 (PDT)
Message-ID: <4434859f-a5b2-a9da-8dad-3f2c4f48cd27@linaro.org>
Date:   Tue, 2 May 2023 13:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] venus: add support for 10 bit decoding.
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1682492417-20496-1-git-send-email-quic_dikshita@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1682492417-20496-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.04.2023 09:00, Dikshita Agarwal wrote:
> - Add support for V4L2_PIX_FMT_P010 color format.
> - Add handling of bit depth change from firmware.
> - Return P010 as preferred format for 10 bit decode.
Sounds like this should be 3 separate patches, preferably with
some insight in each commit message.

Konrad
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/helpers.c        | 25 ++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_plat_bufs.h  |  3 +++
>  .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |  9 +++++++-
>  drivers/media/platform/qcom/venus/vdec.c           | 18 +++++++++++++---
>  4 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index ab6a29f..193215c 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -612,6 +612,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
>  		return HFI_COLOR_FORMAT_NV12_UBWC;
>  	case V4L2_PIX_FMT_QC10C:
>  		return HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
> +	case V4L2_PIX_FMT_P010:
> +		return HFI_COLOR_FORMAT_P010;
>  	default:
>  		break;
>  	}
> @@ -639,12 +641,16 @@ static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
>  	if (is_dec) {
>  		params.width = inst->width;
>  		params.height = inst->height;
> +		params.out_width = inst->out_width;
> +		params.out_height = inst->out_height;
>  		params.codec = inst->fmt_out->pixfmt;
>  		params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_cap->pixfmt);
>  		params.dec.max_mbs_per_frame = mbs_per_frame_max(inst);
>  		params.dec.buffer_size_limit = 0;
>  		params.dec.is_secondary_output =
>  			inst->opb_buftype == HFI_BUFFER_OUTPUT2;
> +		if (params.dec.is_secondary_output)
> +			params.hfi_dpb_color_fmt = inst->dpb_fmt;
>  		params.dec.is_interlaced =
>  			inst->pic_struct != HFI_INTERLACE_FRAME_PROGRESSIVE;
>  	} else {
> @@ -1764,6 +1770,25 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
>  	if (!caps)
>  		return -EINVAL;
>  
> +	if (inst->bit_depth == VIDC_BITDEPTH_10 &&
> +	    inst->session_type == VIDC_SESSION_TYPE_DEC) {
> +		found_ubwc =
> +			find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
> +					   HFI_COLOR_FORMAT_YUV420_TP10_UBWC);
> +		found = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT2,
> +					   fmt);
> +		if (found_ubwc && found) {
> +			/*
> +			 * Hard-code DPB buffers to be 10bit UBWC
> +			 * until V4L2 is able to expose compressed/tiled
> +			 * formats to applications.
> +			 */
> +			*out_fmt = HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
> +			*out2_fmt = fmt;
> +			return 0;
> +		}
> +	}
> +
>  	if (ubwc) {
>  		ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
>  		found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
> diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
> index 52a51a3..25e6074 100644
> --- a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
> +++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
> @@ -12,8 +12,11 @@
>  struct hfi_plat_buffers_params {
>  	u32 width;
>  	u32 height;
> +	u32 out_width;
> +	u32 out_height;
>  	u32 codec;
>  	u32 hfi_color_fmt;
> +	u32 hfi_dpb_color_fmt;
>  	enum hfi_version version;
>  	u32 num_vpp_pipes;
>  	union {
> diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> index ea25c45..08caab1 100644
> --- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> +++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> @@ -1185,6 +1185,7 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
>  	enum hfi_version version = params->version;
>  	u32 codec = params->codec;
>  	u32 width = params->width, height = params->height, out_min_count;
> +	u32 out_width = params->out_width, out_height = params->out_height;
>  	struct dec_bufsize_ops *dec_ops;
>  	bool is_secondary_output = params->dec.is_secondary_output;
>  	bool is_interlaced = params->dec.is_interlaced;
> @@ -1235,7 +1236,13 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
>  		bufreq->count_min = out_min_count;
>  		bufreq->size =
>  			venus_helper_get_framesz_raw(params->hfi_color_fmt,
> -						     width, height);
> +						     out_width, out_height);
> +
> +		if (buftype == HFI_BUFFER_OUTPUT &&
> +		    params->dec.is_secondary_output)
> +			bufreq->size =
> +				venus_helper_get_framesz_raw(params->hfi_dpb_color_fmt,
> +							     out_width, out_height);
>  	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH(version)) {
>  		bufreq->size = dec_ops->scratch(width, height, is_interlaced);
>  	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH_1(version)) {
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 4ceaba3..99d0e96 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -43,6 +43,10 @@ static const struct venus_format vdec_formats[] = {
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>  	}, {
> +		.pixfmt = V4L2_PIX_FMT_P010,
> +		.num_planes = 1,
> +		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +	}, {
>  		.pixfmt = V4L2_PIX_FMT_MPEG4,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> @@ -697,6 +701,9 @@ static int vdec_set_work_route(struct venus_inst *inst)
>  }
>  
>  #define is_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_UBWC_BASE))
> +#define is_10bit_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_10_BIT_BASE & \
> +				    HFI_COLOR_FORMAT_UBWC_BASE))
> +
>  
>  static int vdec_output_conf(struct venus_inst *inst)
>  {
> @@ -744,7 +751,7 @@ static int vdec_output_conf(struct venus_inst *inst)
>  		inst->opb_fmt = out2_fmt;
>  		inst->dpb_buftype = HFI_BUFFER_OUTPUT;
>  		inst->dpb_fmt = out_fmt;
> -	} else if (is_ubwc_fmt(out2_fmt)) {
> +	} else if (is_ubwc_fmt(out2_fmt) || is_10bit_ubwc_fmt(out_fmt)) {
>  		inst->opb_buftype = HFI_BUFFER_OUTPUT;
>  		inst->opb_fmt = out_fmt;
>  		inst->dpb_buftype = HFI_BUFFER_OUTPUT2;
> @@ -1420,7 +1427,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>  static void vdec_event_change(struct venus_inst *inst,
>  			      struct hfi_event_data *ev_data, bool sufficient)
>  {
> -	static const struct v4l2_event ev = {
> +	struct v4l2_event ev = {
>  		.type = V4L2_EVENT_SOURCE_CHANGE,
>  		.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION };
>  	struct device *dev = inst->core->dev_dec;
> @@ -1461,8 +1468,13 @@ static void vdec_event_change(struct venus_inst *inst,
>  	inst->out_width = ev_data->width;
>  	inst->out_height = ev_data->height;
>  
> -	if (inst->bit_depth != ev_data->bit_depth)
> +	if (inst->bit_depth != ev_data->bit_depth) {
>  		inst->bit_depth = ev_data->bit_depth;
> +		if (inst->bit_depth == VIDC_BITDEPTH_10)
> +			inst->fmt_cap = &vdec_formats[3];
> +		else
> +			inst->fmt_cap = &vdec_formats[0];
> +	}
>  
>  	if (inst->pic_struct != ev_data->pic_struct)
>  		inst->pic_struct = ev_data->pic_struct;
