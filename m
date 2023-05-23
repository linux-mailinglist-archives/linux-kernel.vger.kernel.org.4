Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5B570D6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbjEWIN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbjEWINM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:13:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB46F10C3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:11:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510f3db1cd8so1051962a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684829512; x=1687421512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gp1v4Cr3o5+B6rrBcs3JmI/C2kk1LIFxtPN9N4d37Ss=;
        b=EvPA2B3oorfLyrZF5+6TITFdLDkF66Ib+k892LvDLlQoulCfTaoXHVG77F++9noH5r
         8hWSTBG3PtGTTb2CipVLGUnw9O0RqyvF/DK1iJ3/IUu4047Jiv0pY/OJOcOTDA3yaYMs
         Q/RN5/5isOaZp/Qxn40WP4y3igFIuGYNClZRsjmD2LPRzLq1J8zZPqWL+ePtGjzjoWZN
         D+1VgjpBN5s4giysmxwI4kOk1BSPl0La4JD4ABGdxb0yuIC4szQIE4qIZRPy1+VY/9pF
         cM4BPbjHNcdnsMEIYuR73DRhHr7L8H/W8vSs5Cv07ZgqSjJ15idImfh3GDmo+FymY7h4
         klOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684829512; x=1687421512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gp1v4Cr3o5+B6rrBcs3JmI/C2kk1LIFxtPN9N4d37Ss=;
        b=e1ehV8jlnc153eUR41PwJCOtpXH6FLfqtW4wF/qsng3HkmPR0yZNpYrV4XiBTFh9h6
         HYMerYHrUOI0WeHxcgQcx98fjugiyEvkHkma+0xbAU3CppL3P66CzYBN7RGJz4s2H+J2
         YaI06Q8ZOV4aaOt0dRPBqE2HH33XpzJ2OtPgUE5Hyu97mQ9Jrv2ssODfOsc8i+0jnUUp
         j+2ggfiH81Gj8XzTnh+Sjon1cskjxM8OBWBzcL/ST78H3570H49+uB3QdZal/F8y6/Gt
         MC2OXhV9aFeOAx5XeIB0DpLuQvn9nrFJRm82+7gn6Rkp5nI9BtAfPVxl7K5+K/GWcWrc
         /8aQ==
X-Gm-Message-State: AC+VfDzrK3XrmH3cH3FxYAXToQKtMTVj+YgSjnZWrch1cJb7NqDb7jLj
        E3v7FXviwmUUP8ES8QOf/8Em+EEl50FOViqLOGg=
X-Google-Smtp-Source: ACHHUZ7rRd4HnSgmEMMg7ba24i++vzAy/3RyMhjRS9MJknXCIJXMuRwbIaMN9p9Cs7sBRCbccNJENg==
X-Received: by 2002:a2e:8058:0:b0:2af:47b2:3f6a with SMTP id p24-20020a2e8058000000b002af47b23f6amr2376442ljg.53.1684828939421;
        Tue, 23 May 2023 01:02:19 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9617000000b002a77583b718sm1501256ljh.12.2023.05.23.01.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 01:02:18 -0700 (PDT)
Message-ID: <0f7a33c1-f894-adfe-94d7-89296893128f@linaro.org>
Date:   Tue, 23 May 2023 10:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] venus: replace arrary index with enum for supported
 formats
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1684736229-30567-1-git-send-email-quic_dikshita@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1684736229-30567-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.05.2023 08:17, Dikshita Agarwal wrote:
> Use enums to list supported formats for encoder and decoder
> instead of array index which was a error prone design.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
Thanks a lot.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

