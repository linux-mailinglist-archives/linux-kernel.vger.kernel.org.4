Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0195B6F09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiIMOGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiIMOGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:06:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C11B7AF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:05:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e16so20984865wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4SdJBGlm222aqQvtJCvRg2+cXmbZxd7oyHDsXIQ02sM=;
        b=NZJeJCT1hb/oiIbAXKZCL1AiKpB/+q/+p+1XIgGflOL4SKE5j/CmZB95I4Cv9qqtjX
         S5HHF8xfpHWDu2RLGG4KXGfJaFrl7Jchc+iTqI1TR2hMo7Sk64UQkdwR2sIa0uyQKPfE
         Lvtgb4JW1RmPE0jZ/A1TwspplaQwlxf5YSofk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4SdJBGlm222aqQvtJCvRg2+cXmbZxd7oyHDsXIQ02sM=;
        b=SB+h7oykiM1gE9490T2JPv1iI3zBTcX8ALElglHYAVcPGQGHdOSvokNRnPO2GfypcO
         G7PjEakU7DU+Kk7/6uP7mnph3UXVyrgr1nmF0eGjSUgirj5jW0pMafjqcZm+TheVhgzm
         hgQ5ci4siq/JFHhT9nHREVhkC1XChFuWvXU5G64g77ubMaFbiBAE1rKnsPe2N6H5XumR
         VTFlmCSMIaJJ6wssLPwp3UJhlTDVO4eOSyq6yggbW3suIRnA3reYiXbCOTQIOs3BIFYC
         NA/W29aP2KIa5VO5dIxJFdlrj7PCJsQDAI8FvstvO9Qq+TdddA+sdZ+x7/qCCpgnr2t5
         xjwQ==
X-Gm-Message-State: ACgBeo3m1JyUfE+Ct7+yT9/vWV2DOtKeyBrxwd3oS4XF6j4uQpApcwEz
        ayCiq32Xhh9vQP6L6PzbpCdISw==
X-Google-Smtp-Source: AA6agR7Kjy8+Nbx3zyBtj4O5f52dZKYCqslXZH4SLJbvDrwtWGweMsiXZwsg8R6AsSQAPaXZsur9+g==
X-Received: by 2002:a5d:6d8e:0:b0:22a:4831:e0e with SMTP id l14-20020a5d6d8e000000b0022a48310e0emr8994346wrs.442.1663077957051;
        Tue, 13 Sep 2022 07:05:57 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i ([89.101.193.68])
        by smtp.gmail.com with ESMTPSA id ay3-20020a05600c1e0300b003b339438733sm13521965wmb.19.2022.09.13.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:05:55 -0700 (PDT)
Date:   Tue, 13 Sep 2022 16:05:53 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Arec Kao <arec.kao@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Jimmy Su <jimmy.su@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: dt-bindings: media: i2c: document OV4689
 DT bindings
Message-ID: <20220913140553.GA2735@tom-ThinkPad-T14s-Gen-2i>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-2-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911200147.375198-2-mike.rudenko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

On Sun, Sep 11, 2022 at 11:01:34PM +0300, Mikhail Rudenko wrote:
> Add device-tree binding documentation for OV4689 image sensor driver,
> and the relevant MAINTAINERS entries.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  .../bindings/media/i2c/ovti,ov4689.yaml       | 141 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> new file mode 100644
> index 000000000000..376330b5572a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Omnivision OV4689 CMOS
> +
> +maintainers:
> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
> +
> +description: |
> +  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
> +  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
> +  at 2688x1520 resolution. It is programmable through an I2C
> +  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> +  connection.
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: ovti,ov4689
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      External clock (XVCLK) for the sensor, 6-64 MHz
> +    maxItems: 1
> +
> +  clock-names: true
> +
> +  dovdd-supply:
> +    description:
> +      Digital I/O voltage supply, 1.7-3.0 V
> +
> +  avdd-supply:
> +    description:
> +      Analog voltage supply, 2.6-3.0 V
> +
> +  dvdd-supply:
> +    description:
> +      Digital core voltage supply, 1.1-1.3 V
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the powerdown pin (active low)
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the reset pin (active low)
> +
> +  orientation: true
> +
> +  rotation: true
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +    description:
> +      Output port node, single endpoint describing the CSI-2 transmitter
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
> +                  - const: 3
> +                  - const: 4
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +              - items:
> +                  - const: 1
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
> +  - dovdd-supply
> +  - avdd-supply
> +  - dvdd-supply
> +  - powerdown-gpios
> +  - reset-gpios
> +  - port

I think we don't need all of these entries as required.
The only let me say "really" required are:

- compatible
- reg
- clocks
- port

Regards,
Tommaso

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
> +        ov4689: camera@36 {
> +            compatible = "ovti,ov4689";
> +            reg = <0x36>;
> +
> +            clocks = <&ov4689_clk>;
> +            clock-names = "xvclk";
> +
> +            avdd-supply = <&ov4689_avdd>;
> +            dovdd-supply = <&ov4689_dovdd>;
> +            dvdd-supply = <&ov4689_dvdd>;
> +
> +            powerdown-gpios = <&pio 107 GPIO_ACTIVE_LOW>;
> +            reset-gpios = <&pio 109 GPIO_ACTIVE_LOW>;
> +
> +            orientation = <2>;
> +            rotation = <0>;
> +
> +            port {
> +                wcam_out: endpoint {
> +                    remote-endpoint = <&mipi_in_wcam>;
> +                    data-lanes = <1 2 3 4>;
> +                    link-frequencies = /bits/ 64 <500000000>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f468864fd268..63c4844f26e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14523,6 +14523,13 @@ S:	Maintained
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/i2c/ov2740.c
>  
> +OMNIVISION OV4689 SENSOR DRIVER
> +M:	Mikhail Rudenko <mike.rudenko@gmail.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> +
>  OMNIVISION OV5640 SENSOR DRIVER
>  M:	Steve Longerbeam <slongerbeam@gmail.com>
>  L:	linux-media@vger.kernel.org
> -- 
> 2.37.3
> 

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
