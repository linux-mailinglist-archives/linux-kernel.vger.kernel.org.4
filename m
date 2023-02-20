Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6716269C822
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjBTJ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjBTJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:59:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8800A15C84
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:59:35 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a26so2146431lfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywAU8OoBbAUucxBkw+OQ9oXs8iU9JAIrIjeKhlO8RdU=;
        b=qzWSYW/QA2ZJHpcMwlFP4k9gyOtvYZfoeb0vb5PALj+ufZKtsvhwL3irYC3nsY/GjX
         QZb6OYgoUaIKxd0NbkqkzlOqkgqDIDXWKc2CLYHSqfYB1aeSntmCDQeMca2piFZOGXJr
         jqLxJYuP6UHT4NLnsr4utMo+9+CKyrGUwdgl+K6eN63+EU4QKhxknSPmCX282hlR4neW
         pWVjV9MfNkp+njmEO8Ks121zRCdMYDmCpLLRxLEIAccuz0SGc+zGtmil+5Vufz1INfdd
         E4JPrludd89gEhZJFkX9elm3H7ROym/zItA+1Ig4FI6lGRDXI0GuJzvpymyH5qWVSBwD
         qILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywAU8OoBbAUucxBkw+OQ9oXs8iU9JAIrIjeKhlO8RdU=;
        b=TTR+HeFQZ2q7AUeeGVPJJmss+wsr27U5hxxRHer3zSgLY4ANaSJs2Cw5q1mCe16phR
         8ixuW6lU4g5aGDrh9J6K8dymaRuGFe0NaG5dLgpcYwCkUcZpOH3PwF6pLq0Xuxmbt48j
         YdTpibgm5xpGcdw7F+9GS9nulajMOxm3aU4lNx+sbSgd/n+OAgHwEfB2OCoAPEU2g71q
         rFmBqRCYi1hoiaaCV/4fUckAOT840aQycPQHcqeQ1aIlodgVGxpqfe45L8DAOVQ747Jq
         BN/hf/acsTMx8Im15SZbJr6ZohIt2KlmEuWMVCj07rBV02F78Q35v8SB7U5M+EuF5EKo
         wwtA==
X-Gm-Message-State: AO0yUKXRmzk6ZSp4Sh7kFPyBJKFOsqEWohHqFJrxT9Le+f84TiQMSt7E
        AentXhism/Fls1HNTjRgSM5O1Q==
X-Google-Smtp-Source: AK7set/DCtI50kuFxGmgY0zVWagZ8vwkt/Nbtajm7tyz/ZgVuY15E401RNI5p2Ar4Ic3vU2pxdkGfg==
X-Received: by 2002:ac2:5921:0:b0:4b5:3200:eb37 with SMTP id v1-20020ac25921000000b004b53200eb37mr348994lfi.43.1676887173736;
        Mon, 20 Feb 2023 01:59:33 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id u13-20020ac248ad000000b004d3f0f20b98sm1479286lfg.40.2023.02.20.01.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 01:59:33 -0800 (PST)
Message-ID: <cc7a9cce-cd12-0f35-d8f7-933b64bbb34d@linaro.org>
Date:   Mon, 20 Feb 2023 10:59:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 06/14] drm/msm/gpu: Use dev_pm_opp_set_rate for non-GMU
 GPUs
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Emma Anholt <emma@anholt.net>, Chia-I Wu <olvaffe@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
 <20230214173145.2482651-7-konrad.dybcio@linaro.org>
 <2e129fd6-d4e5-a955-5355-3ca71166fb33@linaro.org>
 <82c84ba4-ca33-3ce0-fe86-efedfce04cda@linaro.org>
 <170ee26d-8904-0829-f92e-4ea6678b08eb@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <170ee26d-8904-0829-f92e-4ea6678b08eb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.02.2023 17:47, Dmitry Baryshkov wrote:
