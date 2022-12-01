Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7763EB41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLAIgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLAIgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:36:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C487877412
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:36:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y16so1514245wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oe1Bt00SWfWmsnndQyeMXHNrSaSoX25OpopVJE/Lc9A=;
        b=OUSIo1Z9bjA/LEqX2ib7YZAjnxawUT0Ps+MJgPB83SwRoQlrUz7B6KRXYiMKlIzXu2
         ayaWvgZj6bB4ftam8Q8r13tFDJgqeWbipn8rRN60tQ6W7xLBS0s1yL1TR13CRGJ8J7Bo
         p9W95XtBJs4yydI5UFjy6bgqlxhiPzyowbFlIW8IWGdhdryd7OAhqrKMAaYlkxDiWNT8
         YKO09Dn/wdHHI9UMLLCPOFz8jpQP5DtOBWBUl9QjPETBWogHdSrBqWVJ3b5Y9QK85F/7
         heM2uEH07z0cIC9AG7u847zmr/7keZSJAcWZhszEr4x1L2oRn4rd0AbAdchaYtl1CBZF
         58KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oe1Bt00SWfWmsnndQyeMXHNrSaSoX25OpopVJE/Lc9A=;
        b=3TQOiOH/NpWz75/XfEX+WQOY134awvkTXb3s6knOsWaf5ppP6PBj7vF+8OeaDTZerC
         v0ruBlsbhzCzQuuS985fm3vhNHD12uKRnlgF6VDPQr5cxnWTluQEEIGDYza1oajKXBy0
         rmAFN31sR5E8my4AMFrGSk5fua68PXRV4Z3L8apPhpKpmqnG4zlgZRAhSMlgxEbqddck
         W2UGik3wOSrMT+rkRapIgYYmyWrHcFQcFiaipx1qESrTlxkcLTnbm0YwAmryaRgVz72E
         56cCR1QRsAlh0aikENtjqlsFBWQ9VfUgKeI6LN5gb/IKSreCVWETCC3fdEFBWMUAMMtF
         x77w==
X-Gm-Message-State: ANoB5pkWIg73hgoPOmPNE6xTHlcwNm+w+eVRgAtqJzzFLFoqtQZXTs/9
        sB9/jXVRZVw59YILtbNKg7qeWw==
X-Google-Smtp-Source: AA0mqf5mmeh5ZFnMWkb3HXAwM+p4TLFW/xcDaquaExg0QjuHkTof1pA4eToIeh/1AVNSGzM+/WMw3A==
X-Received: by 2002:a05:6000:83:b0:242:4a6:5baa with SMTP id m3-20020a056000008300b0024204a65baamr18636338wrx.102.1669883803159;
        Thu, 01 Dec 2022 00:36:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bec0:73a:70e1:228f? ([2a01:e0a:982:cbb0:bec0:73a:70e1:228f])
        by smtp.gmail.com with ESMTPSA id a13-20020adfed0d000000b0024219b1cb1bsm3751749wro.60.2022.12.01.00.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 00:36:42 -0800 (PST)
Message-ID: <60c8352f-81c6-72b2-6340-1d866c259937@linaro.org>
Date:   Thu, 1 Dec 2022 09:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V5 1/4] clk: meson: S4: add support for Amlogic S4 SoC PLL
 clock driver and bindings
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
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
 <5b7176b4-d7a2-c67f-31c6-e842e0870836@linaro.org>
 <1jfse72wqk.fsf@starbuckisacylon.baylibre.com>
 <a6cf1b3f-259d-44b7-8a9a-2a0cd29c714b@amlogic.com>
 <1jedtnp7db.fsf@starbuckisacylon.baylibre.com>
 <29f06ea8-3795-46a4-fcd2-3f0d4c313ae7@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <29f06ea8-3795-46a4-fcd2-3f0d4c313ae7@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 14:30, Yu Tu wrote:
