Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38EE74DCE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjGJR50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B162B18C;
        Mon, 10 Jul 2023 10:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 463C26117D;
        Mon, 10 Jul 2023 17:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2555C433CD;
        Mon, 10 Jul 2023 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689011838;
        bh=/I5pqYNPgMU3EjysBC8ykci8OtSUSnTRyQ0bamboDiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e+Z5FkSfT6duwNCWirzt2iuOixAqEnm0JK9up5V0+jTppqhwHlH0UDFU8bBk9jT8i
         0pwFpzfbYYfS6xC3JcptsLHwAsuiI7s/zyVSjktfZVQXedeIcF+Mct+c1sxkMDaeVT
         mvbiN/NFMI4l8Mfi4XK+SnAHRLIvUCEHGtF/ztTCDRRgbNzjFZmnjh6oAi5vMh6BDB
         8PwPBDZfDMKKzzm3UNtwP3yjc64bVD8SzHPCUOoBxYVNP3mBiUxAw1MDLD/qCvN4nn
         UqSHR1OU/6EMvOAqZAu4jbh6Pa8vqZtgrv8NMPN+V7hwVhqmxngDLaUkin8hrR7dQJ
         Q9lEOqgCjoGpA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so11584541fa.0;
        Mon, 10 Jul 2023 10:57:18 -0700 (PDT)
X-Gm-Message-State: ABy/qLbpcqSbntLg/lqEFuysSdsykYh2BJ/kA23FtdS7dNEJptwKdfW8
        wBNzImJsCAW5JU15kQmFoY9jNqPxqX3sRhEVIQ==
X-Google-Smtp-Source: APBJJlHgHIBMx0YbZYevY8LJVdcaIrKkIL2GZViFEE5jVuJubzdXhi9id/g0Ssb5aSItTwU4S71nTDiAya5Sq6Ji/t4=
X-Received: by 2002:a2e:b044:0:b0:2b6:d0c1:7cd0 with SMTP id
 d4-20020a2eb044000000b002b6d0c17cd0mr5110497ljl.22.1689011836511; Mon, 10 Jul
 2023 10:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210604.868002-1-robh@kernel.org> <20230710-unsold-simplify-5a339036ff38@spud>
In-Reply-To: <20230710-unsold-simplify-5a339036ff38@spud>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Jul 2023 11:57:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOW7kxC4m8tCmNrD6pq5y73BjV236nb+ZHAhR4rDrNvw@mail.gmail.com>
Message-ID: <CAL_JsqJOW7kxC4m8tCmNrD6pq5y73BjV236nb+ZHAhR4rDrNvw@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: Merge OV5695 into OV5693 binding
To:     Conor Dooley <conor@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Helen Koike <helen.koike@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:45=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, Jul 07, 2023 at 03:06:04PM -0600, Rob Herring wrote:
> > The OV5695 binding is almost the same as the OV5693 binding. The only
> > difference is 'clock-names' is defined for OV5695. However, the lack of
> > clock-names is an omission as the Linux OV5693 driver expects the same
> > 'xvclk' clock name.
> >
> > 'link-frequencies' is required by OV5693, but not OV5695. Just drop it
> > from being required. Expressing it conditionally would be ugly. It
> > shouldn't really be required either as the driver only supports 1
> > frequency anyways.
>
> I suppose the intent here is something like "the driver only supports 1
> frequency and never bothers to read the property"?

It does read it and fails if it doesn't match. I don't really think
the driver should if there is only 1 freq. I don't know if it's that
the hw only supports 1 frequency or a driver limitation. If the h/w,
then the property is pointless.


