Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676B86EDBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 08:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjDYGe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 02:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjDYGey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:34:54 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5374EE2;
        Mon, 24 Apr 2023 23:34:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 55FB524E059;
        Tue, 25 Apr 2023 14:34:49 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Apr
 2023 14:34:49 +0800
Received: from [192.168.60.155] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Apr
 2023 14:34:48 +0800
Message-ID: <f444f695-cd2b-a8e6-b22f-cfbe0cbeb55b@starfivetech.com>
Date:   Tue, 25 Apr 2023 14:34:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 6/8] media: dt-bindings: Add bindings for JH7110 Camera
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
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230413035541.62129-1-jack.zhu@starfivetech.com>
 <20230413035541.62129-7-jack.zhu@starfivetech.com>
 <20230419061540.GB11679@pendragon.ideasonboard.com>
 <bf265594-3bd1-eba5-7a4a-910e331dcca8@starfivetech.com>
 <20230424120217.GA5444@pendragon.ideasonboard.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230424120217.GA5444@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laurent,

On 2023/4/24 20:02, Laurent Pinchart wrote:
> Hi Jack,
> 
> On Thu, Apr 20, 2023 at 04:51:39PM +0800, Jack Zhu wrote:
>> On 2023/4/19 14:15, Laurent Pinchart wrote:
>> > On Thu, Apr 13, 2023 at 11:55:39AM +0800, Jack Zhu wrote:
>> >> Add the bindings documentation for Starfive JH7110 Camera Subsystem
>> >> which is used for handing image sensor data.
>> >> 
>> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> >> ---
>> >>  .../bindings/media/starfive,jh7110-camss.yaml | 164 ++++++++++++++++++
>> >>  MAINTAINERS                                   |   7 +
>> >>  2 files changed, 171 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> >> 
>> >> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> >> new file mode 100644
>> >> index 000000000000..4cd144f1b845
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> >> @@ -0,0 +1,164 @@
>> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> >> +
>> >> +%YAML 1.2
>> >> +---
>> >> +$id: http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#
>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> +
>> >> +title: Starfive SoC CAMSS ISP
>> >> +
>> >> +maintainers:
>> >> +  - Jack Zhu <jack.zhu@starfivetech.com>
>> >> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
>> >> +
>> >> +description:
>> >> +  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC. It
>> >> +  consists of a VIN controller (Video In Controller, a top-level control until)
>> >> +  and an ISP.
>> >> +
>> >> +properties:
>> >> +  compatible:
>> >> +    const: starfive,jh7110-camss
>> >> +
>> >> +  reg:
>> >> +    maxItems: 2
>> >> +
>> >> +  reg-names:
>> >> +    items:
>> >> +      - const: syscon
>> >> +      - const: isp
>> >> +
>> >> +  clocks:
>> >> +    maxItems: 7
>> >> +
>> >> +  clock-names:
>> >> +    items:
>> >> +      - const: apb_func
>> >> +      - const: wrapper_clk_c
>> >> +      - const: dvp_inv
>> >> +      - const: axiwr
>> >> +      - const: mipi_rx0_pxl
>> >> +      - const: ispcore_2x
>> >> +      - const: isp_axi
>> >> +
>> >> +  resets:
>> >> +    maxItems: 6
>> >> +
>> >> +  reset-names:
>> >> +    items:
>> >> +      - const: wrapper_p
>> >> +      - const: wrapper_c
>> >> +      - const: axird
>> >> +      - const: axiwr
>> >> +      - const: isp_top_n
>> >> +      - const: isp_top_axi
>> >> +
>> >> +  power-domains:
>> >> +    items:
>> >> +      - description: JH7110 ISP Power Domain Switch Controller.
>> >> +
>> >> +  interrupts:
>> >> +    maxItems: 4
>> >> +
>> >> +  ports:
>> >> +    $ref: /schemas/graph.yaml#/properties/ports
>> >> +
>> >> +    properties:
>> >> +      port@0:
>> >> +        $ref: /schemas/graph.yaml#/$defs/port-base
>> >> +        unevaluatedProperties: false
>> >> +        description: Input port for receiving DVP data.
>> >> +
>> >> +        properties:
>> >> +          endpoint:
>> >> +            $ref: video-interfaces.yaml#
>> >> +            unevaluatedProperties: false
>> >> +
>> >> +            properties:
>> >> +              bus-width:
>> >> +                const: 8
>> >> +
>> >> +              data-shift:
>> >> +                const: 2
>> > 
>> > As far as I can tell, those two properties are not handled by the
>> > driver. I assume this is because the driver doesn't support the DVP
>> > input yet. That's fine, but it makes it a bit hard to review the device
>> > tree. Could you provide some information about the DVP hardware
>> > interface ? Does it support both BT.656 and sync signals, or just sync
>> > signals ? Are the polarities of the clock and h/v sync controllable ?
>> > Is the parallel input bus 8-bit wide or are other options supported ?
>> > And finally, what are you modelling with data-shift: 2 ?
>> 
>> Hello Laurent,
>> 
>> The DVP hardware supports BT.656 and sync signals, can control the
>> polarities of h/v sync, supports 8/10/12 bit wide, and data-shift: 2 is
>> line 9-2.
> 
> Thank you for the information. Endpoints for port@0 should then require
> bus-type. The hsync-active and vsync-active should be listed with
> default values and be optional. bus-width should have 8, 10 and 12 as
> supported values, and be required, or have a default (I think making it
> required is best). data-shift should list supported values too,
> including 0, and be optional with a default of 0.
> 

