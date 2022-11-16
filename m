Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8862C331
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiKPP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiKPP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:56:03 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91158BF7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:55:29 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d6so30169179lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxJZcTMnZ0d8Rsb8gNwZY8DF8ihKF/f84NGyK8FI2+k=;
        b=OdkrzXZlviJotbnbYNfqAkvuWplWuARldk3To5s7pFnXd/3r98N9A4cNVBCikMwbWf
         B7v1LwzTvzJlJZMQVXWmsxnR2BvMYuvc1t7w++68g90WR52ySHXwiLiFutmbCiU9wzP8
         3AhWOySw97TIcS3tY9q65L1Jbw0eBiCe9WhM1ni1LIgOqQEoVHuyBt0ViF56w4IS6Pxt
         h7No72Gmqm+3fMn9T+fu/YHKk7ey9ZuHSMLP/CVjWZr+4o7Jczg8NPe9JVW3ooTVFfag
         zBmdZ7uxz34baQmj9gWHOklkyvKd0kzXNqXTYqZKR/43M8rqBS2GC/4fDfPITR0WTmLz
         XaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxJZcTMnZ0d8Rsb8gNwZY8DF8ihKF/f84NGyK8FI2+k=;
        b=pZ7yMZPS+xmCtYz1v+Gt4GKTZtZmnV5vj3mnjORLPFxSE1AU0z7NJHrtsbvtGe4OME
         NMC1DpIK4ra7ypedDGa7lO58YNtwmYb4gkS1qVZYNx7gD9ojCT0uLrWioWmdkg8jWCmX
         uwciQCCe0I0b/QgbfwppRjtsZq9XGhsgBknLiLV0nPDzQ//uPCmm3SnXwHSbaXXgEpvX
         BE1i/3VsGQuj1Fc5bX+hrDyj7Qq7OhqMCakwvA5BnewRiZVm4chC8oSGsEMIwjRRjDx4
         YIhIea8q4+3C+3iHX33IxhleVVU7mrfWaJE0ErEl4xcT2T+8u6r0M4TvRyKSFBZYp1Zu
         nomQ==
X-Gm-Message-State: ANoB5plx9323JYNKMgsIc14hpfFoHckRoYWNWJS33wKP+1emCdikvjG4
        UCMACxk9wzzKvOwAx4wNtP/R9A==
X-Google-Smtp-Source: AA0mqf7GsGMN50F7hT+H8jQgsK382YAdUeXB75eSqqC6j3C8P+jtqJP4ldEXggpFL79RpOksVSV1Sw==
X-Received: by 2002:a19:6449:0:b0:4ae:5dc5:82c5 with SMTP id b9-20020a196449000000b004ae5dc582c5mr8330451lfj.2.1668614128063;
        Wed, 16 Nov 2022 07:55:28 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id g3-20020a05651222c300b00497feee98basm2626991lfu.274.2022.11.16.07.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 07:55:27 -0800 (PST)
Message-ID: <dc656c7a-eab4-f547-ca52-51f7510c2858@linaro.org>
Date:   Wed, 16 Nov 2022 17:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/3] drm/msm/disp/dpu1: add helper to know if display
 is pluggable
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com
References: <1668609040-2549-1-git-send-email-quic_kalyant@quicinc.com>
 <1668609040-2549-3-git-send-email-quic_kalyant@quicinc.com>
 <e049f5b1-da41-6854-4731-b6697770ffde@linaro.org>
 <6b1907db-3fdb-8fe0-e5e3-21ea17021925@quicinc.com>
 <bf14540a-745c-c378-520a-f8edfd3e3adf@linaro.org>
 <0dd3e096-84ac-da81-ad43-bf07485e7b65@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <0dd3e096-84ac-da81-ad43-bf07485e7b65@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 18:35, Abhinav Kumar wrote:
