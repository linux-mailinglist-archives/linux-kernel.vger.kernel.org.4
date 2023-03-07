Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E86AD73D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjCGGU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCGGUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:20:24 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA4367EC;
        Mon,  6 Mar 2023 22:20:22 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id EF19D24E2F7;
        Tue,  7 Mar 2023 14:20:14 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 14:20:14 +0800
Received: from [192.168.60.139] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 14:20:14 +0800
Message-ID: <15e1d04d-5667-5780-f93b-c4a0a85ef774@starfivetech.com>
Date:   Tue, 7 Mar 2023 14:20:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 01/11] media: dt-bindings: starfive,jh7110-camss: add
 binding document
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230302091921.43309-1-jack.zhu@starfivetech.com>
 <20230302091921.43309-2-jack.zhu@starfivetech.com>
 <10e4ac1e-5c4d-4d6d-53e6-fbc1142940f9@linaro.org>
Content-Language: en-US
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <10e4ac1e-5c4d-4d6d-53e6-fbc1142940f9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/3 16:34, Krzysztof Kozlowski wrote:
> On 02/03/2023 10:19, jack.zhu wrote:
>> Add DT binding document for Starfive Camera subsystem driver
>> 
>> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>
>> ---
>>  .../bindings/media/starfive,jh7110-camss.yaml | 150 ++++++++++++++++++
>>  1 file changed, 150 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> new file mode 100644
>> index 000000000000..9a34944ca0ab
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> @@ -0,0 +1,150 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> Drop quotes from both.

OK, I will fix it in V2 version.

> 
>> +
>> +title: Starfive SoC CAMSS ISP
>> +
>> +maintainers:
>> +  - Jack Zhu <jack.zhu@starfivetech.com>
>> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
>> +
>> +description: |
> 
> No need for '|'

OK, I will fix it.

> 
>> +  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC.It
>> +  consists of a VIN controller(Video In Controller, a top-level control until)
>> +  and a ISP.
> 
> "an ISP", I think

I will revise it.

> 
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-camss
>> +
>> +  reg:
>> +    minItems: 2
> 
> Drop minItems, no need.

OK, I will drop it.

> 
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    items:
>> +      - const: syscon
>> +      - const: isp
>> +
>> +  clocks:
>> +    minItems: 7
> 
> Drop mintems

I will drop it.

> 
>> +    maxItems: 7
>> +
>> +  clock-names:
>> +    items:
>> +      - const: clk_apb_func
>> +      - const: clk_wrapper_clk_c
>> +      - const: clk_dvp_inv
>> +      - const: clk_axiwr
>> +      - const: clk_mipi_rx0_pxl
>> +      - const: clk_ispcore_2x
>> +      - const: clk_isp_axi
> 
> Drop "clk" prefix

I will drop it.

> 
>> +
>> +  resets:
>> +    minItems: 6
> 
> Drop

I will drop it.

> 
>> +    maxItems: 6
>> +
>> +  reset-names:
>> +    items:
>> +      - const: rst_wrapper_p
> 
> Drop rst prefix

OK, will fix it.

> 
>> +      - const: rst_wrapper_c
>> +      - const: rst_axird
>> +      - const: rst_axiwr
>> +      - const: rst_isp_top_n
>> +      - const: rst_isp_top_axi
>> +
>> +  power-domains:
>> +    items:
>> +      - description: JH7110 PD ISP - ISP Power Domain Switch Controller.
> 
> Drop redundant pieces, e.g. "PD ISP"

OK, will fix it.

> 
>> +
>> +  interrupts:
>> +    minItems: 4
> 
> Drop

OK, will drop it.

> 
>> +    maxItems: 4
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port@1:
> 
> And what about port@0?

port@0 is reserved for DVP sensor, although it is not supported yet.

> 
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>> +        unevaluatedProperties: false
>> +        description:
>> +          Input port for receiving CSI data.
>> +
>> +        properties:
>> +          endpoint@1:
> 
> Hm, do you have more than one endpoint in this port? Why unit address?

OK, I will change it to "endpoint:"

> 
>> +            $ref: video-interfaces.yaml#
>> +            unevaluatedProperties: false
>> +
>> +    required:
>> +      - port@1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - power-domains
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +
> 
> Drop blank line

I will drop it.

> 
>> +    stfcamss: camss@19840000 {
> 
> isp@

I will alter it.

> 
>> +        compatible = "starfive,jh7110-camss";
>> +        reg = <0x19840000 0x10000>,
>> +            <0x19870000 0x30000>;
> 
> All this looks misaligned
>> +        reg-names = "syscon", "isp";
>> +        clocks = <&ispcrg 0>,
>> +            <&ispcrg 13>,
> 
> Looks even worse...

I will fix it.

> 
>> +            <&ispcrg 2>,
>> +            <&ispcrg 12>,
>> +            <&ispcrg 1>,
>> +            <&syscrg 51>,
>> +            <&syscrg 52>;
>> +        clock-names = "clk_apb_func",
>> +            "clk_wrapper_clk_c",
>> +            "clk_dvp_inv",
>> +            "clk_axiwr",
>> +            "clk_mipi_rx0_pxl",
>> +            "clk_ispcore_2x",
>> +            "clk_isp_axi";
>> +        resets = <&ispcrg 0>,
>> +            <&ispcrg 1>,
>> +            <&ispcrg 10>,
>> +            <&ispcrg 11>,
>> +            <&syscrg 41>,
>> +            <&syscrg 42>;
>> +        reset-names = "rst_wrapper_p",
>> +            "rst_wrapper_c",
>> +            "rst_axird",
>> +            "rst_axiwr",
>> +            "rst_isp_top_n",
>> +            "rst_isp_top_axi";
>> +        power-domains = <&pwrc 5>;
>> +        interrupts = <92>, <87>, <88>, <90>;
>> +
>> +        ports {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            port@1 {
>> +                reg = <1>;
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                vin_from_csi2rx: endpoint@1 {
>> +                    reg = <1>;
>> +                    remote-endpoint = <&csi2rx_to_vin>;
>> +                };
>> +            };
>> +        };
>> +    };
> 
> Best regards,
> Krzysztof
> 
