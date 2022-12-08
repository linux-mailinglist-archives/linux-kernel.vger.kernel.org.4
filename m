Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40400646ADD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLHIoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiLHIo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:44:29 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605ED26489;
        Thu,  8 Dec 2022 00:44:24 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 27C2824DFD7;
        Thu,  8 Dec 2022 16:44:23 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 16:44:23 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 16:44:22 +0800
Message-ID: <b0dfc269-e06e-4f4d-7695-55c8522d6137@starfivetech.com>
Date:   Thu, 8 Dec 2022 16:44:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add bindings for StarFive
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-2-william.qiu@starfivetech.com>
 <d7ecbbbf-5d6b-3254-b645-dbea369447ae@linaro.org>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <d7ecbbbf-5d6b-3254-b645-dbea369447ae@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/7 23:13, Krzysztof Kozlowski wrote:
> On 07/12/2022 14:17, William Qiu wrote:
>> Add documentation to describe StarFive
>> designware mobile storage host controller driver.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  .../bindings/mmc/starfive,jh7110-sdio.yaml    | 71 +++++++++++++++++++
>>  1 file changed, 71 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
>> new file mode 100644
>> index 000000000000..4f27ef3cf4f3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
>> @@ -0,0 +1,71 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/starfive,jh7110-sdio.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive Designware Mobile Storage Host Controller
>> +
>> +description:
>> +  StarFive uses the Synopsys designware mobile storage host controller
>> +  to interface a SoC with storage medium such as eMMC or SD/MMC cards.
>> +
>> +allOf:
>> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> 
> Drop quotes
> 

Will fix.

>> +
>> +maintainers:
>> +  - William Qiu <william.qiu@starfivetech.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-sdio
> 
> Why do you call it sdio if the interface is for mmc as well?
> 

Will update compatible.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 1
>> +    items:
>> +      - description: biu clock
>> +      - description: ciu clock
> 
> I don't think the card interface clock is optional... are you sure you
> have designs working without it? No clock line at all getting to the memory?
> 

Will fix.

>> +
>> +  clock-names:
>> +    minItems: 1
>> +    items:
>> +      - const: biu
>> +      - const: ciu
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  starfive,sys-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      The desired number of times that the host execute tuning when needed.
> 
> That's not matching the property name. Missing number of items... this
> is anyway confusing. Why number of tuning tries is a property of DT?
> 

Will update the description.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/starfive-jh7110.h>
>> +    #include <dt-bindings/reset/starfive-jh7110.h>
>> +    mmc@16010000 {
>> +            compatible = "starfive,jh7110-sdio";
> 
> Use 4 spaces for example indentation.
> 

I'll fix the indentation.

>> +            reg = <0x16010000 0x10000>;
>> +            clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
>> +                 <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> 
> Align with previous <
> 

I will fix.

Thank you for taking time to review and provide helpful comments for this patch.

Best regards,
William Qiu

> Best regards,
> Krzysztof
> 