> Hi Jerome ,
> 
> On 2022/11/28 20:33, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>>
>> On Mon 28 Nov 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:
>>
>>> Hi Jerome,
>>>     Thank you for your reply.
>>>
>>> On 2022/11/25 17:23, Jerome Brunet wrote:
>>>> [ EXTERNAL EMAIL ]
>>>> On Wed 23 Nov 2022 at 14:53, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>>> On 23/11/2022 14:23, Neil Armstrong wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 23/11/2022 12:16, Yu Tu wrote:
>>>>>>> Hi Krzysztof,
>>>>>>>        Thank you for your reply.
>>>>>>>
>>>>>>> On 2022/11/23 18:08, Krzysztof Kozlowski wrote:
>>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>>
>>>>>>>> On 23/11/2022 03:13, Yu Tu wrote:
>>>>>>>>> Add the S4 PLL clock controller found and bindings in the s4 SoC family.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>>>>>> ---
>>>>>>>>>     .../bindings/clock/amlogic,s4-pll-clkc.yaml   |  51 +
>>>>>>>>
>>>>>>>> This is v5 and still bindings are here? Bindings are always separate
>>>>>>>> patches. Use subject prefixes matching the subsystem (git log --oneline
>>>>>>>> -- ...).
>>>>>>>>
>>>>>>>> And this was split, wasn't it? What happened here?!?
>>>>>>>
>>>>>>> Put bindings and clock driver patch together from Jerome. Maybe you can read this chat history.
>>>>>>> https://lore.kernel.or/all/1jy1v6z14n.fsf@starbuckisacylon.baylibre.com/
>>>>>>
>>>>>> Jerome was asking you to send 2 patchsets, one with :
>>>>>> - bindings in separate patches
>>>>>> - drivers in separate patches
>>>>>> and a second with DT changes.
>>>> Indeed, this is what was asked. It is aligned with Krzysztof's request.
>>>
>>> According to your discussion, I still should send patches in the previous
>>> way in series. But I'm going to change it like you suggested.
>>> I don't know, am I getting it right?
>>
>> 3 people tried to explain this already and we all told you the same thing.
>>
>> * 1 patchset per maintainer: clk and dt
>> * bindings must be dedicated patches - never mixed with driver code.
>>
>> I strongly suggest that you take some time to (re)read:
>> * https://docs.kernel.org/process/submitting-patches.html
>> * https://docs.kernel.org/devicetree/bindings/submitting-patches.html
>>
>> If still unclear, please take some time to look at the kernel mailing
>> list archive and see how others have done the same things.
>>
>> Thx.
> 
> I'll change it as you suggest.But I still don't understand what you suggested in V3.
> 
> I remember discussing it with you at V3.
> https://lore.kernel.or/all/1jy1v6z14n.fsf@starbuckisacylon.baylibre.com/
> 
> ">>>> Also it would be nice to split this in two series.
>  >>>> Bindings and drivers in one, arm64 dt in the other. These changes goes
>  >>>> in through different trees.
>  >>> At present, Bindings, DTS and drivers are three series. Do you mean to put
>  >>> Bindings and drivers together? If so, checkpatch.pl will report a warning.
>  >> Yes because patches are not in yet so there is a good reason to ignore
>  >> the warning. Warning will never show up on the actual tree if the
>  >> patches are correctly ordered.
>  >
>  > I think Binding, DTS and drivers use three series and you said two series
>  > is not a big problem. Three series are recommended for checkpatch.pl, I
>  > think it should be easy for that to separate and merge。
> 
> No - There is only 2 series. 1 for the bindings and clock drivers and
> one for the DT once things are in"

Please send the following emails:

* First patchset

[PATCH V6 0/3] clk: meson: Add S4 SoC PLL and Peripheral clock controller
	[PATCH v6 1/3] dt-bindings: clock: document Amlogic S4 SoC PLL & peripheral clock controller
	[PATCH v6 2/3] clk: meson: add support for Amlogic S4 SoC PLL
	[PATCH v6 3/3] clk: meson: add support for Amlogic S4 SoC peripheral clock controller

1) will contain only .yaml and dt-bindings include
2) will only have drivers/clk/meson changes
3) will only have drivers/clk/meson changes

* Second patchset:

[PATCH v1 0/2] arm64: dts: meson: Add S4 SoC PLL and Peripheral clock nodes
	[PATCH v1 1/2] arm64: dts: meson: add S4 Soc PLL clock controller node
	[PATCH v1 2/2] arm64: dts: meson: add S4 Soc Peripheral clock controller node

1) is the patch 3 of v5 patchset
2) is the patch 4 of v5 patchset

And in the second cover letter, explain those patches comes from the previous V5 patchset
and add a link to the V6 "drivers + bindings" patchset as a dependency.

