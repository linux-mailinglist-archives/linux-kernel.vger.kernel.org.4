Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147E1678CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjAXAal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:30:39 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7DB25E2D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:30:37 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz11so35078561ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dueIyUaxNeNEFPj/GQDJydit6xe2M3dnJNE9fhHc1lA=;
        b=mNRl6IenhY+hUGyDvtML/z40vf/CJaTsZPxzMKW0GRLUJSJOI1aHOheSt4Bb9WGY6w
         Y0xYhlA5eiNoJkYXm+6WKBKu8rid7O4Yz5jxDilZFzZj7PL3uJkIiJRnG98V+TfJB9qu
         zlKtrVH+MGMm6LiOqlEeqT6Z8hxwFWRkklEIAtE2OiD1sULY3wIe8lOHBr9zw/0rGp4j
         y6ol0ZTjPQaXF764lyiP1kLOXM5I+GyR1yD92i0EzHc3wdn542XJFJxix+wrv8O5bCyw
         SZmU2llOLZCuyGW1FUsa/ezZBv/aBk/O+bRzGk8HNmRZ78v15UWNFcVIyEB/DnfGV1I0
         D9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dueIyUaxNeNEFPj/GQDJydit6xe2M3dnJNE9fhHc1lA=;
        b=HvD5N4hE2+HucI22NYWYa/uHB4PEw1Nu/LRU8hQWBrPrj7YeKANnnq5Cnli0FumHQZ
         z9sotCW8ZOVrED52HBxXlZpCvbK0YdMrPvo9rTyfKPQ/Wda1SOxW0qtFJi8MilYeAFz7
         YiF5qehCjDUJ5fBdivvmjntUCkQzRJ7pX2/EwWnS1FrGlicjYUeJxgcKgVGMmqCHpvQ0
         BJTIU7O1svf0gxBtB5lvClqSn0nPlYLQMICmlLGzwFnju3rZmA6ShvfhdZjQLugHH3kc
         7drnpHbqrS1Aplo0FN9CmFfITSkscZGsfR4sNLXk62/PmLXxeWG8sP2rm/H5RTqYH677
         IYGw==
X-Gm-Message-State: AFqh2kpsBdvXbN4316GSXskFzTEdjfBKvfF0AdJxs+f8m+XcNZXNi1wD
        Y/oCWcK7mf0snZv7TD7fo7uVWzlFc+8jJUrgsTo=
X-Google-Smtp-Source: AMrXdXuIIDNKUFBEqpNOMIYRRAezfeG1WZEFtg71deB0wBVkk/t8NtTqVDc/QBnN3FR/a8Sg+XDe1g==
X-Received: by 2002:a17:907:94ce:b0:870:ab89:3dd3 with SMTP id dn14-20020a17090794ce00b00870ab893dd3mr31844473ejc.70.1674520235673;
        Mon, 23 Jan 2023 16:30:35 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id fq32-20020a1709069da000b0083f91a32131sm154483ejc.0.2023.01.23.16.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 16:30:35 -0800 (PST)
Message-ID: <db1e407c-8dd6-733f-e52d-55a1f9e43d6f@linaro.org>
Date:   Tue, 24 Jan 2023 02:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH Resend v11 15/15] drm/msm/disp/dpu: update dpu_enc crtc
 state on crtc enable/disable during self refresh
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
References: <1674138393-475-1-git-send-email-quic_vpolimer@quicinc.com>
 <1674138393-475-16-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1674138393-475-16-git-send-email-quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 16:26, Vinod Polimera wrote:
> Populate the enocder software structure to reflect the updated
> crtc appropriately during crtc enable/disable for a new commit
> while taking care of the self refresh transitions when crtc
> disable is triggered from the drm self refresh library.
> 
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 31 ++++++++++++++++++++++++++-----
>   1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index d513aeb4..e8e456a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1013,14 +1013,23 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>   									      crtc);
>   	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
>   	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
> -	struct drm_encoder *encoder;
> +	struct drm_encoder *encoder = NULL;

Why is this chunk necessary?

>   	unsigned long flags;
>   	bool release_bandwidth = false;
>   
>   	DRM_DEBUG_KMS("crtc%d\n", crtc->base.id);
>   
> -	if (old_crtc_state->self_refresh_active)
> +	/* If disable is triggered while in self refresh mode,
> +	 * reset the encoder software state so that in enable
> +	 * it won't trigger a warn while assigning crtc.
> +	 */
> +	if (old_crtc_state->self_refresh_active) {
> +		drm_for_each_encoder_mask(encoder, crtc->dev,
> +					old_crtc_state->encoder_mask) {
> +			dpu_encoder_assign_crtc(encoder, NULL);
> +		}
>   		return;
> +	}
>   
>   	/* Disable/save vblank irq handling */
>   	drm_crtc_vblank_off(crtc);
> @@ -1033,7 +1042,14 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>   		 */
>   		if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
>   			release_bandwidth = true;
> -		dpu_encoder_assign_crtc(encoder, NULL);
> +
> +		/*
> +		 * If disable is triggered during psr active(e.g: screen dim in PSR),
> +		 * we will need encoder->crtc connection to process the device sleep &
> +		 * preserve it during psr sequence.
> +		 */
> +		if (!crtc->state->self_refresh_active)
> +			dpu_encoder_assign_crtc(encoder, NULL);
>   	}
>   
>   	/* wait for frame_event_done completion */
> @@ -1081,6 +1097,9 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>   	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
>   	struct drm_encoder *encoder;
>   	bool request_bandwidth = false;
> +	struct drm_crtc_state *old_crtc_state;
> +
> +	old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
>   
>   	pm_runtime_get_sync(crtc->dev->dev);
>   
> @@ -1103,8 +1122,10 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>   	trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
>   	dpu_crtc->enabled = true;
>   
> -	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
> -		dpu_encoder_assign_crtc(encoder, crtc);
> +	if (!old_crtc_state->self_refresh_active) {
> +		drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
> +			dpu_encoder_assign_crtc(encoder, crtc);
> +	}
>   
>   	/* Enable/restore vblank irq handling */
>   	drm_crtc_vblank_on(crtc);

-- 
With best wishes
Dmitry

