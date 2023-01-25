Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C81467AEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjAYJzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbjAYJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:55:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124B8A53
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:55:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so2187769wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3TI3QogOYMMQNqPXE2b7du3WbjaJH52c2VaulOg3Bhg=;
        b=qug77F6kd2bvCnnzdGxs88Cb4zDm8xwdWaHtW/FM+aX+u6m/7F+m7t6l5ZxBN7FxzL
         PuisldXsfLPXNBsVX6qqQnVziYE3QVHDI/XRler2igoKlFYRilQpgt9OyXLfjAupLIM/
         4G3z7l08N0VnZlHQQYWMd4shRsqfr0GVLfJWF3ZKR3YB7Zh499c61/2DZRwAkd7UFv4d
         dVvS2UUNWMqOLFG2KqFUo3/tGeWQhdbNhpXsQ8RFmsjKLQ7APzRkskXAsAwBlNBNgt3R
         sm4iTGxNQ8zkvSRX1cZh+UnEE5Dy6qHzKK2eZsmndGqrEfbtxahEtSBHJY7yE5DTEsp8
         qttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TI3QogOYMMQNqPXE2b7du3WbjaJH52c2VaulOg3Bhg=;
        b=TOUDCnvR8038OKRD2R9etGd3VFQXblF12V/Sih/hbvAA1gEFueA3h44Q+VrYWTi2kt
         9jBoJpEoodjA+5+bU6BvCgcxG0ylPJlVseP+uo6GRUoHeYFbDtE6W0ZZ0NTpt/+zgek/
         Hphy/UMDFoPxwuxDL/ftWSBoci6N3novcFYahAPn/EON14PxUjwuuDNyyLQM7CsQGSl/
         dmXImVvP9cZsxA/OKmGogO2SZH3JGWbibTSuj222es+UkdLwRL6EAkQ1IrTB9jjeYiFi
         udUO51N5ebD7cYF9jtW0Gnnjt4RIrp1msw3zGVimZ6tkUTrMcRIlt/Oqqbov2qP/+2Z2
         a1Mw==
X-Gm-Message-State: AFqh2krlIDS6epHhVMv7Oaq/CI9UygOXYs44ZMkeeX+jnGVXPFS3kVSQ
        W7+w/RIrLFZduuzmjwFzk5f2sg==
X-Google-Smtp-Source: AMrXdXu2KF4yvkw/TiJ9sngbPl4P5gsVXJvwzfHlUs9sLE0NttgDMQFlQjIghP75T8JZOp14TN7IMw==
X-Received: by 2002:a05:600c:181a:b0:3d2:2043:9cbf with SMTP id n26-20020a05600c181a00b003d220439cbfmr31125729wmp.10.1674640536570;
        Wed, 25 Jan 2023 01:55:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d6049000000b002be1dcb6efbsm4844333wrt.9.2023.01.25.01.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:55:36 -0800 (PST)
Message-ID: <b26a52ff-6b8a-8a64-7189-346cd2b0d705@linaro.org>
Date:   Wed, 25 Jan 2023 10:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add Ambarella clock bindings
To:     Li Chen <me@linux.beauty>
Cc:     Li Chen <lchen@ambarella.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-8-lchen@ambarella.com>
 <0c19efb4-3bca-f500-ca24-14b9d24369ef@linaro.org>
 <87y1prgdyu.wl-me@linux.beauty>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87y1prgdyu.wl-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 10:28, Li Chen wrote:
> 
> Hi Krzysztof,
> 
> Sorry for my late reply.
> 
> On Mon, 23 Jan 2023 16:11:08 +0800,
> Krzysztof Kozlowski wrote:
>>
>> On 23/01/2023 08:32, Li Chen wrote:
>>> This patch introduce clock bindings for Ambarella.
>>>
>>> Signed-off-by: Li Chen <lchen@ambarella.com>
>>> Change-Id: I29018a23ed3a5b79a1103e859a5c7ed7bb83a261
>>
>> All the same problems plus new:
>>
>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>> prefix is already stating that these are bindings.
> 
> Well noted.
> 
>>> ---
>>>  .../clock/ambarella,composite-clock.yaml      | 52 ++++++++++++++++
>>>  .../bindings/clock/ambarella,pll-clock.yaml   | 59 +++++++++++++++++++
>>>  MAINTAINERS                                   |  2 +
>>>  3 files changed, 113 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/ambarella,composite-clock.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/clock/ambarella,pll-clock.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/ambarella,composite-clock.yaml b/Documentation/devicetree/bindings/clock/ambarella,composite-clock.yaml
>>> new file mode 100644
>>> index 000000000000..fac1cb9379c4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/ambarella,composite-clock.yaml
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/ambarella,composite-clock.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Ambarella Composite Clock
>>> +
>>> +maintainers:
>>> +  - Li Chen <lchen@ambarella.com>
>>> +
>>
>> Missing description.
> 
> Thanks, description as below will be added in v2:
> 
> "Ambarella SoCs integrates some composite clocks, like uart0, which aggrate the functionality
> of the basic clock types, like mux and div."
> 
>>> +properties:
>>> +  compatible:
>>> +    items:
>>
>> Drop items.
> 
> Ok.
> 
>>> +      - const: ambarella,composite-clock
>>
>> Missing SoC specific compatible. This is anyway not really correct
>> compatible...
> 
> Most Ambarella's compatibles don't contain SoC name, because we prefer
> to use syscon + offsets in dts to tell driver the correct register offsets, or
> ues struct soc_device and SoC identity stores in a given physical address.

