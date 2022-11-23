Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E516360FB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbiKWOCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbiKWOCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:02:05 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE31185A37
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:57:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1347195wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dL/ms0BVBV2/oY4UScUHED3NO3FKIUaK6/18RYZuPxA=;
        b=ivgk3JNhdWzsOpo+GIpVt6LMMA7Ek5v17Dohgj/LffEcXYE5YqxhXMF2yNkL1XYbPa
         BJvQO07IqnRZf4Pp2ea7fEopixJnXeOmxbuAz4uuk6+nUkCAY8xa3rKj1PE/AtJMQNXr
         iSoC502J0s2U5ebAc7PFn5yr828ybdgyU+7ZylT/UrFxV3WKqArqA+eA0FnSuHo+02hx
         EXwDCXz8rj8CAm0ob0oM5SlhdbXKCtDDRPG4tv3pJ1zqPuhWrflK4CpSGQPQLcIEHD0J
         XiQ0XpMAdNiz/3fwbU5sOLIvsCARAOQ9/0ZxAzzpGMfQjSRLHud/32OZhGuUInh8uE0c
         jBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dL/ms0BVBV2/oY4UScUHED3NO3FKIUaK6/18RYZuPxA=;
        b=3eGV5J4Ni2+P0v57D9GhxCMnERMHFYqe9p8Awfj6D8DYQ6fOxpvhyYmXEHYdMRGbiD
         NTt2FaScWEm99ptmKBH2M5jdLhXC6nrnIYfRfpRUlnQ7Bj9jrO8u/BvWZqWn0wHddIDU
         2j/4XV1j94qv7hg/ByBsa3FgwLg3mdQbEtFIj7Dx4qwyr6Iz8GM5/8nvNUrZjfYcZ2zU
         kwgIeckJCYAYC3PvOuOFU+jo2BWPL5iUbjG9VK6a/cfp2D7mO6Aff0lG8EMAqArgt0Rx
         SGcmjNib/qSztdLlvstJfi/mjLq7Slsa4Z1X3UwN75BC3RPz3hYoDqlYZMXnnW1tJE2x
         gTNw==
X-Gm-Message-State: ANoB5pmhKKugptiLRcUY+0rBMzqJV6f6jKnwR8VGtiDFzMSFSLiqQKEE
        2kQ7f9WMqWEnqwB8S9ql+Mh2NA==
X-Google-Smtp-Source: AA0mqf4Zeq+CBUw9DBFNc5fPW9o18lGsw48Qe4aNbIyv85wr3wsW4SN5jRqHDgSwBj8zT9AvZ+0+Qg==
X-Received: by 2002:a05:600c:2e51:b0:3cf:9f01:620e with SMTP id q17-20020a05600c2e5100b003cf9f01620emr6467998wmf.15.1669211829360;
        Wed, 23 Nov 2022 05:57:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e551:24c3:152c:7c05? ([2a01:e0a:982:cbb0:e551:24c3:152c:7c05])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c4f8800b003cfd64b6be1sm2811870wmq.27.2022.11.23.05.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 05:57:08 -0800 (PST)
Message-ID: <31bdbe7b-b78a-8fc0-602b-fa11004294a7@linaro.org>
Date:   Wed, 23 Nov 2022 14:57:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V5 1/4] clk: meson: S4: add support for Amlogic S4 SoC PLL
 clock driver and bindings
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-2-yu.tu@amlogic.com>
 <f03f331a-5666-298e-a1a2-bdb9bab11a48@linaro.org>
 <92b570ea-3ddc-8e91-5a7a-ed601bb7c02c@amlogic.com>
 <eb56ed39-cfaa-3368-a2c0-0a4e89440e40@linaro.org>
 <322262b1-d3db-f190-ef69-f42d5d0522c0@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <322262b1-d3db-f190-ef69-f42d5d0522c0@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 14:54, Yu Tu wrote:
