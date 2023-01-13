Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC0668ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAME33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjAME1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:27:54 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2EF676D2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:23:25 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bq39so31451811lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3qVpAD4e4r2YgJT6QopKVtu7JfoDub68cT+znrlhg8=;
        b=g1sA+mRdgmsO8AavsUumHfQvlLAtB4VWYXXDCq1VVzPS/3nhZ0fXsMdyNXfCxkN4Px
         NAkp+2C1iN5sx/f49xoGjCrPBJHCZyugZ6Xt+Ox1mjao5V9sWHSK8LFAXfzHbwXtg3nC
         H4FqkcaaJHGoG+b6f00MIrTH95LvcwhSwWN068Gjcn9WOVVt9I3JUxVLsfW6Jjnb7JQU
         ErjD5maMc0S8NBiEn8iG5SD0lq5Txbq+ivp8B85ILpdPAwfObjm0jin09Z0p6ZcQf0yG
         Hq/ueqdpP2iEvYF3/VcAX1wr8GoVyfYfUf9wYdVJGsB5VgePWFw5C79Xkp3HcNOR+YhV
         t87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3qVpAD4e4r2YgJT6QopKVtu7JfoDub68cT+znrlhg8=;
        b=o4hccxGA5cxOkTdGEWMPHaDTpXdMdDt/vTEkkbvnStzLCUDVbth+P4RBTZ4OB+MxaV
         wB07i00O4xtedyEf55CEcVOKlIhI1H0CUFjrrmR+xOShhF9zrvuTEFqtgP/X6Yr+3VGb
         ggX8k2xmzxl24tvZfq6rRvjcOWTcMxzOPprgZvRlRyFjQOlUyEwc8iF0LWkJxzp5y7i9
         cXHFSlzAU80UG+VgXolOTPFR3HAaehK8VZKN8yfyyiOyZt1CE25hnjNyszUxr9IL9UJY
         Wx82TqFtCP9605ofSE9fkmcN8jLIa0/cV1dcsZJ0ileQXkpAU00PpxNXWuvc2c7cHlny
         uvAQ==
X-Gm-Message-State: AFqh2krIWENwjDY650KyMugpuVBivrYxy/zRCi7Owu7mc41vA9cKJ3Dz
        nfBfs3O68Ua8o+cZS80PoAW1vw==
X-Google-Smtp-Source: AMrXdXv/7anjVIOUNJ+YbJdMSEKH2cBrncksS4VLSL3bLyFOCJQTjCjx5DOLn66H/eEOHhRBYmPXnQ==
X-Received: by 2002:a05:6512:2316:b0:4ce:e95c:f300 with SMTP id o22-20020a056512231600b004cee95cf300mr918390lfu.39.1673583803336;
        Thu, 12 Jan 2023 20:23:23 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a26-20020a056512201a00b004ce437fe97dsm392242lfb.102.2023.01.12.20.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 20:23:22 -0800 (PST)
Message-ID: <eea1c5dc-6bc5-4246-f0e1-0c790de9f078@linaro.org>
Date:   Fri, 13 Jan 2023 06:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/msm: Initialize mode_config earlier
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230113041051.4189063-1-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230113041051.4189063-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 06:10, Bjorn Andersson wrote:
> Invoking drm_bridge_hpd_notify() on a drm_bridge with a HPD-enabled
> bridge_connector ends up in drm_bridge_connector_hpd_cb() calling
> drm_kms_helper_hotplug_event(), which assumes that the associated
> drm_device's mode_config.funcs is a valid pointer.
> 
> But in the MSM DisplayPort driver the HPD enablement happens at bind
> time and mode_config.funcs is initialized late in msm_drm_init(). This
> means that there's a window for hot plug events to dereference a NULL
> mode_config.funcs.
> 
> Move the assignment of mode_config.funcs before the bind, to avoid this
> scenario.

Cam we make DP driver not to report HPD events until the enable_hpd() 
was called? I think this is what was fixed by your internal_hpd patchset.

> 
> Reported-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/gpu/drm/msm/msm_drv.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index ee2f60b6f09b..7ac670f3e6ab 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -438,6 +438,9 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   
>   	drm_mode_config_init(ddev);
>   
> +	ddev->mode_config.funcs = &mode_config_funcs;
> +	ddev->mode_config.helper_private = &mode_config_helper_funcs;
> +
>   	ret = msm_init_vram(ddev);
>   	if (ret)
>   		return ret;
> @@ -479,9 +482,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   
>   	drm_helper_move_panel_connectors_to_head(ddev);
>   
> -	ddev->mode_config.funcs = &mode_config_funcs;
> -	ddev->mode_config.helper_private = &mode_config_helper_funcs;
> -
>   	for (i = 0; i < priv->num_crtcs; i++) {
>   		/* initialize event thread */
>   		priv->event_thread[i].crtc_id = priv->crtcs[i]->base.id;

-- 
With best wishes
Dmitry

