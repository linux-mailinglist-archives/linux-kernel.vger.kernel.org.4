Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08DF7196B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjFAJU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjFAJUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:20:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A74197;
        Thu,  1 Jun 2023 02:20:23 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126205251136.34.openmobile.ne.jp [126.205.251.136])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62ADE105;
        Thu,  1 Jun 2023 11:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685611200;
        bh=7OZvICe7BBhFf4AJNPBe52r/1K16wC/5FM5zeCzqEQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWN6EvuqeXh+2xq6KOFe6UAjhn+yDIWo5ZzOnpbcTVUoWM1TDvGpHf+tlKWUE3yBp
         n/F2xL2QN6DWaCT6J1RnnDrORx0nF/nWoYoeZsDYwAQrX7Dz2170CZTiejDK5vdAM0
         LLahCJEvaRMTnMv1sDnE+HhaCZNsNlSXU0WkqV9s=
Date:   Thu, 1 Jun 2023 12:20:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v6 1/6] media: dt-bindings: Add JH7110 Camera Subsystem
Message-ID: <20230601092020.GF22609@pendragon.ideasonboard.com>
References: <20230525083202.67933-1-jack.zhu@starfivetech.com>
 <20230525083202.67933-2-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230525083202.67933-2-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Thank you for the patch.

On Thu, May 25, 2023 at 04:31:57PM +0800, Jack Zhu wrote:
> Add the bindings documentation for Starfive JH7110 Camera Subsystem
> which is used for handing image sensor data.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../bindings/media/starfive,jh7110-camss.yaml | 180 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 187 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> new file mode 100644
> index 000000000000..c66586d90fa2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> @@ -0,0 +1,180 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Starfive SoC CAMSS ISP
> +
> +maintainers:
> +  - Jack Zhu <jack.zhu@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +description:
> +  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC. It
> +  consists of a VIN controller (Video In Controller, a top-level control unit)
> +  and an ISP.
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-camss
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: syscon
> +      - const: isp
> +
> +  clocks:
> +    maxItems: 7
> +
> +  clock-names:
> +    items:
> +      - const: apb_func
> +      - const: wrapper_clk_c
> +      - const: dvp_inv
> +      - const: axiwr
> +      - const: mipi_rx0_pxl
> +      - const: ispcore_2x
> +      - const: isp_axi
> +
> +  resets:
> +    maxItems: 6
> +
> +  reset-names:
> +    items:
> +      - const: wrapper_p
> +      - const: wrapper_c
> +      - const: axird
> +      - const: axiwr
> +      - const: isp_top_n
> +      - const: isp_top_axi
> +
> +  power-domains:
> +    items:
> +      - description: JH7110 ISP Power Domain Switch Controller.
> +
> +  interrupts:
> +    maxItems: 4
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Input port for receiving DVP data.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              bus-type:
> +                enum: [5, 6]
> +
> +              bus-width:
> +                enum: [8, 10, 12]
> +
> +              data-shift:
> +                enum: [0, 2]
> +                default: 0
> +
> +              hsync-active:
> +                enum: [0, 1]
> +                default: 1
> +
> +              vsync-active:
> +                enum: [0, 1]
> +                default: 1
> +
> +            required:
> +              - bus-type
> +              - bus-width
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Input port for receiving CSI data.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - power-domains
> +  - interrupts
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    isp@19840000 {
> +        compatible = "starfive,jh7110-camss";
> +        reg = <0x19840000 0x10000>,
> +              <0x19870000 0x30000>;
> +        reg-names = "syscon", "isp";
> +        clocks = <&ispcrg 0>,
> +                 <&ispcrg 13>,
> +                 <&ispcrg 2>,
> +                 <&ispcrg 12>,
> +                 <&ispcrg 1>,
> +                 <&syscrg 51>,
> +                 <&syscrg 52>;
> +        clock-names = "apb_func",
> +                      "wrapper_clk_c",
> +                      "dvp_inv",
> +                      "axiwr",
> +                      "mipi_rx0_pxl",
> +                      "ispcore_2x",
> +                      "isp_axi";
> +        resets = <&ispcrg 0>,
> +                 <&ispcrg 1>,
> +                 <&ispcrg 10>,
> +                 <&ispcrg 11>,
> +                 <&syscrg 41>,
> +                 <&syscrg 42>;
> +        reset-names = "wrapper_p",
> +                      "wrapper_c",
> +                      "axird",
> +                      "axiwr",
> +                      "isp_top_n",
> +                      "isp_top_axi";
> +        power-domains = <&pwrc 5>;
> +        interrupts = <92>, <87>, <88>, <90>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            port@0 {
> +                reg = <0>;
> +                vin_from_sc2235: endpoint {
> +                    remote-endpoint = <&sc2235_to_vin>;
> +                    bus-type = <5>;
> +                    bus-width = <8>;
> +                    data-shift = <2>;
> +                    hsync-active = <1>;
> +                    vsync-active = <0>;
> +                    pclk-sample = <1>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +                vin_from_csi2rx: endpoint {
> +                    remote-endpoint = <&csi2rx_to_vin>;
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 869e1c7fc869..9ef5d0e5dff0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20070,6 +20070,13 @@ M:	Ion Badulescu <ionut@badula.org>
>  S:	Odd Fixes
>  F:	drivers/net/ethernet/adaptec/starfire*
>  
> +STARFIVE CAMERA SUBSYSTEM DRIVER
> +M:	Jack Zhu <jack.zhu@starfivetech.com>
> +M:	Changhuang Liang <changhuang.liang@starfivetech.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> +
>  STARFIVE DEVICETREES
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  S:	Maintained

-- 
Regards,

Laurent Pinchart
