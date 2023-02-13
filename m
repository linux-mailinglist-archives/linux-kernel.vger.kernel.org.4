Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5A693F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBMHwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMHwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:52:15 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F261BA;
        Sun, 12 Feb 2023 23:52:11 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E9CE224E0AE;
        Mon, 13 Feb 2023 15:52:03 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Feb
 2023 15:52:03 +0800
Received: from [192.168.1.100] (183.27.97.168) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Feb
 2023 15:52:00 +0800
Message-ID: <36d8a648-49f4-281e-3947-cf2cbf3827b2@starfivetech.com>
Date:   Mon, 13 Feb 2023 15:51:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v1 2/4] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230210061713.6449-1-changhuang.liang@starfivetech.com>
 <20230210061713.6449-3-changhuang.liang@starfivetech.com>
 <20230210182935.GA2914589-robh@kernel.org>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230210182935.GA2914589-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.168]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/11 2:29, Rob Herring wrote:
> On Thu, Feb 09, 2023 at 10:17:11PM -0800, Changhuang Liang wrote:
>> Starfive SoC like the jh7110 use a MIPI D-PHY RX controller based on
>> a M31 IP. Add a binding for it.
>>
>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> ---
>>  .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 78 +++++++++++++++++++
>>  1 file changed, 78 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
>> new file mode 100644
>> index 000000000000..1c1e5c7cbee2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/starfive,jh7110-dphy-rx.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Starfive SoC MIPI D-PHY Rx Controller
>> +
>> +maintainers:
>> +  - Jack Zhu <jack.zhu@starfivetech.com>
>> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
>> +
>> +description: |
> 
> Don't need '|'
>

OK, will delete it.

>> +  The Starfive SOC has a MIPI CSI D-PHY based on M31 IP use to transfer
>> +  the CSI cameras data.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: "starfive,jh7110-dphy-rx"
> 
> Drop quotes.
> 

OK, will drop quotes

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 3
>> +    maxItems: 3
> 
> Just maxItems is enough.
> 

OK, will delete minItems.

>> +
>> +  clock-names:
>> +    items:
>> +      - const: cfg
>> +      - const: ref
>> +      - const: tx
>> +
>> +  resets:
>> +    minItems: 2
>> +    maxItems: 2
> 
> Need to define what each reset is.
> 

OK, will define resets.

>> +
>> +  starfive,aon-syscon:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> 
> Drop quotes.
> 

OK, will drop quote

>> +    items:
>> +      items:
>> +        - description: phandle of AON SYSCON
>> +        - description: register offset
>> +    description: The register of dphy rx driver can be configured
>> +      by AON SYSCON in this property.
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - starfive,aon-syscon
>> +  - "#phy-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
>> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
>> +
>> +    dphy@19820000 {
>> +      compatible = "starfive,jh7110-dphy-rx";
>> +      reg = <0x19820000 0x10000>;
>> +      clocks = <&ispcrg JH7110_ISPCLK_M31DPHY_CFGCLK_IN>,
>> +               <&ispcrg JH7110_ISPCLK_M31DPHY_REFCLK_IN>,
>> +               <&ispcrg JH7110_ISPCLK_M31DPHY_TXCLKESC_LAN0>;
>> +      clock-names = "cfg", "ref", "tx";
>> +      resets = <&ispcrg JH7110_ISPRST_M31DPHY_HW>,
>> +               <&ispcrg JH7110_ISPRST_M31DPHY_B09_ALWAYS_ON>;
>> +      starfive,aon-syscon = <&aon_syscon 0x00>;
>> +      #phy-cells = <0>;
>> +    };
>> -- 
>> 2.25.1
>>