> 
> 
> On 11/16/2022 7:18 AM, Dmitry Baryshkov wrote:
>> On 16/11/2022 18:11, Abhinav Kumar wrote:
>>>
>>>
>>> On 11/16/2022 7:08 AM, Dmitry Baryshkov wrote:
>>>> On 16/11/2022 17:30, Kalyan Thota wrote:
>>>>> Since DRM encoder type for few encoders can be similar
>>>>> (like eDP and DP) find out if the interface supports HPD
>>>>> from encoder bridge to differentiate between builtin
>>>>> and pluggable displays.
>>>>>
>>>>> Changes in v1:
>>>>> - add connector type in the disp_info (Dmitry)
>>>>> - add helper functions to know encoder type
>>>>> - update commit text reflecting the change
>>>>>
>>>>> Changes in v2:
>>>>> - avoid hardcode of connector type for DSI as it may not be true 
>>>>> (Dmitry)
>>>>> - get the HPD information from encoder bridge
>>>>>
>>>>> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
>>>>> ---
>>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 16 ++++++++++++++++
>>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
>>>>>   2 files changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c 
>>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>>>> index 9c6817b..be93269 100644
>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>>>> @@ -15,6 +15,7 @@
>>>>>   #include <drm/drm_crtc.h>
>>>>>   #include <drm/drm_file.h>
>>>>>   #include <drm/drm_probe_helper.h>
>>>>> +#include <drm/drm_bridge.h>
>>>>>   #include "msm_drv.h"
>>>>>   #include "dpu_kms.h"
>>>>> @@ -217,6 +218,21 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
>>>>>       15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
>>>>>   };
>>>>> +bool dpu_encoder_is_pluggable(struct drm_encoder *encoder)
>>>>> +{
>>>>> +    struct drm_bridge *bridge;
>>>>> +    int ops = 0;
>>>>> +
>>>>> +    if (!encoder)
>>>>> +        return false;
>>>>> +
>>>>> +    /* Get last bridge in the chain to determine pluggable state */
>>>>> +    drm_for_each_bridge_in_chain(encoder, bridge)
>>>>> +        if (!drm_bridge_get_next_bridge(bridge))
>>>>> +            ops = bridge->ops;
>>>>> +
>>>>> +    return ops & DRM_BRIDGE_OP_HPD;
>>>>
>>>> No. This is not what you should be checking (hint: polled connectors 
>>>> also can be pluggable).
>>>>
>>>> Please check the type of the actual connector connected to this 
>>>> encoder.
>>>>
>>>
>>> Even if we check the connector type as DSI or eDP that does not 
>>> necessarily mean its built-in.
>>>
>>> We can even use DSI or eDP as a pluggable display.
>>
>> Well, I don't think so. eDP and DSI connectors are not pluggable per 
>> design. One can use them so, but they are not thought to be used this 
>> way. Unlike e.g. HDMI, DP, VGA, etc.
>>
> 
> We have had many products where we used HDMI as the primary display 
> where the HPD line was disconnected in the design, so now if we 
> generalize all HDMI connectors to be pluggable we can never enable color 
> management on those even though DSI is not even used in that product.

Did they use HDMI connector internally? Or was it just a panel wired 
somehow to the HDMI pins?

If the former is true, then they still are pluggable. Even if you don't 
have a way to detect that via the HPD pin.

If the later is the case, then it shouldn't be DRM_MODE_CONNECTOR_HDMI.
Well, even if this is an internal HDMI, I'd still use some other 
connector (e.g. DRM_MODE_CONNECTOR_Unknown) just to point out that this 
is not an externally visible HDMI connector one assumes to be able to 
find on the body of the device.

Last, but not least, how would you remove DRM_BRIDGE_OPS_HPD from the 
corresponding bridge driver?


> Thats why I felt we should rely on the HPD_OPS as that way we know that 
> it will be set only if HPD will be used.
> 
> Wouldnt it be just better to also check polling displays to complete 
> this check? Is there a way to do it?


Yes, check DRM_BRIDGE_OP_DETECT. But as I noted, there is a list of 
connectors that will not ever have HPD or polling, but still always are 
external. Well, even for VGA there is no good way to detect whether it 
is plugged in or not (see the comment in display-connector.c).



>> I would say LVDS, eDP, DSI, DPI and SPI can be assumed to be 
>> constantly plugged.
>>
>> Compare this with Composite, SVIDEO, 9PinDIN, TV. They can be assumed 
>> to be external even if they do not have the HPD (or even polling). And 
>> these connectors usually don't have it.
>>
>>>
>>> Thats why we thought of this check.
>>>

-- 
With best wishes
Dmitry

