Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2645F718518
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbjEaOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjEaOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:36:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4678F;
        Wed, 31 May 2023 07:36:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126205251136.34.openmobile.ne.jp [126.205.251.136])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7E7E7F5;
        Wed, 31 May 2023 16:35:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685543751;
        bh=1SJE82aosANYC/2GkoHIf8O9j2MMakzTQj5dEJLPoCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9RFXwnRXh42Fqs1/+s8grkr5M+K9e1+nR2GovL7VdG4RggrFzuJLKVpompDXPFk+
         XsrJ02NFmPougxRcMQw498VVNuFCfED0+kpS5iNTER8mLAQFfcDqMh95RrLyyY6LPS
         szoc2sb1T/skzVBOW0/dXf03yts8xXqCwxF0gsEk=
Date:   Wed, 31 May 2023 17:36:11 +0300
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
Message-ID: <20230531143611.GA24749@pendragon.ideasonboard.com>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-2-tomm.merciai@gmail.com>
 <ZHPElYOeD2C1qo4R@kekkonen.localdomain>
 <20230529063907.GB25984@pendragon.ideasonboard.com>
 <20230529064326.GC25984@pendragon.ideasonboard.com>
 <ZHcff4Gpr9QSgpOs@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230531110600.GB27043@pendragon.ideasonboard.com>
 <ZHdTVT2Ylxlo5NL4@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHdTVT2Ylxlo5NL4@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Wed, May 31, 2023 at 04:01:57PM +0200, Tommaso Merciai wrote:
> On Wed, May 31, 2023 at 02:06:00PM +0300, Laurent Pinchart wrote:
> > On Wed, May 31, 2023 at 12:20:47PM +0200, Tommaso Merciai wrote:
> > > On Mon, May 29, 2023 at 09:43:26AM +0300, Laurent Pinchart wrote:
> > > > On Mon, May 29, 2023 at 09:39:13AM +0300, Laurent Pinchart wrote:
> > > > > On Sun, May 28, 2023 at 09:16:05PM +0000, Sakari Ailus wrote:
> > > > > > On Fri, May 26, 2023 at 07:39:43PM +0200, Tommaso Merciai wrote:
> > > > > > > Add documentation of device tree in YAML schema for the ALVIUM
> > > > > > > Camera from Allied Vision Inc.
> > > > > > > 
> > > > > > > References:
> > > > > > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > > > > > 
> > > > > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > > > ---
> > > > > > > Changes since v1:
> > > > > > >  - Fixed build error as suggested by RHerring bot
> > > > > > > 
> > > > > > >  .../media/i2c/alliedvision,alvium.yaml        | 115 ++++++++++++++++++
> > > > > > >  1 file changed, 115 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > > > > > > 
> > > > > > > diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..81e9e560c99d
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > > > > > > @@ -0,0 +1,115 @@
> > > > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Alliedvision Alvium Camera
> > > > > 
> > > > > s/Alliedvision/Allied Vision/
> > > > > 
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > > > +  - Martin Hecht <martin.hecht@avnet.eu>
> > > > > > > +
> > > > > > > +allOf:
> > > > > > > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    const: alliedvision,alvium
> > > > > 
> > > > > The name is very generic. There are Alvium camera modules that have a
> > > > > GMSL or FPD-Link interface, and I'm pretty sure those will require a
> > > > > different driver. I would add module-specific compatible strings (e.g.
> > > > > "alliedvision,alvium-1500c", ...) here, with a generic fallback.
> > > > > "alliedvision,alvium" isn't good as it won't cover GMSL or FPD-Link,
> > > > > maybe "alliedvision,alvium-csi2" would be an option.
> > > > 
> > > > Actually, "alvium-1500c" as a specific compatible string won't do. You
> > > > need the exact model in the compatible string, otherwise it won't be
> > > > possible for the driver to handle device-specific configuration (for
> > > > instance accessing registers of the camera sensor for fine-grained
> > > > configuration). I would thus recommend using "alliedvision,alvium-1500c"
> > > > and "alliedvision,alvium-1800c" as generic fallbacks, along compatible
> > > > strings that include the exact device model.
> > > 
> > > Agree with alliedvision,alvium-csi2 and thanks for your suggestion.
> > > In my opinion we don’t need names for 1500c and 
> > > others because the same driver can drive all the alvium models.
> > > Alvium is taking care of different sensor abstractions.
> > > 
> > > I test with this driver with the following models:
> > > 
> > >  - 1800 C-1240c
> > >  - 1800 C-040c
> > >  - 1500 C-500
> > > 
> > > What do you think about?
> > 
> > As far as I understand, the camera modules allow accessing sensors
> > registers from the host (through the ISP) for fine-grained
> > configuration. Even if that's not implemented in the driver at the
> > moment, I think it's an important feature to eventually support, and it
> > will require a way for the system to identify the camera module
> > precisely, to know which sensor the module uses. That's why I would like
> > that information to be available in DT, in the form of a compatible
> > string. For instance,
> > 
> > 	compatible = "alliedvision,alvium-1500c-1240c",
> > 		     "alliedvision,alvium-1500c";
> > 
> > The driver will only need DT match entries for
> > "alliedvision,alvium-1500c" and "alliedvision,alvium-1800c".
> 
> Thanks for your feedback.
> 
> Some clarification:
> 
> The Alvium doesn't allow direct access on the sensor.
> Alvium hides the particular sensor totally.

I think I got misled by the "Direct Register Access (DRA) to control the
cameras via registers for advanced users" mention on the Allied Vision
website, and thought direct register access to the sensor was possible.

