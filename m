Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DC37295CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbjFIJr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241886AbjFIJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:47:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381C465AF;
        Fri,  9 Jun 2023 02:41:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977e83d536fso238777766b.3;
        Fri, 09 Jun 2023 02:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686303680; x=1688895680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qE+glKjMKgw9i8FcXwYarHMggyxgdoJ+MHpkTYAXKjM=;
        b=BoVyhz90Zvy7Gsqcu8p1HToECqBYVlD0AV/gjlpXeVxJJ9b2sNJ9wj0KUGZ4DU4bHy
         QV5knn3Dn0IyzBadyJjmuxe+cjXCvXV4msF0uL8kTotHo9wvbJarivV9F/4/fT70PCvm
         Co9hZEtGiy+CSZE82iuQnPB1PMzJN7Y21a23Nsz8Q+Bfira8iH7IapFKGyUeVRc40tbh
         3bZEeQ4wfTMqk+D1Aufe4rnVi1OZu64j0WNsXAD1GGapizc2aA0ybhWUPWhsBodXczRZ
         +F0XAtbbko6TCrG66gp3H5KkEYO7nIg8LuNo+GUOnjgbjYYZJU9IKUITvmKiw2InjGLB
         ajMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303680; x=1688895680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE+glKjMKgw9i8FcXwYarHMggyxgdoJ+MHpkTYAXKjM=;
        b=aInB9aJPDmRj1gGz/lrI9yWBCDT8qiWlz5HOVvu7IkMyO9W7Enn8QTKdX2PVwJ8VPA
         E3N9vwhc77F7PRcEdON8kgQw2CRGAqugcaNLCEAOFH63H2gcTpgJJ92HvVckPBLyDsGP
         X6sHfkhWvm3Ud7T+Si0/rS2Lmj9p9Dvl3PKoHqJ3Kc0KCDrqhuzcC+AwQHPcM3LimI05
         uC1wA63k/r7izzkCYxiuHoy3dFzHbHiu2acNp6ucf5vNUxhP9arYPgCCiZ0ajlUu97uP
         w8axhbJ8TgqB9fCUHLs+jVYgRP0qYHRYGGXIxi1AIiwvo3tPdpm6ia1hiwncYWo5+Fid
         er+Q==
X-Gm-Message-State: AC+VfDzmfF5IXb+qQ5GhJYciADEvEOwXSpxG2jU20TwBubSKr5fxGP5S
        VUmeGt38BU5lzrI3sX34HPg=
X-Google-Smtp-Source: ACHHUZ7HxSp7AeQkGVwLSxIaXHu+qHXDM0pV4Bj4OwPA2/aExqBbvjOJKh+VCjF4nVklFJuu46YgMA==
X-Received: by 2002:a17:906:9b85:b0:96f:dd14:f749 with SMTP id dd5-20020a1709069b8500b0096fdd14f749mr1028797ejc.23.1686303679978;
        Fri, 09 Jun 2023 02:41:19 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906594600b00968db60e070sm1072757ejr.67.2023.06.09.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:41:19 -0700 (PDT)
Date:   Fri, 9 Jun 2023 11:41:16 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
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
Message-ID: <ZILzvMBCXfde3COF@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230608083127.545750-1-tomm.merciai@gmail.com>
 <20230608083127.545750-3-tomm.merciai@gmail.com>
 <ZILkSEllSfSGD8XK@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZILkSEllSfSGD8XK@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,
Thanks for your feedback.

On Fri, Jun 09, 2023 at 08:35:20AM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Thu, Jun 08, 2023 at 10:31:15AM +0200, Tommaso Merciai wrote:
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
> > Changes since v4:
> >  - Fixed id as reported by RHerring bot and LPinchart
> >  - Add minimum into alliedvision,lp2hs-delay-us as suggested by CDooley
> >  - Tested using make dt_binding_check DT_SCHEMA_FILES=alliedvision,alvium-csi2.yaml
> > 
> >  .../media/i2c/alliedvision,alvium-csi2.yaml   | 97 +++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > new file mode 100644
> > index 000000000000..c771e5039641
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#
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
> > +    minimum: 1
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
> 
> Why do you need this? D-PHY TX is obviously controlled by the driver.
> Explicit control of PHY initialisation is of course best option when
> combined with some receivers, done via driver's pre_streamon and s_stream
> callbacks. Can't your hardware do that?

You mean calculate this time in some dynamical way and program this
during pre_streamon or s_stream?

If yes, unfortunately hw can't do this.

Regards,
Tommaso

> 
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
> Sakari Ailus