>  drivers/media/platform/qcom/venus/core.h | 16 ++++++++
>  drivers/media/platform/qcom/venus/vdec.c | 63 +++++++++++++++++++-------------
>  drivers/media/platform/qcom/venus/venc.c | 31 +++++++++-------
>  3 files changed, 72 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 12a42fb..e988ed4 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -83,6 +83,22 @@ struct venus_resources {
>  	const char *fwname;
>  };
>  
> +enum venus_fmt {
> +	VENUS_FMT_NV12			= 0,
> +	VENUS_FMT_QC08C			= 1,
> +	VENUS_FMT_QC10C			= 2,
> +	VENUS_FMT_H264			= 3,
> +	VENUS_FMT_VP8			= 4,
> +	VENUS_FMT_VP9			= 5,
> +	VENUS_FMT_HEVC			= 6,
> +	VENUS_FMT_VC1_ANNEX_G		= 7,
> +	VENUS_FMT_VC1_ANNEX_L		= 8,
> +	VENUS_FMT_MPEG4			= 9,
> +	VENUS_FMT_MPEG2			= 10,
> +	VENUS_FMT_H263			= 11,
> +	VENUS_FMT_XVID			= 12,
Nit: I don't think the '= n' is necessary here, as it doesn't
map to anything in hw/fw (or does it?)

Konrad

> +};
> +
>  struct venus_format {
>  	u32 pixfmt;
>  	unsigned int num_planes;
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index c6f0fd08..bab985b 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -30,69 +30,82 @@
>   * - future firmware versions could add support for >1 planes
>   */
>  static const struct venus_format vdec_formats[] = {
> -	{
> +	[VENUS_FMT_NV12] = {
>  		.pixfmt = V4L2_PIX_FMT_NV12,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> -	}, {
> +	},
> +	[VENUS_FMT_QC08C] = {
>  		.pixfmt = V4L2_PIX_FMT_QC08C,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> -	}, {
> +	},
> +	[VENUS_FMT_QC10C] = {
>  		.pixfmt = V4L2_PIX_FMT_QC10C,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_MPEG4,
> +	},
> +	[VENUS_FMT_H264] = {
> +		.pixfmt = V4L2_PIX_FMT_H264,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_MPEG2,
> +	},
> +	[VENUS_FMT_VP8] = {
> +		.pixfmt = V4L2_PIX_FMT_VP8,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_H263,
> +	},
> +	[VENUS_FMT_VP9] = {
> +		.pixfmt = V4L2_PIX_FMT_VP9,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_G,
> +	},
> +	[VENUS_FMT_HEVC] = {
> +		.pixfmt = V4L2_PIX_FMT_HEVC,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
> +	},
> +	[VENUS_FMT_VC1_ANNEX_G] = {
> +		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_G,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_H264,
> +	},
> +	[VENUS_FMT_VC1_ANNEX_L] = {
> +		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_VP8,
> +	},
> +	[VENUS_FMT_MPEG4] = {
> +		.pixfmt = V4L2_PIX_FMT_MPEG4,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_VP9,
> +	},
> +	[VENUS_FMT_MPEG2] = {
> +		.pixfmt = V4L2_PIX_FMT_MPEG2,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_XVID,
> +	},
> +	[VENUS_FMT_H263] = {
> +		.pixfmt = V4L2_PIX_FMT_H263,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_HEVC,
> +	},
> +	[VENUS_FMT_XVID] = {
> +		.pixfmt = V4L2_PIX_FMT_XVID,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>  	},
> +
>  };
>  
>  static const struct venus_format *
> @@ -1575,8 +1588,8 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
>  static void vdec_inst_init(struct venus_inst *inst)
>  {
>  	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
> -	inst->fmt_out = &vdec_formats[8];
> -	inst->fmt_cap = &vdec_formats[0];
> +	inst->fmt_out = &vdec_formats[VENUS_FMT_H264];
> +	inst->fmt_cap = &vdec_formats[VENUS_FMT_NV12];
>  	inst->width = frame_width_min(inst);
>  	inst->height = ALIGN(frame_height_min(inst), 32);
>  	inst->crop.left = 0;
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 4666f42..b60772c 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -32,28 +32,33 @@
>   * - future firmware versions could add support for >1 planes
>   */
>  static const struct venus_format venc_formats[] = {
> -	{
> +	[VENUS_FMT_NV12] = {
>  		.pixfmt = V4L2_PIX_FMT_NV12,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_MPEG4,
> +	},
> +	[VENUS_FMT_H264] = {
> +		.pixfmt = V4L2_PIX_FMT_H264,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_H263,
> +	},
> +	[VENUS_FMT_VP8] = {
> +		.pixfmt = V4L2_PIX_FMT_VP8,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_H264,
> +	},
> +	[VENUS_FMT_HEVC] = {
> +		.pixfmt = V4L2_PIX_FMT_HEVC,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_VP8,
> +	},
> +	[VENUS_FMT_MPEG4] = {
> +		.pixfmt = V4L2_PIX_FMT_MPEG4,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> -	}, {
> -		.pixfmt = V4L2_PIX_FMT_HEVC,
> +	},
> +	[VENUS_FMT_H263] = {
> +		.pixfmt = V4L2_PIX_FMT_H263,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>  	},
> @@ -1416,8 +1421,8 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
>  
>  static void venc_inst_init(struct venus_inst *inst)
>  {
> -	inst->fmt_cap = &venc_formats[3];
> -	inst->fmt_out = &venc_formats[0];
> +	inst->fmt_cap = &venc_formats[VENUS_FMT_H264];
> +	inst->fmt_out = &venc_formats[VENUS_FMT_NV12];
>  	inst->width = 1280;
>  	inst->height = ALIGN(720, 32);
>  	inst->out_width = 1280;
