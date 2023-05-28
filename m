Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF15D714088
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 23:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjE1VQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 17:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjE1VQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 17:16:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B3EBE;
        Sun, 28 May 2023 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685308573; x=1716844573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y+BKlDevzCKXevCjvN6HMiTRWqU67ZdEh2bnFi5G5hM=;
  b=COkOnpd1GGIUfY3ziqE2jHpxwLEPSnkosf07+D8zeU9fB0g3R6hq/SqG
   PIdzhl40fHV4k0HwCUUPMHQMWLKuEh0mxWSQvDNS0ny2XOFj8bVbTbjD0
   N1GypvAc/M5t07rPfb8WmtrruAHqOsN81iNKQd7tq7koUhOKlhRr5EYKt
   hE26FRdPQRWqwt26GejsbfQzZah0nTvn08X86pul57FILPIPE6WWTCTfZ
   WZaw0TSFyGSDtbWIGF3JMhn1VitwJvVbo0ZtnN+N0aHNPvyeVKMlQDyNO
   og4ehN2f22JBnFWeR2tUbR6PT5BSOFgFOdrn7mZlQ126LgBhD9HnIXdBC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="440918217"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="440918217"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 14:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="738927868"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="738927868"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 14:16:07 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 32BBA12303D;
        Mon, 29 May 2023 00:16:05 +0300 (EEST)
Date:   Sun, 28 May 2023 21:16:05 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
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
Message-ID: <ZHPElYOeD2C1qo4R@kekkonen.localdomain>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-2-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526173955.797226-2-tomm.merciai@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Fri, May 26, 2023 at 07:39:43PM +0200, Tommaso Merciai wrote:
> Add documentation of device tree in YAML schema for the ALVIUM
> Camera from Allied Vision Inc.
> 
> References:
>  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
> Changes since v1:
>  - Fixed build error as suggested by RHerring bot
> 
>  .../media/i2c/alliedvision,alvium.yaml        | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> new file mode 100644
> index 000000000000..81e9e560c99d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Alliedvision Alvium Camera
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
> +    const: alliedvision,alvium
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: XCLK Input Clock
> +
> +  clock-names:
> +    const: xclk

I'd also drop this as you have a single clock only: it's redundant.

> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description: >
> +      Reference to the GPIO connected to the powerdown pin, if any.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: >
> +      Reference to the GPIO connected to the reset pin, if any.
> +
> +  streamon-delay:
> +    maxItems: 1
> +    description: >
> +      Delay before camera start capturing frames in us.
> +
> +  rotation:
> +    enum:
> +      - 0
> +      - 180
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

The driver can know this, no need to have it in DT, i.e. please drop it.

> +          data-lanes:
> +            minItems: 1
> +            maxItems: 4
> +          link-frequencies: true
> +
> +        required:
> +          - data-lanes
> +          - link-frequencies
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/gpio/gpio.h>
> +      #include <dt-bindings/clock/imx8mp-clock.h>
> +
> +      i2c {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          camera: alvium@3c {
> +              compatible = "alliedvision,alvium";
> +              pinctrl-names = "default";
> +              pinctrl-0 = <&pinctrl_csi0_pwn>, <&pinctrl_csi0_rst>, <&pinctrl_csi_mclk>;
> +              reg = <0x3c>;
> +              clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> +              clock-names = "xclk";
> +              assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> +              assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
> +              assigned-clock-rates = <24000000>;
> +              streamon-delay = <20>;
> +              powerdown-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> +              reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +              status = "okay";
> +
> +              port {
> +                  alvium_out: endpoint {
> +                      remote-endpoint = <&mipi_csi_0_in>;
> +                      data-lanes = <1 2 3 4>;
> +                      link-frequencies = /bits/ 64 <681250000>;
> +                      clock-lanes = <0>;
> +                  };
> +              };
> +          };
> +      };
> +
> +...

-- 
Kind regards,

Sakari Ailus
