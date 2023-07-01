Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE61744813
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGAIfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjGAIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:35:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD3ABC
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:35:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so4327094e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688200501; x=1690792501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmyMg2G+EEDiO35MdO/CXry6h0X0pw99+yWSxYKFfbI=;
        b=Vr4Ghuv+Mv6id9gWUhOnC5E8Uwwt4IdgunWijK80oHiTwWIFYfNXLbwkorghenzsSE
         KDecY8a52s/kBHdx+vpCB/MJ9kogFeTX8eYwccfUHuSLRHBUhH4QtyyfNWOMUludHdYT
         ADB6wMuG5EGpJkQ0SLvgJAjtOxx48d//AlNQFCzIo/XXbtacGPxNG1/FtdnafX3iBI3S
         B1H95Az8rW+YJKGWx03TQRzjhVPIZcu9Zm6wcG3D6RjW94N2ZAMENbitJrLLl2PzIR1G
         +GQJp3KLVWxuBAygOLoJFpZERuu//6+rLyW3mpwXjeXjNKwUHd432f6we+U5YYi1zY/a
         EFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688200501; x=1690792501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmyMg2G+EEDiO35MdO/CXry6h0X0pw99+yWSxYKFfbI=;
        b=Ishd/KZTNW++HB/fC4WboHu3rN/IRVtA4u6ermJ7CuqKKsBLolpahZSvVAPNeIm5Da
         CN/9L/LIHJVqJr8TrmBiCjaet28CtiWNFAjIxvtvjiCzUh9UM5A5pHYtU9/M9fV+HtRe
         QcE12NWFWtVrw8UpBtsUn6/G+hC7zspzoNY72I9xFqxEFvwLE3uNE2jpVDvmHdv7+wMu
         jfZfKB9S46LwznhIxVe3E7RV9mKbNChpjrYVVGNPmOdUdKFxxeKikKxZ1dSurzjhv2OD
         aE5ekg4yLZnWz5Ps7AVNyNaqF3g/Fz6o0VClP79TcQYUsKpl0Vu01PVzFZep1nQV4MaN
         Q2Pw==
X-Gm-Message-State: ABy/qLajD00YTnmhIx/KPQJ1GqzuTNPOUnFrxVuY51lwmHF/hymXlFbK
        hLu+fyQnvbZjOpjc6Bvlc9MV0A==
X-Google-Smtp-Source: APBJJlHVg9JKcSsO5f+mwwC7HASqtysYpfW76+fV4zT00bVtxqiuYX4ByGC/rgovc8P5HkKUIELRyg==
X-Received: by 2002:a05:6512:3443:b0:4fb:89c1:c209 with SMTP id j3-20020a056512344300b004fb89c1c209mr3410752lfr.62.1688200501393;
        Sat, 01 Jul 2023 01:35:01 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id q7-20020aa7d447000000b005183ce42da9sm7521126edr.18.2023.07.01.01.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:35:00 -0700 (PDT)
Message-ID: <6ad6d7d1-3626-fe79-6b4c-b7dde2b97860@linaro.org>
Date:   Sat, 1 Jul 2023 10:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] dt-bindings: pps: pps-gpio: introduce capture-clear
 property
Content-Language: en-US
To:     "Farber, Eliav" <farbere@amazon.com>, giometti@enneenne.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ronenk@amazon.com, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com
References: <20230625142134.33690-1-farbere@amazon.com>
 <20230625142134.33690-3-farbere@amazon.com>
 <4244c92d-2079-e3d9-44c8-8e5593d093a5@linaro.org>
 <7d2fa941-8c3e-d99a-f556-ac9c11b500d8@amazon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7d2fa941-8c3e-d99a-f556-ac9c11b500d8@amazon.com>
Content-Type: text/plain; charset=UTF-8
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

On 28/06/2023 10:47, Farber, Eliav wrote:
> On 6/25/2023 6:46 PM, Krzysztof Kozlowski wrote:
>> On 25/06/2023 16:21, Eliav Farber wrote:
>>> Add a new optional "capture-clear" boolean property.
>>> When present, PPS clear events shall also be reported.
>>>
>>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>>> ---
>>>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 4 ++++
>>
>> Please convert the bindings to DT schema first.
> I will convert to DT schema first, if I indeed end up modifying this file.
> 
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt 
>>> b/Documentation/devicetree/bindings/pps/pps-gpio.txt
>>> index 9012a2a02e14..8d588e38c44e 100644
>>> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
>>> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
>>> @@ -14,6 +14,10 @@ Additional required properties for the PPS ECHO 
>>> functionality:
>>>  Optional properties:
>>>  - assert-falling-edge: when present, assert is indicated by a 
>>> falling edge
>>>                         (instead of by a rising edge)
>>> +- capture-clear: when present, report also PPS clear events, which 
>>> is the
>>> +                 opposite of the assert edge (if assert is 
>>> rising-edge then
>>> +                 clear is falling-edge and if assert is falling-edge 
>>> then
>>> +                 clear is rising-edge).
>>
>> Why this is board-dependant? Falling edge is happening anyway, so it is
>> in the hardware all the time. DT describes the hardware, not Linux
>> driver behavior.
> Falling edge of the pulse is happening all the time, but the falling
> edge event is currently never reported by the pps-gpio driver.
> 
> It is because there is no place in the pps-gpio driver that sets
> info->capture_clear, so
>    pps_event(info->pps, &ts, PPS_CAPTURECLEAR, data);
> will never be called.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pps/clients/pps-gpio.c?h=v6.4#n59
> 
> There was an option in the past to set info->capture_clear, but that
> option was removed in commit ee89646619ba ("pps: clients: gpio: Get rid
> of legacy platform data").

I know the history and question was not about it. You add DT support, so
whatever board files were doing, does not matter really.

> 
> This node in the DT isn't a pure HW device, but rather a SW driver.
> The patch I shared allows to set capture-clear from device-tree same as
> setting of assert-falling-edge is done.

The binding still describes actual hardware - there is a system with a
PPS signal on a GPIO.

Your reasoning for this property is because you need it:
"It is because there is no place in the pps-gpio driver that sets"
With this approach we would need to accept every weird or bogus
property, because someone needs it for the driver.

Bindings are for the hardware, even if the concept is a bit more
software-driven.

> 
> Do you suggest I enable capture_clear in a different way?
> Perhaps module-param?

module params are also disliked, so usually the answer for non-hardware
properties is sysfs ABI.

Whether this is hardware property or not, I don't know. You did not
provide rationale supporting it, so I tend to look at this as candidate
for sysfs.

> 
>> What's more, your property name sounds a lot like a driver property, so
>> even if this is suitable for DT, you would need to name it properly to
>> match hardware feature/characteristic.
> I chose capture-clear as a name since it is aligned with the driver's
> terminology. It sets the capture_clear parameter, just like
> assert-falling-edge in DT sets assert_falling_edge parameter.

Sure, poor examples like to multiply. For assert-falling-edge, it looks
like some fake property was added instead of using proper, existing
properties indicating the polarity of GPIO and/or type of interrupt
(rising/falling edge).

Best regards,
Krzysztof

