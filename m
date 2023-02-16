Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B2698C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBPFwD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Feb 2023 00:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBPFwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:52:01 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB4127D6E;
        Wed, 15 Feb 2023 21:51:58 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A1C3824E1EC;
        Thu, 16 Feb 2023 13:51:51 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Feb
 2023 13:51:51 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Feb
 2023 13:51:50 +0800
Message-ID: <79b6cc69-5f34-9983-58e3-64da9fac5ef3@starfivetech.com>
Date:   Thu, 16 Feb 2023 13:51:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add StarFive MMC module
To:     Shengyu Qu <wiagn233@outlook.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-2-william.qiu@starfivetech.com>
 <TY3P286MB26111053410F3F96C9C71D2798A39@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <9ef960ae-7b61-9ed3-5bab-822e6d7d5a76@starfivetech.com>
 <202302160545.31G5jiuf087662@SH1-CSMTP-DB111.sundns.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <202302160545.31G5jiuf087662@SH1-CSMTP-DB111.sundns.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/16 0:49, Shengyu Qu wrote:
> Hello William,
> 
> Thanks for your reply. So there's v5 series? Btw, please fix maintainer information:
> 
> https://patchwork.kernel.org/project/linux-riscv/patch/20230215080203.27445-1-lukas.bulwahn@gmail.com/
> 
> Best regards,
> 
> Shengyu
> 
Hi Shengyu,

Here is v4 series, and I fixed the maintainer information in this series which
Uffe would merge in his next branch.
Thanks for taking time to review this patch series.

Best Regards
William
>>
>> On 2023/2/15 19:59, Shengyu Qu wrote:
>>> Hello William,
>>>
>>> Are you sure changing driver is better than changing yaml bindings? All
>>>
>>> previous version sent was syscon and sysreg seems not consistent with
>>>
>>> other codes.
>>>
>>> Best regards,
>>>
>>> Shengyu
>>>
>> Hi Shengyu,
>>
>> After discussing with colleagues, we decided to restore the lable name to
>> sys_syscon, and sysreg was just a unique name for the functionality of MMC,
>> which will be used in all future versions.
>>
>> Thanks for taking time reviewing this patch series.
>>
>> Best Regards
>> William
>>
>>>> Add documentation to describe StarFive designware mobile storage
>>>> host controller driver.
>>>>
>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    .../bindings/mmc/starfive,jh7110-mmc.yaml     | 77 +++++++++++++++++++
>>>>    1 file changed, 77 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
>>>> new file mode 100644
>>>> index 000000000000..51e1b04e799f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
>>>> @@ -0,0 +1,77 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/mmc/starfive,jh7110-mmc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: StarFive Designware Mobile Storage Host Controller
>>>> +
>>>> +description:
>>>> +  StarFive uses the Synopsys designware mobile storage host controller
>>>> +  to interface a SoC with storage medium such as eMMC or SD/MMC cards.
>>>> +
>>>> +allOf:
>>>> +  - $ref: synopsys-dw-mshc-common.yaml#
>>>> +
>>>> +maintainers:
>>>> +  - William Qiu <william.qiu@starfivetech.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: starfive,jh7110-mmc
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: biu clock
>>>> +      - description: ciu clock
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: biu
>>>> +      - const: ciu
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  starfive,sysreg:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    items:
>>>> +      - items:
>>>> +          - description: phandle to System Register Controller syscon node
>>>> +          - description: offset of SYS_SYSCONSAIF__SYSCFG register for MMC controller
>>>> +          - description: shift of SYS_SYSCONSAIF__SYSCFG register for MMC controller
>>>> +          - description: mask of SYS_SYSCONSAIF__SYSCFG register for MMC controller
>>>> +    description:
>>>> +      Should be four parameters, the phandle to System Register Controller
>>>> +      syscon node and the offset/shift/mask of SYS_SYSCONSAIF__SYSCFG register
>>>> +      for MMC controller.
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - interrupts
>>>> +  - starfive,sysreg
>>>> +
>>>> +unevaluatedProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    mmc@16010000 {
>>>> +        compatible = "starfive,jh7110-mmc";
>>>> +        reg = <0x16010000 0x10000>;
>>>> +        clocks = <&syscrg 91>,
>>>> +                 <&syscrg 93>;
>>>> +        clock-names = "biu","ciu";
>>>> +        resets = <&syscrg 64>;
>>>> +        reset-names = "reset";
>>>> +        interrupts = <74>;
>>>> +        fifo-depth = <32>;
>>>> +        fifo-watermark-aligned;
>>>> +        data-addr = <0>;
>>>> +        starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
>>>> +    };
