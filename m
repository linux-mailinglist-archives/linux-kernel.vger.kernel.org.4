Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624EE67BB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjAYUDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbjAYUDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:03:20 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EDE59769;
        Wed, 25 Jan 2023 12:03:17 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-142b72a728fso22705909fac.9;
        Wed, 25 Jan 2023 12:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JS9Ato+g82YCx7GpbdLV1/5UEFGfDZ+Ro556mCRT4BQ=;
        b=hUUY+a7uLWV06u7LTsD1MykpuBeSa6cEjCzXyLiKTcr6QoEqNtJLZksjw+RZLuBqGW
         GCIPVgmwoGBbzzLbhAfwwBTep4AL/cZarhcen0UReHJ4JbogkPBw3wkvrbjQZfrswUvF
         vCsUyxQIpz5ams3V2Pa0V4+B/O41+Iy6hPvpx46YicZg1/KXr/+FiUidUcD8QTCdvR0W
         OUO1KPobXOwMXuFEqo9edU/UTwZgHg+Hqzdm8506thXabWmNySsKSsYCMaGln/+s86re
         4wl5Mu6FxV8QiapIpNL0ERAOsCSsoQYwf2OTcSkocN6LDpxyrwSw5hc3tRtBFP/QGv+z
         J6FA==
X-Gm-Message-State: AFqh2krecKCnHhv4fgPY7WjWA8y6v8lHUAKrnw1x9JkyP6rdrONoIe6o
        KNH8JhB2Ol3WXfyoqdZWfA==
X-Google-Smtp-Source: AMrXdXvLvf6NAvbOfoqjWJQWiNhdcYmjmN2lD36v7XVDRhMDG0lA69m7W0gqW6Yy/gq48k07wdLhpQ==
X-Received: by 2002:a05:6870:b4a5:b0:158:910:8956 with SMTP id y37-20020a056870b4a500b0015809108956mr19026430oap.54.1674676996710;
        Wed, 25 Jan 2023 12:03:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fw9-20020a056870080900b00143ae7d4ccesm1882540oab.45.2023.01.25.12.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:03:16 -0800 (PST)
Received: (nullmailer pid 2760041 invoked by uid 1000);
        Wed, 25 Jan 2023 20:03:15 -0000
Date:   Wed, 25 Jan 2023 14:03:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: media: i2c: add imx415 cmos image
 sensor
Message-ID: <20230125200315.GA2755157-robh@kernel.org>
References: <20230124060107.3922237-1-michael.riesch@wolfvision.net>
 <20230124060107.3922237-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124060107.3922237-2-michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 07:01:06AM +0100, Michael Riesch wrote:
> Add devicetree binding for the Sony IMX415 CMOS image sensor.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
> v2:
>  - fix reference in port (must be /$defs/port-base)
>  - describe data-lanes in more detail
>  - remove unexpected property clock-lanes from example
>  - sort properties in example alphabetically
> 
>  .../bindings/media/i2c/sony,imx415.yaml       | 130 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> new file mode 100644
> index 000000000000..104c36b64c09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/sony,imx415.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony IMX415 CMOS Image Sensor
> +
> +maintainers:
> +  - Michael Riesch <michael.riesch@wolfvision.net>
> +
> +description: |-
> +  The Sony IMX415 is a diagonal 6.4 mm (Type 1/2.8) CMOS active pixel type
> +  solid-state image sensor with a square pixel array and 8.46 M effective
> +  pixels. This chip operates with analog 2.9 V, digital 1.1 V, and interface
> +  1.8 V triple power supply, and has low power consumption.
> +  The IMX415 is programmable through I2C interface. The sensor output is
> +  available via CSI-2 serial data output (two or four lanes).
> +
> +allOf:
> +  - $ref: ../video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: sony,imx415
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    description: Input clock (24 MHz, 27 MHz, 37.125 MHz, 72 MHz or 74.25 MHz)
> +    items:
> +      - const: inck

I agree with dropping it.

> +
> +  avdd-supply:
> +    description: Analog power supply (2.9 V)
> +
> +  dvdd-supply:
> +    description: Digital power supply (1.1 V)
> +
> +  ovdd-supply:
> +    description: Interface power supply (1.8 V)
> +
> +  reset-gpios:
> +    description: Sensor reset (XCLR) GPIO
> +    maxItems: 1
> +
> +  flash-leds: true
> +
> +  lens-focus: true
> +
> +  orientation: true
> +
> +  rotation: true
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            oneOf:
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4
> +
> +          link-frequencies: true

Don't need to list this here.

> +
> +        required:
> +          - data-lanes
> +          - link-frequencies
> +
> +    required:
> +      - endpoint
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - avdd-supply
> +  - dvdd-supply
> +  - ovdd-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        imx415: camera-sensor@1a {
> +            compatible = "sony,imx415";
> +            reg = <0x1a>;
> +            avdd-supply = <&vcc2v9_cam>;
> +            clocks = <&clock_cam>;
> +            clock-names = "inck";
> +            dvdd-supply = <&vcc1v1_cam>;
> +            lens-focus = <&vcm>;
> +            orientation = <2>;
> +            ovdd-supply = <&vcc1v8_cam>;
> +            reset-gpios = <&gpio_expander 14 GPIO_ACTIVE_LOW>;
> +            rotation = <180>;
> +
> +            port {
> +                imx415_ep: endpoint {
> +                    data-lanes = <1 2 3 4>;
> +                    link-frequencies = /bits/ 64 <445500000>;
> +                    remote-endpoint = <&mipi_in>;
> +                };
> +            };
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f61eb221415b..c9fa893bf649 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19493,6 +19493,13 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml
>  F:	drivers/media/i2c/imx412.c
>  
> +SONY IMX415 SENSOR DRIVER
> +M:	Michael Riesch <michael.riesch@wolfvision.net>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> +
>  SONY MEMORYSTICK SUBSYSTEM
>  M:	Maxim Levitsky <maximlevitsky@gmail.com>
>  M:	Alex Dubov <oakad@yahoo.com>
> -- 
> 2.30.2
> 
