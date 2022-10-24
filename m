Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC3E60BD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJXWbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiJXWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:30:33 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7ED157F4A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:53:22 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id mx8so7269771qvb.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqFLMg6uRhRQRmXJ9QneA5/Qult4cQee1Mbf8jF2WyE=;
        b=AdkZFHvuiAP4xkerquOcpqZB3+k+FtH0/4XwqqQpZmxk6GgrLYTmb8gzshooljZSE6
         jdakcuD8Alctrf4B+M4qnhgUAmiADrcwssfH9wNCEX70M2rzC1PUY7a5dVzkdK05jPGn
         WgFiZsHIuvVuH4NXBSxghwPD5G9/lUsqL08n6/5t+tDTFdOICOi5Ri+B/aDy1f2kfqRl
         q5iDubrjWedxmj6aMtR7hhuABT5Cr9oCqwbguV+mDbs1fsBlBIdDWDSx1p5Gon6qWv+F
         qzRw2bzab9nF8uGnUqezDODBMBl8chfdELzmvA5uPBYJ0RJ62Ps/eIe13CO5ufgQG1nK
         p1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqFLMg6uRhRQRmXJ9QneA5/Qult4cQee1Mbf8jF2WyE=;
        b=Xgthxy88fuKQCdIZu0d8lBlUG1si4E52DVso6DZsDlOCY2ELvrCX1TxKVDUMydNbla
         ErKZVaAG17ah+j894Z29DWqeNCti3f0/WzIs8BATlUXutoUaTYG/ZRFJiclRZiX6wV5E
         02//fft0Z8FfifplXO2iuEDB8qeLL1s6hl9xJJNdSbaVlBWbrKEBVBRvrGZDBUpliuJ/
         r9y03WhpJNc4AcBPe9AMYugegjMtMjKOcXAPzIvVHPer9uupQMO6+wOTqtQbUHy7Hay0
         RBCdlXUiyoMPYVqLkcOu9ncG51hm7D4veiogL73ApOUqYldSnyF0kxIGO2IaOiHhOHdj
         Ek8g==
X-Gm-Message-State: ACrzQf1H+FEs0huZs6uyK4jnPU9XNVSpunr1RbFrfbTdpUHCV/dt8PMk
        aaSskgiiJnddsbuZYslcjP13lw==
X-Google-Smtp-Source: AMsMyM51AifgSKGMphjiFZJRB5CThD2CylgJtsOaKsmO5Ikm7TvSu2+4uhdwYMMfpDLmjyFWp8prVw==
X-Received: by 2002:a05:6214:e62:b0:4b3:ff39:7aef with SMTP id jz2-20020a0562140e6200b004b3ff397aefmr29749239qvb.31.1666644677366;
        Mon, 24 Oct 2022 13:51:17 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id l11-20020a37f90b000000b006ee79bb1f8asm622386qkj.68.2022.10.24.13.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:51:16 -0700 (PDT)
Message-ID: <8cc7a8b6-0ca9-bc61-77e3-abf24cfbc909@linaro.org>
Date:   Mon, 24 Oct 2022 16:51:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>
References: <20221021194552.683-1-vadym.kochan@plvision.eu>
 <20221021194552.683-2-vadym.kochan@plvision.eu>
 <a46c6a18-903d-2120-4876-509ce8ad19d5@linaro.org>
 <VI1P190MB03170416FB2C521103B8EE1A952E9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1P190MB03170416FB2C521103B8EE1A952E9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 15:48, Vadym Kochan wrote:
