Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0146E9F63
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjDTWwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjDTWwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:52:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1C03C34
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:52:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ec8399e963so969652e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682031154; x=1684623154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/v16eKXRHg1HPaanM/4pS/P8Q+dO4SeqtaL/Gi7zG4=;
        b=GXYV6MwDdKsN5Hhdyz0+1OnmgwcIcRDp4GF7vJge12Lf4duzn+D0Ozrdfotl62rMdF
         PD8YBQLlVEXQmGVV1z1FiNmjPF3oAuyTQC5qMSiGlZFz3wNE3WgX7cZEE5f1r7c/1E6+
         nAt1FWN01Kxqxi5mlqBIbBtaUbvfVpCUpjD/4AfSmqU0A0yZ6y4szhGJg5cTX/aWqwP/
         0AYOfu6N6pNG2lXsDec6WPHPlfZ4K+G27jlPnf7IhTic9bCY1nFUwEHIBJ1R5nufdVcV
         rGoTBrkWwNY2lP6RJ7klDTtsHL7X/DDCUdN+z5RFU96Gr00gLku4NeUoTEhIEIG97Nok
         ppUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682031154; x=1684623154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/v16eKXRHg1HPaanM/4pS/P8Q+dO4SeqtaL/Gi7zG4=;
        b=UHyaNHEka+GaY0VS+Jsvx1cNd7dFY1niVlIul4GjOP2hNGF6/MJNgj7ZPZrbewiRDb
         NeBvWblAZJbCyjC0lVYHQi11Ae2lF9dGUTlR3cvzVRfe5UT889gTKmzvOvcSphHXJCQi
         Au8rFmqgx2tY59Y5Oi5iWPYWZ1tSRzM9MTAWVflGbDkF2HIbk+TBnbZAPVuOypUUFXjq
         zlnQS5N11KiYRk+6p6s11wya2VmFGpIjdc08PEsrKzNhIcbMjlPgvmhB7xi/VjR6eM5I
         4o3pYJhV/OOg+yKGmAqtWt5Q/si+Mw7qVOnakrT47Aa0aUTH7/i40hxdOkLeIaEUz/d8
         8Nxg==
X-Gm-Message-State: AAQBX9e4Dd2xVnMobL2pIara5rgAbWORfHomLoY+ODu/hQzRSnoKC+ya
        fj2puaNkiMXZTCxo2yoWPKJprg==
X-Google-Smtp-Source: AKy350ZppDp3Kb0tHzOQRFVgfsZXqHlvIfx1MlP2ho7UCf8CcNG8lEXUrGrnQHVvGdWKxY9SDhJU6Q==
X-Received: by 2002:a19:ad4c:0:b0:4e8:3b51:e7eb with SMTP id s12-20020a19ad4c000000b004e83b51e7ebmr835807lfd.7.1682031154051;
        Thu, 20 Apr 2023 15:52:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id z8-20020a2e7e08000000b002a777ce224dsm402890ljc.138.2023.04.20.15.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:52:33 -0700 (PDT)
Message-ID: <0bba90c1-01be-a76e-df12-2328b84f7298@linaro.org>
Date:   Fri, 21 Apr 2023 01:52:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] DPU1 GC1.8 wiring-up
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230420-topic-dpu_gc-v1-0-d9d1a5e40917@linaro.org>
 <5b133c55-e4f5-bfd2-b542-a7d44313c038@linaro.org>
 <c0e0a55a-cc37-fe8a-8d8a-5fe257f99b9a@linaro.org>
 <3f3b3637-ed85-09a1-22b7-3ccd4bc929bb@quicinc.com>
 <2dff9d62-cffe-c66f-9e50-3ecd64e44d37@linaro.org>
 <6a335df7-ff0b-098a-feec-45714159df04@linaro.org>
 <b134d09c-55fa-7879-80ff-900e39c20c3d@quicinc.com>
 <0f469b3c-5f0f-e027-8a9f-d1233169c04a@linaro.org>
 <57pxyxwluu33z4lpij5gx7biwfo5pbhdalhhxflw7esi5n3vts@qhjb7ldnz3wb>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <57pxyxwluu33z4lpij5gx7biwfo5pbhdalhhxflw7esi5n3vts@qhjb7ldnz3wb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 22:56, Marijn Suijten wrote:
> On 2023-04-20 22:51:22, Dmitry Baryshkov wrote:
>> On 20/04/2023 22:47, Abhinav Kumar wrote:
>>>
>>>
>>> On 4/20/2023 11:01 AM, Dmitry Baryshkov wrote:
>>>> On 20/04/2023 04:36, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 20.04.2023 03:28, Abhinav Kumar wrote:
>>>>>>
>>>>>>
>>>>>> On 4/19/2023 6:26 PM, Konrad Dybcio wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 20.04.2023 03:25, Dmitry Baryshkov wrote:
>>>>>>>> On 20/04/2023 04:14, Konrad Dybcio wrote:
>>>>>>>>> Almost all SoCs from SDM845 to SM8550 inclusive feature a GC1.8
>>>>>>>>> dspp sub-block in addition to PCCv4. The other block differ a bit
>>>>>>>>> more, but none of them are supported upstream.
>>>>>>>>>
>>>>>>>>> This series adds configures the GCv1.8 on all the relevant SoCs.
>>>>>>>>
>>>>>>>> Does this mean that we will see gamma_lut support soon?
>>>>>>> No promises, my plate is not even full, it's beyond overflowing! :P
>>>>>>>
>>>>>>> Konrad
>>>>>>
>>>>>> So I think I wrote about this before during the catalog rework/fixes
>>>>>> that the gc registers are not written to / programmed.
>>>>>>
>>>>>> If thats not done, is there any benefit to this series?
>>>>> Completeness and preparation for the code itself, if nothing else?
>>>>
>>>> The usual problem is that if something is not put to use, it quickly
>>>> rots or becomes misused for newer platforms. We have seen this with
>>>> the some of DPU features.
>>>>
>>>> In case of GC (and the freshly defined DPU_DSPP_IGC, but not used) we
>>>> have three options:
>>>> - drop the unused GC from msm8998_sblk.
>>>> - keep things as is, single unused GC entry
>>>> - fill all the sblk with the correct information in hope that it stays
>>>> correct
>>>>
>>>> Each of these options has its own drawbacks. I have slight bias
>>>> towards the last option, to have the information in place (as long as
>>>> it is accurate).
>>>>
>>>
>>> My vote is for (1) . Today, GC is unused and from the discussion here,
>>> there is no concrete plan to add it. If we keep extending an unused
>>> bitmask for all the chipsets including the ones which will get added in
>>> the future in the hope that someday the feature comes, it doesnt sound
>>> like a good idea.
>>>
>>> I would rather do (1), if someone has time.
>>
>> Agree, this was the second item on my preference list. Could you please
>> send this oneliner?
> 
> Nit (to make sure we're on the same thought here): I think it's a
> 3-liner: remove it from DSPP_MSM8998_MASK as well as msm8998_dspp_sblk.
> 
>>> OR lets stay at (2) till
>>> someone does (1).
> 
> I'm personally okay leaving it in place too, with an eye on implementing
> this, IGC, and other blocks at some point if there's a use for it via
> standard DRM properties.

I took a quick glance. I think it is possible, but not straightforward. 
But I must admit here, I don't have a full picture regarding different 
color encodings, ranges and the rest of gamma/degamma API and usage.

> 
>>> When someone implements GC, we can re-use this patch and that time keep
>>> konrad's author rights or co-developed by.
> 
> Good to at least know all these SoCs have the same offset and revision.
> 
> - Marijn

-- 
With best wishes
Dmitry

