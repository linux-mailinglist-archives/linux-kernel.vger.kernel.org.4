Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994B5629B90
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKOOIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKOOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:08:43 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAEA6583
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:08:41 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z24so17661230ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiTVqep6DU3EQigGK3/zHq9dFgIjE2mGeNBBEKQcEuw=;
        b=VIOa8Bduskofw1HyyiM/+ADYmDV7qu6UAs23GhKMa5I+72Wpi1+scUftzlB1QlGYCC
         2bf7cy/aQbYg/JsVaD9WiZAUpXaQluLwDHuX3IJpRaycZjuu1m4+RqEkiWTgtrr8umUH
         qTxdNj4xFTgQVfXDhIzgNj9RJJOZLxzYta5RocnLzaqwWlcr3TX1x/cSagU5fdmH/lGt
         uS5RbxehwU3AD/PRDGz/eJc0QP0OVUPHHtpShW/hl6GxbczYpMqKP7aS0wVTg2mf9PIt
         rUNc8+Nvpjg0Aw23TVmbcNy126//piwytSQubsHIGY8wJRAa9YBuYMcWtbkWy1m5/+5P
         aQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiTVqep6DU3EQigGK3/zHq9dFgIjE2mGeNBBEKQcEuw=;
        b=Oonx0sCBtRvubIgLBUqZHL7n2CXVoz0c0Yh4oKkvb1WXuPC1sbpkUb6o3LZHraOWs7
         scEmkCLZDpOsr8PBaDIDtdq0JoVu8AyG9w0rchLpn4D67UXDwmqqLHbp5N27dEdwpsu5
         MJi/F0vB2KK+V0eTmmYvLPE4dyb+y9mfK8xG/Ah1iWqBYJ9mH1q7H5vybqEU2a7QAmgQ
         3QqdTtQ7qVzu0fxfyCqnL6zBHG/iSlPIuSd05skRGvUo1Yodq25Uxop2XMbnG5pk4ErK
         auxWiEjOWiOqsALufG10c/+tZCMvb9LTwZzwnHm0feWhakKz3mZoI5CiRw2Qmow94t40
         ZMsA==
X-Gm-Message-State: ANoB5pnq8/gpMrFT+LFheb8wgunmeyizGAZ1hNolTgbPXpLsLZduCQpm
        yhMzbrpQq3NSTYrQ+1hbDGps2jDIVgbcUrSN
X-Google-Smtp-Source: AA0mqf5tf4cNFzATyjN2JH2wnr6CNKgdMcgN+PCe0/cmxPHrIlV6p350nZWLhKt8Xi7zKVD4RKF+9Q==
X-Received: by 2002:a2e:a27b:0:b0:279:5fa:8e7c with SMTP id k27-20020a2ea27b000000b0027905fa8e7cmr2725033ljm.62.1668521319792;
        Tue, 15 Nov 2022 06:08:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 14-20020ac2568e000000b004946bb30469sm2221536lfr.82.2022.11.15.06.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:08:39 -0800 (PST)
Message-ID: <c9b82051-a9f5-883f-5455-1cb06aa6521b@linaro.org>
Date:   Tue, 15 Nov 2022 15:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: spi: convert Freescale DSPI to dt-schema
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
References: <20221111224651.577729-1-vladimir.oltean@nxp.com>
 <417bfdea-ed41-6468-ec16-f54480cfe2f6@linaro.org>
 <20221115135912.ksjk7zxqsyazqhtf@skbuf>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115135912.ksjk7zxqsyazqhtf@skbuf>
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

On 15/11/2022 14:59, Vladimir Oltean wrote:
> On Tue, Nov 15, 2022 at 02:46:21PM +0100, Krzysztof Kozlowski wrote:
>>> +$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi.yaml
>>
>> Why second "fsl" in file name? It does not patch compatibles and
>> duplicates the vendor. We do not have compatibles "nxp,imx6-nxp".
> 
> Ok, which file name would be good then? There are 9 different (all SoC
> specific) compatible strings, surely the convention of naming the file
> after a compatible string has some limitations...

If all DSPI blocks fit here, then maybe: fsl,dspi.yaml

fsl,spi-dspi.yaml is also a bit redundant.

> 
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml
>>> +
>>> +title: Freescale DSPI Controller
>>> +
>>> +maintainers:
>>> +  - Vladimir Oltean <olteanv@gmail.com>
>>> +
>>> +allOf:
>>> +  - $ref: "spi-controller.yaml#"
>>
>> Drop quotes.
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    description:
>>> +      Some integrations can have a single compatible string containing their
>>> +      SoC name (LS1012A, LS1021A, ...). Others require their SoC compatible
>>> +      string, plus a fallback compatible string (either on LS1021A or on
>>> +      LS2085A).
>>
>> Why? The fsl,ls1012a-dspi device is either compatible with
>> fsl,ls1021a-v1.0-dspi or not. It cannot be both - compatible and not
>> compatible.
> 
> LS1012A is compatible with LS1021A to the extent that it works when
> treated like a LS1021A. LS1012A has a FIFO size of 8 SPI words, LS1021A
> of just 4. Treating it like LS1021A means roughly half the performance,
> but it still works.
> 
> I didn't invent any of this. When I took over the driver, there were
> device trees like this all over the place:
> 
> 		dspi: spi@2100000 {
> 			compatible = "fsl,ls1012a-dspi", "fsl,ls1021a-v1.0-dspi";

Which looks ok...

> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			reg = <0x0 0x2100000 0x0 0x10000>;
> 			interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
> 			clock-names = "dspi";
> 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> 					    QORIQ_CLK_PLL_DIV(1)>;
> 			spi-num-chipselects = <5>;
> 			big-endian;
> 			status = "disabled";
> 		};
> 
> but the Linux driver pre-~5.7 always relied on the fallback compatible
> string (LS1021A in this case). I'm working with what's out in the field,
> haven't changed a thing there.

The driver matters less (except ABI), but anyway it confirms the case -
fallback is expected always.  Why the fallback should be removed if the
devices are compatible (including halved performance)?

> 
>>> +    oneOf:
>>> +      - enum:
>>> +          - fsl,ls1012a-dspi
>>> +          - fsl,ls1021a-v1.0-dspi
>>> +          - fsl,ls1028a-dspi
>>> +          - fsl,ls2085a-dspi
>>> +          - fsl,lx2160a-dspi
>>> +          - fsl,vf610-dspi
>>> +      - items:
>>> +          - enum:
>>> +              - fsl,ls1012a-dspi
>>> +              - fsl,ls1028a-dspi
>>> +              - fsl,ls1043a-dspi
>>> +              - fsl,ls1046a-dspi
>>> +              - fsl,ls1088a-dspi
>>> +          - const: fsl,ls1021a-v1.0-dspi
>>> +      - items:
>>> +          - enum:
>>> +              - fsl,ls2080a-dspi
>>> +              - fsl,lx2160a-dspi
>>> +          - const: fsl,ls2085a-dspi
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: dspi
>>> +
>>> +  dmas:
>>> +    maxItems: 2
>>> +
>>> +  dma-names:
>>> +    items:
>>> +      - const: tx
>>> +      - const: rx
>>> +
>>> +  spi-num-chipselects:
>>
>> Would be nice to deprecated it in separate patches. There is num-cs
>> property.
> 
> Will add this on my TODO list. Right now I'm just converting what exists.

Sure.

Best regards,
Krzysztof

