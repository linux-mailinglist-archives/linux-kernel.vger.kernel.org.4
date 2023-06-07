Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD5C726256
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbjFGOIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbjFGOIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:08:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A507426A9;
        Wed,  7 Jun 2023 07:07:27 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126233170111.36.openmobile.ne.jp [126.233.170.111])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3405574C;
        Wed,  7 Jun 2023 16:06:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686146776;
        bh=kCRKxvi6zAil5DUbFlSXgY362+TZAeDnMNb4BtuTjxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVIAlSkH4e4J34zanVyVIXvMOPMkZ2o3VabjAYEo48/hO6GesmWWCQAGJiTJs0Koi
         WLSoHBAu+h/oW6j/BbSlUYDCzyie1TVdxOYOYH5r4OEymHN0ge1uyz3IK5RVXQE4u4
         eWk5yJLcOXJDfI5YuPWz92gUDOn/qQwOXVcZYKTs=
Date:   Wed, 7 Jun 2023 17:06:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <20230607140638.GA16848@pendragon.ideasonboard.com>
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
 <20230607131936.382406-3-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607131936.382406-3-tomm.merciai@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 03:19:24PM +0200, Tommaso Merciai wrote:
> Add documentation of device tree in YAML schema for the ALVIUM
> Camera from Allied Vision Inc.
> 
> References:
>  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v1:
>  - Fixed build error as suggested by RHerring bot
> 
> Changes since v2:
>  - Fixed License as suggested by KKozlowski/CDooley
>  - Removed rotation property as suggested by CDooley/LPinchart
>  - Fixed example node name as suggested by CDooley
>  - Fixed title as suggested by LPinchart
>  - Fixed compatible name as suggested by LPinchart
>  - Removed clock as suggested by LPinchart
>  - Removed gpios not as suggested by LPinchart
>  - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
>  - Fixed vendor prefix, unit append as suggested by KKozlowski
>  - Fixed data-lanes
>  - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
>  - Dropped status into example  as suggested by KKozlowski
>  - Added vcc-ext-in supply as suggested by LPinchart
>  - Dropped pinctrl into example as suggested by LPinchart
> 
> Changes since v3:
>  - Fixed vcc-ext-in-supply description as suggested by LPinchart
>  - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
>  - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
>  - Collected Reviewed-by tag from LPinchart
> 
>  .../media/i2c/alliedvision,alvium-csi2.yaml   | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> new file mode 100644
> index 000000000000..4726d0068229
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#

This is still wrong, see Rob's bot reply in the previous version.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allied Vision Alvium Camera
> +
> +maintainers:
> +  - Tommaso Merciai <tomm.merciai@gmail.com>
> +  - Martin Hecht <martin.hecht@avnet.eu>
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: alliedvision,alvium-csi2
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-ext-in-supply:
> +    description: |
> +      The regulator that supplies power to the VCC_EXT_IN pins.
> +
> +  alliedvision,lp2hs-delay-us:
> +    maximum: 150000
> +    description: |
> +      Low power to high speed delay time.
> +
> +      If the value is larger than 0, the camera forces a reset of all
> +      D-PHY lanes for the duration specified by this property. All lanes
> +      will transition to the low-power state and back to the high-speed
> +      state after the delay. Otherwise the lanes will transition to and
> +      remain in the high-speed state immediately after power on.
> +
> +      This is meant to help CSI-2 receivers synchronizing their D-PHY
> +      RX.
> +
> +  port:
> +    description: Digital Output Port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          link-frequencies: true
> +
> +          data-lanes:
> +            minItems: 1
> +            items:
> +              - const: 1
> +              - const: 2
> +              - const: 3
> +              - const: 4
> +
> +        required:
> +          - data-lanes
> +          - link-frequencies
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-ext-in-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        alvium: camera@3c {
> +            compatible = "alliedvision,alvium-csi2";
> +            reg = <0x3c>;
> +            vcc-ext-in-supply = <&reg_vcc_ext_in>;
> +            alliedvision,lp2hs-delay-us = <20>;
> +
> +            port {
> +                alvium_out: endpoint {
> +                    remote-endpoint = <&mipi_csi_0_in>;
> +                    data-lanes = <1 2 3 4>;
> +                    link-frequencies = /bits/ 64 <681250000>;
> +                };
> +            };
> +        };
> +    };
> +
> +...

-- 
Regards,

Laurent Pinchart
