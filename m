Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426296B31E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCIXFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjCIXFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:05:41 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E53F4028
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:05:39 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id h9so3537637ljq.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 15:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678403138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fImqtEk3Yd/BGvJUs6e3qMPUkkVywiIrFLK2xRO4mHk=;
        b=SVF1YOWqlHcnG+98KHK6urC9FRxOMKlDBgSLVJgzU4H7ilC0w1HMRNzwiax+5TSVsz
         qhH9PKA5g+Hvh7Y93QMH0aNLA/FQOSlsX9/Y65lgdV9Ko0k7TXyM5lPI4uukZZ/0Ml2B
         tE4vBNNh+BWTfJlWcSOX2h2YPYStF2PxcnWAK+pKV1GvGBxX5DoZ8dRID6e/epDEUTO3
         MC+K1sCUzIqXL1gFqH8c5BeOg7vmut1l3uwNSEAX7myOL3OoaWGOtxwmkj/D8hLSO4BL
         5mi87l+TMjRcqqcIBaVvyIQA9q2Xw9EglvAfgSO9Bl1/sl/kilN2LcgCINZczoxURDuY
         hlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678403138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fImqtEk3Yd/BGvJUs6e3qMPUkkVywiIrFLK2xRO4mHk=;
        b=zeLdSgulVmCIHcp24NVxQpzSf8G5vNP3JpDeMO/HIUl5QU0U6J3uPklsJTI1Cb6iJ/
         dIdhhtikE50g2m16drs9KtebO9Hrrr3GSBYJBdIqXCWlEH9fyNbEyl8w2E4IIPj8Epuw
         mqo4mHTEQHkk4Kkmxk102ZXZobkGAHiyFBeC4jRAfdcbzFxX3+zoq0El9x0+DXotWko7
         NnEKYcWmu5ZmK3yFas/O1ymKEPf480PNco4zsLxT0OxoJbcj+mUcHSqD5wIAkA4N4XyK
         6A8YQ1qDEUkJR3yXj985caxMebM34q+i/CqVRnMMB0Gei6+rnMDaWQRMJII7kHO8jM9B
         UvhA==
X-Gm-Message-State: AO0yUKV9XYsI99lrLV2MatNsvhrryKZjjpbmpNv8B8ac1C2uRxMyvLas
        EWmvATTGBq0vHoLo/Yv9Vb/qtw==
X-Google-Smtp-Source: AK7set9AR4JFXKutmZJPBcVPweBBC2MWCPTYwTcbdhPO6Vxn8D1IcwdDLcYkLz7ISFyPNqhxDkfMgQ==
X-Received: by 2002:a2e:8091:0:b0:293:2ef5:9434 with SMTP id i17-20020a2e8091000000b002932ef59434mr6499836ljg.2.1678403137854;
        Thu, 09 Mar 2023 15:05:37 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id bi37-20020a05651c232500b00295b1b6e063sm48761ljb.34.2023.03.09.15.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 15:05:37 -0800 (PST)
Message-ID: <e08cad22-09fe-1c65-a329-802b116e7503@linaro.org>
Date:   Fri, 10 Mar 2023 01:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/msm: Check for the GPU IOMMU during bind
To:     Jordan Crouse <jorcrous@amazon.com>,
        freedreno@lists.freedesktop.org
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230309222049.4180579-1-jorcrous@amazon.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230309222049.4180579-1-jorcrous@amazon.com>
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

On 10/03/2023 00:20, Jordan Crouse wrote:
> While booting with amd,imageon on a headless target the GPU probe was
> failing with -ENOSPC in get_pages() from msm_gem.c.
> 
> Investigation showed that the driver was using the default 16MB VRAM
> carveout because msm_use_mmu() was returning false since headless devices
> use a dummy parent device. Avoid this by extending the existing is_a2xx
> priv member to check the GPU IOMMU state on all platforms and use that
> check in msm_use_mmu().

I wonder if we can fix this by setting 'dummy_dev'->of_node to adreno's 
of_node. Did you check that possibility?

> 
> This works for memory allocations but it doesn't prevent the VRAM carveout
> from being created because that happens before we have a chance to check
> the GPU IOMMU state in adreno_bind.
> 
> There are a number of possible options to resolve this but none of them are
> very clean. The easiest way is to likely specify vram=0 as module parameter
> on headless devices so that the memory doesn't get wasted.
> 
> Signed-off-by: Jordan Crouse <jorcrous@amazon.com>
> ---
> 
>   drivers/gpu/drm/msm/adreno/adreno_device.c | 6 +++++-
>   drivers/gpu/drm/msm/msm_drv.c              | 7 +++----
>   drivers/gpu/drm/msm/msm_drv.h              | 2 +-
>   3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 36f062c7582f..4f19da28f80f 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -539,7 +539,11 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>   	DBG("Found GPU: %u.%u.%u.%u", config.rev.core, config.rev.major,
>   		config.rev.minor, config.rev.patchid);
>   
> -	priv->is_a2xx = config.rev.core == 2;
> +	/*
> +	 * A2xx has a built in IOMMU and all other IOMMU enabled targets will
> +	 * have an ARM IOMMU attached
> +	 */
> +	priv->has_gpu_iommu = config.rev.core == 2 || device_iommu_mapped(dev);
>   	priv->has_cached_coherent = config.rev.core >= 6;
>   
>   	gpu = info->init(drm);
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index aca48c868c14..a125a351ec90 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -318,11 +318,10 @@ bool msm_use_mmu(struct drm_device *dev)
>   	struct msm_drm_private *priv = dev->dev_private;
>   
>   	/*
> -	 * a2xx comes with its own MMU
> -	 * On other platforms IOMMU can be declared specified either for the
> -	 * MDP/DPU device or for its parent, MDSS device.
> +	 * Return true if the GPU or the MDP/DPU or parent MDSS device has an
> +	 * IOMMU
>   	 */
> -	return priv->is_a2xx ||
> +	return priv->has_gpu_iommu ||
>   		device_iommu_mapped(dev->dev) ||
>   		device_iommu_mapped(dev->dev->parent);

It is not a problem of you patch, of course, but this check now looks 
strange to me. We mix the GPU check and MDP/DPU checks. Consider msm8x60 
(a220, mdp4) and, for example, no system level MMU.

>   }
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 9f0c184b02a0..f33f94acd1b9 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -126,7 +126,7 @@ struct msm_drm_private {
>   	struct msm_gpu *gpu;
>   
>   	/* gpu is only set on open(), but we need this info earlier */
> -	bool is_a2xx;
> +	bool has_gpu_iommu;
>   	bool has_cached_coherent;
>   
>   	struct drm_fb_helper *fbdev;

-- 
With best wishes
Dmitry

