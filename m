Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760175BC3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiISIC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiISIC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:02:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4EB110A;
        Mon, 19 Sep 2022 01:02:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lh5so20827797ejb.10;
        Mon, 19 Sep 2022 01:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Hb+LQ/uyGV8kGNz+Ke2mkp7zed284VoXqnzKaBCm57g=;
        b=L5wONmIgN9yjpEfobylVqpdBOzqNPY6sKX/2UyZAYoqLOaFNvovGq9tjB0p7VU3CgT
         hvoqRUG1p0O4eVtubAM71ZF+poYWaJGEqm2SIVaI/j/zwjJU+CzSEbawWlQB5MUQFSkn
         g4QGfpCBhF6Y1N98S5/mkkWa3PTqpywetBu2Xi99wTorME0UwqAhRKT9CpZ/sJwE+lvw
         wblNOAZQB1rs3Eo2pqwjBq8iF4GIxJuu1Eha7GsHAEFwl+emi+8dU9IeVbPsgFsG9aj3
         SjdGTwVQxhdZ2Vi/nKesPz5u0ctSeFFoxXUs0z4mk2JmhLQBtCQkA6Royr63EFmy9Ifb
         XYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Hb+LQ/uyGV8kGNz+Ke2mkp7zed284VoXqnzKaBCm57g=;
        b=OgtJAoV4B8SFXXmcxlX4BJlsVtDi2YCjJ4VEw58Nqmr5nj5J/1xpwQYxpUylHtnHV8
         sSBpWNPrX/Gx9zivnJ8Ct+TnJRGZKFG6LrpZ7rsQLML/q61aaISL3mjZCt/RcyWFd2kF
         HEZLgY7fLzLf7P77iuwwqgOe7sqTWERcnZxhwdfOqiqvzK4/o98yxwjFpLC0hbXz2pwy
         JXHKiqwFSSzQjqv9wCMH7q4vVF30IbQFiNMfmVfB0nYmsKkh3WTGaEmC7mTTNApU52qw
         KkmIlclz0FAdiiQy48Y/UgFecIzdI+XvPrgVWX9xTtjpTSLj9onGa2MuoUuRqK1LdNsl
         UUTQ==
X-Gm-Message-State: ACrzQf2SO1nwWWTrB8HmFGrAHllXaX8Vjb6tRDN2qES3RwceET+I4FkM
        reayXyTKLuyztL/98UksZS3MHSRstS134nBccLI=
X-Google-Smtp-Source: AMsMyM4Q31IAB2Gj84OAMmxiawByYlqI0oggv9ZOEatwM3tLlYek88amVbzfL9lDq/aGZHPR1T9Yyhi8maOgjzEzybo=
X-Received: by 2002:a17:907:3f93:b0:780:1b17:1160 with SMTP id
 hr19-20020a1709073f9300b007801b171160mr11919490ejc.196.1663574543166; Mon, 19
 Sep 2022 01:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220916122627.28461-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <YyZS0VeXNki3CDSv@pendragon.ideasonboard.com>
In-Reply-To: <YyZS0VeXNki3CDSv@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 09:01:55 +0100
Message-ID: <CA+V-a8vPja=PLc9aXwxKk2ct-1inpQcPczcSd++6WLnYO22=pw@mail.gmail.com>
Subject: Re: [PATCH v2] media: dt-bindings: ov5645: Convert OV5645 binding to
 a schema
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the review

On Sun, Sep 18, 2022 at 12:06 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Fri, Sep 16, 2022 at 01:26:27PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Convert the simple OV5645 Device Tree binding to json-schema.
> >
> > The previous binding marked the below properties as required which was a
> > driver requirement and not the device requirement so just drop them from
> > the required list during the conversion.
> > - clock-names
>
> Should we then drop clock-names completely, as there's a single clock
> and there will never be more ?
>
Agreed, I'll drop it and send a followup driver patch with the below change:

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 81e4e87e1821..47451238ca05 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1090,7 +1090,7 @@ static int ov5645_probe(struct i2c_client *client)
        }

        /* get system clock (xclk) */
