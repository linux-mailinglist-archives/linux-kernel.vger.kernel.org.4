Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0E95BAEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiIPN6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiIPN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:57:55 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A7EAF0F5;
        Fri, 16 Sep 2022 06:57:50 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [104.132.8.103])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC35D440;
        Fri, 16 Sep 2022 15:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663336668;
        bh=xHIvIS8YqC6ueY7VdiX5kXkLJ5nlj/ISTZP9yAw8ijY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S95U6kPRzWCzcSSdmO2fhkYc1+ZgRXN8AQdM+PoXHPpnOpZs1x4RLJ4ez5qIjCo89
         eOK3oRJtNYPa9z49uDQPcR4sS5RH2SD6GfZmVUzSxYgpiM7W1JxjAQ7A244/v+pY7w
         xuRlbdcBxwjtDdxLGlwewUBtHqha6yyOKjNd0kIo=
Date:   Fri, 16 Sep 2022 16:57:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org, kishon@ti.com,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        jacopo@jmondi.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 3/4] media: dt-bindings: add bindings for Toshiba TC358746
Message-ID: <YySAzUBPXkaxsKIY@pendragon.ideasonboard.com>
References: <20220818143307.967150-1-m.felsch@pengutronix.de>
 <20220818143307.967150-4-m.felsch@pengutronix.de>
 <YxUoSfbrPPPT5nz6@pendragon.ideasonboard.com>
 <20220915131933.wclmhtliji5wz35t@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220915131933.wclmhtliji5wz35t@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Thu, Sep 15, 2022 at 03:19:33PM +0200, Marco Felsch wrote:
> On 22-09-05, Laurent Pinchart wrote:
> > On Thu, Aug 18, 2022 at 04:33:06PM +0200, Marco Felsch wrote:
> > > Add the bindings for the Toshiba TC358746 Parallel <-> MIPI-CSI bridge
> > > driver.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  .../bindings/media/i2c/toshiba,tc358746.yaml  | 157 ++++++++++++++++++
> > >  1 file changed, 157 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> > > new file mode 100644
> > > index 000000000000..9783cca363c6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> > > @@ -0,0 +1,157 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/i2c/toshiba,tc358746.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Toshiba TC358746 Parallel to MIPI CSI2 Bridge
> > > +
> > > +maintainers:
> > > +  - Marco Felsch <kernel@pengutronix.de>
> > > +
> > > +description: |-
> > > +  The Toshiba TC358746 converts a parallel video stream into a MIPI CSI-2
> > > +  stream. The direction can be either parallel-in -> csi-out or csi-in ->
> > > +  parallel-out The chip is programmable trough I2C and SPI but the SPI
> > > +  interface is only supported in parallel-in -> csi-out mode.
> > > +
> > > +  Note that the current device tree bindings only support the
> > > +  parallel-in -> csi-out path.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: toshiba,tc358746
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    description:
> > > +      The phandle to the reference clock source. This corresponds to the
> > > +      hardware pin REFCLK.
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    const: refclk
> > 
> > As there's a single clock, should we omit the clock name ?
> 
> Don't know, I would rather keep it to make it explicite. Many other go
> that way too.

I don't mind either way.

> > > +# The bridge can act as clock provider for the sensor. To enable this support
> > > +# #clock-cells must be specified. Attention if this feature is used than the
> > 
> > s/than/then/
> 
> Sure, thanks.
> 
> > > +# mclk rate must be at least: (2 * link-frequency) / 8
> > > +#                             `------------------´   ^
> > > +#                             internal PLL rate   smallest possible mclk-div
> > 
> > Could this be captured in the description of the property instead of a
> > comment ?
> 
> Hm.. a few (1,2) bindings using comments like this but I'm not against
> it. If it belongs to the description, which property should I use? Since
> there is no: clock-controller property like gpio-controller or
> interrupt-controller. The clock provider will be activated based on the
> #clock-cells property. But this property has nothing to with the
> description since this property specifies the cell size.

