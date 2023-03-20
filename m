Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517886C0A88
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCTGYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCTGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:24:43 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA67D83E2;
        Sun, 19 Mar 2023 23:24:39 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 91EFE24DFD7;
        Mon, 20 Mar 2023 14:24:38 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 14:24:38 +0800
Received: from [192.168.60.83] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 14:24:38 +0800
Message-ID: <4cf91114-65e7-ba7d-28d3-6f2f93affbde@starfivetech.com>
Date:   Mon, 20 Mar 2023 14:24:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/6] media: dt-bindings: Add bindings for JH7110 Camera
 Subsystem
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Eugen Hristev" <eugen.hristev@collabora.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
 <20230310120553.60586-2-jack.zhu@starfivetech.com>
 <20230312111228.GA2545@pendragon.ideasonboard.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230312111228.GA2545@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/12 19:12, Laurent Pinchart wrote:
> Hi Jack,
> 
> Thank you for the patch.

Thank you for your comments.

> 
> On Fri, Mar 10, 2023 at 08:05:48PM +0800, Jack Zhu wrote:
>> Add the bindings documentation for Starfive JH7110 Camera Subsystem
>> which is used for handing image sensor data.
>> 
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> ---
>>  .../bindings/media/starfive,jh7110-camss.yaml | 144 ++++++++++++++++++
>>  1 file changed, 144 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> new file mode 100644
>> index 000000000000..3f348dd53441
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> @@ -0,0 +1,144 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Starfive SoC CAMSS ISP
>> +
>> +maintainers:
>> +  - Jack Zhu <jack.zhu@starfivetech.com>
>> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
>> +
>> +description:
>> +  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC.It
> 
> s/.It/. It/

OK, will fix

> 
>> +  consists of a VIN controller(Video In Controller, a top-level control until)
> 
> s/(/ (/

OK, will fix

> 
>> +  and an ISP.
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-camss
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    items:
>> +      - const: syscon
>> +      - const: isp
>> +
>> +  clocks:
>> +    maxItems: 7
>> +
>> +  clock-names:
>> +    items:
>> +      - const: apb_func
>> +      - const: wrapper_clk_c
>> +      - const: dvp_inv
>> +      - const: axiwr
>> +      - const: mipi_rx0_pxl
>> +      - const: ispcore_2x
>> +      - const: isp_axi
>> +
>> +  resets:
>> +    maxItems: 6
>> +
>> +  reset-names:
>> +    items:
>> +      - const: wrapper_p
>> +      - const: wrapper_c
>> +      - const: axird
>> +      - const: axiwr
>> +      - const: isp_top_n
>> +      - const: isp_top_axi
>> +
>> +  power-domains:
>> +    items:
>> +      - description: JH7110 ISP Power Domain Switch Controller.
>> +
>> +  interrupts:
>> +    maxItems: 4
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port@1:
> 
> Why port@1 if there is no port@0 ?

Will add port@0 node in the next version.
port@0 is reserved for DVP sensor which is not currently supported.

> 
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
> 
> I think you can use
> 
>         $ref: /schemas/graph.yaml#/properties/port
> 
> here as you don't define any additional property for the port node.

OK, will alter it

> 
>> +        unevaluatedProperties: false
>> +        description:
>> +          Input port for receiving CSI data.
>> +
>> +        properties:
>> +          endpoint:
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
> 
> The 'ports' node should be mandatory too.

OK, will fix. Thanks.

> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    stfcamss: isp@19840000 {
> 
> You can drop the label as it's not used.

OK, will drop.

> 
>> +        compatible = "starfive,jh7110-camss";
>> +        reg = <0x19840000 0x10000>,
>> +              <0x19870000 0x30000>;
>> +        reg-names = "syscon", "isp";
>> +        clocks = <&ispcrg 0>,
>> +                 <&ispcrg 13>,
>> +                 <&ispcrg 2>,
>> +                 <&ispcrg 12>,
>> +                 <&ispcrg 1>,
>> +                 <&syscrg 51>,
>> +                 <&syscrg 52>;
>> +        clock-names = "apb_func",
>> +                      "wrapper_clk_c",
>> +                      "dvp_inv",
>> +                      "axiwr",
>> +                      "mipi_rx0_pxl",
>> +                      "ispcore_2x",
>> +                      "isp_axi";
>> +        resets = <&ispcrg 0>,
>> +                 <&ispcrg 1>,
>> +                 <&ispcrg 10>,
>> +                 <&ispcrg 11>,
>> +                 <&syscrg 41>,
>> +                 <&syscrg 42>;
>> +        reset-names = "wrapper_p",
>> +                      "wrapper_c",
>> +                      "axird",
>> +                      "axiwr",
>> +                      "isp_top_n",
>> +                      "isp_top_axi";
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
>> +                vin_from_csi2rx: endpoint {
>> +                    remote-endpoint = <&csi2rx_to_vin>;
>> +                };
>> +            };
>> +        };
>> +    };
> 