> Hi Neil,
> 
> On 2022/11/23 21:23, Neil Armstrong wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hi,
>>
>> On 23/11/2022 12:16, Yu Tu wrote:
>>> Hi Krzysztof,
>>>      Thank you for your reply.
>>>
>>> On 2022/11/23 18:08, Krzysztof Kozlowski wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On 23/11/2022 03:13, Yu Tu wrote:
>>>>> Add the S4 PLL clock controller found and bindings in the s4 SoC family.
>>>>>
>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>> ---
>>>>>   .../bindings/clock/amlogic,s4-pll-clkc.yaml   |  51 +
>>>>
>>>> This is v5 and still bindings are here? Bindings are always separate
>>>> patches. Use subject prefixes matching the subsystem (git log --oneline
>>>> -- ...).
>>>>
>>>> And this was split, wasn't it? What happened here?!?
>>>
>>> Put bindings and clock driver patch together from Jerome. Maybe you can read this chat history.
>>> https://lore.kernel.or/all/1jy1v6z14n.fsf@starbuckisacylon.baylibre.com/
>>
>> Jerome was asking you to send 2 patchsets, one with :
>> - bindings in separate patches
>> - drivers in separate patches
>> and a second with DT changes.
>>
>> Then when the bindings + clocks patches are merged, a pull request of the bindings
>> can be done to me so I can merge it with DT.
>>
> 
> I may have misunderstood Jerome's advice.So should I follow the V4 patch format and change as Jerome suggested from V3?

Let's wait for his input on this to see if a v4 is needed now or later.

> 
>>>
>>>>
>>>>
>>>>>   MAINTAINERS                                   |   1 +
>>>>>   drivers/clk/meson/Kconfig                     |  13 +
>>>>>   drivers/clk/meson/Makefile                    |   1 +
>>>>>   drivers/clk/meson/s4-pll.c                    | 875 ++++++++++++++++++
>>>>>   drivers/clk/meson/s4-pll.h                    |  88 ++
>>>>>   .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |  30 +
>>>>>   7 files changed, 1059 insertions(+)
>>>>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>>>   create mode 100644 drivers/clk/meson/s4-pll.c
>>>>>   create mode 100644 drivers/clk/meson/s4-pll.h
>>>>>   create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..fd517e8ef14f
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>>> @@ -0,0 +1,51 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-pll-clkc.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Amlogic Meson S serials PLL Clock Controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Neil Armstrong <narmstrong@baylibre.com>
>>>>> +  - Jerome Brunet <jbrunet@baylibre.com>
>>>>> +  - Yu Tu <yu.hu@amlogic.com>
>>>>> +
>>>> One blank line.
>>>
>>>   I will delete this, on next version patch.
>>>
>>>>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: amlogic,s4-pll-clkc
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: xtal
>>>>> +
>>>>> +  "#clock-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - clocks
>>>>> +  - clock-names
>>>>> +  - "#clock-cells"
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    clkc_pll: clock-controller@fe008000 {
>>>>> +      compatible = "amlogic,s4-pll-clkc";
>>>>> +      reg = <0xfe008000 0x1e8>;
>>>>> +      clocks = <&xtal>;
>>>>> +      clock-names = "xtal";
>>>>> +      #clock-cells = <1>;
>>>>> +    };
>>>>
>>>>
>>>>> +#endif /* __MESON_S4_PLL_H__ */
>>>>> diff --git a/include/dt-bindings/clock/amlogic,s4-pll-clkc.h b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>>> new file mode 100644
>>>>> index 000000000000..345f87023886
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>>
>>>> This belongs to bindings patch, not driver.
>>>>
>>>>> @@ -0,0 +1,30 @@
>>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>>>> +/*
>>>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>>>> + * Author: Yu Tu <yu.tu@amlogic.com>
>>>>> + */
>>>>> +
>>>>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
>>>>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
>>>>> +
>>>>> +/*
>>>>> + * CLKID index values
>>>>> + */
>>>>> +
>>>>> +#define CLKID_FIXED_PLL            1
>>>>> +#define CLKID_FCLK_DIV2            3
>>>>
>>>> Indexes start from 0 and are incremented by 1. Not by 2.
>>>>
>>>> NAK.
>>>
>>> I remember Jerome discussing this with you.You can look at this submission history.
>>> https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
>>
>> Historically we did that by only exposing part of the numbers, controlling which
>> clocks were part of the bindings.
>>
>> But it seems this doesn't make sens anymore, maybe it would be time to put all the
>> clock ids in the bindings for this new SoC and break with the previous strategy.
> 
> That's OK with me. But I don't know if Jerome thinks it's ok?

Let's wait for his input on that aswell.

Neil

> 
>>
>> Neil
>>
>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>> .
>>
>> .

