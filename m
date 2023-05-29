Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228777145C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjE2Hvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjE2Hv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:51:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66B0A7;
        Mon, 29 May 2023 00:51:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126255106133.24.openmobile.ne.jp [126.255.106.133])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B71AD836;
        Mon, 29 May 2023 09:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685346665;
        bh=eFTNMtre/w6DIO0d6Af3j84MFjCZzQZiUGcvJ8Xr6e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mb5hqQRK/y5pqKlNrIdNpcoWlZdX9EQD9/oXxWbGauZ3FBOiuiLKdxDEf4UBTmdTV
         nfSx5AqkhGn2I2EWinr4UXh3HQidn+JOrmZBOUjYy9urTUIzMv/1SVTr8OzSjj9tRB
         Heeb/wPxgLaucRUgqIddRVR9CSyULk2SxUJXrtLU=
Date:   Mon, 29 May 2023 10:51:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <20230529075126.GG25984@pendragon.ideasonboard.com>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-2-tomm.merciai@gmail.com>
 <ZHPElYOeD2C1qo4R@kekkonen.localdomain>
 <ZHRXI6c7G3Sh03i9@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZHRXI6c7G3Sh03i9@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Mon, May 29, 2023 at 09:41:23AM +0200, Tommaso Merciai wrote:
> On Sun, May 28, 2023 at 09:16:05PM +0000, Sakari Ailus wrote:
> > On Fri, May 26, 2023 at 07:39:43PM +0200, Tommaso Merciai wrote:
> > > Add documentation of device tree in YAML schema for the ALVIUM
> > > Camera from Allied Vision Inc.
> > > 
> > > References:
> > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > 
> > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > ---
> > > Changes since v1:
> > >  - Fixed build error as suggested by RHerring bot
> > > 
> > >  .../media/i2c/alliedvision,alvium.yaml        | 115 ++++++++++++++++++
> > >  1 file changed, 115 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > > new file mode 100644
> > > index 000000000000..81e9e560c99d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > > @@ -0,0 +1,115 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Alliedvision Alvium Camera
> > > +
> > > +maintainers:
> > > +  - Tommaso Merciai <tomm.merciai@gmail.com>
> > > +  - Martin Hecht <martin.hecht@avnet.eu>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: alliedvision,alvium
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    description: XCLK Input Clock
> > > +
> > > +  clock-names:
> > > +    const: xclk
> > 
> > I'd also drop this as you have a single clock only: it's redundant.
> 
> Then you suggest also to drop devm_clk_get(dev, "xclk");
> into the driver code and use devm_clk_get(&pdev->dev, NULL);
> right?

Actually, I don't see any clock input pin in the 22-pins FPC connector.
Are you sure the camera module needs an external clock ?

> > > +
> > > +  powerdown-gpios:
> > > +    maxItems: 1
> > > +    description: >
> > > +      Reference to the GPIO connected to the powerdown pin, if any.
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +    description: >
> > > +      Reference to the GPIO connected to the reset pin, if any.
> > > +
> > > +  streamon-delay:
> > > +    maxItems: 1
> > > +    description: >
> > > +      Delay before camera start capturing frames in us.
> > > +
> > > +  rotation:
> > > +    enum:
> > > +      - 0
> > > +      - 180
> > > +
> > > +  port:
> > > +    description: Digital Output Port
> > > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > > +    additionalProperties: false
> > > +
> > > +    properties:
> > > +      endpoint:
> > > +        $ref: /schemas/media/video-interfaces.yaml#
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          clock-lanes:
> > > +            const: 0
> > 
> > The driver can know this, no need to have it in DT, i.e. please drop it.
> 
> Oks.
> 
> > 
> > > +          data-lanes:
> > > +            minItems: 1
> > > +            maxItems: 4
> > > +          link-frequencies: true
> > > +
> > > +        required:
> > > +          - data-lanes
> > > +          - link-frequencies
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - port
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +      #include <dt-bindings/gpio/gpio.h>
> > > +      #include <dt-bindings/clock/imx8mp-clock.h>
> > > +
> > > +      i2c {
> > > +          #address-cells = <1>;
> > > +          #size-cells = <0>;
> > > +
> > > +          camera: alvium@3c {
> > > +              compatible = "alliedvision,alvium";
> > > +              pinctrl-names = "default";
> > > +              pinctrl-0 = <&pinctrl_csi0_pwn>, <&pinctrl_csi0_rst>, <&pinctrl_csi_mclk>;
> > > +              reg = <0x3c>;
> > > +              clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> > > +              clock-names = "xclk";
> > > +              assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> > > +              assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
> > > +              assigned-clock-rates = <24000000>;
> > > +              streamon-delay = <20>;
> > > +              powerdown-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> > > +              reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> > > +              status = "okay";
> > > +
> > > +              port {
> > > +                  alvium_out: endpoint {
> > > +                      remote-endpoint = <&mipi_csi_0_in>;
> > > +                      data-lanes = <1 2 3 4>;
> > > +                      link-frequencies = /bits/ 64 <681250000>;
> > > +                      clock-lanes = <0>;
> > > +                  };
> > > +              };
> > > +          };
> > > +      };
> > > +
> > > +...

-- 
Regards,

Laurent Pinchart
