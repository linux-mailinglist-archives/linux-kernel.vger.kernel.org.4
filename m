Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE4C7215D8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 11:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFDJ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 05:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjFDJ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 05:26:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5127DF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 02:26:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977c89c47bdso172751866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685870783; x=1688462783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOyO+F8LRs6BsNfeY641bPGb9ljO3kjEoQREB3o9rl8=;
        b=cWVI2r9+YQLvWwp7bN1HVq75QKXxHltK2lY1gTsp60p2jmZwQrNl+oCvpfHS4wdCus
         5mtuaTiDO7AZcuG1k8FfoZB8oAIEASOX3kq5AjuaT2kcvJfqUlhaSyqfZdEMgPUCBMLg
         gikrBsuf/URBdQ2WS9NJwesGCbSef2WHCf4L1Ko9M+94AWH6ub7ZRu+/XBuNS3/zO9xb
         7sNE8NfDIyChKI1ui1LERDn9pYT8z31DJuFNw4BRO3+F+iEXPxfZWC3OUjds9SdeONXu
         f2c6y5jUTGkpqfVWdzvbrpmV2MhzG/WY58PrQCUvO2o3NNg6mKlwdJdDNR2/r/ogZgtu
         vJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685870783; x=1688462783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOyO+F8LRs6BsNfeY641bPGb9ljO3kjEoQREB3o9rl8=;
        b=SCWcxHXe1xiiY4PaS1bAQKs2IxHngY57HoPTd0cam2itQWDoZwBGLJobhV97kJsSXr
         4eF3f1YB8cRrPz3RoPnLtsnXewX9xL+AaxnfzYyw1Jk3LCgPgp8gEGsWcHjajLAKoHpG
         zbnE+1wbwimHV7IPY4g92TPtOe4YiBSgHF49PIU9+OExstwaO/VbDGPOKkWdLTWashB3
         UaAg7uE5OMfSWQAjKjjHws5lbIPH9+QQaDIWbBGIr44NNdBWIx8AtxMNsCid0O1Lgw2T
         qHfDVFdFNBEc9PPMx0sUb3S8cansX0oAXt27MaBKF5rgkfU2W0AwdZv7sXSb8T6DBaNb
         1fRQ==
X-Gm-Message-State: AC+VfDyFNGSiY4Qxg0yZbS4L+M+DYNqnXjBQhx7x7PU7viEFge0I7GfV
        1QZEFQoUwS/wjuoAY+LUN4EQMA==
X-Google-Smtp-Source: ACHHUZ6QTfvmeyM3nuQK2LXg5ix5mtBfeEGgyDMR/JTPPBlmm0uZjHE+PfdVFREn59PNZnqoWN3CIQ==
X-Received: by 2002:a17:907:c0f:b0:973:d953:4bf7 with SMTP id ga15-20020a1709070c0f00b00973d9534bf7mr4244765ejc.48.1685870783026;
        Sun, 04 Jun 2023 02:26:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id bn10-20020a170906c0ca00b009660449b9a3sm2887490ejb.25.2023.06.04.02.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 02:26:22 -0700 (PDT)
Message-ID: <eaf9d7cf-c9f5-a5d5-67af-c43761c3c6cf@linaro.org>
Date:   Sun, 4 Jun 2023 11:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "conor@kernel.org" <conor@kernel.org>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
References: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
 <20230531234923.2307013-4-chris.packham@alliedtelesis.co.nz>
 <a23dd485-a3d9-e31f-be3e-0ab293fcfc4a@linaro.org>
 <785368df-1881-e62e-6172-d902cee814a8@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <785368df-1881-e62e-6172-d902cee814a8@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 01:06, Chris Packham wrote:
> Hi Krzystof,
> 
> On 1/06/23 19:05, Krzysztof Kozlowski wrote:
>> On 01/06/2023 01:49, Chris Packham wrote:
>>> From: Vadym Kochan <vadym.kochan@plvision.eu>
>>>
>>> Switch the DT binding to a YAML schema to enable the DT validation.
>>>
>>> The text binding didn't mention it as a requirement but existing usage
>>> has
>>>
>>>     compatible = "marvell,armada-8k-nand-controller",
>>>                  "marvell,armada370-nand-controller";
>>>
>>> so the YAML allows this in addition to the individual compatible values.
>>>
>>> There was also an incorrect reference to dma-names being "rxtx" where
>>> the driver and existing device trees actually use dma-names = "data" so
>>> this is corrected in the conversion.
>>>
>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>
>>> Notes:
>>>      Changes in v8:
>>>      - Mark deprecated compatible values as such
>>>      - Allow "marvell,armada-8k-nand-controller" without
>>>        "marvell,armada370-nand-controller"
>>>      - Make dma-names usage reflect reality
>>>      - Update commit message
>>>      
>>>      Changes in v7:
>>>      - Restore "label" and "partitions" properties (should be picked up via
>>>        nand-controller.yaml but aren't)
>> What do you mean by "aren't"? They are not needed.
> 
> (sorry I keep responding to snippets rather than putting all the replies 
> in one place. For posterity here's the same response I provided in a 
> separate message).
> 
> I mean I simply cannot make it work and I'm out of ideas (I'm also in an 
> awkward timezone so it takes 24hrs for me to ask a question and get a 
> response which leads to me making guesses instead of waiting).
> 
> nand-controller.yaml references nand-chip.yaml which references mtd.yaml 
> which defines the "label" and "partitions" property.
> 
> I thought marvell,nand-controller.yaml could just say `$ref: 
> nand-controller.yaml` and it would mean I'd get all the definitions down 
> the chain but this doesn't seem to work the way I expect (or more likely 
> I'm not doing it right). I thought it might have something to do with 
> the different patternProperties pattern but even when I make that match 
> what is used in nand-controller.yaml it doesn't seem to pick up those 
> properties.

Then you are doing something different than all other bindings.

>>>      - Add/restore nand-on-flash-bbt and nand-ecc-mode which aren't covered
>>>        by nand-controller.yaml.
>>>      - Use "unevalautedProperties: false"
>>>      - Corrections for clock-names, dma-names, nand-rb and nand-ecc-strength
>>>      - Add pxa3xx-nand-controller example
>>>      
>>>      Changes in v6:
>>>      - remove properties covered by nand-controller.yaml
>>>      - add example using armada-8k compatible
>>>      
>>>      earlier changes:
>>>      
>>>      v5:
>>>         1) Get back "label" and "partitions" properties but without
>>>            ref to the "partition.yaml" which was wrongly used.
>>>      
>>>         2) Add "additionalProperties: false" for nand@ because all possible
>>>            properties are described.
>>>      
>>>      v4:
>>>         1) Remove "label" and "partitions" properties
>>>      
>>>         2) Use 2 clocks for A7K/8K platform which is a requirement
>>>      
>>>      v3:
>>>        1) Remove txt version from the MAINTAINERS list
>>>      
>>>        2) Use enum for some of compatible strings
>>>      
>>>        3) Drop:
>>>              #address-cells
>>>              #size-cells:
>>>      
>>>           as they are inherited from the nand-controller.yaml
>>>      
>>>        4) Add restriction to use 2 clocks for A8K SoC
>>>      
>>>        5) Dropped description for clock-names and extend it with
>>>           minItems: 1
>>>      
>>>        6) Drop description for "dmas"
>>>      
>>>        7) Use "unevalautedProperties: false"
>>>      
>>>        8) Drop quites from yaml refs.
>>>      
>>>        9) Use 4-space indentation for the example section
>>>      
>>>      v2:
>>>        1) Fixed warning by yamllint with incorrect indentation for compatible list
>>>
>>>   .../bindings/mtd/marvell,nand-controller.yaml | 223 ++++++++++++++++++
>>>   .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ----------
>>>   MAINTAINERS                                   |   1 -
>>>   3 files changed, 223 insertions(+), 127 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>>> new file mode 100644
>>> index 000000000000..433feb430555
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
>>> @@ -0,0 +1,223 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://scanmail.trustwave.com/?c=20988&d=18P45NWaR4V6pXt_kuivNCiVAXCm3C7MEF-_8xrP2A&u=http%3a%2f%2fdevicetree%2eorg%2fschemas%2fmtd%2fmarvell%2cnand-controller%2eyaml%23
>>> +$schema: http://scanmail.trustwave.com/?c=20988&d=18P45NWaR4V6pXt_kuivNCiVAXCm3C7MEFvq8B-ZjQ&u=http%3a%2f%2fdevicetree%2eorg%2fmeta-schemas%2fcore%2eyaml%23
>>> +
>>> +title: Marvell NAND Flash Controller (NFC)
>>> +
>>> +maintainers:
>>> +  - Miquel Raynal <miquel.raynal@bootlin.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - const: marvell,armada-8k-nand-controller
>>> +          - const: marvell,armada370-nand-controller
>>> +      - enum:
>>> +          - marvell,armada-8k-nand-controller
>>> +          - marvell,armada370-nand-controller
>>> +          - marvell,pxa3xx-nand-controller
>>> +      - description: legacy bindings
>>> +        deprecated: true
>>> +        enum:
>>> +          - marvell,armada-8k-nand
>>> +          - marvell,armada370-nand
>>> +          - marvell,pxa3xx-nand
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    description:
>>> +      Shall reference the NAND controller clocks, the second one is
>>> +      is only needed for the Armada 7K/8K SoCs
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  clock-names:
>>> +    minItems: 1
>>> +    items:
>>> +      - const: core
>>> +      - const: reg
>>> +
>>> +  dmas:
>>> +    maxItems: 1
>>> +
>>> +  dma-names:
>>> +    items:
>>> +      - const: data
>>> +
>>> +  marvell,system-controller:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Syscon node that handles NAND controller related registers
>>> +
>>> +patternProperties:
>>> +  "^nand@[0-3]$":
>>> +    type: object
>>> +    unevaluatedProperties: false
>>> +    properties:
>>> +      reg:
>>> +        minimum: 0
>>> +        maximum: 3
>>> +
>>> +      nand-rb:
>>> +        minItems: 1
>> Drop minItems.
>>
>>> +        maxItems: 1
>> Didn't you have here minimum and maximum? I think I did not ask to
>> remove them.
> 
> I did but I couldn't figure out how to do minimum and maximum with an 
> array would the following be correct (note removing both minItems and 
> maxItems as dtb_check complains if I have maxItems and items).

