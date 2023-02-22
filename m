Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2354169FEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjBVWk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjBVWk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:40:56 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22854460A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:40:54 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i9so11857614lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/Y1KciKJZ7VrZa7gW0Zk0UbrGDz/hc2vzEA3PjcOcc=;
        b=nEUnG1X2syFChhsaIXbJ4M2fp7tcyeGP2H6ZEvHSjURRaXYvibakD70006YLtxqcYN
         Hu61Yu44WBUcQGd1fPzcOi2DMDZ5Le2HOLAP8ZH+36dsiPlNRtgs8drQXKcHe44LyqCQ
         DoSyHBW8Tw67rOB/NskrIJ1Ng8uFf8hdQFlGrd5foNzu5so74pdEC4Zda+ZSQKyuViny
         rOEAvdFKQyPfxJRYQAA7lJZvSSzODJRgK54t2G3hFV3th78fRLnw/yRAOl0qQ3d7dvMK
         16Ii18+kGHsEG/7nAzQxnsTMhlxF1qRAYeiGHmvndo1OSCRwP+hEKYAb63/Z134jLyO6
         TDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/Y1KciKJZ7VrZa7gW0Zk0UbrGDz/hc2vzEA3PjcOcc=;
        b=zFp7w/7Iz/aP+FqbiUKVRGTa9Ry+PbXZ/492xVKosBrNAHaH6p2QyINHbNWyMQd/4P
         4SxOG7xEkav6L+XO5wWLi/E9Fgit7oGqBEyyzvZzMqXxN3YMH1wkdpteRDbzKrJ9Nflr
         oNqdnFvnhG/dZq4egeKSwrmyZVHqCgpjTi53gkHAromMFbZzmt7XCwhrL30hibjMdR5B
         EhP8O20/k/chkBvUw52DlPWFBLqkW4bRjLdL58vfCdkrQsvoomqbWHJ398v26n4MMx21
         d8S0e6VUPFy/hk/IMEpS+2fDw30hi1z+MxXnIqcXvOICF7JqebzImjkhvmUnuvyB3TNA
         QQ7w==
X-Gm-Message-State: AO0yUKXl/1KqFiCVQpO2qwXhW77AAF7243RW1c/aokR2kn3YOo1tmfib
        jwDa62DXVdYpNwFxwwx0+FrT/Q==
X-Google-Smtp-Source: AK7set/oe/NTvA8Q49sJW8AIXbVS4dwnSRYNzENHQ3vtDIlMjzoGyUHFWwe/9jG6vu3XzFZr7Oq3yA==
X-Received: by 2002:a19:f609:0:b0:4b5:b06d:4300 with SMTP id x9-20020a19f609000000b004b5b06d4300mr3175904lfe.29.1677105652345;
        Wed, 22 Feb 2023 14:40:52 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id l23-20020ac24317000000b004cca1658a41sm646920lfh.300.2023.02.22.14.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:40:52 -0800 (PST)
Message-ID: <180a33e7-d7b0-1b7f-9b91-20eb81d377dc@linaro.org>
Date:   Wed, 22 Feb 2023 23:40:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/5] drm/msm/adreno: Use OPP for every GPU generation
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230222-konrad-longbois-next-v1-0-01021425781b@linaro.org>
 <20230222-konrad-longbois-next-v1-1-01021425781b@linaro.org>
 <6ff7aea6-6535-3f54-b8d2-718d9a38a1be@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6ff7aea6-6535-3f54-b8d2-718d9a38a1be@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.2023 23:38, Dmitry Baryshkov wrote:
