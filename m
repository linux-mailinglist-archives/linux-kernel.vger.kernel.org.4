Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2DC67221F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjARPvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjARPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:50:42 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1623EC58;
        Wed, 18 Jan 2023 07:48:54 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id c145-20020a4a4f97000000b004f505540a20so2149359oob.1;
        Wed, 18 Jan 2023 07:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYovn9TNMLK9yH9oQn2nAGpxM1OD6nBpNMaOlnS+2Vc=;
        b=pM+V/nf9zvEctDOQRoraAJ84YSKDtST/OQerZkyHgNpYsXpRndTaaJob00UDYVtLuv
         mf6osV0D90oUH6F6vhIkwQt0oXGVhUxHg0y95zDjQMrANsNbaZyWBiXyRioWqQc8kepa
         Xdk2p3nMzPady7GtxWppih+T5QL0ATBdBUIIbJBUwSqj9owvj9rVPtXThaHRzhxyqsju
         C31Z+g8QMfsN3e9f8OMU7Hv18B2HvVIOpKhLW4VRtG0QgV1ZKsShT1ghdLgDpYlqR8BG
         mb0KM7DKGd+l0jtujrqKr07UhVhlWzdxo56aiYNenl7eToaFl/QvRo847EJNLxU4SlcZ
         6dmw==
X-Gm-Message-State: AFqh2kqcXl7FsUUVekTfoTXzHsCaM7yLCCjra6WFAD/wAH5HlB/mEFKP
        b0oqIleXxnlhN+C1OTV0aA==
X-Google-Smtp-Source: AMrXdXuLEpOJ51vJCCLbJC9ZuJIJ0cX1UL1IoGNleq9XsYXwsk7bGdCGUfxvOJc8VObdNlRB69erXw==
X-Received: by 2002:a4a:944a:0:b0:4e7:128c:f195 with SMTP id j10-20020a4a944a000000b004e7128cf195mr3326321ooi.8.1674056933271;
        Wed, 18 Jan 2023 07:48:53 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id g6-20020a4aa706000000b004f9cd1e42d3sm2264840oom.26.2023.01.18.07.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:48:52 -0800 (PST)
Received: (nullmailer pid 61513 invoked by uid 1000);
        Wed, 18 Jan 2023 15:48:52 -0000
Date:   Wed, 18 Jan 2023 09:48:52 -0600
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
        Shawn Tu <shawnx.tu@intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] dt-bindings: media: i2c: add imx415 cmos image sensor
Message-ID: <20230118154852.GA55989-robh@kernel.org>
References: <20230118103239.3409674-1-michael.riesch@wolfvision.net>
 <20230118103239.3409674-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118103239.3409674-2-michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:32:38AM +0100, Michael Riesch wrote:
> Add devicetree binding for the Sony IMX415 CMOS image sensor.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../bindings/media/i2c/sony,imx415.yaml       | 120 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> new file mode 100644
> index 000000000000..ae54834a2341
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> @@ -0,0 +1,120 @@
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
> +    $ref: /schemas/graph.yaml#/properties/port

/properties/port is for when there are no extra properties. You need 
/$defs/port-base here since there are extra properties in the endpoint 
node.

> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes: true
> +          link-frequencies: true
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
> +            ovdd-supply = <&vcc1v8_cam>;
> +            lens-focus = <&vcm>;
> +            rotation = <180>;
> +            orientation = <2>;
> +            reset-gpios = <&gpio_expander 14 GPIO_ACTIVE_LOW>;
> +
> +            port {
> +                imx415_ep: endpoint {
> +                    remote-endpoint = <&mipi_in>;
> +                    clock-lanes = <0>;
> +                    data-lanes = <1 2>;
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
