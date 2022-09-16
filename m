Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C0C5BAADF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiIPKbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiIPKaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:30:52 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C26B5A43;
        Fri, 16 Sep 2022 03:18:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 130so31798235ybw.8;
        Fri, 16 Sep 2022 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JeqBUIL5Q3gilj1ggDIfyx5qaL/olub3pv2t1oiDKOU=;
        b=ln3rWLSKaB6VusyovUiKD6ahSQrzeiB3ECQYdGt88pI/k9YFVYM7kaH02KhwQF/Era
         MlJFiVQ7/M8fu1zTPe7xioVTujWQ4Jmod9rHnfrwMTWgVtU3sBXSQMdk9vFOaQYnYpnk
         6VJgEtbFYyklTPUTpX0XQJLkQcw/VAu+24iIFmW4sOJylYlbi/zGlUAdBfg0Y+R+xlNB
         b4gTNTSEaY9KUsmeOXPboVAhz0J8RLwPCnRprPKmIzpgThWuhho2Q/4QkoKQXMtDa7RY
         B5AT3GFmE9bNrRb0pod02OjJezpYseMW4XN4xUGANtrF04M/oLr18eJpWvKa7Al/Ke4e
         puig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JeqBUIL5Q3gilj1ggDIfyx5qaL/olub3pv2t1oiDKOU=;
        b=2+Wob/dODrsL6ojebK8a4XaWemOxkUejyyTRsw2hZkLhmlMjYBjxEWxyOcntIVqORz
         7QjgAovzZEV+VvwPTGL4zV//aAfjhTXm+EdSuteLrMxDzM9FXWGlo3HQuxraXXABvc60
         ri3sURthEG8k0BRHBS78XfSmD1iq7EtKFUNzNBfl259DEe6k2L6WX3Fu5coLFtolKfDk
         vGkqbeMc+N+/TjRWvOXj/o2IRv5ezKjLeLiU0BT7HKEHgDkPskXtHOFdeup4ogfGniZZ
         daF5k2BknqmJgfy3mHsUn7gjjkqrc7Zo9i9xKhHVTK0mGx2cHC2Uoj75e05SWgSQEari
         xjug==
X-Gm-Message-State: ACrzQf1fcjvFhRX6juhBRPIpk6k3QCLQXAAcHo4ZycQ6UUhL5cb9drsY
        8eBeM2AgH6F4Gz6/aDjDJV9XU3iP0yxlcElOLuU=
X-Google-Smtp-Source: AMsMyM6KKWpmTT+3967gp0w0iTjppjIVs4dzGIiballbtWjO+1p+Rxm+vdYhdtBOPbvM6HN3pqfV7lj6943osxtks7A=
X-Received: by 2002:a05:6902:1007:b0:6ae:6cd5:4b0b with SMTP id
 w7-20020a056902100700b006ae6cd54b0bmr3827198ybt.354.1663323446656; Fri, 16
 Sep 2022 03:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220914141655.GA2131586-robh@kernel.org>
In-Reply-To: <20220914141655.GA2131586-robh@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 16 Sep 2022 11:16:59 +0100
Message-ID: <CA+V-a8vDu_JJ4x+R-a+cLthjWRtdYD=aqnRfCYQYYR4QOUO_kQ@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: ov5645: Convert OV5645 binding to a schema
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
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

Hi Rob,

Thank you for the review.

On Wed, Sep 14, 2022 at 3:16 PM Rob Herring <robh@kernel.org> wrote:
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
>
> What are you using from here?
>
> (Answer below)
>
> > +
> > +properties:
<snip>
> > +  - port
> > +
> > +additionalProperties: false
>
> You are not because this prevents it. Either remove the ref or use
> unevaluatedProperties.
>
I'll drop the ref while sending the v2.

Cheers,
Prabhakar
