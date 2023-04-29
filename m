Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA266F21C4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjD2A4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347153AbjD2A4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:56:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A944213
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:56:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so1717915e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682729797; x=1685321797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=321lwNICJElX/vTBOCXvsvigu8PI/jfoCt5tMZAwHqE=;
        b=pIub9jNybPkX3mF03qU12uB1+XIpzmkgBIoTlDHh0pshQ6vcp/JgpL9xhzx0/HvO5d
         LvBzLGU9ZnkAnPkzAPIKlIxpC5yn4FlYDWCqDb7YK+gRsCbNO7pUDGjkqTCfIF7U9WqH
         zbVIg+2hcFAPpqcH6TF/1odgwVF9OYr4ThC8kV81cagIJzRLdM/FF74S0f/av4C6+v8X
         17AU2wO+74HztTt/HNtdhXq5nazQJG9WVAQWlUs3/4ewDuIefcneuLq3MZM//m3Gp1EK
         0xyY3VeNEAykzOtXX/TzHE+gryERVgzki0cJECJoo+bbEZ4y+B6JY+ajBlHu4A6S1zRz
         teJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682729797; x=1685321797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=321lwNICJElX/vTBOCXvsvigu8PI/jfoCt5tMZAwHqE=;
        b=O5iSny+xqXVGAgu9z6jOvpjha4T9EHoYNBKbZf3MfO9jGWzJyBuweI6CMSjSp8+z7z
         1Dgcp8j1D30H4EskByHdPR379mlAxrmKl6MobzkE15x30Bq5oFEX98iUI1BuVO2zWSMh
         PxuDpxjFP/RZGvtEpaU2kYeR94kZpruW97K0hAbqSpiGu91D+Zb/ig11td0DnVW+9a0a
         4UzPnkE18QtdmZeyXYFpBIx10ZUOT3dIbzYchbGkMfuZtW3e6lbKbOD5OHNYBrFCvOh7
         O6SV6RFxGlfh6NV7tOopNm+HfwVJGhHVcFPzT7gVWhlRay+eZL3n9A2kb75P1sVpDTK7
         nEHA==
X-Gm-Message-State: AC+VfDw6+gBsU9BAwOKeDpWpJxL/HFyATW9GYdWV1i5qcPbLp+VxihVu
        g8vGSJwk2sTHE0+K327oeGQ6Gw==
X-Google-Smtp-Source: ACHHUZ57bL2MXFm0lrKnZoHfQR0p3AAbCS3Fp+6GYZjU40ieEDBeKWmJWyDp7jzVQ3Q6QWF2yfpbRQ==
X-Received: by 2002:a1c:f019:0:b0:3f1:78a7:6bd2 with SMTP id a25-20020a1cf019000000b003f178a76bd2mr5409795wmb.27.1682729797539;
        Fri, 28 Apr 2023 17:56:37 -0700 (PDT)
Received: from [10.5.118.67] ([81.145.206.52])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c16d400b003f19bca8f03sm19015670wmn.43.2023.04.28.17.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 17:56:37 -0700 (PDT)
Message-ID: <37b12f18-bf76-33c1-f5cc-e679bd215cf6@linaro.org>
Date:   Sat, 29 Apr 2023 03:56:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 6/7] drm/msm/dpu: save dpu topology configuration
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1682725511-18185-1-git-send-email-quic_khsieh@quicinc.com>
 <1682725511-18185-7-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1682725511-18185-7-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 02:45, Kuogee Hsieh wrote:
> At current implementation, topology configuration is thrown away after
> dpu_rm_reserve(). This patch save the topology so that it can be used
> for DSC related calculation later.

Even if we delay the virtual wide planes patchset, please don't save the 
topology in the encoder. If we get cloned encoders support (e.g. for 
CWB), the end topology will contain both WB and INTF entries and as such 
it will not be useable by a single encoder. Thus this change is not 
future-proof.

> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 32 ++++++++++++++---------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index ecb87bc..2fdacf1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -542,13 +542,13 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
>   	return (num_dsc > 0) && (num_dsc > intf_count);
>   }
>   
> -static struct msm_display_topology dpu_encoder_get_topology(
> +static void dpu_encoder_get_topology(
>   			struct dpu_encoder_virt *dpu_enc,
>   			struct dpu_kms *dpu_kms,
>   			struct drm_display_mode *mode,
> -			struct drm_crtc_state *crtc_state)
> +			struct drm_crtc_state *crtc_state,
> +			struct msm_display_topology *topology)
>   {
> -	struct msm_display_topology topology = {0};
>   	int i, intf_count = 0;
>   
>   	for (i = 0; i < MAX_PHYS_ENCODERS_PER_VIRTUAL; i++)
> @@ -567,16 +567,16 @@ static struct msm_display_topology dpu_encoder_get_topology(
>   	 * Add dspps to the reservation requirements if ctm is requested
>   	 */
>   	if (intf_count == 2)
> -		topology.num_lm = 2;
> +		topology->num_lm = 2;
>   	else if (!dpu_kms->catalog->caps->has_3d_merge)
> -		topology.num_lm = 1;
> +		topology->num_lm = 1;
>   	else
> -		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
> +		topology->num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
>   
>   	if (crtc_state->ctm)
> -		topology.num_dspp = topology.num_lm;
> +		topology->num_dspp = topology->num_lm;
>   
> -	topology.num_intf = intf_count;
> +	topology->num_intf = intf_count;
>   
>   	if (dpu_enc->dsc) {
>   		/*
> @@ -585,12 +585,10 @@ static struct msm_display_topology dpu_encoder_get_topology(
>   		 * this is power optimal and can drive up to (including) 4k
>   		 * screens
>   		 */
> -		topology.num_dsc = 2;
> -		topology.num_lm = 2;
> -		topology.num_intf = 1;
> +		topology->num_dsc = 2;
> +		topology->num_lm = 2;
> +		topology->num_intf = 1;
>   	}
> -
> -	return topology;
>   }
>   
>   static int dpu_encoder_virt_atomic_check(
> @@ -602,7 +600,7 @@ static int dpu_encoder_virt_atomic_check(
>   	struct msm_drm_private *priv;
>   	struct dpu_kms *dpu_kms;
>   	struct drm_display_mode *adj_mode;
> -	struct msm_display_topology topology;
> +	struct msm_display_topology *topology;
>   	struct dpu_global_state *global_state;
>   	int i = 0;
>   	int ret = 0;
> @@ -639,7 +637,9 @@ static int dpu_encoder_virt_atomic_check(
>   		}
>   	}
>   
> -	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state);
> +	topology = &dpu_enc->topology;
> +	memset(topology, 0, sizeof (*topology));
> +	dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state, topology);
>   
>   	/*
>   	 * Release and Allocate resources on every modeset
> @@ -650,7 +650,7 @@ static int dpu_encoder_virt_atomic_check(
>   
>   		if (!crtc_state->active_changed || crtc_state->enable)
>   			ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
> -					drm_enc, crtc_state, topology);
> +					drm_enc, crtc_state, *topology);
>   	}
>   
>   	trace_dpu_enc_atomic_check_flags(DRMID(drm_enc), adj_mode->flags);

-- 
With best wishes
Dmitry

