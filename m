Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC167B28E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjAYM0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjAYM0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:26:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B94AD21;
        Wed, 25 Jan 2023 04:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674649563; x=1706185563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yrSmmLc3DVdQTD12Kpyaer5iKdyd+7tY7IvnduKXdIk=;
  b=RKQLwS3og08tKZxYM2jGIg8PSZ1ryyfhT7KN5rnEvIdYUs55VNId5ZFK
   qwo5iD9bxBxsZ0Ve3F28Cv61dxzviaYj/gYHaqyROZwbShIkyH0wbO6Bx
   LIpILRBfRMOY9nww8yzAWhH4dK8wgD7fakKNyKivmZhq/aC9CRARDHs9z
   ULJVlk3fbJr7oQZLLGQs1C63B7imf7kzy/qHBnf/IPqLK0vF71ZO3Zh0r
   mBosAiAX3kFFoqyB5jxIEPF2nna55TfMBv8F6lZkFtPz7UbJFWSkmJaDl
   LFzMwaARazcZlVV7n5UbbQ2Zs2O/fm5f/dTaw9K3Tdl5xRvCWwhkOvm/0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="314446106"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="314446106"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 04:26:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="836329640"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="836329640"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 04:25:58 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 4CDEE120C31;
        Wed, 25 Jan 2023 14:25:55 +0200 (EET)
Date:   Wed, 25 Jan 2023 14:25:55 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: media: i2c: add imx415 cmos image
 sensor
Message-ID: <Y9Ef0/lxLS564JT5@kekkonen.localdomain>
References: <20230124060107.3922237-1-michael.riesch@wolfvision.net>
 <20230124060107.3922237-2-michael.riesch@wolfvision.net>
 <20230125112111.hnjf57gecch4ddi5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125112111.hnjf57gecch4ddi5@pengutronix.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Wed, Jan 25, 2023 at 12:21:11PM +0100, Marco Felsch wrote:
> Hi Michael,
> 
> On 23-01-24, Michael Riesch wrote:
> > Add devicetree binding for the Sony IMX415 CMOS image sensor.
> > 
> > Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> > ---
> > v2:
> >  - fix reference in port (must be /$defs/port-base)
> >  - describe data-lanes in more detail
> >  - remove unexpected property clock-lanes from example
> >  - sort properties in example alphabetically
> > 
> >  .../bindings/media/i2c/sony,imx415.yaml       | 130 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 137 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> > new file mode 100644
> > index 000000000000..104c36b64c09
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> > @@ -0,0 +1,130 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/sony,imx415.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sony IMX415 CMOS Image Sensor
> > +
> > +maintainers:
> > +  - Michael Riesch <michael.riesch@wolfvision.net>
> > +
> > +description: |-
> > +  The Sony IMX415 is a diagonal 6.4 mm (Type 1/2.8) CMOS active pixel type
> > +  solid-state image sensor with a square pixel array and 8.46 M effective
> > +  pixels. This chip operates with analog 2.9 V, digital 1.1 V, and interface
> > +  1.8 V triple power supply, and has low power consumption.
> > +  The IMX415 is programmable through I2C interface. The sensor output is
> > +  available via CSI-2 serial data output (two or four lanes).
> > +
> > +allOf:
> > +  - $ref: ../video-interface-devices.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: sony,imx415
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    description: Input clock (24 MHz, 27 MHz, 37.125 MHz, 72 MHz or 74.25 MHz)
> 
> I would move this description to the clocks property.
> 
> > +    items:
> > +      - const: inck
> 
> If there is only one clock we could remove the clock-names property to
> not bother the user to specify this.
> 
> > +
> > +  avdd-supply:
> > +    description: Analog power supply (2.9 V)
> > +
> > +  dvdd-supply:
> > +    description: Digital power supply (1.1 V)
> > +
> > +  ovdd-supply:
> > +    description: Interface power supply (1.8 V)
> > +
> > +  reset-gpios:
> > +    description: Sensor reset (XCLR) GPIO
> > +    maxItems: 1
> > +
> > +  flash-leds: true
> > +
> > +  lens-focus: true
> > +
> > +  orientation: true
> > +
> > +  rotation: true
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > +
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/media/video-interfaces.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          data-lanes:
> > +            oneOf:
> > +              - items:
> > +                  - const: 1
> > +                  - const: 2
> > +              - items:
> > +                  - const: 1
> > +                  - const: 2
> > +                  - const: 3
> > +                  - const: 4
> > +
> > +          link-frequencies: true
> > +
> > +        required:
> > +          - data-lanes
> > +          - link-frequencies
> > +
> > +    required:
> > +      - endpoint
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - avdd-supply
> > +  - dvdd-supply
> > +  - ovdd-supply
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        imx415: camera-sensor@1a {
> > +            compatible = "sony,imx415";
> > +            reg = <0x1a>;
> > +            avdd-supply = <&vcc2v9_cam>;
> > +            clocks = <&clock_cam>;
> > +            clock-names = "inck";
> > +            dvdd-supply = <&vcc1v1_cam>;
> > +            lens-focus = <&vcm>;
> > +            orientation = <2>;
> > +            ovdd-supply = <&vcc1v8_cam>;
> > +            reset-gpios = <&gpio_expander 14 GPIO_ACTIVE_LOW>;
> > +            rotation = <180>;
> > +
> > +            port {
> > +                imx415_ep: endpoint {
> > +                    data-lanes = <1 2 3 4>;
> > +                    link-frequencies = /bits/ 64 <445500000>;
> > +                    remote-endpoint = <&mipi_in>;
> > +                };
> > +            };
> > +        };
> > +    };
> 
> Nit albeit I'm not quite sure but I think the indent should be two spaces.

I'm not sure either but AFAIR all the other examples I've seen use four
spaces.

> 
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f61eb221415b..c9fa893bf649 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19493,6 +19493,13 @@ T:	git git://linuxtv.org/media_tree.git
> >  F:	Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml
> >  F:	drivers/media/i2c/imx412.c
> >  
> > +SONY IMX415 SENSOR DRIVER
> > +M:	Michael Riesch <michael.riesch@wolfvision.net>
> > +L:	linux-media@vger.kernel.org
> > +S:	Maintained
> > +T:	git git://linuxtv.org/media_tree.git
> > +F:	Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> 
> I'm not sure if you should add an entry here since you're already listed
> as maintainer within the binding file.

Should be here as well.

-- 
Regards,

Sakari Ailus