That's not correct hardware description. Drop the syscon and offsets.

> 
> So compatibles like "ambarella,composite-clock" and "ambarella,pinctrl" are
> used widely in Ambarella kernels. 

What do you do downstream does not matter. You can invent any crazy idea
and it is not an argument that it should be done like that. Usually
downstream code is incorrect...

> Feel free to correct me if you think this
> is not a good idea.

This is bad idea. Compatibles should be specific. Devices should not use
syscons to poke other registers, unless strictly necessary, but have
strictly defined MMIO address space and use it.

> 
>>> +
>>> +  clocks: true
>>
>> No, needs constraints.
> 
> Ok. I will list all clocks name
> 
>>> +  assigned-clocks: true
>>> +  assigned-clock-parents: true
>>> +  assigned-clock-rates: true
>>
>> Drop these three.
> 
> Ok
> 
>>> +  clock-output-names: true
>>
>> Missing constraints.
> 
> Ok, I will add "maxItems: 1"
> 
>>> +  amb,mux-regmap: true
>>
>> NAK.
>>
>> It's enough. The patches have very, very poor quality.
>>
>> Missing description, missing type/$ref, wrong prefix.
> 
> Sorry, I forget to run dt_binding_check, I will spend some
> time learning the binding and check, sorry for it.
> 
>>> +  amb,div-regmap: true
>>> +  amb,div-width: true
>>> +  amb,div-shift: true
>>
>> These two are arguments to phandle.
> 
> I will add description and $ref to regmap and width/shift.

Drop all these syscon properties.

> 
>>> +
>>> +  '#clock-cells':
>>> +    const: 0
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - '#clock-cells'
>>> +
>>> +additionalProperties: false
>>
>> So why you decided to add it here and not in other places?
> 
> I didn't understand it well. I will add it to other places in v2,
> thanks for pointint out it.
> 
>>> +
>>> +examples:
>>> +  - |
>>> +      gclk_uart0: gclk-uart0 {
>>
>> Wrong indentation.
> 
> Well noted.
> 
>>> +        #clock-cells = <0>;
>>> +        compatible = "ambarella,composite-clock";
>>> +        clocks = <&osc>, <&gclk_core>, <&pll_out_enet>, <&pll_out_sd>;
>>> +        clock-output-names = "gclk_uart0";
>>> +        assigned-clocks = <&gclk_uart0>;
>>> +        assigned-clock-parents = <&osc>;
>>> +        assigned-clock-rates = <24000000>;
>>> +        amb,mux-regmap = <&rct_syscon 0x1c8>;
>>> +        amb,div-regmap = <&rct_syscon 0x038>;
>>> +        amb,div-width = <24>;
>>> +        amb,div-shift = <0>;
>>> +      };
>>> diff --git a/Documentation/devicetree/bindings/clock/ambarella,pll-clock.yaml b/Documentation/devicetree/bindings/clock/ambarella,pll-clock.yaml
>>> new file mode 100644
>>> index 000000000000..65c1feb60041
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/ambarella,pll-clock.yaml
>>> @@ -0,0 +1,59 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/ambarella,pll-clock.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Ambarella PLL Clock
>>> +
>>> +maintainers:
>>> +  - Li Chen <lchen@ambarella.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ambarella,pll-clock
>>> +      - ambarella,clkpll-v0
>>> +
>>> +if:
>>
>> No, this does not work like that. It sits under "allOf", located after
>> "required:".
> 
> Thanks, I will learn "allOf" and use it in v2. BTW, we use the two compatibles as below:
> clocks {
>                 compatible = "ambarella,clkpll-v0";

Nope.

>                 ...
>                 gclk_core: gclk-core {
>                         #clock-cells = <0>;
>                         compatible = "ambarella,pll-clock";

Also nope.

>                         clocks = <&osc>;
>                         clock-output-names = "gclk_core";
>                         amb,clk-regmap = <&rct_syscon 0x000 0x004 0x100 0x104 0x000 0x000>;

Nope, nope, nope.

You need proper clock-controller with its own MMIO address space.

>                 };
>                 ...
> }
> 
> I'm not sure can I describe the two compatibles in this single yaml, can you give some advice? thanks!

There are plenty of examples, including example-schema.

Best regards,
Krzysztof

