Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35B56A94C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCCKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCCKEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:04:11 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3155F5C11E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:04:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id i28so2961328lfv.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 02:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PE43XKo/WgEddymgmmBxjWwiJFJAm6sS/o3gvfnyfCQ=;
        b=CzE8aAydE9S5MQ8bS6Gj/M12uzdszbeQy+9bwn6MceFKBRVsenTlEc/U+BS/B3ynA2
         CFugrtLE8MeQARiEqDIFwTMLzBNDNU1TEo5zxnPwS/anGKZjn5i8lWMLOGjk7dHnw+GL
         YuWy03M6DYeuCy1Us49BTSIuNy6btp42UexlC/TgB9lZdqttergzeB24nC9AVkoWY6qj
         Q/6pk/w42T8g1BCLNDAx7xZejwSeieYjJu8liwlAEvTZXV7M8R3e7LFG3RFWTiv2bbHi
         71GT4X4gzcDaat505BPRkC3aBfA81rdCJhj+NW435fI6mWg0dltZU91d3pFCbQUdoaWK
         3WZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PE43XKo/WgEddymgmmBxjWwiJFJAm6sS/o3gvfnyfCQ=;
        b=5tl4RbTtZ23AvVLRiN1wd0Hvlv3NzucfmfP6fLyoqngoJTiLLaIE+HZIhDBQuBWyXT
         /DYOmjd1OpZusEsuGXOtP3uSFJIqhWGjFyOQ9k7yFWxyyWPV8e08BigpnBWd7y4QxAsZ
         UbTHJyV310tcfd9kIQFF7jif+XufbCF8ok5ShSgeKAuPW1aQAJivSLeY+rflzmq71PNa
         9xN7dye08T1tkD5LK5MUuyixKADF85NWEFuTzSDJbWyiq9m7JEGxG8Pl846DVd31ou5g
         d717Dlqpzkuj07C+jhBHzT7BxYOrYq6Hr/o/PW8xl3uE+S3m56LyqKzOTe+xxC644bto
         I7qw==
X-Gm-Message-State: AO0yUKWybqBsFklvTPa3Zw7uiy0AH6LtWTCVaKo4WpVM0G40TMTMbTct
        i5RIito/uojxCzSIxE2+UjfTkg==
X-Google-Smtp-Source: AK7set8r6HNCYZMbYo9olpHaL1iwTTESqqbYHQDRtADO+VFgb+QtAiSYRRDoaH98GZ//SobIaaX9VA==
X-Received: by 2002:a19:7419:0:b0:4c0:2ddc:4559 with SMTP id v25-20020a197419000000b004c02ddc4559mr419717lfe.69.1677837846268;
        Fri, 03 Mar 2023 02:04:06 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b14-20020a056512024e00b004d127a5a73dsm320689lfo.181.2023.03.03.02.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:04:05 -0800 (PST)
Message-ID: <0351cdef-61ed-117c-71d5-477f2e8a191d@linaro.org>
Date:   Fri, 3 Mar 2023 12:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 14/15] drm/msm/atomic: Switch to vblank_start helper
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Liu Shixin <liushixin2@huawei.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230302235356.3148279-1-robdclark@gmail.com>
 <20230302235356.3148279-15-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230302235356.3148279-15-robdclark@gmail.com>
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

On 03/03/2023 01:53, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Drop our custom thing and switch to drm_crtc_next_vblank_start() for
> calculating the time of the start of the next vblank period.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

It took me a while to dig into the differences between old and proposed 
paths. Looks correct to me.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 15 ---------------
>   drivers/gpu/drm/msm/msm_atomic.c        |  8 +++++---
>   drivers/gpu/drm/msm/msm_kms.h           |  8 --------
>   3 files changed, 5 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index a683bd9b5a04..43996aecaf8c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -411,20 +411,6 @@ static void dpu_kms_disable_commit(struct msm_kms *kms)
>   	pm_runtime_put_sync(&dpu_kms->pdev->dev);
>   }
>   
> -static ktime_t dpu_kms_vsync_time(struct msm_kms *kms, struct drm_crtc *crtc)
> -{
> -	struct drm_encoder *encoder;
> -
> -	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask) {
> -		ktime_t vsync_time;
> -
> -		if (dpu_encoder_vsync_time(encoder, &vsync_time) == 0)
> -			return vsync_time;
> -	}
> -
> -	return ktime_get();
> -}
> -
>   static void dpu_kms_prepare_commit(struct msm_kms *kms,
>   		struct drm_atomic_state *state)
>   {
> @@ -953,7 +939,6 @@ static const struct msm_kms_funcs kms_funcs = {
>   	.irq             = dpu_core_irq,
>   	.enable_commit   = dpu_kms_enable_commit,
>   	.disable_commit  = dpu_kms_disable_commit,
> -	.vsync_time      = dpu_kms_vsync_time,
>   	.prepare_commit  = dpu_kms_prepare_commit,
>   	.flush_commit    = dpu_kms_flush_commit,
>   	.wait_flush      = dpu_kms_wait_flush,
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index 1686fbb611fd..c5e71c05f038 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -186,8 +186,7 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>   	struct msm_kms *kms = priv->kms;
>   	struct drm_crtc *async_crtc = NULL;
>   	unsigned crtc_mask = get_crtc_mask(state);
> -	bool async = kms->funcs->vsync_time &&
> -			can_do_async(state, &async_crtc);
> +	bool async = can_do_async(state, &async_crtc);
>   
>   	trace_msm_atomic_commit_tail_start(async, crtc_mask);
>   
> @@ -231,7 +230,9 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>   
>   			kms->pending_crtc_mask |= crtc_mask;
>   
> -			vsync_time = kms->funcs->vsync_time(kms, async_crtc);
> +			if (drm_crtc_next_vblank_start(async_crtc, &vsync_time))
> +				goto fallback;
> +
>   			wakeup_time = ktime_sub(vsync_time, ms_to_ktime(1));
>   
>   			msm_hrtimer_queue_work(&timer->work, wakeup_time,
> @@ -253,6 +254,7 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>   		return;
>   	}
>   
> +fallback:
>   	/*
>   	 * If there is any async flush pending on updated crtcs, fold
>   	 * them into the current flush.
> diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
> index f8ed7588928c..086a3f1ff956 100644
> --- a/drivers/gpu/drm/msm/msm_kms.h
> +++ b/drivers/gpu/drm/msm/msm_kms.h
> @@ -59,14 +59,6 @@ struct msm_kms_funcs {
>   	void (*enable_commit)(struct msm_kms *kms);
>   	void (*disable_commit)(struct msm_kms *kms);
>   
> -	/**
> -	 * If the kms backend supports async commit, it should implement
> -	 * this method to return the time of the next vsync.  This is
> -	 * used to determine a time slightly before vsync, for the async
> -	 * commit timer to run and complete an async commit.
> -	 */
> -	ktime_t (*vsync_time)(struct msm_kms *kms, struct drm_crtc *crtc);
> -
>   	/**
>   	 * Prepare for atomic commit.  This is called after any previous
>   	 * (async or otherwise) commit has completed.

-- 
With best wishes
Dmitry

