Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010565BAB8B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiIPKpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiIPKo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:44:29 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEEEAE9CE;
        Fri, 16 Sep 2022 03:25:10 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e131so1183339yba.7;
        Fri, 16 Sep 2022 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GiIfw1dxibIqjmHKxoLe0gdkj3kFgIi+iMb1sHlKIyE=;
        b=YFDCh0XobXY1owjyvGCQYgvG6NuqdzTk1ecS+/18WVvqqmDIM+5su4KWEKCe7uB3+r
         Gfkb5EVKa9gIfut4n2/7v5A481pLC9hl7mfjn8cyYZO+9X6cxTKNzUk2ol8rG+DgoBca
         EH4dTyD44qE4MVGZlimy332ilMVLeIhP2aZfkCh+4aE9XbQ7mwTU0rI/DXzfY15Mf1p8
         uytp15Fe2Nij3h7woGeCdYrzxZ17YBEC4nt6jrpqbI8fy1PgAAHDgebpRNT5jA/3SHK1
         zV0NelATY/cz1njuhyMVbX+eA+yzudt6ctbJnyUtSandPaPRQ27DFW6fncmRD+2Axirm
         ynLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GiIfw1dxibIqjmHKxoLe0gdkj3kFgIi+iMb1sHlKIyE=;
        b=bwygVrgNx8xWWFRzZ6lJiQYsLANeRj7Fbbsf7XlIT3SZGbaeQQwFL0begFI3U62TNT
         5OVe+Sr4SnGXvis78PXxV4CzqzIg14fGwG2g2NswDtQVTyepc2OfIG1t6FDntcGOFPBA
         RW/UaNLD/CVq6LvE+3I+dBP2OnWwqfY9hahmBRUwtqhbpJLJOw/gh9CCfeBwDCjkQtA3
         2AUpxq53BEstGDHdvmzjT4p8bpj5sarhTOxp+dU+NNgQLo/UGfOKu706zZy/QNsCnj2S
         AhcA9/SNI/wEybUAH3g2kHNYDqZrr/4ps2dpTtVf5u/KoZ3UfXwrk6i7D5iddFLO9HCf
         Zxdg==
X-Gm-Message-State: ACrzQf0EhAIImeBQmmnWoxchlKuCKlHBFoCjyq+3FwlOhBhPA/OVOHs4
        P+uAohQ6aGHIgiBUL2GBLomlzW9wo8XP5o1uTdc=
X-Google-Smtp-Source: AMsMyM4Wv12sOXw1JibT4UDIF9iFQLRDHgdZt1xzBtXwSBe6jqHIlRJqa6y/OkUzGJh8OumyiiXb3VBK2ELbIVIOgQc=
X-Received: by 2002:a25:8b8c:0:b0:67b:5c18:870 with SMTP id
 j12-20020a258b8c000000b0067b5c180870mr3663306ybl.244.1663323900308; Fri, 16
 Sep 2022 03:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220914214132.GA2173@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20220914214132.GA2173@tom-ThinkPad-T14s-Gen-2i>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 16 Sep 2022 11:24:33 +0100
Message-ID: <CA+V-a8ufbsiz3p2n3LmYxES2aJYN9y8byF9bSyckNFz=fB-5LQ@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: ov5645: Convert OV5645 binding to a schema
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
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

Hi Tommaso,

Thank you for the review.

On Wed, Sep 14, 2022 at 10:41 PM Tommaso Merciai
<tommaso.merciai@amarulasolutions.com> wrote:
>
> Hi Prabhakar,
>
> On Tue, Sep 13, 2022 at 05:02:24PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Convert the simple OV5645 Device Tree binding to json-schema.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/media/i2c/ov5645.txt  |  54 --------
> >  .../bindings/media/i2c/ovti,ov5645.yaml       | 119 ++++++++++++++++++
> >  2 files changed, 119 insertions(+), 54 deletions(-)
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
> > index 000000000000..7f407c988f87
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml
> > @@ -0,0 +1,119 @@
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
> > +allOf:
> > +  - $ref: /schemas/media/video-interface-devices.yaml#
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
> > +          clock-lanes:
> > +            const: 0
> > +
> > +          bus-type:
> > +            const: 4
> > +
> > +          data-lanes:
> > +            minItems: 1
> > +            maxItems: 2
> > +            items:
> > +              enum: [1, 2]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - clock-frequency
> > +  - vdda-supply
> > +  - vddd-supply
> > +  - vdddo-supply
> > +  - enable-gpios
> > +  - reset-gpios
> > +  - port
>
> I think we don't need all of these properties as required.
> The only "really" required are:
>
>   - compatible
>   - reg
>   - clocks
>   - port
>
Agreed, it's just the driver requirement hence the previous bindings
had marked them as required.

Cheers,
Prabhakar
