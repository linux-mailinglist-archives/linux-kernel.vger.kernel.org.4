Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E4E7145CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjE2H5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjE2H5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:57:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A65AC;
        Mon, 29 May 2023 00:57:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-514924b4f8cso2914340a12.3;
        Mon, 29 May 2023 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685347069; x=1687939069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qqGqiO4ndkjf0+jSsXuDX+UyXqG51piAUZDUSuHN4n0=;
        b=g890nTuCK59aYad1AAbzUTKgqG343hFWwrQVdLcJB7bl51HmS4hEHyTbUBPmhvsm51
         V/PhNdSjzdd8qbrY6Ba/qIua6eravlQ+45w1UDpuyD7wFmDC96xgY2wmflKQE9Tg3Bq8
         iLgOg2Ou/qM+AxExe8FjeAgf07FIS1ai/y/Ec4i/VibwxtK6HJhtNw4vn/kwLu7cmp+x
         7tzuxXon27wJSbQqAhojQiHHZSdw0wGwCJiFXKdI+GE1OQk3NPPFpTG/kOuWOkIR2rSu
         bRdGmvaTRcMrofm8LIvCQLNCeWTpvmVCKaFSE9EZTqYql23BBmLX1Gof6wfgsKUF74K3
         3OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347069; x=1687939069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqGqiO4ndkjf0+jSsXuDX+UyXqG51piAUZDUSuHN4n0=;
        b=TUpn8Ym5p0i5P1fr2NpwLloYjkuXZ0mu+r/rp51je3M4YPYmYgXY1lhCYyG6d9jeUS
         eapb3THk2J6IOijWcy1mMbUzH4yIaeus3MYGOnC5eNcJ4gSUZ91+LNGKdnjMvAsUIcKB
         URjb/F2xmzfvhaxubcBDM5v2LSKvX+ZEiWGECyYA7ugep7un1c2fN0ltF7k67rMszSgH
         iauBNodhQ8wRYwQXmLiHp6j0g5zDDkOISkPBM0swOzGXK41zf2pR9nl6ydfR+pXV2+Aj
         /vXplqm0jWu6dTESk1rcbpOaslG9mhfA5NxYBEeULe23i5PZDm9WvKAwxzLCRj0Tm1IY
         vKXg==
X-Gm-Message-State: AC+VfDwkXZqgIkOwayKgxyn2aYafa3O/jACI6f6SJjuu9evN7YqRGJ6p
        lZ2BeNifinHi5tx5D46B6cM=
X-Google-Smtp-Source: ACHHUZ4NRmJMKd+1mQzdudbceBwYSK5vISu+5C0co5Xwsapztsi8NsAGKPYsg9E2msEbdwtg7K5HNA==
X-Received: by 2002:a50:ef10:0:b0:514:8e56:4cae with SMTP id m16-20020a50ef10000000b005148e564caemr5999786eds.8.1685347069282;
        Mon, 29 May 2023 00:57:49 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id z4-20020aa7d404000000b0050bc9ffed66sm2782001edq.53.2023.05.29.00.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:57:48 -0700 (PDT)
Date:   Mon, 29 May 2023 09:57:45 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        linuxfancy@googlegroups.com,
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
        linux-kernel@vger.kernel.org,
        Michael Roeder <michael.roeder@avnet.eu>
Subject: Re: [PATCH v2 1/2] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZHRa+Uzmez9Q+sX1@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-2-tomm.merciai@gmail.com>
 <ZHPElYOeD2C1qo4R@kekkonen.localdomain>
 <20230529063907.GB25984@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529063907.GB25984@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laurent,

On Mon, May 29, 2023 at 09:39:07AM +0300, Laurent Pinchart wrote:
> On Sun, May 28, 2023 at 09:16:05PM +0000, Sakari Ailus wrote:
> > On Fri, May 26, 2023 at 07:39:43PM +0200, Tommaso Merciai wrote:
> > > Add documentation of device tree in YAML schema for the ALVIUM
> > > Camera from Allied Vision Inc.
> > > 
> > > References:
> > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > 
> > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > ---
> > > Changes since v1:
> > >  - Fixed build error as suggested by RHerring bot
> > > 
> > >  .../media/i2c/alliedvision,alvium.yaml        | 115 ++++++++++++++++++
> > >  1 file changed, 115 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > > new file mode 100644
> > > index 000000000000..81e9e560c99d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> > > @@ -0,0 +1,115 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Alliedvision Alvium Camera
> 
> s/Alliedvision/Allied Vision/

Arg... Thanks :)

