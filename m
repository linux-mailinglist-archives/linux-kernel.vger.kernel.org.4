Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4B64D8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiLOJuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiLOJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:49:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A672220EE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:49:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z26so14797525lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yY96EIpEYo2WvzK5TLn9sy1o8NsGtoNUVSSOvpliiac=;
        b=NWjRT0VljK2M8aptatHJ8aLxWUf4BSSb7gtfVo4p2OixaPp17M2vyQAVBEqOHOemj3
         N+AQEz6MpApP9/2/ceTUgN4RLCN+vrmm4+TXtkQEROSrVdQeLaxneWEmj2uy+/1jfTTE
         gjZ7DblQriWzYDQ3xeB/XCaArVES8ccpi+XpnAWUszGdvlk5IQOc2zLal/XTd4nNbcx+
         FvScg3QKnn1vADCaOBHKqwIsMueohg++CwoN1eyFwqrOIGkFl16qj0ZrFk8BRpY33ZHX
         h77sAQY21iUugI02FlpmSXECFYCLsv3mvPUAJhSCZlIMox7uW/2360vTxa31ytPcM06a
         ANHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yY96EIpEYo2WvzK5TLn9sy1o8NsGtoNUVSSOvpliiac=;
        b=Ssqf+RCgM+L+AznZscy/W4fdoyrMZBcCB85LKPhAW/4Gba65ubYZpvrRmAgpxOlODj
         4XtwofPp8kM0Z4BvHtO+sKWeIvjrNpDhDuXmxfpf/d3Lblly24DYduPFjubj6R2i3Yb8
         ekWPPZyNtImDLqCTGF8JgXaHpJ55p/SdW8W1KShdrKUNpRdgNZj2BGhGARKBYyQqrYz6
         KOHbgfCFkQlWHjNupz/LINGvzxnB+NmFe8dAccLN5tTPT5dcki2qgwdudlwUqKU6iHzu
         wgVdFiQBAsBTGCHPT1InAkIEU65uXtfEOuhIHvPly1yGBKOLjKX3snGkYctS5eaUJLtv
         ACng==
X-Gm-Message-State: ANoB5pkFQA0g1232nvBweJjGoxX5VC0lHpQWcZ2ASCbjdE92yWdFQbOB
        ihgEezX0PM3084dPba4LZ38tfw==
X-Google-Smtp-Source: AA0mqf7zAnoMebFACZks9GUm6dwE1ZHAdzdmTbCibv2fl5cvIUrtTdpngz8fSmPdZ5KR7LlEFDr/jQ==
X-Received: by 2002:ac2:44d8:0:b0:4a4:68b8:9c2e with SMTP id d24-20020ac244d8000000b004a468b89c2emr7468340lfm.22.1671097759677;
        Thu, 15 Dec 2022 01:49:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512202c00b00494935ddb88sm1114271lfs.240.2022.12.15.01.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 01:49:19 -0800 (PST)
Message-ID: <8199105f-4c67-1af3-65fe-a5c8ddababca@linaro.org>
Date:   Thu, 15 Dec 2022 10:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/5] dt-bindings: gpio: Add RZ/V2M PWC GPIO driver
 bindings
Content-Language: en-US
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
 <20221213224310.543243-2-fabrizio.castro.jz@renesas.com>
 <20221214161057.GA1140718-robh@kernel.org>
 <TYWPR01MB87759AE2651E96276F6CAE94C2E09@TYWPR01MB8775.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYWPR01MB87759AE2651E96276F6CAE94C2E09@TYWPR01MB8775.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 19:26, Fabrizio Castro wrote:
> Hi Rob,
> 
> Thanks for your feedback!
> 
>> From: Rob Herring <robh@kernel.org>
>> Sent: 14 December 2022 16:11
>> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>> Subject: Re: [PATCH 1/5] dt-bindings: gpio: Add RZ/V2M PWC GPIO driver
>> bindings
>>
>> On Tue, Dec 13, 2022 at 10:43:06PM +0000, Fabrizio Castro wrote:
>>> Add dt-bindings document for the RZ/V2M PWC GPIO driver.
>>
>> Bindings are for h/w blocks/devices, not a specific driver.
> 
> Apologies, I will reword the changelog in v2.
> 
>>
>>>
>>> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>>> ---
>>>  .../bindings/gpio/renesas,rzv2m-pwc-gpio.yaml | 62 +++++++++++++++++++
>>>  1 file changed, 62 insertions(+)
>>>  create mode 100644
>> Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-gpio.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-
>> gpio.yaml b/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-
>> gpio.yaml
>>> new file mode 100644
>>> index 000000000000..ecc034d53259
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-gpio.yaml
>>> @@ -0,0 +1,62 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id:
>> https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetre
>> e.org%2Fschemas%2Fgpio%2Frenesas%2Crzv2m-pwc-
>> gpio.yaml%23&amp;data=05%7C01%7Cfabrizio.castro.jz%40renesas.com%7C603623c
>> 766f4421b85bd08daddedcb8c%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638
>> 066310628408926%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
>> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=o46ncDZK8YK5HYJ
>> ZYDXuq3yfEA34vnaxEsIDBlcroc0%3D&amp;reserved=0
>>> +$schema:
>> https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetre
>> e.org%2Fmeta-
>> schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cfabrizio.castro.jz%40renesas.com
>> %7C603623c766f4421b85bd08daddedcb8c%7C53d82571da1947e49cb4625a166a4a2a%7C0
>> %7C0%7C638066310628408926%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
>> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=VoWvV
>> pW782DVH2zdTKIesyzqm6sjiFyacbl833%2BjRis%3D&amp;reserved=0
>>> +
>>> +title: Renesas RZ/V2M External Power Sequence Controller (PWC) GPIO
>>> +
>>> +description: |+
>>> +  The PWC IP found in the RZ/V2M family of chips comes with General-
>> Purpose
>>> +  Output pins, alongside the below functions
>>> +    - external power supply on/off sequence generation
>>> +    - on/off signal generation for the LPDDR4 core power supply (LPVDD)
>>> +    - key input signals processing
>>> +  This node uses syscon to map the register used to control the GPIOs
>>> +  (the register map is retrieved from the parent dt-node), and the node
>> should
>>> +  be represented as a sub node of a "syscon", "simple-mfd" node.
>>> +
>>> +maintainers:
>>> +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - renesas,r9a09g011-pwc-gpio # RZ/V2M
>>> +          - renesas,r9a09g055-pwc-gpio # RZ/V2MA
>>> +      - const: renesas,rzv2m-pwc-gpio
>>> +
>>> +  offset:
>>
>> Too generic of a name. We want any given property name (globally) to
>> have 1 type. With the below comment, this should be replaced with 'reg'
>> instead if you have child nodes.
> 
> My understanding is that syscon subnodes normally use this name for exactly
> the same purpose, for example:
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml#L27
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml#L30
> 
> What am I missing?

