Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7146FACB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjEHL1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjEHL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:26:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8F3A5E1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:26:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f00d41df22so28188469e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683545197; x=1686137197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgp4w7UgtGPW6wmF4U1r9WAnrIsZUUpZz/2MD42UzYc=;
        b=ibUxcb63dNhxKPG6WlrwUfgo/nK6cepLMmXEXUV6yHciHB/+Ri1/Qq0xRTUdGjGald
         lR+MaSbckb3bISrb8QrdUthJJnoVMzEO9G2kV340N1nxQ4O+FJq9nMh0p+0SBBos9RS5
         VlrftkbpoA4dGhGzInVrpiJn66Lr2PWkeW223+C/vsbxN8l7p2DzS51h1clLeNdmCIKr
         ziQ2imDORby43gPJJ/DNzuEkaAR4rmnuMnguPdjvVawBX1ymPe07VhrfDQ646vEqm3Kz
         ZmlLn4lqGjr0Y/5glIa5RHVvj25gTrAZZu6IlZEmN3WpblFt5qcQdokey9FUJc8mX/pg
         ediw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545197; x=1686137197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgp4w7UgtGPW6wmF4U1r9WAnrIsZUUpZz/2MD42UzYc=;
        b=GTQ3uW1wugNqQJ9TSwNjnqA7kUYQ/fsQ5nuRtS9EmnBAIOmQgQOD6Bp2qnszN+R5Re
         caKTFca3/cXKRA4YTinDMqIawtYBPVp9t69xjUhiPzMIwD1n7XtJGUjdO3dPRx0s40h0
         fdaUXfgvt6XRAU7BGlZ/igE4/FSBL6wX+23VnncQ35TYaCHZWPmNyeDpbvMKXjbsNM1h
         5efAB5DZIOO06bGw1h18y84qQ+5yyJY83T5ZZJrZtP1qo1XiEIwqkwJLQhIR/cdC0hw4
         j9+vW9NjNg2Bo7vYIUP9pe6AeM7L7IidnRoaH4L3yGNYdhvJ9WWkAPkQPn0Htl+ZZyCQ
         p8Hg==
X-Gm-Message-State: AC+VfDyRVgcLPygpIrOunklY7Q4sIyLCtCnBsUp+BGIkq63iAdsnOQBX
        b1lUYphB57kUGrJ6Vc2W8hUGFA==
X-Google-Smtp-Source: ACHHUZ4ICyUpFMfcjzB2NR90fEPuHFIHGyWmG7SwR4v7eU+z+qCKnFMg2I25yvCeCXT4byqsSvOqeA==
X-Received: by 2002:a05:6512:3985:b0:4ef:fb45:7037 with SMTP id j5-20020a056512398500b004effb457037mr5021723lfu.20.1683545196918;
        Mon, 08 May 2023 04:26:36 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f4-20020ac25324000000b004b5979f9ba8sm1274886lfh.210.2023.05.08.04.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 04:26:36 -0700 (PDT)
Message-ID: <933ec58a-0f1f-93d2-9fe6-ab818de17bbd@linaro.org>
Date:   Mon, 8 May 2023 14:26:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/msm/dpu: Set DPU_DATA_HCTL_EN for in INTF_SC7180_MASK
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230508-topic-hctl_en-v1-1-0f8b5df60ed5@linaro.org>
 <vonnkr34hogk3r54pg5wqw3xv5ood4zkdojehcr5stonvqev6u@nnezyvphwo5k>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <vonnkr34hogk3r54pg5wqw3xv5ood4zkdojehcr5stonvqev6u@nnezyvphwo5k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 13:57, Marijn Suijten wrote:
> On 2023-05-08 12:29:32, Konrad Dybcio wrote:
>> DPU5 and newer targets enable this unconditionally. Move it from the
>> SC7280 mask to the SC7180 one.
>>
>> Fixes: 7bdc0c4b8126 ("msm:disp:dpu1: add support for display for SC7180 target")
> 
> The flag only exists since 591e34a091d17 ("drm/msm/disp/dpu1: add
> support for display for SC7280 target"), and I don't know how bad it is
> if it was lacking when SC7180 was added?

I think 591e34a091d1 ("drm/msm/disp/dpu1: add support for display for 
SC7280 target") or 7e6ee55320f0 ("drm/msm/disp/dpu1: enable DATA_HCTL_EN 
for sc7280 target") would be more appropriate here.

With that in place:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> I wonder if this needs any Reported-by/Suggested-by, given that I found
> the DATA_COMPRESS discrepancy for your SM6375 patch (which was using
> SC7280 to have the HCTL mask) and Dmitry pointing out that HCTL needs to
> be in SC7180 entirely.
> 
> Fortunately none of this affects cmdmode :)
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
>> ---
>> Depends on:
>> https://lore.kernel.org/linux-arm-msm/20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com/
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> index 27420fc863d6..7ea8fd69d5fd 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> @@ -98,9 +98,12 @@
>>   #define INTF_SDM845_MASK (0)
>>   
>>   #define INTF_SC7180_MASK \
>> -	(BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE) | BIT(DPU_INTF_STATUS_SUPPORTED))
>> +	(BIT(DPU_INTF_INPUT_CTRL) | \
>> +	 BIT(DPU_INTF_TE) | \
>> +	 BIT(DPU_INTF_STATUS_SUPPORTED) | \
>> +	 BIT(DPU_DATA_HCTL_EN))
>>   
>> -#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN) | BIT(DPU_INTF_DATA_COMPRESS)
>> +#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_INTF_DATA_COMPRESS)
>>   
>>   #define WB_SM8250_MASK (BIT(DPU_WB_LINE_MODE) | \
>>   			 BIT(DPU_WB_UBWC) | \
>>
>> ---
>> base-commit: c47189dee0decd9ecc1e65ae376ad6d4b0b7f1f2
>> change-id: 20230508-topic-hctl_en-3abb999a6c99
>>
>> Best regards,
>> -- 
>> Konrad Dybcio <konrad.dybcio@linaro.org>
>>

-- 
With best wishes
Dmitry

