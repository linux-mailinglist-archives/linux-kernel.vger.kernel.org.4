Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCC86A235E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBXVEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:04:40 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E445E859
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:04:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i9so786709lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lszs4gFEp6xlpuCdIMDcvdyOaBDChuIXNZLbY3PSN+w=;
        b=FFoAnd2wFYH55quPctWfE3WOhdtqx4qGcOH/8R1h9cZgLIO1SjNy1jyuHGfYQlqXwg
         tN4gn4i3zpVfs5LYJOycZm2yEvpjjO1n/ZGofv8WSYllHopEX3oG1l7fs47maVqGiXjJ
         RoJHLAqO1GPVMKKcqWJE8HGWFB6BFRAt9Q9JNF/DN9aJjU1LxEacVtlp4b4+f8rL6/oT
         Dte+b48yE5mIl6Xe1KDgQ+VJz/UTJMlspMK7kuJmQMDF2SCVrhixJfHJXKjYsunFXkWI
         bZzAjlCc4OC+Ra+0Had2ryAVanchi16nbp+qmCZqkTqzM+WDHuKniQ4Ocef9jXZbjwrX
         6k+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lszs4gFEp6xlpuCdIMDcvdyOaBDChuIXNZLbY3PSN+w=;
        b=ReBj4hk6jzz4I1OExdWTBdxbP5OLGdp4sAvpX88abytJtimRdPCt33NTARV9Qc6rRS
         yT2kwGzgqpd0IDQtOByNqdGSD7VgLEck1TFvU3E47PmCEi8qk+eM4HEMDgRjvOeEJwTB
         Adgmcg60++umfVPkaAji9XFHJTjzldD/vu0zPRnS2uRr4KClCDxwsJTQ633l2cJRuRCy
         ydbKxgyPoFiYYdM5gdDDdT3S7iuRt0WBZtLCt8RSD/0PefGw5dLSUJzOFphncLlLiBYo
         2XgIqh3NYw4a+WXRiwnL9YYkYLoJDXP5AJ+nDJPY0VECaSzfe1WhKLKuuq2e6MavFYQL
         ZIiA==
X-Gm-Message-State: AO0yUKX7oyjkQ+QtDu8zHnau52blMYejXeo5ANrQGEF6BH+trC3jomRI
        BTS1h0WwVw1kI3cjz08z93b82w==
X-Google-Smtp-Source: AK7set+jot1Xx+HYRKIm/IB6J0LNgiDMMuzLqDQidL6EC2s5j4GX6oiobb4KkHt+I3bq5PgbJzZ8eg==
X-Received: by 2002:a05:6512:147:b0:4db:513b:6ef4 with SMTP id m7-20020a056512014700b004db513b6ef4mr5691421lfo.11.1677272676735;
        Fri, 24 Feb 2023 13:04:36 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j7-20020ac253a7000000b004d86808fd33sm746lfh.15.2023.02.24.13.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:04:36 -0800 (PST)
Message-ID: <525078f5-44be-9a75-a737-ddcc6e097700@linaro.org>
Date:   Fri, 24 Feb 2023 23:04:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFC PATCH 2/2] drm/msm/dsi: use new
 dpu_dsc_populate_dsc_config()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1677267647-28672-1-git-send-email-quic_khsieh@quicinc.com>
 <1677267647-28672-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1677267647-28672-3-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 21:40, Kuogee Hsieh wrote:
> use new introduced dpu_dsc_populate_dsc_config() to calculate
> and populate drm_dsc_info instead of hard code value.

DPU is an optional component, so DSI driver should not depend on the DPU 
driver.

> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 78 ++++++--------------------------------
>   1 file changed, 12 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 31ad193..5f3f84f 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023. Qualcomm Innovation Center, Inc. All rights reserved
>    */
>   
>   #include <linux/clk.h>
> @@ -21,7 +22,6 @@
>   
>   #include <video/mipi_display.h>
>   
> -#include <drm/display/drm_dsc_helper.h>
>   #include <drm/drm_of.h>
>   
>   #include "dsi.h"
> @@ -31,6 +31,7 @@
>   #include "msm_kms.h"
>   #include "msm_gem.h"
>   #include "phy/dsi_phy.h"
> +#include "dpu_dsc_helper.h"
>   
>   #define DSI_RESET_TOGGLE_DELAY_MS 20
>   
> @@ -1819,29 +1820,8 @@ static int dsi_host_parse_lane_data(struct msm_dsi_host *msm_host,
>   	return -EINVAL;
>   }
>   
> -static u32 dsi_dsc_rc_buf_thresh[DSC_NUM_BUF_RANGES - 1] = {
> -	0x0e, 0x1c, 0x2a, 0x38, 0x46, 0x54, 0x62,
> -	0x69, 0x70, 0x77, 0x79, 0x7b, 0x7d, 0x7e
> -};
> -
> -/* only 8bpc, 8bpp added */
> -static char min_qp[DSC_NUM_BUF_RANGES] = {
> -	0, 0, 1, 1, 3, 3, 3, 3, 3, 3, 5, 5, 5, 7, 13
> -};
> -
> -static char max_qp[DSC_NUM_BUF_RANGES] = {
> -	4, 4, 5, 6, 7, 7, 7, 8, 9, 10, 11, 12, 13, 13, 15
> -};
> -
> -static char bpg_offset[DSC_NUM_BUF_RANGES] = {
> -	2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -12, -12, -12, -12
> -};
> -
>   static int dsi_populate_dsc_params(struct msm_dsi_host *msm_host, struct drm_dsc_config *dsc)
>   {
> -	int i;
> -	u16 bpp = dsc->bits_per_pixel >> 4;
> -
>   	if (dsc->bits_per_pixel & 0xf) {
>   		DRM_DEV_ERROR(&msm_host->pdev->dev, "DSI does not support fractional bits_per_pixel\n");
>   		return -EINVAL;
> @@ -1852,50 +1832,16 @@ static int dsi_populate_dsc_params(struct msm_dsi_host *msm_host, struct drm_dsc
>   		return -EOPNOTSUPP;
>   	}
>   
> -	dsc->rc_model_size = 8192;
> -	dsc->first_line_bpg_offset = 12;
> -	dsc->rc_edge_factor = 6;
> -	dsc->rc_tgt_offset_high = 3;
> -	dsc->rc_tgt_offset_low = 3;
> -	dsc->simple_422 = 0;
> -	dsc->convert_rgb = 1;
> -	dsc->vbr_enable = 0;
> -
> -	/* handle only bpp = bpc = 8 */
> -	for (i = 0; i < DSC_NUM_BUF_RANGES - 1 ; i++)
> -		dsc->rc_buf_thresh[i] = dsi_dsc_rc_buf_thresh[i];
> -
> -	for (i = 0; i < DSC_NUM_BUF_RANGES; i++) {
> -		dsc->rc_range_params[i].range_min_qp = min_qp[i];
> -		dsc->rc_range_params[i].range_max_qp = max_qp[i];
> -		/*
> -		 * Range BPG Offset contains two's-complement signed values that fill
> -		 * 8 bits, yet the registers and DCS PPS field are only 6 bits wide.
> -		 */
> -		dsc->rc_range_params[i].range_bpg_offset = bpg_offset[i] & DSC_RANGE_BPG_OFFSET_MASK;
> -	}
> -
> -	dsc->initial_offset = 6144;		/* Not bpp 12 */
> -	if (bpp != 8)
> -		dsc->initial_offset = 2048;	/* bpp = 12 */
> -
> -	if (dsc->bits_per_component <= 10)
> -		dsc->mux_word_size = DSC_MUX_WORD_SIZE_8_10_BPC;
> -	else
> -		dsc->mux_word_size = DSC_MUX_WORD_SIZE_12_BPC;
> -
> -	dsc->initial_xmit_delay = 512;
> -	dsc->initial_scale_value = 32;
> -	dsc->first_line_bpg_offset = 12;
> -	dsc->line_buf_depth = dsc->bits_per_component + 1;
> -
> -	/* bpc 8 */
> -	dsc->flatness_min_qp = 3;
> -	dsc->flatness_max_qp = 12;
> -	dsc->rc_quant_incr_limit0 = 11;
> -	dsc->rc_quant_incr_limit1 = 11;
> -
> -	return drm_dsc_compute_rc_parameters(dsc);
> +	/*
> +	 * NOTE:
> +	 * dsc->dsc_version_major, dsc->dsc_version_minor
> +	 * dsc->bits_per_pixel,
> +	 * dsc->bits_per_component,
> +	 * dsc->native_422, dsc->native_420
> +	 *
> +	 * above parameters must be populated

Comments
In Yoda style
written should be not.

> +	 */
> +	return dpu_dsc_populate_dsc_config(dsc, 0);
>   }
>   
>   static int dsi_host_parse_dt(struct msm_dsi_host *msm_host)

-- 
With best wishes
Dmitry

