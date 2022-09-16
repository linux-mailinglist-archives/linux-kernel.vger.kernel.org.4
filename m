Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F545BACCA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiIPLw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIPLw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:52:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62AEAE9FC;
        Fri, 16 Sep 2022 04:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663329175; x=1694865175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ymRcD4SMNJ2Wskv31fxwW5RgjmCxw86sr/wur9dJFcg=;
  b=gVbmxKKLN1rrk3zw/H4FgFrJuBJepJc9YpkScbWhTTqZdIHA/TOQvS0y
   7qUMmc/2lzcGnpDNY4cHd5EdJPXZtgu+FL4Z7L944YzSyVPQx9SD1MKvW
   SKzjf57YJMmma3MDWARp7nHVJ5POL497sPY1K+o8waT+bHMqI8tY9QNGd
   wqWtfVIooehPlLqPIOSzDpX801uAxJWoGl92xfl9gn7TXw2zPAp+dBVYP
   okWMFmZjkdFPuU4UTPCQOaDkt7O/BCMaeSPUlhUqUMH9KkgaswrkHprf4
   3vQpQn1LXuMdeBo0gDZZxFcLWJuXNZyQOeQ2DIX8vvT6N8jbzdFXWLH8h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="362938151"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="362938151"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 04:52:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="595226961"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 04:52:43 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 5C6812010E;
        Fri, 16 Sep 2022 14:52:41 +0300 (EEST)
Date:   Fri, 16 Sep 2022 11:52:41 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] media: dt-bindings: ov5645: Convert OV5645 binding to a
 schema
Message-ID: <YyRjiY5XRPglSHuN@paasikivi.fi.intel.com>
References: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Sep 13, 2022 at 05:02:24PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Convert the simple OV5645 Device Tree binding to json-schema.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/media/i2c/ov5645.txt  |  54 --------
>  .../bindings/media/i2c/ovti,ov5645.yaml       | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5645.txt
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> deleted file mode 100644
> index 72ad992f77be..000000000000
> --- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -* Omnivision 1/4-Inch 5Mp CMOS Digital Image Sensor
> -
> -The Omnivision OV5645 is a 1/4-Inch CMOS active pixel digital image sensor with
> -an active array size of 2592H x 1944V. It is programmable through a serial I2C
> -interface.
> -
> -Required Properties:
> -- compatible: Value should be "ovti,ov5645".
> -- clocks: Reference to the xclk clock.
> -- clock-names: Should be "xclk".
> -- clock-frequency: Frequency of the xclk clock.
> -- enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This corresponds
> -  to the hardware pin PWDNB which is physically active low.
> -- reset-gpios: Chip reset GPIO. Polarity is GPIO_ACTIVE_LOW. This corresponds to
> -  the hardware pin RESETB.
> -- vdddo-supply: Chip digital IO regulator.
> -- vdda-supply: Chip analog regulator.
> -- vddd-supply: Chip digital core regulator.
> -
> -The device node must contain one 'port' child node for its digital output
> -video port, in accordance with the video interface bindings defined in
> -Documentation/devicetree/bindings/media/video-interfaces.txt.
> -
> -Example:
> -
> -	&i2c1 {
> -		...
> -
> -		ov5645: ov5645@3c {
> -			compatible = "ovti,ov5645";
> -			reg = <0x3c>;
> -
> -			enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> -			reset-gpios = <&gpio5 20 GPIO_ACTIVE_LOW>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&camera_rear_default>;
> -
> -			clocks = <&clks 200>;
> -			clock-names = "xclk";
> -			clock-frequency = <24000000>;
> -
> -			vdddo-supply = <&camera_dovdd_1v8>;
> -			vdda-supply = <&camera_avdd_2v8>;
> -			vddd-supply = <&camera_dvdd_1v2>;
> -
> -			port {
> -				ov5645_ep: endpoint {
> -					clock-lanes = <1>;
> -					data-lanes = <0 2>;
> -					remote-endpoint = <&csi0_ep>;
> -				};
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> new file mode 100644
> index 000000000000..7f407c988f87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5645.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OmniVision OV5645 Image Sensor Device Tree Bindings
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: ovti,ov5645
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: XCLK Input Clock
> +
> +  clock-names:
> +    const: xclk
> +
> +  clock-frequency:
> +    description: Frequency of the xclk clock in Hz.
> +
> +  vdda-supply:
> +    description: Analog voltage supply, 2.8 volts
> +
> +  vddd-supply:
> +    description: Digital core voltage supply, 1.5 volts
> +
> +  vdddo-supply:
> +    description: Digital I/O voltage supply, 1.8 volts
> +
> +  enable-gpios:
> +    maxItems: 1
> +    description:
> +      Reference to the GPIO connected to the PWDNB pin, if any.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      Reference to the GPIO connected to the RESETB pin, if any.
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
> +          clock-lanes:
> +            const: 0
> +
> +          bus-type:
> +            const: 4

Please drop the two, they provide no information to the driver that already
knows this. (Unless of course, the driver supports other bus types these
bindings do not document. Some OV sensors do.) clock-lanes needs to go in
any case, and data-lanes are dependent on bus-type being 4 I presume.

bus-type is also not present in the example.

> +
> +          data-lanes:
> +            minItems: 1
> +            maxItems: 2
> +            items:
> +              enum: [1, 2]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - clock-frequency
> +  - vdda-supply
> +  - vddd-supply
> +  - vdddo-supply
> +  - enable-gpios
> +  - reset-gpios
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/gpio/gpio.h>
> +
> +      i2c {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          camera@3c {
> +              compatible = "ovti,ov5645";
> +              pinctrl-names = "default";
> +              pinctrl-0 = <&pinctrl_ov5645>;
> +              reg = <0x3c>;
> +              clocks = <&clks 1>;
> +              clock-names = "xclk";
> +              clock-frequency = <24000000>;
> +              vdddo-supply = <&ov5645_vdddo_1v8>; /* 1.8v */
> +              vdda-supply = <&ov5645_vdda_2v8>;  /* 2.8v */
> +              vddd-supply = <&ov5645_vddd_1v5>;  /* 1.5v */
> +              enable-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +              reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
> +
> +              port {
> +                  ov5645_ep: endpoint {
> +                      remote-endpoint = <&csi0_ep>;
> +                      clock-lanes = <0>;
> +                      data-lanes = <1 2>;
> +                  };
> +              };
> +          };
> +      };
> +...

-- 
Kind regards,

Sakari Ailus
