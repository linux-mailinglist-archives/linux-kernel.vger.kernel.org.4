Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEAF6CF123
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjC2Rbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2Rbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:31:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27785FE6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:31:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y20so21246157lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680111085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKUp8oQT2937+iLDgPVmHMrXn9AJqcS/Qo7VP4VGSrc=;
        b=N4TvfqSwMCVjbDDxy2dbivFCv1ns9kOMPlc9B5Kmc25WwSGhOCDHi0l9gd4u5UHtNZ
         3FOuQEgFMv1Mi5d75fnCo4VAWlojeZM2kOHCZnunlNdRQ81oxa1c501aYr8JtvPyRpxr
         5Q2sl7FdhTbqEnoza6Fhrm0UgcZAzrEyp1PuwPJruTiTMhCLLL4zUihCmOgX46SQF7JR
         yStG0DDIVsfLX+VjLaDsGScIDjSYqMZzCGteWYlOrgpc6X1BRgbdopXFCbYjF5jwl3N7
         hoDQ1jh4Tl21Bqwb6hNIwyu+GXx1PdxaFXtVLMwYwjYrpAPQJcH4zzdVqJbQbtg1vrBa
         zW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680111085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKUp8oQT2937+iLDgPVmHMrXn9AJqcS/Qo7VP4VGSrc=;
        b=kNDUmxu4BffOBbYkN/IHH1ZauVftuPT4uWxKnGPbi0gOgCbyg+xB2cg5mYcVlhKh49
         dI1fSTpUulai7SB9NH4Lxph5025U91X0UhY7gDB2FxTD94FQRPxtDGZ36VGU3rxwOizV
         FQZWQgpuGP5Qe/ywrb9dopLAyf1k8ppEg2ii1WdBa/LDSlGzvF201ZTET6n31P5uvKyp
         7yVedkUz8B2Ee1wwu4exOd9vypUE2CRB6L96hj7xO/bGQ6KQdG3snjGpSzNYKto9XJeE
         7NLNB3klgpPne1M3GxSU2wYwvKfm159aKYaib5+ttXQOJcmZfO6MJz+ikrGPV6A2VksJ
         7vXA==
X-Gm-Message-State: AAQBX9dil1+XC/VGybnGBNehWhDexr3FyOc8JGH2fpkJ7E7AAFcIaz3f
        h6GbX5OsHdsw1/dBo0dVNrOE1g==
X-Google-Smtp-Source: AKy350aB0j3c+eGT0mY6Ft1GQFoC5DsZuQx4Y3sE2T8yMJTGK8FwE7Y4b3VTXhlfEqTak5pPqZGpgw==
X-Received: by 2002:a05:6512:971:b0:4e9:a75b:cccb with SMTP id v17-20020a056512097100b004e9a75bcccbmr5072963lft.28.1680111084835;
        Wed, 29 Mar 2023 10:31:24 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b004b6f00832cesm5510541lfh.166.2023.03.29.10.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 10:31:24 -0700 (PDT)
Message-ID: <bc0961f3-5608-eab9-0937-462d498bd6e6@linaro.org>
Date:   Wed, 29 Mar 2023 19:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm/adreno: adreno_gpu: Use suspend() instead of
 idle() on load error
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230329140445.2180662-1-konrad.dybcio@linaro.org>
 <ZCRNFitcrAeH27Pn@hovoldconsulting.com>
 <83986fa9-c9eb-ae5a-b239-584092f2cea5@linaro.org>
 <CAF6AEGsYimELcEAs8hdkYqdMzteMwzhPFavvmEUiEFsO01RrrQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAF6AEGsYimELcEAs8hdkYqdMzteMwzhPFavvmEUiEFsO01RrrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.03.2023 19:30, Rob Clark wrote:
> On Wed, Mar 29, 2023 at 8:48 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 29.03.2023 16:37, Johan Hovold wrote:
>>> On Wed, Mar 29, 2023 at 04:04:44PM +0200, Konrad Dybcio wrote:
>>>> If we fail to initialize the GPU for whatever reason (say we don't
>>>> embed the GPU firmware files in the initrd), the error path involves
>>>> pm_runtime_put_sync() which then calls idle() instead of suspend().
>>>>
>>>> This is suboptimal, as it means that we're not going through the
>>>> clean shutdown sequence. With at least A619_holi, this makes the GPU
>>>> not wake up until it goes through at least one more start-fail-stop
>>>> cycle. Fix that by using pm_runtime_put_sync_suspend to force a clean
>>>> shutdown.
>>>
>>> This does not sound right. If pm_runtime_put_sync() fails to suspend the
>>> device when the usage count drops to zero, then you have a bug somewhere
>>> else.
>> I was surprised to see that it was not called as well, but I wasn't able
>> to track it down before..
>>
>>>
>>> Also since commit 2c087a336676 ("drm/msm/adreno: Load the firmware
>>> before bringing up the hardware") the firmware is loaded before even
>>> hitting these paths so the above description does not sound right in
>>> that respect either (or is missing some details).
>> ..but I did some more digging and I found that the precise "firmware"
>> that fails is the ZAP blob, which is not checked like SQE in the
>> commit you mentioned!
>>
>> Now I don't think that we can easily check for it as-is since
>> zap_shader_load_mdt() does the entire find-load-authenticate
>> dance which is required with secure assets, but it's obviously
>> possible to rip out the find-load part of that and go on from
>> there.
>>
>> Do you think that would be a better solution?
> 
> Hmm, to hit this it sounds like you'd need all the fw _except_ the zap
> in the initrd?
Correct.

Konrad
> 
> BR,
> -R
> 
>> Konrad
>>
>>>
>>>> Test cases:
>>>> 1. firmware baked into kernel
>>>> 2. error loading fw in initrd -> load from rootfs at DE start
>>>>
>>>> Both succeed on A619_holi (SM6375) and A630 (SDM845).
>>>>
>>>> Fixes: 0d997f95b70f ("drm/msm/adreno: fix runtime PM imbalance at gpu load")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> index f61896629be6..59f3302e8167 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>>> @@ -477,7 +477,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
>>>>      return gpu;
>>>>
>>>>  err_put_rpm:
>>>> -    pm_runtime_put_sync(&pdev->dev);
>>>> +    pm_runtime_put_sync_suspend(&pdev->dev);
>>>>  err_disable_rpm:
>>>>      pm_runtime_disable(&pdev->dev);
>>>
>>> Johan