Thank you for your suggestion. I will make the following modifications:

            properties:
              bus-type:
                enum: [5, 6]

              bus-width:
                enum: [8, 10, 12]

              data-shift:
                enum: [0, 2]
                default: 0

              hsync-active:
                enum: [0, 1]
                default: 1

              vsync-active:
                enum: [0, 1]
                default: 1
            
            required:
              - bus-type
              - bus-width

>> >> +
>> >> +      port@1:
>> >> +        $ref: /schemas/graph.yaml#/properties/port
>> >> +        description: Input port for receiving CSI data.
>> >> +
>> >> +    required:
>> >> +      - port@0
>> >> +      - port@1
>> >> +
>> >> +required:
>> >> +  - compatible
>> >> +  - reg
>> >> +  - reg-names
>> >> +  - clocks
>> >> +  - clock-names
>> >> +  - resets
>> >> +  - reset-names
>> >> +  - power-domains
>> >> +  - interrupts
>> >> +  - ports
>> >> +
>> >> +additionalProperties: false
>> >> +
>> >> +examples:
>> >> +  - |
>> >> +    isp@19840000 {
>> >> +        compatible = "starfive,jh7110-camss";
>> >> +        reg = <0x19840000 0x10000>,
>> >> +              <0x19870000 0x30000>;
>> >> +        reg-names = "syscon", "isp";
>> >> +        clocks = <&ispcrg 0>,
>> >> +                 <&ispcrg 13>,
>> >> +                 <&ispcrg 2>,
>> >> +                 <&ispcrg 12>,
>> >> +                 <&ispcrg 1>,
>> >> +                 <&syscrg 51>,
>> >> +                 <&syscrg 52>;
>> >> +        clock-names = "apb_func",
>> >> +                      "wrapper_clk_c",
>> >> +                      "dvp_inv",
>> >> +                      "axiwr",
>> >> +                      "mipi_rx0_pxl",
>> >> +                      "ispcore_2x",
>> >> +                      "isp_axi";
>> >> +        resets = <&ispcrg 0>,
>> >> +                 <&ispcrg 1>,
>> >> +                 <&ispcrg 10>,
>> >> +                 <&ispcrg 11>,
>> >> +                 <&syscrg 41>,
>> >> +                 <&syscrg 42>;
>> >> +        reset-names = "wrapper_p",
>> >> +                      "wrapper_c",
>> >> +                      "axird",
>> >> +                      "axiwr",
>> >> +                      "isp_top_n",
>> >> +                      "isp_top_axi";
>> >> +        power-domains = <&pwrc 5>;
>> >> +        interrupts = <92>, <87>, <88>, <90>;
>> >> +
>> >> +        ports {
>> >> +            #address-cells = <1>;
>> >> +            #size-cells = <0>;
>> >> +            port@0 {
>> >> +                reg = <0>;
>> >> +                vin_from_sc2235: endpoint {
>> >> +                    remote-endpoint = <&sc2235_to_vin>;
>> >> +                    bus-width = <8>;
>> >> +                    data-shift = <2>;
>> >> +                    hsync-active = <1>;
>> >> +                    vsync-active = <0>;
>> >> +                    pclk-sample = <1>;
>> >> +                };
>> >> +            };
>> >> +
>> >> +            port@1 {
>> >> +                reg = <1>;
>> >> +                vin_from_csi2rx: endpoint {
>> >> +                    remote-endpoint = <&csi2rx_to_vin>;
>> >> +                };
>> >> +            };
>> >> +        };
>> >> +    };
>> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> index bbb8b5c0187b..b8c76b0d7eb3 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -19909,6 +19909,13 @@ M:	Ion Badulescu <ionut@badula.org>
>> >>  S:	Odd Fixes
>> >>  F:	drivers/net/ethernet/adaptec/starfire*
>> >>  
>> >> +STARFIVE CAMERA SUBSYSTEM DRIVER
>> >> +M:	Jack Zhu <jack.zhu@starfivetech.com>
>> >> +M:	Changhuang Liang <changhuang.liang@starfivetech.com>
>> >> +L:	linux-media@vger.kernel.org
>> >> +S:	Maintained
>> >> +F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> >> +
>> >>  STARFIVE DEVICETREES
>> >>  M:	Emil Renner Berthing <kernel@esmil.dk>
>> >>  S:	Maintained
> 