Neil
> 
>>
>>>
>>>>
>>>>>>
>>>>>> Then when the bindings + clocks patches are merged, a pull request of the bindings
>>>>>> can be done to me so I can merge it with DT.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>     MAINTAINERS                                   |   1 +
>>>>>>>>>     drivers/clk/meson/Kconfig                     |  13 +
>>>>>>>>>     drivers/clk/meson/Makefile                    |   1 +
>>>>>>>>>     drivers/clk/meson/s4-pll.c                    | 875 ++++++++++++++++++
>>>>>>>>>     drivers/clk/meson/s4-pll.h                    |  88 ++
>>>>>>>>>     .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |  30 +
>>>>>>>>>     7 files changed, 1059 insertions(+)
>>>>>>>>>     create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>>>>>>>     create mode 100644 drivers/clk/meson/s4-pll.c
>>>>>>>>>     create mode 100644 drivers/clk/meson/s4-pll.h
>>>>>>>>>     create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..fd517e8ef14f
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>>>>>>> @@ -0,0 +1,51 @@
>>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>>> +%YAML 1.2
>>>>>>>>> +---
>>>>>>>>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-pll-clkc.yaml#
>>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>>> +
>>>>>>>>> +title: Amlogic Meson S serials PLL Clock Controller
>>>>>>>>> +
>>>>>>>>> +maintainers:
>>>>>>>>> +  - Neil Armstrong <narmstrong@baylibre.com>
>>>>>>>>> +  - Jerome Brunet <jbrunet@baylibre.com>
>>>>>>>>> +  - Yu Tu <yu.hu@amlogic.com>
>>>>>>>>> +
>>>>>>>> One blank line.
>>>>>>>
>>>>>>>     I will delete this, on next version patch.
>>>>>>>
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +properties:
>>>>>>>>> +  compatible:
>>>>>>>>> +    const: amlogic,s4-pll-clkc
>>>>>>>>> +
>>>>>>>>> +  reg:
>>>>>>>>> +    maxItems: 1
>>>>>>>>> +
>>>>>>>>> +  clocks:
>>>>>>>>> +    maxItems: 1
>>>>>>>>> +
>>>>>>>>> +  clock-names:
>>>>>>>>> +    items:
>>>>>>>>> +      - const: xtal
>>>>>>>>> +
>>>>>>>>> +  "#clock-cells":
>>>>>>>>> +    const: 1
>>>>>>>>> +
>>>>>>>>> +required:
>>>>>>>>> +  - compatible
>>>>>>>>> +  - reg
>>>>>>>>> +  - clocks
>>>>>>>>> +  - clock-names
>>>>>>>>> +  - "#clock-cells"
>>>>>>>>> +
>>>>>>>>> +additionalProperties: false
>>>>>>>>> +
>>>>>>>>> +examples:
>>>>>>>>> +  - |
>>>>>>>>> +    clkc_pll: clock-controller@fe008000 {
>>>>>>>>> +      compatible = "amlogic,s4-pll-clkc";
>>>>>>>>> +      reg = <0xfe008000 0x1e8>;
>>>>>>>>> +      clocks = <&xtal>;
>>>>>>>>> +      clock-names = "xtal";
>>>>>>>>> +      #clock-cells = <1>;
>>>>>>>>> +    };
>>>>>>>>
>>>>>>>>
>>>>>>>>> +#endif /* __MESON_S4_PLL_H__ */
>>>>>>>>> diff --git a/include/dt-bindings/clock/amlogic,s4-pll-clkc.h b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..345f87023886
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>>>>>>
>>>>>>>> This belongs to bindings patch, not driver.
>>>>>>>>
>>>>>>>>> @@ -0,0 +1,30 @@
>>>>>>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>>>>>>>> +/*
>>>>>>>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>>>>>>>> + * Author: Yu Tu <yu.tu@amlogic.com>
>>>>>>>>> + */
>>>>>>>>> +
>>>>>>>>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
>>>>>>>>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
>>>>>>>>> +
>>>>>>>>> +/*
>>>>>>>>> + * CLKID index values
>>>>>>>>> + */
>>>>>>>>> +
>>>>>>>>> +#define CLKID_FIXED_PLL            1
>>>>>>>>> +#define CLKID_FCLK_DIV2            3
>>>>>>>>
>>>>>>>> Indexes start from 0 and are incremented by 1. Not by 2.
>>>>>>>>
>>>>>>>> NAK.
>>>>>>>
>>>>>>> I remember Jerome discussing this with you.You can look at this submission history.
>>>>>>> https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
>>>>>>
>>>>>> Historically we did that by only exposing part of the numbers, controlling which
>>>>>> clocks were part of the bindings.
>>>>>>
>>>>>> But it seems this doesn't make sens anymore, maybe it would be time to put all the
>>>>>> clock ids in the bindings for this new SoC and break with the previous strategy.
>>>> Krzysztof and I agreed there is nothing wrong with the current
>>>> approach, I believe.
>>>> It does not prevent someone from using an un-exposed clock, sure, or
>>>> exposing it in the future if necessary.
>>>> However, I think it clearly shows that an un-exposed element is not
>>>> expected to be used by an external consumers. It should be enough to
>>>> trigger a discussion if this expectation is wrong.
>>>>
>>>>>
>>>>> So the outcome of the previous discussion was somewhere later in that
>>>>> thread:
>>>>>
>>>>>> It is just a choice to not expose some IDs.
>>>>>> It is not tied to the implementation at all.
>>>>>> I think we actually follow the rules and the idea behind it.
>>>>>
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>> .
>>
>> .

