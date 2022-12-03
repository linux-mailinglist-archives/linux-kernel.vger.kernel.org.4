Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513AE641607
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLCKoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLCKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:44:08 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B30C43AE9
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 02:44:07 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id bn5so8088610ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 02:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VA6bgdS0eWxkTgT0XZ0SoXlx4jS/fw585JN+2qGw6LU=;
        b=JkYod0TCwxV83odqnX1BI8Nd4HLmNhA21w18fCZuPeRbW5BF5gMZRsztxQU2yxZD15
         IX9JscIQJHdBEqSDz8WdAofRaFs7XY6Fz6i/Cbg/APN/Zwn3hXSF7hnsuuTlpgs4ilvy
         sQ61VmIBiuT+Eeo1L9VHIFTQN8FM2AWk+Xt/ADvxRx4tRdL4gFQrNNp6Vc4xCa4Cr6ak
         JEeS9QKFoi945AMiu/kZCPpMTiKxkMv69T5rYg78v8u77IDwHc3FzDW2F8pS6NgMG2QM
         erl2d6HprOJNtkdR/rLHHhfarJHm3/skPewUDi+6Yz5UtM3Qt4wFlKTGYj7PkraXy8oy
         zTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VA6bgdS0eWxkTgT0XZ0SoXlx4jS/fw585JN+2qGw6LU=;
        b=6r/N/J0q0DWHwNZLqtbwpvoMsYokccuEm8tNMY1rbM/pUQ35jBj+PEP7pBeD7iepE+
         zUEb2iwqSaeWDfwdbgxRvHALM5/oMtSsy/iT3m/U1Fx43xnRfDa/PWPmHvoObJoARmww
         u6P2pa8ueQpMo4h56O86jnRWu1cqnKGh3ETBF38Ayz/k7dmnuMdE99VPe+gzHwBCmFwx
         lOqVEv3HBUPX5N2NjADbVPhusTkhLFUkfgRZy0Ar+ZUjuJ3neWyPpxwP8ILrWYJS9Th+
         0h8b0vl+xGa1m48sycIxhxWNJ6Xw9tnxgvPmOweql4IYCYiqr6kbgpbLZvwGSr1zMfmK
         mTTw==
X-Gm-Message-State: ANoB5pmTbpxwhQouxjtyt8y273gQbpRhpq573xQ+Cz4f+A/8tfbrkwKx
        O/dFO4p/GTyHk2Zk26nOqux9OA==
X-Google-Smtp-Source: AA0mqf65bteWp/5x2VGymOoQTMXDSV6uq3dkYvxgSK7hCEwsZMR8HN1bOyqzRgWw+dQpYM/+lHc/tg==
X-Received: by 2002:a2e:a0c2:0:b0:279:95c2:c154 with SMTP id f2-20020a2ea0c2000000b0027995c2c154mr12495316ljm.44.1670064245500;
        Sat, 03 Dec 2022 02:44:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c24-20020a056512239800b004b40c1f1c70sm1351910lfv.212.2022.12.03.02.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Dec 2022 02:44:04 -0800 (PST)
Message-ID: <f4c98f85-a39a-77ff-3b69-e461f482fee7@linaro.org>
Date:   Sat, 3 Dec 2022 11:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/2] dt-bindings: leds: add binding for aw200xx
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Martin Kurbanov <MMKurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
 <20221124204807.1593241-2-mmkurbanov@sberdevices.ru>
 <bb12ea88-b416-7e32-93b9-730b6f009b98@linaro.org>
 <0a9e7d65-4ad7-b753-ec9b-8e58a549b5db@sberdevices.ru>
 <620b19f5-2202-21a5-7e3b-816dcd42d1b4@linaro.org>
 <20221202185308.zh5kesfxvyrco2cr@CAB-WSD-L081021>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202185308.zh5kesfxvyrco2cr@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 19:53, Dmitry Rokosov wrote:
> Hello Krzysztof,
> 
> On Fri, Dec 02, 2022 at 05:41:37PM +0100, Krzysztof Kozlowski wrote:
>> On 28/11/2022 18:43, Martin Kurbanov wrote:
>>> Hi. Thank you for quick reply. 
>>>
>>> On 25.11.2022 11:29, Krzysztof Kozlowski wrote:
>>>>> +
>>>>> +  imax:
>>>>> +    maxItems: 1
>>>>> +    description:
>>>>> +      Maximum supply current, see dt-bindings/leds/leds-aw200xx.h
>>>>
>>>> No. Use existing properties from common.yaml. This looks like
>>>> led-max-microamp and it is per LED, not per entire device.
>>>
>>> The AW200XX LED chip does not support imax setup per led.
>>> Imax is the global parameter over the all leds. I suppose, it's better
>>> to add vendor prefix or take minimum from all subnodes?
>>> How do you think?
>>
>> Have in mind that led-max-microamp is a required property in some cases,
>> so skipping it and using per-device properties does not solve the
>> problem of adjusting proper currents. What if each LED you set for
>> something which in total gives more than your imax?
>>
> 
> You are right. From my point of view too, we must build our solutions from
> HW capabilities. 

And there was no proposal to go around HW capabilities. We talk only
about representation.

> In the current situation, AW200XX chips support global
> Imax value, so it's acceptable decision to use vendor prefix for global
> imax parameter, why not?

Jacek made his statement some time ago quite clear:

https://lore.kernel.org/all/5785F17D.3010108@samsung.com/

"If you question the idea of having different maximum brightness per
sub-LEDs controlled by the same device, then it means that you have
objections to the entire idea of LED subsystem max_brightness property,
whereas it has been broadly accepted and successfully used for years."

Best regards,
Krzysztof

