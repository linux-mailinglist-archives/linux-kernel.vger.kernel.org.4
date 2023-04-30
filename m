Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5600B6F2896
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjD3Lag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3Lae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 07:30:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE9626AB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 04:30:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so307339966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 04:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682854231; x=1685446231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVxAbtgWt8piDuFL2bIM7+Ard0QYLwJUtfo5posTlu8=;
        b=V48CE5XksJN9W2lqT5IsiEiLKywu0Dx/veB5aLENwl02WSwESfSqDTLgSba8BnAsCB
         L+1yNbYz47h8/tFGxCNr0nuVCvrosHx1BnSLh2E2nuQtww1wdTlEpKGPlAznliqtpxQ/
         +6IV3/3CmNbLy+q1UUEzvLGQb+tOMlI0A36F2qmkeY0d5vLF+9ahsDLRnxJo6uwMuPsj
         BIMaO1TvzZ72buJEbjvkgR4qsvMp+Odn/XlG5Y7iIXBEfiXNbrRsFRz0RIbjqwf/9eEl
         TjheTQbpTCpZUB9nh2lh2T3Ts18nWlp5y5+wOvCef9anB6yvQliSBApCQubDPzR1zX9B
         0KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682854231; x=1685446231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVxAbtgWt8piDuFL2bIM7+Ard0QYLwJUtfo5posTlu8=;
        b=O/fqmI4A+o0uC0ff1DxNHg/QGBBzZHRu1jyjV4W7/XyLQXykoPvFTKNHuDAGWBmDpR
         CzKqbu22+INlTVnXSCUfmd8EeWnphEa3u6A5armnV4ft4e2NgjkN3hACJp9ULWYSwceE
         nB8GRiECc+X/FJ35kO0hfQCKiZV9o8LyVSvu/oYgQYBHeTnjiOSTzOK64aLpn49n2o3t
         gdyaI9axC6N1OXO5ZdtLo7kJmokHaH/f536XqumRq9tQMjUSaeA/xDqPBvm1r+zUOpU6
         T9rSo54G9HAa9QAvTZ2yUEjnr5Im6w/9ufvxy1201RB7PMV9E1TNGEr0bwt+ddwLqHxT
         tlKg==
X-Gm-Message-State: AC+VfDzh5uePuLAA98WgelLGKyNfMLCnM3ifNXRQDoTnJktqa+LDrtVX
        I1mwrpiMMseSSlfm5x/ylSVm6Q==
X-Google-Smtp-Source: ACHHUZ7mIWoKHzDSU5Di+4SWLZ6PKI098SuYW2eCN4UKMZ0F2zinCJrzHMsaioh3L9kOGWNKFNJDeQ==
X-Received: by 2002:a17:907:368d:b0:953:1f45:3ced with SMTP id bi13-20020a170907368d00b009531f453cedmr9744583ejc.8.1682854231272;
        Sun, 30 Apr 2023 04:30:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4f23:e9a6:a1cf:ebd3? ([2a02:810d:15c0:828:4f23:e9a6:a1cf:ebd3])
        by smtp.gmail.com with ESMTPSA id o9-20020a1709064f8900b0094f3b18044bsm13473230eju.218.2023.04.30.04.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 04:30:30 -0700 (PDT)
Message-ID: <c981e048-8925-deba-6916-9199844976b9@linaro.org>
Date:   Sun, 30 Apr 2023 13:30:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 09/43] dt-bindings: watchdog: add DT bindings for Cirrus
 EP93x
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-10-nikita.shubin@maquefel.me>
 <00882340-477b-dc0b-d489-94efdf045f1c@linaro.org>
 <cb0b1779a8bd18212439f9baf70fdb183c9f0fc7.camel@maquefel.me>
 <e73cec19-9ac8-bee2-8c28-c7a40b929e53@linaro.org>
 <c74d958aa1ea38f61cd1db965dce3cadbff530b5.camel@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c74d958aa1ea38f61cd1db965dce3cadbff530b5.camel@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2023 19:42, Nikita Shubin wrote:
> On Fri, 2023-04-28 at 14:20 +0200, Krzysztof Kozlowski wrote:
>> On 28/04/2023 16:33, Nikita Shubin wrote:
>>> Hello Krzysztof!
>>>
>>> On Tue, 2023-04-25 at 11:31 +0200, Krzysztof Kozlowski wrote:
>>>> On 24/04/2023 14:34, Nikita Shubin wrote:
>>>>> This adds device tree bindings for the Cirrus Logic EP93xx
>>>>> watchdog block used in these SoCs.
>>>>>
>>>>> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>>>>> ---
>>>>>  .../bindings/watchdog/cirrus,ep93xx-wdt.yaml  | 38
>>>>> +++++++++++++++++++
>>>>>  1 file changed, 38 insertions(+)
>>>>>  create mode 100644
>>>>> Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-
>>>>> wdt.yaml
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-
>>>>> wdt.yaml
>>>>> b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-
>>>>> wdt.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..f39d6b14062d
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-
>>>>> wdt.yaml
>>>>> @@ -0,0 +1,38 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id:
>>>>> http://devicetree.org/schemas/watchdog/cirrus,ep93xx-wdt.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Cirrus Logic EP93xx Watchdog Timer
>>>>
>>>> EP93xx is no EP9301. This does not match your compatible list.
>>>> You
>>>> should probably list all of your devices. With or without
>>>> compatibility
>>>> between them (so with a generic fallback for example).
>>>
>>> I will rename file to cirrus,ep9301-wdt.yaml, all ep93xx SoC family
>>> has
>>> the same watchdog, so there is now reason for other compatible i
>>> think.
>>
>> You should always have dedicated compatibles, even if using one
>> fallback.
>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
> 
> Krzysztof, sorry to bother you - but i don't quite get, what we should
> have in compatibles ? 
> 
> Should i make an additional fallback compatible like "cirrus,ep-wdt"
> and then "compatible" will look like:
> 
> properties:
>   compatible:
>     - items:
>       - enum:
>         - cirrus,ep9301-wdt
>       - const: cirrus,ep-wdt
> 
> Or should i describe every ep93xx SoC variant like:
> 
> properties:
>   compatible:
>     - items:
>       - enum:
>         - cirrus,ep9302-wdt
>         - cirrus,ep9307-wdt
>         - cirrus,ep9312-wdt
>         - cirrus,ep9315-wdt
>       - const: cirrus,ep9301-wdt

This one is preferred. Just don't forget for an entry allowing 9301
alone (and everything within oneOf)

Syntax looks like:

https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L31

> 
> There are ep9301, ep9302, ep9307, ep9312 and ep9315 SoC variants - all
> have the same watchdog and rtc implementation without any difference at
> all.

We still prefer to have dedicated compatible, in case some
bugs/differences are found.

> 
> If on of this is true does the same applies to ep9301-rtc and any other
> variants where we do have a single compatible ?

Yes, please.


Best regards,
Krzysztof

