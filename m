Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1172934D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbjFIIgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbjFIIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:35:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6E5269A;
        Fri,  9 Jun 2023 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686299729; x=1717835729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TxzCRg5AI8iyyCans3FKD36C4QD1ErtUY7c3p53QRCw=;
  b=hcK+DMqZlrXWHJTyGUO+hw3MBZkwSduQfFFZIgcWfZNPm0wj8Qn33WwT
   wJvFTThQgx4u5yxzu7qbT3nM1PTgX8TJDX4/8VDs9j06Nt/XZYxCotWc7
   mNXnUoMOF9Q4/sTc1vy3nCwFzQotlz4M2qeHiqfJTxsZPaVOWVruWw7Un
   OAjec7vRPLQpZt2+vhC//ohwu+VRTYE2AfTyzfKM8l8MizJd9bB3D5IgZ
   bbvmC/Hljs9bcxFhc5vBX0gqxb+ys6DYoS47uVICWhYhljyxDeB5j278b
   BFAe//6l75RnPR24zJaM6bWsqwIMCz+/BfAahJOtGP+dz/JRe1iq3pBwv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="360907175"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="360907175"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="710295460"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="710295460"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:35:23 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 946AF11F9D2;
        Fri,  9 Jun 2023 11:35:20 +0300 (EEST)
Date:   Fri, 9 Jun 2023 08:35:20 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZILkSEllSfSGD8XK@kekkonen.localdomain>
References: <20230608083127.545750-1-tomm.merciai@gmail.com>
 <20230608083127.545750-3-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608083127.545750-3-tomm.merciai@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Thu, Jun 08, 2023 at 10:31:15AM +0200, Tommaso Merciai wrote:
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
> Changes since v4:
>  - Fixed id as reported by RHerring bot and LPinchart
>  - Add minimum into alliedvision,lp2hs-delay-us as suggested by CDooley
>  - Tested using make dt_binding_check DT_SCHEMA_FILES=alliedvision,alvium-csi2.yaml
> 
>  .../media/i2c/alliedvision,alvium-csi2.yaml   | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> new file mode 100644
> index 000000000000..c771e5039641
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#
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
> +    minimum: 1
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

Why do you need this? D-PHY TX is obviously controlled by the driver.
Explicit control of PHY initialisation is of course best option when
combined with some receivers, done via driver's pre_streamon and s_stream
callbacks. Can't your hardware do that?

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

Sakari Ailus
