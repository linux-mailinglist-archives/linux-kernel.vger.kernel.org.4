Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CBC73AD01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjFVXPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjFVXPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:15:05 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCE11BE7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:14:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b479d53d48so1450171fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687475697; x=1690067697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1JY0yeL3CeoNuEhq9uRKX956qL6nT7MiCllyM/47ik=;
        b=pDgvUF90fHQm5F2DkDPo2iXIdKKXGkIoGOpgdvMdlg9jB+cag1pl8EJ76CM6XD2nHO
         T/Q7vGDxcWWFG/NCZhQKgzHFCiHfb4v/LmF+PkScYz8AYs3kq7IS8rVWVLAquwAMJ+Ed
         GBsfXR5QVrglU+R1oHBgKOEtpPPkgIeQXHbkZEwjYrnIVkuHoXcKuVnGPXZw/gU3ZdFl
         JLpbeMwU7NWfkW4l9L2Y0JNb0ZdRERyG9J6nXkUQNT/NQvOm4wpWkGp+1A2rwSgg0MZM
         lw7Q+oCIgiRJCW5wZ7mPkDsuQW0Nh7DghXimKMB9fFshVDQLcr9chYGJ8GdrL4+bUzOR
         YZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687475697; x=1690067697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1JY0yeL3CeoNuEhq9uRKX956qL6nT7MiCllyM/47ik=;
        b=kt6p/wtUUShbSdjlz/7pWJCy8e4P8jsKtWLUioqtESMkXx3f0JiRiTNQTLC61V2n1m
         zmRWzDmvaxILkhYm8HdSsGCFSobyGoDay6xBwI7+gMoTP2Z8cctsgA3HE8bWJOjrXyRU
         MLwjKN3ymxHnDh9PcEEGEHRxxZjV9k6oFlY6rndVT3b9a8nUTs9GEIjbN+PJGn4S9oqe
         FDEZBc9U3HTen6+emdEfnJQFcnossir9NYnlsDqYxNs+Gz4/32HXDqQQG/42RlullLiH
         m/stvkQxyH/SEUKdA61sNjABtJ9LPRA+f7VMekPHO9g0sqZcSVHKLbUMsFYaw12SKGSK
         Zmig==
X-Gm-Message-State: AC+VfDwdmNNvkO2Djpd+ybwQyXPjxqW+Fljr6gDgmV/LsnPAkqSnUyvH
        PBGRJldD23GglEbC269uXoDxJA==
X-Google-Smtp-Source: ACHHUZ51Vi7gdrXGLA0oOJ1dXh3HiLjBGA0Ks/lCXN75Wlh+vv5jSmCwxP1WSZc2IkK17o30KM3N7g==
X-Received: by 2002:a05:6512:55a:b0:4f7:669f:7da8 with SMTP id h26-20020a056512055a00b004f7669f7da8mr12998738lfl.7.1687475697468;
        Thu, 22 Jun 2023 16:14:57 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id g15-20020a19ee0f000000b004f86e5918a6sm1237614lfb.189.2023.06.22.16.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 16:14:56 -0700 (PDT)
Message-ID: <dab90e58-c25a-9b5a-bae0-dfc50de7d363@linaro.org>
Date:   Fri, 23 Jun 2023 02:14:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/msm/dpu: Set DATABUS_WIDEN on command mode
 encoders
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-2-c7069f2efca1@quicinc.com>
 <c74c9e0e-d059-f0e3-4350-03089c37131a@linaro.org>
 <cce68370-3fd9-4c9a-258e-af0d5d057fda@quicinc.com>
 <n2c5qlujxhbbj2aqlgj7fetzoteood5h4hmbwt4mapi77xlvmt@bpourzaideti>
 <81a5e241-ec82-7414-8752-4ce3cb084959@linaro.org>
 <f14f2c31-38c2-0600-3a29-17e83afececf@quicinc.com>
 <26tvhvqpxtxz5tqc6jbjixadpae34k7uc7fyec2u5o2ccj4tdq@tjvguzlolc3g>
 <8dcd643f-9644-a4e7-a0d5-eefa28084a88@linaro.org>
 <7d5256cd-c0bd-36e3-9b59-63ad8595f0ce@quicinc.com>
 <b119470d-f656-71d1-8b87-b4b8196f5220@linaro.org>
 <a4688db2-4230-7485-a688-bc6253d2d4b8@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <a4688db2-4230-7485-a688-bc6253d2d4b8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 01:37, Abhinav Kumar wrote:
> 
> 
> On 6/21/2023 4:46 PM, Dmitry Baryshkov wrote:
>> On 22/06/2023 02:01, Abhinav Kumar wrote:
>>>
>>>
>>> On 6/21/2023 9:36 AM, Dmitry Baryshkov wrote:
>>>> On 21/06/2023 18:17, Marijn Suijten wrote:
>>>>> On 2023-06-20 14:38:34, Jessica Zhang wrote:
>>>>> <snip>
>>>>>>>>>>> +    if (phys_enc->hw_intf->ops.enable_widebus)
>>>>>>>>>>> + phys_enc->hw_intf->ops.enable_widebus(phys_enc->hw_intf);
>>>>>>>>>>
>>>>>>>>>> No. Please provide a single function which takes necessary
>>>>>>>>>> configuration, including compression and wide_bus_enable.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> There are two ways to look at this. Your point is coming from the
>>>>>>>>> perspective that its programming the same register but just a 
>>>>>>>>> different
>>>>>>>>> bit. But that will also make it a bit confusing.
>>>>>>>
>>>>>>> My point is to have a high-level function that configures the 
>>>>>>> INTF for
>>>>>>> the CMD mode. This way it can take a structure with necessary
>>>>>>> configuration bits.
>>>>>>
>>>>>> Hi Dmitry,
>>>>>>
>>>>>> After discussing this approach with Abhinav, we still have a few
>>>>>> questions about it:
>>>>>>
>>>>>> Currently, only 3 of the 32 bits for INTF_CONFIG2 are being used (the
>>>>>> rest are reserved with no plans of being programmed in the 
>>>>>> future). Does
>>>>>> this still justify the use of a struct to pass in the necessary
>>>>>> configuration?
>>>>>
>>>>> No.  The point Dmitry is making is **not** about this concidentally
>>>>> using the same register, but about adding a common codepath to enable
>>>>> compression on this hw_intf (regardless of the registers it needs to
>>>>> touch).
>>>>
>>>> Actually to setup INTF for CMD stream (which is equal to setting up 
>>>> compression at this point).
>>>>
>>>
>>> Yes it should be setup intf for cmd and not enable compression.
>>>
>>> Widebus and compression are different features and we should be able 
>>> to control them independently.
>>>
>>> We just enable them together for DSI. So a separation is necessary.
>>>
>>> But I am still not totally convinced we even need to go down the path 
>>> for having an op called setup_intf_cmd() which takes in a struct like
>>>
>>> struct dpu_cmd_intf_cfg {
>>>      bool data_compress;
>>>      bool widebus_en;
>>> };
>>>
>>> As we have agreed that we will not touch the video mode timing engine 
>>> path, it leaves us with only two bits.
>>>
>>> And like I said, its not that these two bits always go together. We 
>>> want to be able to control them independently which means that its 
>>> not necessary both bits program the same register one by one. We 
>>> might just end up programming one of them if we just use widebus.
>>>
>>> Thats why I am still leaning on keeping this approach.
>>
>> I do not like the idea of having small functions being called between 
>> modules. So, yes there will a config of two booleans, but it is 
>> preferable (and more scalable) compared to separate callbacks.
>>
> 
> I definitely agree with the scalable part and I even cross checked that 
> the number of usable bitfields of this register is going up from one 
> chipset to the other although once again that depends on whether we will 
> use those features.
> 
> For that reason I am not opposed to the struct idea.
> 
> But there is also another pattern i am seeing which worries me. Usable 
> bitfields sometimes even reduce. For those cases, if we go with a 
> pre-defined struct it ends up with redundant members as those bitfields 
> go away.
> 
> With the function op based approach, we just call the op if the feature 
> bit / core revision.
> 
> So I wanted to check once more about the fact that we should consider 
> not just expansion but also reduction.

As we have to support all generations, there is no actual reduction. 
Newer SoCs do not have particular feature/bit, but older ones do. By 
having multiple optional ops we just move this knowledge from 
ops->complex_callback() to _setup_block_ops(). But more importantly the 
caller gets more complicated. Instead of just calling ops->set_me_up(), 
it has to check all the optional callbacks and call the one by one.

> 
>> Not to mention that it allows us to program required registers 
>> directly (by setting values) rather than using RMW cycles and thus 
>> depending on the value being previously programmed to these registers.
>>
> 
> This will not change. We will still have to use RMW cycles to preserve 
> the reset values of some of the fields as those are the right values for 
> the registers and shouldnt be touched.

I'd like to point to the dpu_hw_intf_setup_timing_engine(), a close 
rival callback, setting up the INTF for video mode. It does not do RMW 
cycles, it just writes all the registers.

In the worst case, there will be a single RMW instead of having multiple 
of them.


> 
>>>
>>>>>  Similar to how dpu_hw_intf_setup_timing_engine() programs the
>>>>> hw_intf - including widebus! - for video-mode.
>>>>>
>>>>> Or even more generically, have a struct similar to intf_timing_params
>>>>> that says how the intf needs to be configured - without the caller
>>>>> knowing about INTF_CONFIG2.
>>>>>
>>>>> struct dpu_hw_intf_cfg is a very good example of how we can use a 
>>>>> single
>>>>> struct and a single callback to configure multiple registers at once
>>>>> based on some input parameters.
>>>>>
>>>>>> In addition, it seems that video mode does all its INTF_CONFIG2
>>>>>> configuration separately in dpu_hw_intf_setup_timing_engine(). If we
>>>>>> have a generic set_intf_config2() op, it might be good to have it as
>>>>>> part of a larger cleanup where we have both video and command mode 
>>>>>> use
>>>>>> the generic op. What are your thoughts on this?
>>>>>
>>>>> Not in that way, but if there is a generic enable_compression() or
>>>>> configure_compression() callback (or even more generic, similar to
>>>>> setup_intf_cfg in dpu_hw_ctl) that would work for both video-mode and
>>>>> command-mode, maybe that is beneficial.
>>>>
>>>> I'd rather not do this. Let's just 'setup timing enging' vs 'setup 
>>>> CMD'. For example, it might also include setting up other INTF 
>>>> parameters for CMD mode (if anything is required later on).
>>>>
>>>
>>> Agreed on setup CMD but I dont know whether we need a setup CMD at all.
>>> Seems like an overkill.
>>>
>>>>>
>>>>> - Marijn
>>>>
>>

-- 
With best wishes
Dmitry