> Either way,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.
>
> >
> > The rockchip-isp1 binding example is missing required properties, so it
> > has to be updated as well.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/media/i2c/ov5695.txt  | 41 -------------------
> >  .../bindings/media/i2c/ovti,ov5693.yaml       | 19 +++++----
> >  .../bindings/media/rockchip-isp1.yaml         |  1 +
> >  3 files changed, 13 insertions(+), 48 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5695.=
txt
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ov5695.txt b/D=
ocumentation/devicetree/bindings/media/i2c/ov5695.txt
> > deleted file mode 100644
> > index 640a63717d96..000000000000
> > --- a/Documentation/devicetree/bindings/media/i2c/ov5695.txt
> > +++ /dev/null
> > @@ -1,41 +0,0 @@
> > -* Omnivision OV5695 MIPI CSI-2 sensor
> > -
> > -Required Properties:
> > -- compatible: shall be "ovti,ov5695"
> > -- clocks: reference to the xvclk input clock
> > -- clock-names: shall be "xvclk"
> > -- avdd-supply: Analog voltage supply, 2.8 volts
> > -- dovdd-supply: Digital I/O voltage supply, 1.8 volts
> > -- dvdd-supply: Digital core voltage supply, 1.2 volts
> > -- reset-gpios: Low active reset gpio
> > -
> > -The device node shall contain one 'port' child node with an
> > -'endpoint' subnode for its digital output video port,
> > -in accordance with the video interface bindings defined in
> > -Documentation/devicetree/bindings/media/video-interfaces.txt.
> > -The endpoint optional property 'data-lanes' shall be "<1 2>".
> > -
> > -Example:
> > -&i2c7 {
> > -     ov5695: camera-sensor@36 {
> > -             compatible =3D "ovti,ov5695";
> > -             reg =3D <0x36>;
> > -             pinctrl-names =3D "default";
> > -             pinctrl-0 =3D <&clk_24m_cam>;
> > -
> > -             clocks =3D <&cru SCLK_TESTCLKOUT1>;
> > -             clock-names =3D "xvclk";
> > -
> > -             avdd-supply =3D <&pp2800_cam>;
> > -             dovdd-supply =3D <&pp1800>;
> > -             dvdd-supply =3D <&pp1250_cam>;
> > -             reset-gpios =3D <&gpio2 5 GPIO_ACTIVE_LOW>;
> > -
> > -             port {
> > -                     wcam_out: endpoint {
> > -                             remote-endpoint =3D <&mipi_in_wcam>;
> > -                             data-lanes =3D <1 2>;
> > -                     };
> > -             };
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.ya=
ml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > index 359dc08440a8..a3d73a87d797 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> > @@ -5,26 +5,29 @@
> >  $id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >
> > -title: Omnivision OV5693 CMOS Sensor
> > +title: Omnivision OV5693/OV5695 CMOS Sensors
> >
> >  maintainers:
> >    - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> >
> >  description: |
> > -  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, =
CMOS
> > -  image sensor that delivers 2592x1944 at 30fps. It provides full-fram=
e,
> > +  The Omnivision OV5693/OV5695 are high performance, 1/4-inch, 5 megap=
ixel, CMOS
> > +  image sensors that deliver 2592x1944 at 30fps. It provides full-fram=
e,
> >    sub-sampled, and windowed 10-bit MIPI images in various formats via =
the
> >    Serial Camera Control Bus (SCCB) interface.
> >
> > -  OV5693 is controlled via I2C and two-wire Serial Camera Control Bus =
(SCCB).
> > -  The sensor output is available via CSI-2 serial data output (up to 2=
-lane).
> > +  OV5693/OV5695 are controlled via I2C and two-wire Serial Camera Cont=
rol Bus
> > +  (SCCB). The sensor output is available via CSI-2 serial data output =
(up to
> > +  2-lane).
> >
> >  allOf:
> >    - $ref: /schemas/media/video-interface-devices.yaml#
> >
> >  properties:
> >    compatible:
> > -    const: ovti,ov5693
> > +    enum:
> > +      - ovti,ov5693
> > +      - ovti,ov5695
> >
> >    reg:
> >      maxItems: 1
> > @@ -34,6 +37,9 @@ properties:
> >        System input clock (aka XVCLK). From 6 to 27 MHz.
> >      maxItems: 1
> >
> > +  clock-names:
> > +    const: xvclk
> > +
> >    dovdd-supply:
> >      description:
> >        Digital I/O voltage supply, 1.8V.
> > @@ -72,7 +78,6 @@ properties:
> >
> >          required:
> >            - data-lanes
> > -          - link-frequencies
> >
> >  required:
> >    - compatible
> > diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml=
 b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> > index 0bad7e640148..e466dff8286d 100644
> > --- a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> > +++ b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> > @@ -199,6 +199,7 @@ examples:
> >              wcam: camera@36 {
> >                  compatible =3D "ovti,ov5695";
> >                  reg =3D <0x36>;
> > +                clocks =3D <&cru SCLK_TESTCLKOUT1>;
> >
> >                  port {
> >                      wcam_out: endpoint {
> > --
> > 2.40.1
> >