> On 18/02/2023 13:04, Konrad Dybcio wrote:
>>
>>
>> On 17.02.2023 22:07, Dmitry Baryshkov wrote:
>>> On 14/02/2023 19:31, Konrad Dybcio wrote:
>>>> Currently we only utilize the OPP table connected to the GPU for
>>>> getting (available) frequencies. We do however need to scale the
>>>> voltage rail(s) accordingly to ensure that we aren't trying to
>>>> run the GPU at 1GHz with a VDD_LOW vote, as that would result in
>>>> an otherwise inexplainable hang.
>>>>
>>>> Tell the OPP framework that we want to scale the "core" clock
>>>> and swap out the clk_set_rate to a dev_pm_opp_set_rate in
>>>> msm_devfreq_target() to enable usage of required-opps and by
>>>> extension proper voltage level/corner scaling.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    drivers/gpu/drm/msm/adreno/adreno_gpu.c | 4 ++++
>>>>    drivers/gpu/drm/msm/msm_gpu_devfreq.c   | 2 +-
>>>>    2 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>>> index ce6b76c45b6f..15e405e4f977 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>>> @@ -1047,6 +1047,10 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>>>        const char *gpu_name;
>>>>        u32 speedbin;
>>>>    +    /* This can only be done here, or devm_pm_opp_set_supported_hw will WARN_ON() */
>>>> +    if (!IS_ERR(devm_clk_get(dev, "core")))
>>>> +        devm_pm_opp_set_clkname(dev, "core");
>>>
>>> Can we instead move a call to a6xx_set_supported_hw() / check_speed_bin after the adreno_gpu_init() ? It will call msm_gpu_init, which in turn sets gpu->core_clk.
>>>
>>> Ideally you can call devm_pm_opp_set_clkname() from that function.
>>
>>
>>> Or maybe completely drop gpu->core_clk and always use devm_pm_opp_set_clk_rate().
>> That would break non-OPP targets, last of which were probably added N=big years ago..
> 
> No. In the lack of OPP tables, dev_pm_opp_clk_set_rate() should behave exactly like the clk_set_rate().
Not sure if that's what you meant, but if a device lacks OPP,
devm_pm_opp_set_rate will return -ENODEV.

If you meant "if we can't find an opp table, behave as if we
called clk_set_rate", a discussion on #freedreno with robclark
indicates he'd accept getting rid of non-opp code, provided we
construct a table if need be, since we have the data required
to do so ([FMIN=27MHz, FMAX=fast_rate]).

> 
>> I'm not sure these would still work, as I think we've got rid of some ugly
>> clock getters that were looking for both "core" and "core_clk" etc.
> 
> We still support core vs core_clk, see the get_clocks() at msm_gpu.c and then msm_clk_bulk_get_clock(). However we might mimick this function and call devm_pm_opp_set_clkname() with the proper name ("core" or "core_clk").
> 
>>
>> See 8db0b6c7b636376789e356d861c3c6c35dcb6913 for what seems to be the most recent
>> example of non-OPP.
>>
>> IMX51/53 also have no OPP tables and are using the (AFAIK) now-defunct _clk-suffixed
>> clock-names.
> 
> It works, I tested it during this cycle.
Oh okay, I had a feeling like that was dropped at one point..

> 
>>
>> I'd be more than happy to rip out some of this legacy code and convert it
>> to something modern like OPP, but I'm not sure you guys would like it considering
>> the breakage on (arguably ancient and borderline retired) platforms.
> 
> I think, we should try switching to OPP-for-everybody, granted the promise of dev_pm_opp_set_clk_rate() being backwards compatible with bare clk_set_rate().
It's not, but as I mentioned, we can easily work around that.

> 
>>
>> This patch as-is "only" breaks non-OPP a5xx & a6xx (as they have .gpu_busy defined),
>> of which there are none..
...but we want to get devfreq everywhere and it's a few LoC away..

Konrad
>>
>>>
>>>> +
>>>>        adreno_gpu->funcs = funcs;
>>>>        adreno_gpu->info = adreno_info(config->rev);
>>>>        adreno_gpu->gmem = adreno_gpu->info->gmem;
>>>> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>>>> index e27dbf12b5e8..ea70c1c32d94 100644
>>>> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>>>> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>>>> @@ -48,7 +48,7 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
>>>>            gpu->funcs->gpu_set_freq(gpu, opp, df->suspended);
>>>>            mutex_unlock(&df->lock);
>>>>        } else {
>>>> -        clk_set_rate(gpu->core_clk, *freq);
>>>> +        dev_pm_opp_set_rate(dev, *freq);
>>>
>>> This is not enough, there are calls to clk_set_rate(gpu->core_clk) in msm_gpu.c which are called from the suspend/resume path.
>> Right, good catch.
>>
>> Konrad
>>>
>>>>        }
>>>>          dev_pm_opp_put(opp);
>>>
> 