-       ov5645->xclk = devm_clk_get(dev, "xclk");
+       ov5645->xclk = devm_clk_get(dev, NULL);
        if (IS_ERR(ov5645->xclk)) {
                dev_err(dev, "could not get xclk");
                return PTR_ERR(ov5645->xclk);


> > - clock-frequency
> > - vdda-supply
> > - vddd-supply
> > - vdddo-supply
>
> The power supplies should remain mandatory, the sensor can't operate
> without them.
>
Ok, I will mark them as mandatory.

> > - enable-gpios
> > - reset-gpios
>
> These can become optional indeed as they can be hardwired.
>
OK.

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * Dropped ref to video-interface-devices.yaml#
> > * Dropped driver specific required items from the list
> > * Updated commit message
> > * Dropped clock-lanes and bus-type from the port and example node
> > * Marked data-lanes as required in port node
> > ---
> >  .../devicetree/bindings/media/i2c/ov5645.txt  |  54 ---------
> >  .../bindings/media/i2c/ovti,ov5645.yaml       | 105 ++++++++++++++++++
> >  2 files changed, 105 insertions(+), 54 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5645.txt
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> > deleted file mode 100644
> > index 72ad992f77be..000000000000
> > --- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> > +++ /dev/null
> > @@ -1,54 +0,0 @@
> > -* Omnivision 1/4-Inch 5Mp CMOS Digital Image Sensor
> > -
> > -The Omnivision OV5645 is a 1/4-Inch CMOS active pixel digital image sensor with
> > -an active array size of 2592H x 1944V. It is programmable through a serial I2C
> > -interface.
> > -
> > -Required Properties:
> > -- compatible: Value should be "ovti,ov5645".
> > -- clocks: Reference to the xclk clock.
> > -- clock-names: Should be "xclk".
> > -- clock-frequency: Frequency of the xclk clock.
> > -- enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This corresponds
> > -  to the hardware pin PWDNB which is physically active low.
> > -- reset-gpios: Chip reset GPIO. Polarity is GPIO_ACTIVE_LOW. This corresponds to
> > -  the hardware pin RESETB.
> > -- vdddo-supply: Chip digital IO regulator.
> > -- vdda-supply: Chip analog regulator.
> > -- vddd-supply: Chip digital core regulator.
> > -
> > -The device node must contain one 'port' child node for its digital output
> > -video port, in accordance with the video interface bindings defined in
> > -Documentation/devicetree/bindings/media/video-interfaces.txt.
> > -
> > -Example:
> > -
> > -     &i2c1 {
> > -             ...
> > -
> > -             ov5645: ov5645@3c {
> > -                     compatible = "ovti,ov5645";
> > -                     reg = <0x3c>;
> > -
> > -                     enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> > -                     reset-gpios = <&gpio5 20 GPIO_ACTIVE_LOW>;
> > -                     pinctrl-names = "default";
> > -                     pinctrl-0 = <&camera_rear_default>;
> > -
> > -                     clocks = <&clks 200>;
> > -                     clock-names = "xclk";
> > -                     clock-frequency = <24000000>;
> > -
> > -                     vdddo-supply = <&camera_dovdd_1v8>;
> > -                     vdda-supply = <&camera_avdd_2v8>;
> > -                     vddd-supply = <&camera_dvdd_1v2>;
> > -
> > -                     port {
> > -                             ov5645_ep: endpoint {
> > -                                     clock-lanes = <1>;
> > -                                     data-lanes = <0 2>;
> > -                                     remote-endpoint = <&csi0_ep>;
> > -                             };
> > -                     };
> > -             };
> > -     };
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> > new file mode 100644
> > index 000000000000..22e685729bcf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> > @@ -0,0 +1,105 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5645.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: OmniVision OV5645 Image Sensor Device Tree Bindings
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: ovti,ov5645
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: XCLK Input Clock
> > +
> > +  clock-names:
> > +    const: xclk
> > +
> > +  clock-frequency:
> > +    description: Frequency of the xclk clock in Hz.
> > +
> > +  vdda-supply:
> > +    description: Analog voltage supply, 2.8 volts
> > +
> > +  vddd-supply:
> > +    description: Digital core voltage supply, 1.5 volts
> > +
> > +  vdddo-supply:
> > +    description: Digital I/O voltage supply, 1.8 volts
> > +
> > +  enable-gpios:
> > +    maxItems: 1
> > +    description:
> > +      Reference to the GPIO connected to the PWDNB pin, if any.
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      Reference to the GPIO connected to the RESETB pin, if any.
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
> > +          data-lanes:
> > +            minItems: 1
> > +            maxItems: 2
> > +            items:
> > +              enum: [1, 2]
> > +
> > +        required:
> > +          - data-lanes
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +      #include <dt-bindings/gpio/gpio.h>
> > +
> > +      i2c {
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          camera@3c {
> > +              compatible = "ovti,ov5645";
> > +              pinctrl-names = "default";
> > +              pinctrl-0 = <&pinctrl_ov5645>;
> > +              reg = <0x3c>;
> > +              clocks = <&clks 1>;
> > +              clock-names = "xclk";
> > +              clock-frequency = <24000000>;
> > +              vdddo-supply = <&ov5645_vdddo_1v8>; /* 1.8v */
> > +              vdda-supply = <&ov5645_vdda_2v8>;  /* 2.8v */
> > +              vddd-supply = <&ov5645_vddd_1v5>;  /* 1.5v */
>
> I'd drop the comments as the voltages are listed in the label name. Up
> to you.
>
Agreed, I will drop the comments.

Cheers,
Prabhakar
