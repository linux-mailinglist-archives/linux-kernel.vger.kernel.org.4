Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89574A3F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjGFSzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjGFSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:55:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855C01FC7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:55:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso1522179e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688669715; x=1691261715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c73ospzpOiJ3HtlgE71gvC44nRlCQXqmHvLoRFp4sL4=;
        b=ND2+mI66BMUP0EVE1nSaYxo9mWB5eeoIo1gtE7E+zEXop6A8oX/OLRZXrLxEN1LhAh
         M58ceesFaLsZHJIl14MQQebqOO9dtXDwDrdF0XzK1FztkxRZn8WN4ay8KzkMAA8ePzMb
         jzf63o8jdzaNDYop5EEeRy3wdHRZDegmCOdKjn14iMOXuAAxvMuitqELUqjRH/oXZAQ6
         I3uzETwgEkWbFL6nff3d943wAiWYpBMPBH3GKYEqF/32sT2xRB7eQ5OjmibnmSD+ofK8
         F6W3/mg4BJ2Iii0UkfWEFfFIMkJSCMZjfTy6B8/wrYcM801nR3PGAcFPLDDSMEgJnUXQ
         C5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688669715; x=1691261715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c73ospzpOiJ3HtlgE71gvC44nRlCQXqmHvLoRFp4sL4=;
        b=JN7FV9vUdk2tBZ9I6A2CA1/AkL9TRudcT4t7mOTyRHeie9tXcmAaGtc76476DyI+nn
         zN4JZv4zQRPSZN3it01ICGIlWzCzgw6vQBrGOPps8hnmBZlWcs7/iTgcadB41swUP01u
         bbUExIdor9Zo3U482514Fyy/+0vbQri0w8GZuzS4fK/QZp7dAaBTjDf32HczReNfovsR
         KIXFWNbZjO7N6/Loi0BBxzNWwQW2UHdB2uvJI/PqTwhZ+eaQrkSNOttxjnN2cEvT6fKu
         7hlSxSQsIXiLaigz34dwHkFtyUnpE4JueKrW+JSChHSzCgaL4Cnm7R8KRaO3hlTTSfbd
         oMbQ==
X-Gm-Message-State: ABy/qLa1AJ33XVqVTsIgomB6mNCMueLYjmeNiyYPmAeDpw8Yv2nLyaM3
        64HcY6im+PM9QwWjl9S9JKSPhw==
X-Google-Smtp-Source: APBJJlF1X8wbG4TDSUK8MuBW3QmgXhipXcKJo3Ts0Qh54FlI4NjRBynEemoPlOJF9xLjXeRjhk8xZQ==
X-Received: by 2002:a05:6512:3253:b0:4fa:5e76:7ad4 with SMTP id c19-20020a056512325300b004fa5e767ad4mr2021699lfr.10.1688669714682;
        Thu, 06 Jul 2023 11:55:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q17-20020ac25151000000b004fb9c625b4asm363910lfd.210.2023.07.06.11.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 11:55:14 -0700 (PDT)
Message-ID: <d73f6733-e605-0cf8-7909-8cced6e3b70d@linaro.org>
Date:   Thu, 6 Jul 2023 21:55:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/msm: Check for the GPU IOMMU during bind
Content-Language: en-GB
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230309222049.4180579-1-jorcrous@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> 
> This works for memory allocations but it doesn't prevent the VRAM carveout
> from being created because that happens before we have a chance to check
> the GPU IOMMU state in adreno_bind.
> 
> There are a number of possible options to resolve this but none of them are
> very clean. The easiest way is to likely specify vram=0 as module parameter
> on headless devices so that the memory doesn't get wasted.

This patch was on my plate for quite a while, please excuse me for 
taking it so long.

I see the following problem with the current code. We have two different 
instances than can access memory: MDP/DPU and GPU. And each of them can 
either have or miss the MMU.

For some time I toyed with the idea of determining whether the allocated 
BO is going to be used by display or by GPU, but then I abandoned it. We 
can have display BOs being filled by GPU, so handling it this way would 
complicate things a lot.

This actually rings a tiny bell in my head with the idea of splitting 
the display and GPU parts to two different drivers, but I'm not sure 
what would be the overall impact.

More on the msm_use_mmu() below.

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

I have a generic feeling that both old an new code is not fully correct. 
Please correct me if I'm wrong:

We should be using VRAM, if either of the blocks can not use remapped 
memory. So this should have been:

bool msm_use_mmu()
{
  if (!gpu_has_iommu)
    return false;

  if (have_display_part && !display_has_mmu())
    return false;

  return true;
}

What do you think.

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

