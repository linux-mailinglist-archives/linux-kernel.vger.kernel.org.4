Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B357738B84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjFUQh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjFUQhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:37:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420231BE5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:36:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f766777605so8207873e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687365398; x=1689957398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V91HdnJXsaX0PLi6by4eFkZCUR8xDSPcjyaQrOd751A=;
        b=Qh8KOKMuCq9jCpN3+pxWOUMRcma+ssgtoHyQsuO6TGppIutQdKQu6tsrZRxm/5vD1j
         c5xaA55jh45mfJ5Ksz1JaK4/3dP6phXPB8sSItILjcaHihwi+cbgYvO6WCYH8tzHw7ZP
         ohu8GHmMt8XYMri7HmKtjUffBeq3kZG7MJm0IEL1a6wkVlih8wjaUY+kaK/jFJGIrhke
         nygtNAD+r5R0TdDaCgbDGjJfuID1dRVioXrFeXzdHpHaDJUEreC8mSds6SgSkvhwDR0u
         ECIO6eB8dgnf5h7LVAm43XGyoHIOznecKu4oEsGfU7gBRYeDzYXiyPKMP70orzvVIp3w
         idng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687365398; x=1689957398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V91HdnJXsaX0PLi6by4eFkZCUR8xDSPcjyaQrOd751A=;
        b=mI2O9t3hhwht0nJqX9/szMiPSe1MUbgnrFGjkofK7vIk2Yddd8Ym+QftYlXul9lap9
         S3cB/Lg8RiAWxxDBw8TrrqPzQ1g8psMVOGrejM1eBWAtRxAiNLn+Bj+QUbcNEbWkgosp
         etvBnkgpkx+sbxfHepaNj84Mo5KjIOn4P61O6NYrrEUP1SnwnkzNJhWN2ZvYLL4+o4xA
         UPQWAXX2Qgl16PA3bCE/Sdq6vkVe+xoKJtYuBlgkF0QAPD+9GCJYK7y6fbhrdnbYamgE
         exlA0B/Rc0aYpnp1SZHis8tYWZDGVjBpOqoG+undmD+CMBgiloY/+xUv5BaVOlU8Z1yE
         Usbg==
X-Gm-Message-State: AC+VfDxSTc7PayLtdxKQf6r6mRU8rCxhmH7F8IGJXyWtD1UalGe+ijyh
        1suiqNjiHKdso8UPLXMdaRbe4w==
X-Google-Smtp-Source: ACHHUZ6dEDu85fL5mAUf/2mokFDGQqHGCVyQDKbdeNp2HIwGLClLZK2w/Hl7Mb+dn+n2XGKLgb19Tg==
X-Received: by 2002:a19:5f18:0:b0:4f3:80a3:b40a with SMTP id t24-20020a195f18000000b004f380a3b40amr10226590lfb.69.1687365398317;
        Wed, 21 Jun 2023 09:36:38 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004f85885cff1sm813463lfc.134.2023.06.21.09.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 09:36:37 -0700 (PDT)
Message-ID: <8dcd643f-9644-a4e7-a0d5-eefa28084a88@linaro.org>
Date:   Wed, 21 Jun 2023 19:36:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/msm/dpu: Set DATABUS_WIDEN on command mode
 encoders
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <26tvhvqpxtxz5tqc6jbjixadpae34k7uc7fyec2u5o2ccj4tdq@tjvguzlolc3g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 18:17, Marijn Suijten wrote:
> On 2023-06-20 14:38:34, Jessica Zhang wrote:
> <snip>
>>>>>>> +    if (phys_enc->hw_intf->ops.enable_widebus)
>>>>>>> +        phys_enc->hw_intf->ops.enable_widebus(phys_enc->hw_intf);
>>>>>>
>>>>>> No. Please provide a single function which takes necessary
>>>>>> configuration, including compression and wide_bus_enable.
>>>>>>
>>>>>
>>>>> There are two ways to look at this. Your point is coming from the
>>>>> perspective that its programming the same register but just a different
>>>>> bit. But that will also make it a bit confusing.
>>>
>>> My point is to have a high-level function that configures the INTF for
>>> the CMD mode. This way it can take a structure with necessary
>>> configuration bits.
>>
>> Hi Dmitry,
>>
>> After discussing this approach with Abhinav, we still have a few
>> questions about it:
>>
>> Currently, only 3 of the 32 bits for INTF_CONFIG2 are being used (the
>> rest are reserved with no plans of being programmed in the future). Does
>> this still justify the use of a struct to pass in the necessary
>> configuration?
> 
> No.  The point Dmitry is making is **not** about this concidentally
> using the same register, but about adding a common codepath to enable
> compression on this hw_intf (regardless of the registers it needs to
> touch).

Actually to setup INTF for CMD stream (which is equal to setting up 
compression at this point).

>  Similar to how dpu_hw_intf_setup_timing_engine() programs the
> hw_intf - including widebus! - for video-mode.
> 
> Or even more generically, have a struct similar to intf_timing_params
> that says how the intf needs to be configured - without the caller
> knowing about INTF_CONFIG2.
> 
> struct dpu_hw_intf_cfg is a very good example of how we can use a single
> struct and a single callback to configure multiple registers at once
> based on some input parameters.
> 
>> In addition, it seems that video mode does all its INTF_CONFIG2
>> configuration separately in dpu_hw_intf_setup_timing_engine(). If we
>> have a generic set_intf_config2() op, it might be good to have it as
>> part of a larger cleanup where we have both video and command mode use
>> the generic op. What are your thoughts on this?
> 
> Not in that way, but if there is a generic enable_compression() or
> configure_compression() callback (or even more generic, similar to
> setup_intf_cfg in dpu_hw_ctl) that would work for both video-mode and
> command-mode, maybe that is beneficial.

I'd rather not do this. Let's just 'setup timing enging' vs 'setup CMD'. 
For example, it might also include setting up other INTF parameters for 
CMD mode (if anything is required later on).

> 
> - Marijn

-- 
With best wishes
Dmitry

