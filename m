Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6DB6F1799
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346023AbjD1MVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240226AbjD1MVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:21:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D62619B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:21:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f6401ce8f8so6156688f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682684459; x=1685276459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QpeQU6IkVIN1ly6E38pITYrefuVTR9SPX5jEk0qIoZ0=;
        b=iSawk03mpSiV7zoQBTgeXzmXjgORfLHbHFibARf9aeo38ta85qN/jTLCKS6i16XuHE
         wDGNEExr3DS6IuUR67EMK/Ymt33gDLK0koSvgxc/qCy9Lx1vZW5s4LTJ8c00ogIwlD2a
         jX1buqNtxCRFRb13C1BaUG7XibeILanBuf1Jm3RyX4xcD60iDy/syw5LRPXBaqGx6t2Q
         JgKEh0q1gAkM5MSk9uQtEB9Afuvtpb8wE1xvA8ewRXcfygOXhe5BkkB2geM/pp1q2jIf
         +kPu7brB+r0CQ+1fs7Td4uE1WzbEpGvp90Oe2eJiK4soHlNxLPm5cznJWACAsKJO2CsD
         9AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682684459; x=1685276459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpeQU6IkVIN1ly6E38pITYrefuVTR9SPX5jEk0qIoZ0=;
        b=WrF4GH90gg2lhpNjMfuLfrMosCFaU8dLZQ4vNgD7kgvcrsGxWfjnE0LlbinelBh563
         AK4iClL80wRsQvYdRPnCaydsaHxANBLHnK4XD38pnTq2tejv3HxdcrwFuWArzsA5uX+3
         Vp5WY0TveQU1Ugi1oM5hPFkJNsPRIouKaADNCmq3vcDqj3dFYjsGpVm3bFFVsyyyeP1P
         kqotHykG85ZdWKi58huQYzhc1bwzRGoV7poKGoCHXMW79hzqj9X2TSz6sOB4Cy2uG13a
         tO0+3DvO2Dnxwjst6PVDg7ZaglHe7PNViRznpS6LG0K5Giq0IT5UcbrCn7BikoBp3YgW
         Jv5g==
X-Gm-Message-State: AC+VfDyAyqNaZgPXPAXQAo/9Hdtap9kDw7DaGPrBz8+ZWcpMahFVf5Jx
        cjhEnkMIoJCiSFzhhVwvDHYdHw==
X-Google-Smtp-Source: ACHHUZ6rsPO6wDlFQzENrINCgsq67v79X8zDwqpmHyUTSf6dwPi4DygquY3+5uJxS0R/2QopMOXwVw==
X-Received: by 2002:adf:f94f:0:b0:2f9:1224:2475 with SMTP id q15-20020adff94f000000b002f912242475mr3388938wrr.68.1682684459639;
        Fri, 28 Apr 2023 05:20:59 -0700 (PDT)
Received: from [172.23.2.142] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d56ca000000b002c54c9bd71fsm20979563wrw.93.2023.04.28.05.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 05:20:59 -0700 (PDT)
Message-ID: <e73cec19-9ac8-bee2-8c28-c7a40b929e53@linaro.org>
Date:   Fri, 28 Apr 2023 14:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cb0b1779a8bd18212439f9baf70fdb183c9f0fc7.camel@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2023 16:33, Nikita Shubin wrote:
> Hello Krzysztof!
> 
> On Tue, 2023-04-25 at 11:31 +0200, Krzysztof Kozlowski wrote:
>> On 24/04/2023 14:34, Nikita Shubin wrote:
>>> This adds device tree bindings for the Cirrus Logic EP93xx
>>> watchdog block used in these SoCs.
>>>
>>> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>>> ---
>>>  .../bindings/watchdog/cirrus,ep93xx-wdt.yaml  | 38
>>> +++++++++++++++++++
>>>  1 file changed, 38 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
>>> b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
>>> new file mode 100644
>>> index 000000000000..f39d6b14062d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-
>>> wdt.yaml
>>> @@ -0,0 +1,38 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id:
>>> http://devicetree.org/schemas/watchdog/cirrus,ep93xx-wdt.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Cirrus Logic EP93xx Watchdog Timer
>>
>> EP93xx is no EP9301. This does not match your compatible list. You
>> should probably list all of your devices. With or without
>> compatibility
>> between them (so with a generic fallback for example).
> 
> I will rename file to cirrus,ep9301-wdt.yaml, all ep93xx SoC family has
> the same watchdog, so there is now reason for other compatible i think.

You should always have dedicated compatibles, even if using one fallback.
https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

Best regards,
Krzysztof

