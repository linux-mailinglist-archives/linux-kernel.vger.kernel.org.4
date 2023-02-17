Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC869B57E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBQW0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBQW0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:26:30 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08555BD99
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:26:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p19so3282384lfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nk0P5TEcjLAlZRZi1tf2S3Zc1fDdctQasJLS4BDXM9w=;
        b=vSJPS7u+IYoDpIUA+dfRFb+S3oLZOXXPRmirjjw6S3qPOReKK0aPTSTvFwB88nm8l2
         7cCBxdEmxGN/KzKqvt/TxqtUlfX+AXs12qiVyGyCr0vwLBa2IwYLfSXHv02pmuNByR09
         GmhsDB5ZQZKXE0SvuOy4txvWAOzqcHyj67bkSQ95TIxI917dL/BX5HQ30LYC4E0Mu/s2
         9bGtMFcREbBi5fvbQqWRm2KmR/pmZOnK2I0X0lpLnTu5PKVusRfJer1i3W3gf0brUltz
         C4hYeM0jGidLIXMEoDCpGrncUy2X6oVUk30PJ97jH4cW/hUTXRaVwR4r1OqYjTOeV5Oq
         /CCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk0P5TEcjLAlZRZi1tf2S3Zc1fDdctQasJLS4BDXM9w=;
        b=qz/saB10P/O2grKrwpVSSk8sh8dv+5i5taTAAOPKqp0UL9hH6+gISgND1iluC3MViZ
         8mGbOKaPlrK+WRCrHruKGSQSBH8kkLeCKba1XQc39EUvlq+UU1Lx+zMw2I2jFWqxVHjW
         0Oq1wDEx+HRN79aiMrlkOkjZLqJ3rHgaz73J+xgUb91cJXyKVQMU08WChlZN0bsQKUf0
         eaeZJHiDCY1Mt0LvYb0cMDLWoQp++QuwftsUyLQIIC7Tz5OMHRldxx41xf/1JMhoOMhp
         Qbv2GbF/VGtOi3Vi1THUAB1/qDj9KAute0/aLmIRg37Ketz2ENEGs5UBuc9hR5znZk5i
         +Uaw==
X-Gm-Message-State: AO0yUKURP0VFVc3VyQpA7eng1xEcpNlseO1yZB1P7Xo1WrmUHdjpf5en
        TtI7Op9a5cMmRK+cAF7hUQ4fSg==
X-Google-Smtp-Source: AK7set9tQUZjlvOjEPKgIZhNhaqAqfvoIjGR/tM9dONOTFbJZHwBM+4tpGwqyBXE9VDv0qHRQ1y7TQ==
X-Received: by 2002:a05:6512:10d3:b0:4db:5123:c271 with SMTP id k19-20020a05651210d300b004db5123c271mr2439616lfg.29.1676672786935;
        Fri, 17 Feb 2023 14:26:26 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q13-20020ac25a0d000000b004b578e52d81sm791238lfn.176.2023.02.17.14.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 14:26:26 -0800 (PST)
Message-ID: <3c17e91a-4903-ac13-7829-54c2c31bab6f@linaro.org>
Date:   Sat, 18 Feb 2023 00:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 4/4] drm/msm/dpu: manage DPU resources if CTM is
 requested
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
References: <1676286704-818-1-git-send-email-quic_kalyant@quicinc.com>
 <1676286704-818-5-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1676286704-818-5-git-send-email-quic_kalyant@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 13:11, Kalyan Thota wrote:
> Allow modeset to be triggered during CTM enable/disable.
> In the modeset callbacks, DPU resources required for the
> CTM feature are managed appropriately.
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_atomic.c | 18 ++++++++++++++++++
>   drivers/gpu/drm/msm/msm_drv.c    |  2 +-
>   drivers/gpu/drm/msm/msm_drv.h    |  1 +
>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index 1686fbb..e3e607c 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -179,6 +179,24 @@ static unsigned get_crtc_mask(struct drm_atomic_state *state)
>   	return mask;
>   }
>   
> +int msm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
> +{
> +	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +	struct drm_crtc *crtc;
> +	int i;
> +

I hope this can be gone for good if at some point we have CRTC resource 
allocation split from encoder resource alloc.

> +	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> +				      new_crtc_state, i) {
> +		if ((old_crtc_state->ctm && !new_crtc_state->ctm) ||
> +		    (!old_crtc_state->ctm && new_crtc_state->ctm)) {
> +			new_crtc_state->mode_changed = true;
> +			state->allow_modeset = true;
> +		}
> +	}
> +
> +	return drm_atomic_helper_check(dev, state);
> +}
> +
>   void msm_atomic_commit_tail(struct drm_atomic_state *state)
>   {
>   	struct drm_device *dev = state->dev;
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 0759e2d..3221284 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -52,7 +52,7 @@
>   static const struct drm_mode_config_funcs mode_config_funcs = {
>   	.fb_create = msm_framebuffer_create,
>   	.output_poll_changed = drm_fb_helper_output_poll_changed,
> -	.atomic_check = drm_atomic_helper_check,
> +	.atomic_check = msm_atomic_check,
>   	.atomic_commit = drm_atomic_helper_commit,
>   };
>   
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index ea80846..7d0243a 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -209,6 +209,7 @@ int msm_atomic_init_pending_timer(struct msm_pending_timer *timer,
>   		struct msm_kms *kms, int crtc_idx);
>   void msm_atomic_destroy_pending_timer(struct msm_pending_timer *timer);
>   void msm_atomic_commit_tail(struct drm_atomic_state *state);
> +int msm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state);
>   struct drm_atomic_state *msm_atomic_state_alloc(struct drm_device *dev);
>   void msm_atomic_state_clear(struct drm_atomic_state *state);
>   void msm_atomic_state_free(struct drm_atomic_state *state);

-- 
With best wishes
Dmitry