> 
> > > +
> > > +maintainers:
> > > +  - Tommaso Merciai <tomm.merciai@gmail.com>
> > > +  - Martin Hecht <martin.hecht@avnet.eu>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: alliedvision,alvium
> 
> The name is very generic. There are Alvium camera modules that have a
> GMSL or FPD-Link interface, and I'm pretty sure those will require a
> different driver. I would add module-specific compatible strings (e.g.
> "alliedvision,alvium-1500c", ...) here, with a generic fallback.
> "alliedvision,alvium" isn't good as it won't cover GMSL or FPD-Link,
> maybe "alliedvision,alvium-csi2" would be an option.
> 
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    description: XCLK Input Clock
> > > +
> > > +  clock-names:
> > > +    const: xclk
> > 
> > I'd also drop this as you have a single clock only: it's redundant.
> > 
> > > +
> > > +  powerdown-gpios:
> > > +    maxItems: 1
> > > +    description: >
> > > +      Reference to the GPIO connected to the powerdown pin, if any.
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +    description: >
> > > +      Reference to the GPIO connected to the reset pin, if any.
> 
> Reading the Alvium CSI-2 Cameras User Guide, I don't see any powerdown
> or reset pin on the 22-pin connector. Am I missing something ? There are
> however two GPIOs (in addition to the I2C signals that are also
> documented as GPIOs), do you plan to support those ?

You are completely right I will drop rst and pwdn pins.
About 2 gpios, we don't use those for now.

> 
> > > +
> > > +  streamon-delay:
> > > +    maxItems: 1
> > > +    description: >
> > > +      Delay before camera start capturing frames in us.
> 
> Add "-us" to the property name to indicate the unit.
> 
> This is a vendor-specific property, and should thus have a vendor
> prefix.
> 
> A longer description is needed, from that single line I have no idea
> what the property does exactly.

Thanks for the suggestion.
I will provide a cleared description on v3.

> 
> > > +
> > > +  rotation:
> > > +    enum:
> > > +      - 0
> > > +      - 180
> 
> Why is the rotation restricted to 0 or 180 ? Someone could mount the
> module with  90 degrees rotation, shouldn't the DT bindings allow
> describing that ?

I'll drop rotation.

> 
> You need a property for the vcc-ext-in supply.

Can you give me more details about this?
Thanks.

> 
> > > +
> > > +  port:
> > > +    description: Digital Output Port
> > > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > > +    additionalProperties: false
> > > +
> > > +    properties:
> > > +      endpoint:
> > > +        $ref: /schemas/media/video-interfaces.yaml#
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          clock-lanes:
> > > +            const: 0
> > 
> > The driver can know this, no need to have it in DT, i.e. please drop it.
> > 
> > > +          data-lanes:
> > > +            minItems: 1
> > > +            maxItems: 4
> > > +          link-frequencies: true
> > > +
> > > +        required:
> > > +          - data-lanes
> > > +          - link-frequencies
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - port
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +      #include <dt-bindings/gpio/gpio.h>
> > > +      #include <dt-bindings/clock/imx8mp-clock.h>
> > > +
> > > +      i2c {
> > > +          #address-cells = <1>;
> > > +          #size-cells = <0>;
> > > +
> > > +          camera: alvium@3c {
> > > +              compatible = "alliedvision,alvium";
> 
> The "alliedvision" prefix is missing from
> Documentation/devicetree/bindings/vendor-prefixes.yaml.

oks

> 
> > > +              pinctrl-names = "default";
> > > +              pinctrl-0 = <&pinctrl_csi0_pwn>, <&pinctrl_csi0_rst>, <&pinctrl_csi_mclk>;
> 
> I'd drop pinctrl, it makes the example longer without adding much value.

oks

> 
> > > +              reg = <0x3c>;
> > > +              clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> > > +              clock-names = "xclk";
> > > +              assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> > > +              assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
> > > +              assigned-clock-rates = <24000000>;
> > > +              streamon-delay = <20>;
> > > +              powerdown-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> > > +              reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> > > +              status = "okay";
> > > +
> > > +              port {
> > > +                  alvium_out: endpoint {
> > > +                      remote-endpoint = <&mipi_csi_0_in>;
> > > +                      data-lanes = <1 2 3 4>;
> > > +                      link-frequencies = /bits/ 64 <681250000>;
> > > +                      clock-lanes = <0>;
> > > +                  };
> > > +              };
> > > +          };
> > > +      };
> > > +
> > > +...

Thanks for your time.

Regards,
Tommaso


> 
> -- 
> Regards,
> 
> Laurent Pinchart