> For this reason I would prefer to keep generic
> "alvium-csi2" name.

Given that the camera has device identification registers, that should
be OK.

> > > > > > > +
> > > > > > > +  reg:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  clocks:
> > > > > > > +    description: XCLK Input Clock
> > > > > > > +
> > > > > > > +  clock-names:
> > > > > > > +    const: xclk
> > > > > > 
> > > > > > I'd also drop this as you have a single clock only: it's redundant.
> > > > > > 
> > > > > > > +
> > > > > > > +  powerdown-gpios:
> > > > > > > +    maxItems: 1
> > > > > > > +    description: >
> > > > > > > +      Reference to the GPIO connected to the powerdown pin, if any.
> > > > > > > +
> > > > > > > +  reset-gpios:
> > > > > > > +    maxItems: 1
> > > > > > > +    description: >
> > > > > > > +      Reference to the GPIO connected to the reset pin, if any.
> > > > > 
> > > > > Reading the Alvium CSI-2 Cameras User Guide, I don't see any powerdown
> > > > > or reset pin on the 22-pin connector. Am I missing something ? There are
> > > > > however two GPIOs (in addition to the I2C signals that are also
> > > > > documented as GPIOs), do you plan to support those ?
> > > > > 
> > > > > > > +
> > > > > > > +  streamon-delay:
> > > > > > > +    maxItems: 1
> > > > > > > +    description: >
> > > > > > > +      Delay before camera start capturing frames in us.
> > > > > 
> > > > > Add "-us" to the property name to indicate the unit.
> > > > > 
> > > > > This is a vendor-specific property, and should thus have a vendor
> > > > > prefix.
> > > > > 
> > > > > A longer description is needed, from that single line I have no idea
> > > > > what the property does exactly.
> > > > > 
> > > > > > > +
> > > > > > > +  rotation:
> > > > > > > +    enum:
> > > > > > > +      - 0
> > > > > > > +      - 180
> > > > > 
> > > > > Why is the rotation restricted to 0 or 180 ? Someone could mount the
> > > > > module with  90 degrees rotation, shouldn't the DT bindings allow
> > > > > describing that ?
> > > > > 
> > > > > You need a property for the vcc-ext-in supply.
> > > > > 
> > > > > > > +
> > > > > > > +  port:
> > > > > > > +    description: Digital Output Port
> > > > > > > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > > > > > > +    additionalProperties: false
> > > > > > > +
> > > > > > > +    properties:
> > > > > > > +      endpoint:
> > > > > > > +        $ref: /schemas/media/video-interfaces.yaml#
> > > > > > > +        unevaluatedProperties: false
> > > > > > > +
> > > > > > > +        properties:
> > > > > > > +          clock-lanes:
> > > > > > > +            const: 0
> > > > > > 
> > > > > > The driver can know this, no need to have it in DT, i.e. please drop it.
> > > > > > 
> > > > > > > +          data-lanes:
> > > > > > > +            minItems: 1
> > > > > > > +            maxItems: 4
> > > > > > > +          link-frequencies: true
> > > > > > > +
> > > > > > > +        required:
> > > > > > > +          - data-lanes
> > > > > > > +          - link-frequencies
> > > > > > > +
> > > > > > > +required:
> > > > > > > +  - compatible
> > > > > > > +  - reg
> > > > > > > +  - clocks
> > > > > > > +  - clock-names
> > > > > > > +  - port
> > > > > > > +
> > > > > > > +additionalProperties: false
> > > > > > > +
> > > > > > > +examples:
> > > > > > > +  - |
> > > > > > > +      #include <dt-bindings/gpio/gpio.h>
> > > > > > > +      #include <dt-bindings/clock/imx8mp-clock.h>
> > > > > > > +
> > > > > > > +      i2c {
> > > > > > > +          #address-cells = <1>;
> > > > > > > +          #size-cells = <0>;
> > > > > > > +
> > > > > > > +          camera: alvium@3c {
> > > > > > > +              compatible = "alliedvision,alvium";
> > > > > 
> > > > > The "alliedvision" prefix is missing from
> > > > > Documentation/devicetree/bindings/vendor-prefixes.yaml.
> > > > > 
> > > > > > > +              pinctrl-names = "default";
> > > > > > > +              pinctrl-0 = <&pinctrl_csi0_pwn>, <&pinctrl_csi0_rst>, <&pinctrl_csi_mclk>;
> > > > > 
> > > > > I'd drop pinctrl, it makes the example longer without adding much value.
> > > > > 
> > > > > > > +              reg = <0x3c>;
> > > > > > > +              clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> > > > > > > +              clock-names = "xclk";
> > > > > > > +              assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> > > > > > > +              assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
> > > > > > > +              assigned-clock-rates = <24000000>;
> > > > > > > +              streamon-delay = <20>;
> > > > > > > +              powerdown-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> > > > > > > +              reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> > > > > > > +              status = "okay";
> > > > > > > +
> > > > > > > +              port {
> > > > > > > +                  alvium_out: endpoint {
> > > > > > > +                      remote-endpoint = <&mipi_csi_0_in>;
> > > > > > > +                      data-lanes = <1 2 3 4>;
> > > > > > > +                      link-frequencies = /bits/ 64 <681250000>;
> > > > > > > +                      clock-lanes = <0>;
> > > > > > > +                  };
> > > > > > > +              };
> > > > > > > +          };
> > > > > > > +      };
> > > > > > > +
> > > > > > > +...

-- 
Regards,

Laurent Pinchart
