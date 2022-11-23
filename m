Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18516360CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiKWN7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbiKWN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:59:03 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C917D86
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:53:25 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l8so21419576ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VykN1snra/zat50du/sylTDkAQWFbkUpGcISFnpSrU=;
        b=hm+OicoABUCzeGO4J90aIWK3PrBVZi1AR1xQVX+WFNj9MBQgBA/Yu7+KiL7nuQ0JFb
         3/wyfmSxIxGXg2vewYYQbCBQziJzWmPjWaqKvI1GqZTpye+xEDYJ41m09R4c8Zz2ly1o
         +hKCr9XK2ksI+I0QgaMFDrm6Q2jnYLvMFSUPlh+zbjRb48P4vGqNsAU4avjYlptZNfpF
         /Pn0MfQqDNa0rRPTuO9lqixL05eYwpvcwZ/enKe2oSpothxorIHnWjP4qzGuIK2A69Wo
         QB6VtT5AtwWlAkkbizibYXc1an1xtBMkO5GEFFdQ7E3KDdScD4YFaFVJZG1Hcd8DhSwf
         tXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VykN1snra/zat50du/sylTDkAQWFbkUpGcISFnpSrU=;
        b=KTY1ABWrIeEwasf3BVnAGX9ZXmhRrgsEztgHY4G9p3w/J0yXxkENV2ey1HPG6jvDca
         BQYCgsAmZ26F0L0KekjNyePZKq3kubyMOc/rWQs/zm5XJrhTvICPiYi370vfK+/zqDgZ
         l1DPca5/240GIahYFNZbSKy7j8b95Oal8Eaapp90FzDktAy2/7c4yCSdkMF/c+qzYw+8
         /6DM9OXyl00hvHd+MkxDbmhGbbaMK3MWFSd/xWHeXzPQrQK3upQxLkmkj22yF4wanA1+
         DPpWwu9ZOzMlTrttPxKqimQMQhod1ZVOx1CmMFxlg/I87pdW5EzOWoLYZS9h3yVW2wAS
         LEfg==
X-Gm-Message-State: ANoB5pnATI4mARXGwcbOdAkgtmwvTni+fWzqbqz5gMzFz17JVQuoFyYU
        1+AK1x5GjYs9zrUUyy0XHrWaqQ==
X-Google-Smtp-Source: AA0mqf42fVDI2ExqDatFsEhnBlEbgKZEiziqkEdy1zQzU5b7c/G49NbrIU/GTUeInCPlx+AsTZTnMw==
X-Received: by 2002:a05:651c:1603:b0:26d:d603:8df2 with SMTP id f3-20020a05651c160300b0026dd6038df2mr8342363ljq.189.1669211603831;
        Wed, 23 Nov 2022 05:53:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i5-20020a0565123e0500b004978e51b691sm2917378lfv.266.2022.11.23.05.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 05:53:23 -0800 (PST)
Message-ID: <5b7176b4-d7a2-c67f-31c6-e842e0870836@linaro.org>
Date:   Wed, 23 Nov 2022 14:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V5 1/4] clk: meson: S4: add support for Amlogic S4 SoC PLL
 clock driver and bindings
Content-Language: en-US
To:     neil.armstrong@linaro.org, Yu Tu <yu.tu@amlogic.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eb56ed39-cfaa-3368-a2c0-0a4e89440e40@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 23/11/2022 14:23, Neil Armstrong wrote:
> Hi,
> 
> On 23/11/2022 12:16, Yu Tu wrote:
>> Hi Krzysztof,
>>      Thank you for your reply.
>>
>> On 2022/11/23 18:08, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 23/11/2022 03:13, Yu Tu wrote:
>>>> Add the S4 PLL clock controller found and bindings in the s4 SoC family.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>   .../bindings/clock/amlogic,s4-pll-clkc.yaml   |  51 +
>>>
>>> This is v5 and still bindings are here? Bindings are always separate
>>> patches. Use subject prefixes matching the subsystem (git log --oneline
>>> -- ...).
>>>
>>> And this was split, wasn't it? What happened here?!?
>>
>> Put bindings and clock driver patch together from Jerome. Maybe you can read this chat history.
>> https://lore.kernel.or/all/1jy1v6z14n.fsf@starbuckisacylon.baylibre.com/
> 
> Jerome was asking you to send 2 patchsets, one with :
> - bindings in separate patches
> - drivers in separate patches
> and a second with DT changes.
> 
> Then when the bindings + clocks patches are merged, a pull request of the bindings
> can be done to me so I can merge it with DT.
> 
>>
>>>
>>>
>>>>   MAINTAINERS                                   |   1 +
>>>>   drivers/clk/meson/Kconfig                     |  13 +
>>>>   drivers/clk/meson/Makefile                    |   1 +
>>>>   drivers/clk/meson/s4-pll.c                    | 875 ++++++++++++++++++
>>>>   drivers/clk/meson/s4-pll.h                    |  88 ++
>>>>   .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |  30 +
>>>>   7 files changed, 1059 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>>   create mode 100644 drivers/clk/meson/s4-pll.c
>>>>   create mode 100644 drivers/clk/meson/s4-pll.h
>>>>   create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>> new file mode 100644
>>>> index 000000000000..fd517e8ef14f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>> @@ -0,0 +1,51 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-pll-clkc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Amlogic Meson S serials PLL Clock Controller
>>>> +
>>>> +maintainers:
>>>> +  - Neil Armstrong <narmstrong@baylibre.com>
>>>> +  - Jerome Brunet <jbrunet@baylibre.com>
>>>> +  - Yu Tu <yu.hu@amlogic.com>
>>>> +
>>> One blank line.
>>
>>   I will delete this, on next version patch.
>>
>>>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: amlogic,s4-pll-clkc
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: xtal
>>>> +
>>>> +  "#clock-cells":
>>>> +    const: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - "#clock-cells"
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    clkc_pll: clock-controller@fe008000 {
>>>> +      compatible = "amlogic,s4-pll-clkc";
>>>> +      reg = <0xfe008000 0x1e8>;
>>>> +      clocks = <&xtal>;
>>>> +      clock-names = "xtal";
>>>> +      #clock-cells = <1>;
>>>> +    };
>>>
>>>
>>>> +#endif /* __MESON_S4_PLL_H__ */
>>>> diff --git a/include/dt-bindings/clock/amlogic,s4-pll-clkc.h b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>> new file mode 100644
>>>> index 000000000000..345f87023886
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>
>>> This belongs to bindings patch, not driver.
>>>
>>>> @@ -0,0 +1,30 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>>> +/*
>>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>>> + * Author: Yu Tu <yu.tu@amlogic.com>
>>>> + */
>>>> +
>>>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
>>>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
>>>> +
>>>> +/*
>>>> + * CLKID index values
>>>> + */
>>>> +
>>>> +#define CLKID_FIXED_PLL            1
>>>> +#define CLKID_FCLK_DIV2            3
>>>
>>> Indexes start from 0 and are incremented by 1. Not by 2.
>>>
>>> NAK.
>>
>> I remember Jerome discussing this with you.You can look at this submission history.
>> https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
> 
> Historically we did that by only exposing part of the numbers, controlling which
> clocks were part of the bindings.
> 
> But it seems this doesn't make sens anymore, maybe it would be time to put all the
> clock ids in the bindings for this new SoC and break with the previous strategy.

So the outcome of the previous discussion was somewhere later in that
thread:

> It is just a choice to not expose some IDs.
> It is not tied to the implementation at all.
> I think we actually follow the rules and the idea behind it.


Best regards,
Krzysztof

