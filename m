Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91A733D33
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 02:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbjFQAfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 20:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjFQAfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 20:35:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046F43A9E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 17:35:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso1882880e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686962143; x=1689554143;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2TH6omPv0iR522UdJK1kb0tXN035zPLb4qVh0Ld1XM=;
        b=XBgu0GGV5zx3DH/PFgGeauOi9aSUFK2FRC13k3AMP8+X/P12cZk+wm6YoMhVKOBCR5
         5s2oIUc37wMUFAsOPg1G8vB/2pf84dufOEBSmakgTTy8dkWjVg2/OSLMG8SsZkoufsoc
         E4qDbX/caGJnc4f0pHKvJflpJNCMeyBuKWMuu85xmBFBQgWjJgwXwnwyNIcckds+wFI+
         Kk83MMtzte6Bph/LkYyE9+jzkr0rBAGV0Kn3pin2BP1vlvXg+E7aREHDz1Gc1oo+CXZ2
         ID6Yqs0ORZNjBPGAT96zAUZXfVMW3NN2RUKG2RxIPh1kMa0nfWSEyKUkLrM1XsQRmZj4
         xe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686962143; x=1689554143;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2TH6omPv0iR522UdJK1kb0tXN035zPLb4qVh0Ld1XM=;
        b=fzQB8O6lrmlFwEDEgDrHIPnMJqjNaOAbwLXmkGd7re79oLTnpK8tba68v465yICLLo
         Ii7mChG4kpRZkrRxKef5z1cR/kC4Hji7tj3ouFlyTzuRkFMwP4/AJufZeOldc+ujTNdB
         fZNzqGl8mfII6RweDiM+BFh8vYBStS+t7W54KmUhWEHn9kopCxDpxXaaHMkMwNrikTNd
         NR/GkpPfN5LetFcHBxLE8HbRumgDq5ZDuYbPy2eOMXz53R8BoxZ3n6wZKQOvnPX9efWV
         RtdRH4TaEacoz2bqxQo+qQs6e4l9kBo+OquCB4xrBjBrcW4sGhFsD6FJl+dA689++5tT
         pP/w==
X-Gm-Message-State: AC+VfDy501S4AClmg4R8XPI49+Vl9e8i+1n9JumQVlvaC58FNiIQL23W
        YsJFOjHthTn8RRIAX4UPUWN5ng==
X-Google-Smtp-Source: ACHHUZ7EGZ2ATBREBepfd/b8cQfB8NRUTbMYq7wOnNB6H7VrGl6KhtWaW23waE97DghoMPtMS0sdRQ==
X-Received: by 2002:a19:e01e:0:b0:4f8:4348:e000 with SMTP id x30-20020a19e01e000000b004f84348e000mr2530942lfg.13.1686962143229;
        Fri, 16 Jun 2023 17:35:43 -0700 (PDT)
Received: from [192.168.1.212] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y18-20020ac255b2000000b004eb12850c40sm3223810lfg.14.2023.06.16.17.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 17:35:42 -0700 (PDT)
Message-ID: <81a5e241-ec82-7414-8752-4ce3cb084959@linaro.org>
Date:   Sat, 17 Jun 2023 03:35:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/msm/dpu: Set DATABUS_WIDEN on command mode
 encoders
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <n2c5qlujxhbbj2aqlgj7fetzoteood5h4hmbwt4mapi77xlvmt@bpourzaideti>
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

On 17/06/2023 00:54, Marijn Suijten wrote:
> On 2023-06-16 14:18:39, Abhinav Kumar wrote:
>>
>>
>> On 6/14/2023 12:56 AM, Dmitry Baryshkov wrote:
>>> On 14/06/2023 04:57, Jessica Zhang wrote:
>>>> Add a DPU INTF op to set the DATABUS_WIDEN register to enable the
>>>> databus-widen mode datapath.
>>>>
>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  3 +++
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 12 ++++++++++++
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          |  3 +++
>>>>    3 files changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>>> index b856c6286c85..124ba96bebda 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
>>>> @@ -70,6 +70,9 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>>>>        if (intf_cfg.dsc != 0 && phys_enc->hw_intf->ops.enable_compression)
>>>>            phys_enc->hw_intf->ops.enable_compression(phys_enc->hw_intf);
>>>> +
>>>> +    if (phys_enc->hw_intf->ops.enable_widebus)
>>>> +        phys_enc->hw_intf->ops.enable_widebus(phys_enc->hw_intf);
>>>
>>> No. Please provide a single function which takes necessary
>>> configuration, including compression and wide_bus_enable.
>>>
>>
>> There are two ways to look at this. Your point is coming from the
>> perspective that its programming the same register but just a different
>> bit. But that will also make it a bit confusing.

My point is to have a high-level function that configures the INTF for 
the CMD mode. This way it can take a structure with necessary 
configuration bits.

>>
>> So lets say the function is called intf_cfg2_xxx(..., bool widebus, bool
>> data_compress)
>>
>> Now for the caller who wants to just enable widebus this will be
>>
>> intf_cfg2_xxx(....., true, false)
>>
>> if we want to do both
>>
>> intf_cfg2_xxx(...., true, true)
>>
>> the last one where we want to do just data_compress(highly unlikely and
>> not recommended)
>>
>> intf_cfg2_xxx(...., false, true)
>>
>> Now someone looking at the code will have to go and find out what each
>> bool is.
>>
>> Whereas with separate ops, its kind of implicit.
> 
> That's why you never pass bools as function argument (edge-case if it is
> the only argument, and its meaning becomes clear from the function
> name).  Use enumerations anywhere else.
> 
> - Marijn
> 
>>
>> For that reason, I dont think this patch is bad at all.

-- 
With best wishes
Dmitry

