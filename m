Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22B6681967
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbjA3Shs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbjA3ShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:37:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F1B135
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:36:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v10so11889698edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZhLOD9IjFhT2rw5mFVQaRWDwbDZlqozjoeDC3b7Esw=;
        b=N1dmJr/r8/XSvyoUxRNc2HjR0kOQkzvm2Ls4s4KX7nE03ug0BnSqPpeXukRW1nGVGO
         mUNRdd4Pgm344uL3hROdKa9/JQoe/K9mDXJEiqYLeKq64hBwquTI6wAy7No2AYzt8VYp
         f/43I6o4AvhVx/LkESOysg0UhYz9vKsX4N5uF2J46mZTTLdCfLSDC9xTGSu7WRvCebeG
         7rdw9mYyXqXClvmJkPy845MjgFT8wMU6Hn3UJKSpJ7bMMJIBGwEwRSmgIjY+AyKb5H8A
         mX3OQI4Nl6yFKOvE9PV46OQ4XGBvUib7ghHLBkTf81y6X3LJ+/c0Gno1SfrdAIyOyca6
         N6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZhLOD9IjFhT2rw5mFVQaRWDwbDZlqozjoeDC3b7Esw=;
        b=0wyHFPgWj46WAZyjeREO6eI8dYtsEcJjbp4jB8ZvIvueD+ExiBzPyNF6Gpu4mBNswu
         0RND9Bqr3VHljMSTaOKI1MJxfMfD78Dw086tijZ6USS0hNklBhBZvRcjpqOBb7unFDSN
         hPpWA26RgQE0zgmq8AyJMsKiX2iJQ0SLvGpELfIz61TP3luo1CaTN5qNUmuOpzn6sscT
         vGjaxTNmT31YYb3uHH1UE9sKBP4oyQFaVFkTrvPOrv1Zn2Sk/CwhteW5qrPlgM3xfXPp
         othqu1PIVCxO/1Lsfe7dd96jDJJl9Q2WKh5meRzajzcmULcbixqlSjdx9D4v9xTZ8Hbk
         wbKg==
X-Gm-Message-State: AFqh2kplJUDqdSvw2u2YF8rT39FhQjJklKhycQ1MCmaoRzqysTGFsl+O
        jPEO7ttRc0jthYH3CP8DutucrQ==
X-Google-Smtp-Source: AMrXdXvR5Q6KvIhrUEwYGvqNhBkWgrUuFEJSdmc3ZGDzFQa57T8TClhZRDJYjAW55lqTmNIGI4NywQ==
X-Received: by 2002:a05:6402:298e:b0:496:6a20:6b61 with SMTP id eq14-20020a056402298e00b004966a206b61mr57790399edb.22.1675103796373;
        Mon, 30 Jan 2023 10:36:36 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id fd22-20020a056402389600b004a1d4142543sm5937753edb.27.2023.01.30.10.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 10:36:35 -0800 (PST)
Message-ID: <e9b238af-28dd-f38e-24e3-4065c39d4e25@linaro.org>
Date:   Mon, 30 Jan 2023 20:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [v1 2/3] drm/msm/disp/dpu1: add dspps into reservation if there
 is a ctm request
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
References: <1675092092-26412-1-git-send-email-quic_kalyant@quicinc.com>
 <1675092092-26412-3-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1675092092-26412-3-git-send-email-quic_kalyant@quicinc.com>
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

On 30/01/2023 17:21, Kalyan Thota wrote:
> Add dspp blocks into the topology for reservation, if there is a ctm
> request for that composition.
> 
> Changes in v1:
> - Minor nits (Dmitry)
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 9c6817b..3bd46b4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -545,7 +545,8 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
>   static struct msm_display_topology dpu_encoder_get_topology(
>   			struct dpu_encoder_virt *dpu_enc,
>   			struct dpu_kms *dpu_kms,
> -			struct drm_display_mode *mode)
> +			struct drm_display_mode *mode,
> +			struct drm_crtc_state *crtc_state)
>   {
>   	struct msm_display_topology topology = {0};
>   	int i, intf_count = 0;
> @@ -573,11 +574,9 @@ static struct msm_display_topology dpu_encoder_get_topology(
>   	else
>   		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
>   
> -	if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
> -		if (dpu_kms->catalog->dspp &&
> -			(dpu_kms->catalog->dspp_count >= topology.num_lm))
> -			topology.num_dspp = topology.num_lm;
> -	}
> +	if (dpu_kms->catalog->dspp &&
> +	    crtc_state->ctm && (dpu_kms->catalog->dspp_count >= topology.num_lm))

This condition doesn't look correct anymore for the following reasons:
- if there are no DSPPs we will completely ignore the ctm property
- if there are not enough DSPPs, the CTM property will be ignore

I think, this should be just:

if (crtc_state->ctm)
     topology.num_dspp = topology.num_lm;




> +		topology.num_dspp = topology.num_lm;
>   
>   	topology.num_enc = 0;
>   	topology.num_intf = intf_count;
> @@ -643,7 +642,7 @@ static int dpu_encoder_virt_atomic_check(
>   		}
>   	}
>   
> -	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode);
> +	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state);
>   
>   	/* Reserve dynamic resources now. */
>   	if (!ret) {

-- 
With best wishes
Dmitry