These are generic drivers, so they need offset as they do not match any
specific programming model. You are not making a generic device. Address
offsets are not suitable in most cases for DTS. There are of course
exceptions so you can present reasons why this one is exception.
> 
>>
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      Offset in the register map for controlling the GPIOs (in bytes).
>>> +
>>> +  regmap:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Phandle to the register map node.
>>
>> Looks like GPIO is a sub-function of some other block. Define the
>> binding for that entire block.
> 
> That's defined in patch 3 from this series.
> I have sent it as patch 3 because that document references:
> * /schemas/gpio/renesas,rzv2m-pwc-gpio.yaml
> * /schemas/power/reset/renesas,rzv2m-pwc-poweroff.yaml
> Which are defined in this patch and in patch 2 in the series.
> 
> Do you want me to move patch 3 to patch 1 in v2?

We do not want regmap, but proper definition of entire hardware.

> 
>> GPIO can be either either a function of
>> that node (just add GPIO provider properties) or you can have GPIO child
>> nodes. Depends on what the entire block looks like to decide. Do you
>> have multiple instances of the GPIO block would be one reason to have
>> child nodes.
> 
> From a pure HW point of view, this GPIO block is contained inside the PWC block
> (as PWC is basically a MFD device), and it only deals with 2 General-Purpose
> Output pins, both controlled by 1 (and the same) register, therefore the GPIO
> block is only 1 child.
> 
> If possible, I would like to keep the functionality offered by the sub-blocks of
> PWC contained in separated drivers and DT nodes (either non-child nodes or child
> nodes).

Driver do not matter for bindings. We talk about regmap field which - as
you explained above - is not needed.


> 
> My understanding is that simple-mfd will automatically probe the children of the
> simple-mfd node, and also hierarchically it makes sense to me to have the DT nodes
> of the PWC sub-blocks as children of the "syscon", "simple-mfd" node. I have found
> other instances of this same architecture in the kernel already (plenty from NXP/Freescale),
> for example:

I don't understand. You do not have here simple-mfd and it still does
not explain Rob's comment and regmap.

> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx8mm.dtsi#L585
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx8mn.dtsi#L586
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx8mp.dtsi#L451
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx8mq.dtsi#L616
> https://github.com/torvalds/linux/blob/master/arch/mips/boot/dts/mti/sead3.dts#L93
> etc...
> 
> Something like the below could also work, but I don't think it would represent the
> HW accurately:
> pwc: pwc@a3700000 {
> 	compatible = "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc",
> 		     "syscon", "simple-mfd";
> 	reg = <0 0xa3700000 0 0x800>;
> };
> 
> pwc-gpio {
> 	compatible = "renesas,r9a09g011-pwc-gpio",
> 		     "renesas,rzv2m-pwc-gpio";
> 	regmap = <&pwc>;
> 	gpio-controller;
> 	#gpio-cells = <2>;
> };
> 
> pwc-poweroff {
> 	compatible = "renesas,r9a09g011-pwc-poweroff",
> 		     "renesas,rzv2m-pwc-poweroff";
> 	regmap = <&pwc>;
> };
> 
> 
> I think the below describes things better:
> pwc: pwc@a3700000 {
> 	compatible = "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc",
> 		     "syscon", "simple-mfd";
> 	reg = <0 0xa3700000 0 0x800>;
> 
> 	gpio {
> 		compatible = "renesas,r9a09g011-pwc-gpio",
> 			     "renesas,rzv2m-pwc-gpio";
> 		regmap = <&pwc>;

You speak about two different things. So again - drop regmap. You do not
need it.

> 		offset = <0x80>;
> 		gpio-controller;
> 		#gpio-cells = <2>;
> 	};
> 
> 	poweroff {
> 		compatible = "renesas,r9a09g011-pwc-poweroff",
> 			     "renesas,rzv2m-pwc-poweroff";
> 		regmap = <&pwc>;

Drop regmap.

> 	};
> };
> 

Best regards,
Krzysztof

