Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EB3726292
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbjFGOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbjFGOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:19:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9571BCA;
        Wed,  7 Jun 2023 07:19:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977c72b116fso705419366b.3;
        Wed, 07 Jun 2023 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686147548; x=1688739548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRASiZNU+uqCC6xMOmhgYj3PMgTAAgT7bOasKdKB5sA=;
        b=XAA/GQ3KlIJTcdmCYotdZLxRXKyz/uiqk/cIETK+NAGTwjkxag5cHzVohfb8NvBph2
         uxL5OZyRSeuaQM1/8XrAKWIAAu4611vAfezDc/oupPD2j3hJOodmDK1vFzTv0xScP+nC
         dTaPw+J9bFDpJ8ycjhMm6w/PM6V9KkOhSnL/T4BXG8GfJPasBqQ0CnQznpwg0lrwk6z1
         uFL5LCGmA6upiN/JDCF5pPYI4sgXfR1feMCqu0yHNz6dVEU/f6rstksBpYwlezPHYGpx
         Pz1mO/iiWR34VWKfqToecczWUymvj5M0Syza1f+FRkKwXwYQjx37eHzCY0qMv13jpyLw
         rS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686147548; x=1688739548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRASiZNU+uqCC6xMOmhgYj3PMgTAAgT7bOasKdKB5sA=;
        b=MjnDU29ei3n9bi1xf8oSIqnnnDr67Vbm3e7HRkaoGFhhyRt8PEXEpSTNmnFQwiEqSt
         brcDIGM0fOnpmGUW2aEWoJlcGvD9qSAPwAXvPs6/CxhUpTntpTvh0EY9Y5fr6CpYoGEv
         a1E6kMGa4on2FHngDF/RutxyylS72b0ae7UKdMWs8A1vkXvnjEkiMsk6LYDrrt4oYdx3
         d5hhs06BYX4qLmmZnkxMBqgEr/wPd20usdshLEjykihzTDLni48Rot2udKY+IPB3UA1A
         XZ6O4NRMFzDCWSWoojQ7/bzrOaMD94H/KmpuUiKT8TameACqcn4ZKFrTOUGcDnJz0dWl
         NQVA==
X-Gm-Message-State: AC+VfDxqIG9YYcOaA2T4H5cb/horoOZ46K5u/nK1lS7Ak5of9mKlucXe
        8ndMa5hC9ZJTTmBfVDXQj3o=
X-Google-Smtp-Source: ACHHUZ4/pQAkwYxjWZTufCVWroKQr6DTSYhTEf/z/XjNCeP2/LMxYOPbTNJsYAUBP1HSGPY1DbQfvQ==
X-Received: by 2002:a17:907:6297:b0:978:6f92:be99 with SMTP id nd23-20020a170907629700b009786f92be99mr5939377ejc.65.1686147548258;
        Wed, 07 Jun 2023 07:19:08 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id i5-20020a170906850500b0097886843f75sm665534ejx.177.2023.06.07.07.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:19:07 -0700 (PDT)
Date:   Wed, 7 Jun 2023 16:19:05 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZICR2euf7f7Kay8y@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
 <20230607131936.382406-3-tomm.merciai@gmail.com>
 <20230607140638.GA16848@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607140638.GA16848@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 05:06:38PM +0300, Laurent Pinchart wrote:
> On Wed, Jun 07, 2023 at 03:19:24PM +0200, Tommaso Merciai wrote:
> > Add documentation of device tree in YAML schema for the ALVIUM
> > Camera from Allied Vision Inc.
> > 
> > References:
> >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > Changes since v1:
> >  - Fixed build error as suggested by RHerring bot
> > 
> > Changes since v2:
> >  - Fixed License as suggested by KKozlowski/CDooley
> >  - Removed rotation property as suggested by CDooley/LPinchart
> >  - Fixed example node name as suggested by CDooley
> >  - Fixed title as suggested by LPinchart
> >  - Fixed compatible name as suggested by LPinchart
> >  - Removed clock as suggested by LPinchart
> >  - Removed gpios not as suggested by LPinchart
> >  - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
> >  - Fixed vendor prefix, unit append as suggested by KKozlowski
> >  - Fixed data-lanes
> >  - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
> >  - Dropped status into example  as suggested by KKozlowski
> >  - Added vcc-ext-in supply as suggested by LPinchart
> >  - Dropped pinctrl into example as suggested by LPinchart
> > 
> > Changes since v3:
> >  - Fixed vcc-ext-in-supply description as suggested by LPinchart
> >  - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
> >  - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
> >  - Collected Reviewed-by tag from LPinchart
> > 
> >  .../media/i2c/alliedvision,alvium-csi2.yaml   | 96 +++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > new file mode 100644
> > index 000000000000..4726d0068229
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#
> 
> This is still wrong, see Rob's bot reply in the previous version.

Arg... :'(

Thanks Laurent.

Regards,
Tommaso

> 
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allied Vision Alvium Camera
> > +
> > +maintainers:
> > +  - Tommaso Merciai <tomm.merciai@gmail.com>
> > +  - Martin Hecht <martin.hecht@avnet.eu>
> > +
> > +allOf:
> > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: alliedvision,alvium-csi2
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vcc-ext-in-supply:
> > +    description: |
> > +      The regulator that supplies power to the VCC_EXT_IN pins.
> > +
> > +  alliedvision,lp2hs-delay-us:
> > +    maximum: 150000
> > +    description: |
> > +      Low power to high speed delay time.
> > +
> > +      If the value is larger than 0, the camera forces a reset of all
> > +      D-PHY lanes for the duration specified by this property. All lanes
> > +      will transition to the low-power state and back to the high-speed
> > +      state after the delay. Otherwise the lanes will transition to and
> > +      remain in the high-speed state immediately after power on.
> > +
> > +      This is meant to help CSI-2 receivers synchronizing their D-PHY
> > +      RX.
> > +
> > +  port:
> > +    description: Digital Output Port
> > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/media/video-interfaces.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          link-frequencies: true
> > +
> > +          data-lanes:
> > +            minItems: 1
> > +            items:
> > +              - const: 1
> > +              - const: 2
> > +              - const: 3
> > +              - const: 4
> > +
> > +        required:
> > +          - data-lanes
> > +          - link-frequencies
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vcc-ext-in-supply
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        alvium: camera@3c {
> > +            compatible = "alliedvision,alvium-csi2";
> > +            reg = <0x3c>;
> > +            vcc-ext-in-supply = <&reg_vcc_ext_in>;
> > +            alliedvision,lp2hs-delay-us = <20>;
> > +
> > +            port {
> > +                alvium_out: endpoint {
> > +                    remote-endpoint = <&mipi_csi_0_in>;
> > +                    data-lanes = <1 2 3 4>;
> > +                    link-frequencies = /bits/ 64 <681250000>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...
> 
> -- 
> Regards,
> 
> Laurent Pinchart
