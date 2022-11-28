Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C31639EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 02:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiK1BPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 20:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiK1BPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 20:15:11 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C7F764B;
        Sun, 27 Nov 2022 17:15:07 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1793424E194;
        Mon, 28 Nov 2022 09:15:06 +0800 (CST)
Received: from EXMBX065.cuchost.com (172.16.6.65) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 28 Nov
 2022 09:15:05 +0800
Received: from [192.168.125.66] (183.27.97.81) by EXMBX065.cuchost.com
 (172.16.6.65) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 28 Nov
 2022 09:15:04 +0800
Message-ID: <05ade4a9-6ae2-6e3a-5223-270b24e6ea24@starfivetech.com>
Date:   Mon, 28 Nov 2022 09:15:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/5] dt-bindings: pinctrl: Add StarFive JH7110 aon
 pinctrl
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221118011108.70715-1-hal.feng@starfivetech.com>
 <20221118011108.70715-4-hal.feng@starfivetech.com>
 <7f78e57a-d9be-b1e9-d161-40b1f66e3804@linaro.org>
From:   Jianlong Huang <jianlong.huang@starfivetech.com>
In-Reply-To: <7f78e57a-d9be-b1e9-d161-40b1f66e3804@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.81]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX065.cuchost.com
 (172.16.6.65)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 09:44:00 +0100, Krzysztof Kozlowski wrote:
> On 18/11/2022 02:11, Hal Feng wrote:
>> From: Jianlong Huang <jianlong.huang@starfivetech.com>
>> 
>> Add pinctrl bindings for StarFive JH7110 SoC aon pinctrl controller.
>> 
>> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../pinctrl/starfive,jh7110-aon-pinctrl.yaml  | 134 ++++++++++++++++++
>>  1 file changed, 134 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..1dd000e1f614
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
>> @@ -0,0 +1,134 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/starfive,jh7110-aon-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 Aon Pin Controller
>> +
>> +description: |
>> +  Bindings for the JH7110 RISC-V SoC from StarFive Technology Ltd.
>> +
>> +  Out of the SoC's many pins only the ones named PAD_GPIO0 to PAD_GPIO4
>> +  can be multiplexed and have configurable bias, drive strength,
>> +  schmitt trigger etc.
>> +  Some peripherals have their I/O go through the 4 "GPIOs". This also
>> +  includes PWM.
>> +
>> +maintainers:
>> +  - Jianlong Huang <jianlong.huang@starfivetech.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-aon-pinctrl
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reg-names:
>> +    items:
>> +      - const: control
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  gpio-controller: true
>> +
>> +  "#gpio-cells":
>> +    const: 2
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description: The GPIO parent interrupt.
> 
> Same comments apply plus one more.

Will fix, drop this description.

> 
>> +
>> +  interrupt-controller: true
>> +
>> +  "#interrupt-cells":
>> +    const: 2
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - gpio-controller
>> +  - "#gpio-cells"
>> +  - interrupts
>> +  - interrupt-controller
>> +  - "#interrupt-cells"
> 
> "required:" goes after patternProperties.

Will fix.

> 
>> +
>> +patternProperties:
>> +  '-[0-9]+$':
> 
> Same comment.

Will fix.
Keep consistent quotes, use '

> 
>> +    type: object
>> +    patternProperties:
>> +      '-pins$':
>> +        type: object
>> +        description: |
>> +          A pinctrl node should contain at least one subnode representing the
>> +          pinctrl groups available on the machine. Each subnode will list the
>> +          pins it needs, and how they should be configured, with regard to
>> +          muxer configuration, system signal configuration, pin groups for
>> +          vin/vout module, pin voltage, mux functions for output, mux functions
>> +          for output enable, mux functions for input.
>> +
>> +        properties:
>> +          pinmux:
>> +            description: |
>> +              The list of GPIOs and their mux settings that properties in the
>> +              node apply to. This should be set using the GPIOMUX macro.
>> +            $ref: "/schemas/pinctrl/pinmux-node.yaml#/properties/pinmux"
>> +
>> +          bias-disable: true
>> +
>> +          bias-pull-up:
>> +            type: boolean
>> +
>> +          bias-pull-down:
>> +            type: boolean
>> +
>> +          drive-strength:
>> +            enum: [ 2, 4, 8, 12 ]
>> +
>> +          input-enable: true
>> +
>> +          input-disable: true
>> +
>> +          input-schmitt-enable: true
>> +
>> +          input-schmitt-disable: true
>> +
>> +          slew-rate:
>> +            maximum: 1
>> +
>> +        additionalProperties: false
>> +
>> +    additionalProperties: false
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/starfive-jh7110.h>
>> +    #include <dt-bindings/reset/starfive-jh7110.h>
>> +    #include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
>> +
>> +        soc {
>> +                #address-cells = <2>;
>> +                #size-cells = <2>;
> 
> Same comment.

Will fix.
Use 4 spaces for example indentation.

> 
>> +
>> +                gpioa: gpio@17020000 {
>> +                        compatible = "starfive,jh7110-aon-pinctrl";
>> +                        reg = <0x0 0x17020000 0x0 0x10000>;
>> +                        reg-names = "control";
>> +                        resets = <&aoncrg_rst JH7110_AONRST_AON_IOMUX>;
>> +                        interrupts = <85>;
>> +                        interrupt-controller;
>> +                        #interrupt-cells = <2>;
>> +                        #gpio-cells = <2>;
>> +                        gpio-controller;
>> +                };
>> +        };
>> +
>> +...
> 

Best regards,
Jianlong Huang


