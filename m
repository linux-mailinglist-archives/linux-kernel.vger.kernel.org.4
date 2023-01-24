Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE46793B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjAXJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjAXJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:11:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1853E08F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:11:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id k20so389814edj.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+G2nFoMV6cD+GiU2NuAOa612nY43Jz0nOwwYptg3fzI=;
        b=FOkYvgEo4x7tWzQNMytM7vS8fDznXvFjo8KEfW1hpcjmnoWQ8IqX0hmi7FtUWPLmpO
         Vum/R2egZ5/bIqc9hlytOass/8g8fz7Gz4LedPDBwEJeccBMsTjtj+jpG//hPq4ZkHxW
         tZGBRlcYbbmjdfRAbNYNSCSYgXqeFtQwNgMa9uu4dRC8lBCTRqkkTvH7abJsURZR/ZRi
         1xt42jGjro3MqtzTb2Kb/+f5WYI/UcP31yxBIsXp0Qeae6dc/iLonMoazBMDjWMPxvJq
         /KMYyuN4VQ+5udD6MR+N42kVa04wPqDND4LAVhQtZRgrhhSNs8IMxe1kTiMw99zrw+/n
         5uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+G2nFoMV6cD+GiU2NuAOa612nY43Jz0nOwwYptg3fzI=;
        b=C3YjjQnOXQQ35CECdubXNoBbYgwqMikEzgB+VoRiVkKMKxGZfGBwYRjwoMeBEHNNCx
         NiephL2UzyjoGISvqpDnWS5siwT/O+gJNpHLCOaFwj+ihqP7roX/f9rjY71tbe+mD7VD
         1rXeO8zRvW/NChQga3PvSJ9TzBQlsptza/LbAVzagA97YH+0wf4a/GSmm0vx1zJimVK/
         IehEfcHtN/3AFE+xX017EnVoZwVTNtjMzpGvc7WFbpOre0orbJdHqHRBIAOKHzO5jqkt
         iS3/2o4ZyTCr8uAxGuB4pE+bYsFofYdheNQO7hlVFXLHW3POa4rB2hKTg0IXfwhhUJnH
         QoQg==
X-Gm-Message-State: AFqh2krWXdMoomACrxbNBLF48oZDxNUpUjOLmPQ/QikYl6NbJ2AiG9iA
        RV/fVqKl+uSXlCjZlpUuMeGIrA==
X-Google-Smtp-Source: AMrXdXtv4fe1LBekOxD1hSLgHGtsz8S1xqObkEBEmzsrnRk6g3vY4479/jAf65J9XL3fgz42PIHX6g==
X-Received: by 2002:a05:6402:2289:b0:498:f82c:7068 with SMTP id cw9-20020a056402228900b00498f82c7068mr26811666edb.35.1674551487356;
        Tue, 24 Jan 2023 01:11:27 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7db8a000000b00487b73912c2sm789825edt.12.2023.01.24.01.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 01:11:27 -0800 (PST)
Message-ID: <8392e1f3-8459-4408-41de-564a41980b4c@linaro.org>
Date:   Tue, 24 Jan 2023 11:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 12/14] drm/msm/disp/dpu1: revise timing engine
 programming to work for DSC
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
 <1674498274-6010-13-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1674498274-6010-13-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 20:24, Kuogee Hsieh wrote:
> Current implementation timing engine programming does not consider
> compression factors. This patch add consideration of DSC factors
> while programming timing engine.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |   2 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  14 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 132 +++++++++++++--------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  10 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h         |   6 +-
>   5 files changed, 110 insertions(+), 54 deletions(-)
> 

[skipped]

> @@ -113,82 +124,96 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>   	/* read interface_cfg */
>   	intf_cfg = DPU_REG_READ(c, INTF_CONFIG);
>   
> -	if (ctx->cap->type == INTF_DP)
> +	if (ctx->cap->type == INTF_EDP || ctx->cap->type == INTF_DP)
>   		dp_intf = true;
>   
>   	hsync_period = p->hsync_pulse_width + p->h_back_porch + p->width +
> -	p->h_front_porch;
> +			p->h_front_porch;
>   	vsync_period = p->vsync_pulse_width + p->v_back_porch + p->height +
> -	p->v_front_porch;
> +			p->v_front_porch;

Actually I went on through the history and found the previous 
submission, https://patchwork.freedesktop.org/patch/471505/.
Exactly the same piece of code. Did you expect that the comments will be 
different this time?

I really hoped that at that time we already went through this. But it 
seems I was wrong. That series went through v10 or v12 before being 
accepted. And it was just adding wide_bus_en. Back at that time we 
lightly discussed that the code will receive compression support. But I 
never expected to see the original submission again.

It might sound bad, but could you please find somebody who can do 
internal review for you? Good internal review.

That said, I really do not expect to see v2 before the whole series is 
reworked, restructured and prepared for the review on your side.