items:
  minimum: n
  maximum: n
  maxItems: n

or

items:
 - minimum: n
   maximum: n

See for example Documentation/devicetree/bindings/arm/l2c2x0.yaml


> 
>         nand-rb:
>          items:
>            - minimum: 0
>              maximum: 1
> 
>>
>>> +
>>> +      nand-ecc-step-size:
>>> +        const: 512
>>> +
>>> +      nand-ecc-strength:
>>> +        enum: [1, 4, 8, 12, 16]
>>> +
>>> +      nand-on-flash-bbt:
>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>> +
>>> +      nand-ecc-mode:
>>> +        const: hw
>>> +
>>> +      label:
>>> +        $ref: /schemas/types.yaml#/definitions/string
>> Drop label
>>
>>> +
>>> +      partitions:
>>> +        type: object
>> Drop partitions.
> 
> This is the part I can't get to work. It should pick it up via 
> nand-controller.yaml but nothing I do seems to work.
> 
>>> +
>>> +      marvell,nand-keep-config:
>>> +        description: |
>>> +          Orders the driver not to take the timings from the core and
>>> +          leaving them completely untouched. Bootloader timings will then
>>> +          be used.
>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>> +
>>> +      marvell,nand-enable-arbiter:
>>> +        description: |
>>> +          To enable the arbiter, all boards blindly used it,
>>> +          this bit was set by the bootloader for many boards and even if
>>> +          it is marked reserved in several datasheets, it might be needed to set
>>> +          it (otherwise it is harmless).
>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>> +        deprecated: true
>>> +
>>> +    additionalProperties: false
>> unevaluatedProperties: false
> It was hiding by '"^nand@[0-3]$":'. Should I move it here?

You cannot have both additionalProps and unevaluatedProps at the same
time, so we do not talk about same thing or this was never working?

Best regards,
Krzysztof