> Hi Krzysztof,
> 
> On Sat, 22 Oct 2022 12:18:49 -0400, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> On 21/10/2022 15:45, Vadym Kochan wrote:
>>> Switch the DT binding to a YAML schema to enable the DT validation.
>>>
>>> Dropped deprecated compatibles and properties described in txt file.
>>>
>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>>> ---
>>>  .../bindings/mtd/marvell,nand-controller.yaml | 199 ++++++++++++++++++
>>>  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
>>>  2 files changed, 199 insertions(+), 126 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>>> new file mode 100644
>>> index 000000000000..535b7f8903c8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>>> @@ -0,0 +1,199 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Marvell NAND Flash Controller (NFC)
>>> +
>>> +maintainers:
>>> +  - Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> This should be someone responsible for hardware, not subsystem
>> maintainer. Unless by coincidence Miquel matches both. :)
>>
>>> +
>>> +properties:
>>> +
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +        - const: marvell,armada-8k-nand-controller
>>> +        - const: marvell,armada370-nand-controller
>>
>> Does not look like you tested the bindings. Please run `make
>> dt_binding_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> 
> Yes, on v1 I did not use yamllint, but installed after Rob pointed
> on some lint warnings.

I did not say about yamllint.

> 
>>
>>> +      - const: marvell,armada370-nand-controller
>>> +      - const: marvell,pxa3xx-nand-controller
>>
>> These two are just enum.
>>
> 
> OK.
> 
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>
>> Drop, comes with nand-controller.yaml
>>
> 
> OK.
> 
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>
>> Ditto
>>
> 
> OK.
> 
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +    description: |
>>
>> No need for |
>>
>>> +     Shall reference the NAND controller clocks, the second one is
>>> +     is only needed for the Armada 7K/8K SoCs
>>
>> You need allOf:if:then restricting it further per variant.
>>
> 
> OK, added.
> 
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: core
>>> +      - const: reg
>>> +    description: |
>>> +      Mandatory if there is a second clock, in this case there
>>> +      should be one clock named "core" and another one named "reg"
>>
>> The message is confusing. What is mandatory if there is a second clock?
>> Plus, the binding requires two clocks.
>>
>> Drop entire description.
>>
>> minItems: 1
>>
> 
> OK, droped (I used from the txt version).
> Added minItems.
> 
>>
>>> +
>>> +  dmas:
>>> +    maxItems: 1
>>> +    description: rxtx DMA channel
>>
>> Drop description.
>>
> 
> OK.
> 
>>> +
>>> +  dma-names:
>>> +    items:
>>> +      - const: rxtx
>>> +
>>> +  marvell,system-controller:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Syscon node that handles NAND controller related registers
>>> +
>>> +patternProperties:
>>> +  "^nand@[0-3]$":
>>> +    type: object
>>> +    properties:
>>> +
>>
>> Drop blank line.
>>
> 
> OK.
> 
>>> +      reg:
>>> +        minimum: 0
>>> +        maximum: 3
>>> +
>>> +      nand-rb:
>>> +        minimum: 0
>>> +        maximum: 1
>>> +
>>> +      nand-ecc-strength:
>>> +        enum: [1, 4, 8]
>>> +
>>> +      nand-on-flash-bbt: true
>>> +
>>> +      nand-ecc-mode: true
>>> +
>>> +      nand-ecc-algo:
>>> +        description: |
>>> +          This property is essentially useful when not using hardware ECC.
>>> +          Howerver, it may be added when using hardware ECC for clarification
>>> +          but will be ignored by the driver because ECC mode is chosen depending
>>> +          on the page size and the strength required by the NAND chip.
>>> +          This value may be overwritten with nand-ecc-strength property.
>>> +
>>> +      nand-ecc-step-size:
>>> +        const: 512
>>
>> Why this is const?
>>
> 
> Removed const.
> 
>>> +        description: |
>>> +          Marvell's NAND flash controller does use fixed strength
>>> +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
>>> +          will shrink or grow in order to fit the required strength.
>>> +          Step sizes are not completely random for all and follow certain
>>> +          patterns described in AN-379, "Marvell SoC NFC ECC".
>>> +
>>> +      label:
>>> +        $ref: /schemas/types.yaml#/definitions/string
>>> +
>>> +      partitions:
>>> +        type: object
>>> +        $ref: "/schemas/mtd/partitions/partition.yaml"
>>
>> Drop quotes
>>
> 
> OK.
> 
>>         unevalautedProperties: false
>>
>> and then you will see errors, because you referenced schema for one
>> partition.
>>
> 
> Hm, I did not see errors with partitions with- or without "unevaluatedProperties".

As pointed before and here - I am not sure if you tested the bindings,
so of course then will be no warnings...

Best regards,
Krzysztof