> On 22/02/2023 23:47, Konrad Dybcio wrote:
>> Some older GPUs (namely a2xx with no opp tables at all and a320 with
>> downstream-remnants gpu pwrlevels) used not to have OPP tables. They
>> both however had just one frequency defined, making it extremely easy
>> to construct such an OPP table from within the driver if need be.
>>
>> Do so and switch all clk_set_rate calls on core_clk to their OPP
>> counterparts.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 94 +++++++++++++++------------------
>>   drivers/gpu/drm/msm/msm_gpu.c           |  4 +-
>>   drivers/gpu/drm/msm/msm_gpu_devfreq.c   |  2 +-
>>   3 files changed, 45 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> index ce6b76c45b6f..9b940c0f063f 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> @@ -922,73 +922,50 @@ void adreno_wait_ring(struct msm_ringbuffer *ring, uint32_t ndwords)
>>               ring->id);
>>   }
>>   -/* Get legacy powerlevels from qcom,gpu-pwrlevels and populate the opp table */
>> -static int adreno_get_legacy_pwrlevels(struct device *dev)
>> -{
>> -    struct device_node *child, *node;
>> -    int ret;
>> -
>> -    node = of_get_compatible_child(dev->of_node, "qcom,gpu-pwrlevels");
>> -    if (!node) {
>> -        DRM_DEV_DEBUG(dev, "Could not find the GPU powerlevels\n");
>> -        return -ENXIO;
>> -    }
>> -
>> -    for_each_child_of_node(node, child) {
>> -        unsigned int val;
>> -
>> -        ret = of_property_read_u32(child, "qcom,gpu-freq", &val);
>> -        if (ret)
>> -            continue;
>> -
>> -        /*
>> -         * Skip the intentionally bogus clock value found at the bottom
>> -         * of most legacy frequency tables
>> -         */
>> -        if (val != 27000000)
>> -            dev_pm_opp_add(dev, val, 0);
>> -    }
>> -
>> -    of_node_put(node);
>> -
>> -    return 0;
>> -}
>> -
>> -static void adreno_get_pwrlevels(struct device *dev,
>> +static int adreno_get_pwrlevels(struct device *dev,
>>           struct msm_gpu *gpu)
>>   {
>> +    struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>>       unsigned long freq = ULONG_MAX;
>>       struct dev_pm_opp *opp;
>>       int ret;
>>         gpu->fast_rate = 0;
>>   -    /* You down with OPP? */
>> -    if (!of_find_property(dev->of_node, "operating-points-v2", NULL))
>> -        ret = adreno_get_legacy_pwrlevels(dev);
>> -    else {
>> -        ret = devm_pm_opp_of_add_table(dev);
>> -        if (ret)
>> -            DRM_DEV_ERROR(dev, "Unable to set the OPP table\n");
>> -    }
>> -
>> -    if (!ret) {
>> +    /* devm_pm_opp_of_add_table may error out but will still create an OPP table */
>> +    ret = devm_pm_opp_of_add_table(dev);
>> +    if (ret == -ENODEV) {
>> +        /* Special cases for ancient hw with ancient DT bindings */
>> +        if (adreno_is_a2xx(adreno_gpu)) {
>> +            dev_warn(dev, "Unable to find the OPP table. Falling back to 200 MHz.\n");
>> +            dev_pm_opp_add(dev, 200000000, 0);
>> +            gpu->fast_rate = 200000000;
> 
> We can skip setting the fast_rate, dev_pm_opp_find_freq_floor below will get it from our freshly generated opp table.
It's not reached in this code path.

> 
>> +        } else if (adreno_is_a320(adreno_gpu)) {
>> +            dev_warn(dev, "Unable to find the OPP table. Falling back to 450 MHz.\n");
>> +            dev_pm_opp_add(dev, 450000000, 0);
>> +            gpu->fast_rate = 450000000;
>> +        } else {
>> +            DRM_DEV_ERROR(dev, "Unable to find the OPP table\n");
>> +            return -ENODEV;
>> +        }
>> +    } else if (ret) {
>> +        DRM_DEV_ERROR(dev, "Unable to set the OPP table\n");
>> +        return ret;
>> +    } else {
>>           /* Find the fastest defined rate */
>>           opp = dev_pm_opp_find_freq_floor(dev, &freq);
>> -        if (!IS_ERR(opp)) {
>> +
>> +        if (IS_ERR(opp))
>> +            return PTR_ERR(opp);
>> +        else {
>>               gpu->fast_rate = freq;
>>               dev_pm_opp_put(opp);
>>           }
>>       }
>>   -    if (!gpu->fast_rate) {
>> -        dev_warn(dev,
>> -            "Could not find a clock rate. Using a reasonable default\n");
>> -        /* Pick a suitably safe clock speed for any target */
>> -        gpu->fast_rate = 200000000;
>> -    }
>> -
>>       DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
>> +
>> +    return 0;
>>   }
>>     int adreno_gpu_ocmem_init(struct device *dev, struct adreno_gpu *adreno_gpu,
>> @@ -1046,6 +1023,17 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>       struct adreno_rev *rev = &config->rev;
>>       const char *gpu_name;
>>       u32 speedbin;
>> +    int ret;
>> +
>> +    /* This can only be done here, or devm_pm_opp_set_supported_hw will WARN_ON() */
> 
> I'd rephrase this to '...done before devm_pm_opp_of_add_table(), or dev_pm_opp_set_config() will...'. It took me a while to find correct limitation.
> 
> I wanted to move the code below to msm_gpu_init(), but after digging in found that it's not possible.
Ack, I wasted some time on this too..

Konrad
> 
> 
>> +    if (IS_ERR(devm_clk_get(dev, "core"))) {
>> +        /*
>> +         * If "core" is absent, go for the legacy clock name.
>> +         * If we got this far in probing, it's a given one of them exists.
>> +         */
>> +        devm_pm_opp_set_clkname(dev, "core_clk");
>> +    } else
>> +        devm_pm_opp_set_clkname(dev, "core");
>>         adreno_gpu->funcs = funcs;
>>       adreno_gpu->info = adreno_info(config->rev);
>> @@ -1070,7 +1058,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>         adreno_gpu_config.nr_rings = nr_rings;
>>   -    adreno_get_pwrlevels(dev, gpu);
>> +    ret = adreno_get_pwrlevels(dev, gpu);
>> +    if (ret)
>> +        return ret;
>>         pm_runtime_set_autosuspend_delay(dev,
>>           adreno_gpu->info->inactive_period);
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>> index 380249500325..cdcb00df3f25 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>> @@ -59,7 +59,7 @@ static int disable_pwrrail(struct msm_gpu *gpu)
>>   static int enable_clk(struct msm_gpu *gpu)
>>   {
>>       if (gpu->core_clk && gpu->fast_rate)
>> -        clk_set_rate(gpu->core_clk, gpu->fast_rate);
>> +        dev_pm_opp_set_rate(&gpu->pdev->dev, gpu->fast_rate);
>>         /* Set the RBBM timer rate to 19.2Mhz */
>>       if (gpu->rbbmtimer_clk)
>> @@ -78,7 +78,7 @@ static int disable_clk(struct msm_gpu *gpu)
>>        * will be rounded down to zero anyway so it all works out.
>>        */
>>       if (gpu->core_clk)
>> -        clk_set_rate(gpu->core_clk, 27000000);
>> +        dev_pm_opp_set_rate(&gpu->pdev->dev, 27000000);
>>         if (gpu->rbbmtimer_clk)
>>           clk_set_rate(gpu->rbbmtimer_clk, 0);
>> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>> index e27dbf12b5e8..ea70c1c32d94 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>> @@ -48,7 +48,7 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
>>           gpu->funcs->gpu_set_freq(gpu, opp, df->suspended);
>>           mutex_unlock(&df->lock);
>>       } else {
>> -        clk_set_rate(gpu->core_clk, *freq);
>> +        dev_pm_opp_set_rate(dev, *freq);
>>       }
>>         dev_pm_opp_put(opp);
>>
> 