>   
>   	display_v_start = ((p->vsync_pulse_width + p->v_back_porch) *
> -	hsync_period) + p->hsync_skew;
> +			hsync_period) + p->hsync_skew;
>   	display_v_end = ((vsync_period - p->v_front_porch) * hsync_period) +
> -	p->hsync_skew - 1;
> +			p->hsync_skew - 1;
> +
> +	hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
>   
>   	hsync_start_x = p->h_back_porch + p->hsync_pulse_width;
>   	hsync_end_x = hsync_period - p->h_front_porch - 1;
>   
> -	if (p->width != p->xres) { /* border fill added */
> -		active_h_start = hsync_start_x;
> -		active_h_end = active_h_start + p->xres - 1;
> -	} else {
> -		active_h_start = 0;
> -		active_h_end = 0;
> -	}
> -
> -	if (p->height != p->yres) { /* border fill added */
> -		active_v_start = display_v_start;
> -		active_v_end = active_v_start + (p->yres * hsync_period) - 1;
> -	} else {
> -		active_v_start = 0;
> -		active_v_end = 0;
> -	}
> -
> -	if (active_h_end) {
> -		active_hctl = (active_h_end << 16) | active_h_start;
> -		intf_cfg |= INTF_CFG_ACTIVE_H_EN;
> -	} else {
> -		active_hctl = 0;
> -	}
> -
> -	if (active_v_end)
> -		intf_cfg |= INTF_CFG_ACTIVE_V_EN;
> -
> -	hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
> -	display_hctl = (hsync_end_x << 16) | hsync_start_x;
> -
>   	/*
>   	 * DATA_HCTL_EN controls data timing which can be different from
>   	 * video timing. It is recommended to enable it for all cases, except
>   	 * if compression is enabled in 1 pixel per clock mode
>   	 */
> +	if (!p->compression_en || p->wide_bus_en)
> +		intf_cfg2 |= INTF_CFG2_DATA_HCTL_EN;
> +
>   	if (p->wide_bus_en)
> -		intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN | INTF_CFG2_DATA_HCTL_EN;
> +		intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
>   
> +	/*
> +	 * If widebus is disabled:
> +	 * For uncompressed stream, the data is valid for the entire active
> +	 * window period.
> +	 * For compressed stream, data is valid for a shorter time period
> +	 * inside the active window depending on the compression ratio.
> +	 *
> +	 * If widebus is enabled:
> +	 * For uncompressed stream, data is valid for only half the active
> +	 * window, since the data rate is doubled in this mode.
> +	 * p->width holds the adjusted width for DP but unadjusted width for DSI
> +	 * For compressed stream, data validity window needs to be adjusted for
> +	 * compression ratio and then further halved.
> +	 */
>   	data_width = p->width;
>   
> +	if (p->compression_en) {
> +		if (p->wide_bus_en)
> +			data_width = DIV_ROUND_UP(p->dce_bytes_per_line, 6);
> +		else
> +			data_width = DIV_ROUND_UP(p->dce_bytes_per_line, 3);
> +	} else if (!dp_intf && p->wide_bus_en) {
> +		data_width = p->width >> 1;
> +	} else {
> +		data_width = p->width;
> +	}
> +
>   	hsync_data_start_x = hsync_start_x;
>   	hsync_data_end_x =  hsync_start_x + data_width - 1;
>   
> +	display_hctl = (hsync_end_x << 16) | hsync_start_x;
>   	display_data_hctl = (hsync_data_end_x << 16) | hsync_data_start_x;
>   
>   	if (dp_intf) {
>   		/* DP timing adjustment */
>   		display_v_start += p->hsync_pulse_width + p->h_back_porch;
>   		display_v_end   -= p->h_front_porch;
> +	}
> +
> +	intf_cfg |= INTF_CFG_ACTIVE_H_EN;
> +	intf_cfg |= INTF_CFG_ACTIVE_V_EN;
> +	active_h_start = hsync_start_x;
> +	active_h_end = active_h_start + p->xres - 1;
> +	active_v_start = display_v_start;
> +	active_v_end = active_v_start + (p->yres * hsync_period) - 1;
>   
> -		active_h_start = hsync_start_x;
> -		active_h_end = active_h_start + p->xres - 1;
> -		active_v_start = display_v_start;
> -		active_v_end = active_v_start + (p->yres * hsync_period) - 1;
> +	active_hctl = (active_h_end << 16) | active_h_start;
>   
> -		active_hctl = (active_h_end << 16) | active_h_start;
> +	if (dp_intf) {
>   		display_hctl = active_hctl;
>   
> -		intf_cfg |= INTF_CFG_ACTIVE_H_EN | INTF_CFG_ACTIVE_V_EN;
> +		if (p->compression_en) {
> +			active_data_hctl = (hsync_start_x + p->extra_dto_cycles) << 16;
> +			active_data_hctl += hsync_start_x;
> +
> +			display_data_hctl = active_data_hctl;
> +		}
>   	}
>   
> +	_check_and_set_comp_bit(ctx, p->dsc_4hs_merge, p->compression_en, &intf_cfg2);
> +
>   	den_polarity = 0;
>   	if (ctx->cap->type == INTF_HDMI) {
>   		hsync_polarity = p->yres >= 720 ? 0 : 1;
> @@ -202,7 +227,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,

-- 
With best wishes
Dmitry