I would have put it in the description of the #clock-cells property:

  "#clock-cells":
    description: |
      The bridge can act as clock provider for the sensor. To enable
      this support #clock-cells must be specified. Attention ...
    const: 0

but if it becomes an issue, I'm OK with the comment too.

> > > +  "#clock-cells":
> > > +    const: 0
> > > +
> > > +  clock-output-names:
> > > +    description:
> > > +      The clock name of the MCLK output, the default name is tc358746-mclk.
> > > +    maxItems: 1
> > > +
> > > +  vddc-supply:
> > > +    description: Digital core voltage supply, 1.2 volts
> > > +
> > > +  vddio-supply:
> > > +    description: Digital I/O voltage supply, 1.8 volts
> > > +
> > > +  vddmipi-supply:
> > > +    description: MIPI CSI phy voltage supply, 1.2 volts
> > > +
> > > +  reset-gpios:
> > > +    description:
> > > +      The phandle and specifier for the GPIO that controls the chip reset.
> > > +      This corresponds to the hardware pin RESX which is physically active low.
> > > +    maxItems: 1
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Input port
> > 
> > Are the H/V sync signal polarities fixed, or should they be specified
> > here ?
> 
> At the moment they are fixed.

If the hardware supports different polarities, let's add them to the
device tree binding, even if the driver only supports a single option at
the moment.

> I can describe it if you want.

Thanks.

> > Does the chip support external sync only, or also BT.656 ? In the
> > latter case this needs a bus-type.
> 
> Yes, the chip also supports BT.656 but the driver doesn't support it
> yet. You're right, that we should make it explicite albeit it would a
> bit overhead yet since the only mode is: parallel-in with externa syncs.

Let's prepare for BT.656 support in the DT bindings, or we may regret it
later :-)

> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        description: Output port
> > > +
> > > +        properties:
> > > +          endpoint:
> > > +            $ref: /schemas/media/video-interfaces.yaml#
> > > +            unevaluatedProperties: false
> > > +
> > > +            properties:
> > > +              data-lanes:
> > > +                minItems: 1
> > > +                maxItems: 4
> > > +
> > > +              clock-noncontinuous: true
> > > +              link-frequencies: true
> > > +
> > > +            required:
> > > +              - data-lanes
> > > +              - link-frequencies
> > > +
> > > +    required:
> > > +      - port@0
> > > +      - port@1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - vddc-supply
> > > +  - vddio-supply
> > > +  - vddmipi-supply
> > > +  - ports
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +
> > > +    i2c {
> > > +      #address-cells = <1>;
> > > +      #size-cells = <0>;
> > > +
> > > +      csi-bridge@e {
> > > +        compatible = "toshiba,tc358746";
> > > +        reg = <0xe>;
> > > +
> > > +        clocks = <&refclk>;
> > > +        clock-names = "refclk";
> > > +
> > > +        reset-gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
> > > +
> > > +        vddc-supply = <&v1_2d>;
> > > +        vddio-supply = <&v1_8d>;
> > > +        vddmipi-supply = <&v1_2d>;
> > > +
> > > +        /* sensor mclk provider */
> > > +        #clock-cells = <0>;
> > > +
> > > +        ports {
> > > +          #address-cells = <1>;
> > > +          #size-cells = <0>;
> > > +
> > > +          /* Input */
> > > +          port@0 {
> > > +            reg = <0>;
> > > +            tc358746_in: endpoint {
> > > +              remote-endpoint = <&sensor_out>;
> > > +              };
> > 
> > Wrong indentation here.
> 
> Yes, thanks.
> 
> > > +          };
> > > +
> > > +          /* Output */
> > > +          port@1 {
> > > +            reg = <1>;
> > > +            tc358746_out: endpoint {
> > > +              remote-endpoint = <&mipi_csi2_in>;
> > > +              data-lanes = <1 2>;
> > > +              clock-noncontinuous;
> > > +              link-frequencies = /bits/ 64 <216000000>;
> > > +            };
> > > +          };
> > > +        };
> > > +      };
> > > +    };

-- 
Regards,

Laurent Pinchart
