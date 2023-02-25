Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AAD6A2AED
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBYRDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYRDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:03:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C210424;
        Sat, 25 Feb 2023 09:03:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDF61B80ABB;
        Sat, 25 Feb 2023 17:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FBCC433EF;
        Sat, 25 Feb 2023 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677344579;
        bh=bHEWDyG7kXz25ZUz+/73q42vYXCa+sI94eFctjfq2C8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m+1z9lMOxjnx3evCxXFRmNZ75g42hZfkCSWI7/uZSmWl8389iW/oHE29kD4HLs391
         F+cY/H/KMOkxYzSdvrzbWMp91FO17NbDwio7IM8HUvDdRmbuKhOc3qRRo95FL/xF7J
         W4BNdZmkc3CBikf/Iw56keg4q1HgIqgKCB1yCzmRE8+QSIfizrzZtwgIviNxTv/mgI
         dfLxqRShK4RAeogFPIDhilEmlqOMLPTIN+5foDm0+frtbl0pnthzJYSiN7ADAvUeLs
         vqVl+P+Zdp7bT2Tls9anD2VfB/HJS8oPEl55qi4l3tohjIB5kLSj6BYtyCWTmdo9OT
         9nRbLqGEcNzCg==
Date:   Sat, 25 Feb 2023 17:17:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Message-ID: <20230225171723.15e822ec@jic23-huawei>
In-Reply-To: <c38afa67-d24f-0390-f18a-81bee15b7eca@kernel.org>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
        <20230220123232.413029-2-marius.cristea@microchip.com>
        <c38afa67-d24f-0390-f18a-81bee15b7eca@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marius

Welcome to IIO.

I'll comment on top of Krzystof's review to avoid duplication.


> >=20
> > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > ---
> >  .../bindings/iio/adc/microchip,pac193x.yaml   | 122 ++++++++++++++++++

Wild cards in names bite us far too often.  Name this and the driver after =
one of
the supported parts.

> >  1 file changed, 122 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip=
,pac193x.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac193=
x.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
> > new file mode 100644
> > index 000000000000..e4ea560991e9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
> > @@ -0,0 +1,122 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/microchip,pac193x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip PAC193X Power Monitors with Accumulator
> > +
> > +maintainers:
> > +  - Marius Cristea <marius.cristea@microchip.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microchip,pac1934
> > +      - microchip,pac1933
> > +      - microchip,pac1932
> > +      - microchip,pac1931 =20
>=20
> Maybe order these numerically (ascending)?
>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  microchip,samp-rate:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Sampling rate for all device's channels. =20
>=20
> What are the units? rate is usually in hz, which should be expressed in
> unit suffix (property name)]

It's unusual for sampling rate to be a property of the hardware and hence
suitable for DT binding. Normally we make this a userspace control instead.
If there is a reason for doing it from DT, that wants to be mentioned here.

>=20
> > +    enum: [8, 64, 256, 1024]
> > +    default: 1024
> > +
> > +required: =20
>=20
> required goes after all properties, so after patternProperties
>=20
> > +  - compatible
> > +  - reg
> > +  - microchip,samp-rate
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +patternProperties:
> > +  "^channel([1-4])@[1-4]+$": =20
>=20
> Why first reg-pattern ([1-4])? For what do you need it?
>=20
> > +    $ref: "adc.yaml" =20
>=20
> Drop quotes
>=20
> > +    type: object
> > +    description: Represents the external channels which are connected =
to the ADC.
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel number.
> > +          It can have up to 4 channels, numbered from 1 to 4.
> > +        items:
> > +          - minimum: 1
> > +            maximum: 4
> > +
> > +      microchip,uohms-shunt-res: =20
>=20
> Not a correct unit suffix. Use standard properties:
> git grep shunt -- Documentation/devicetree/

Check for existing relevant properties. Here we have
shunt-resistor-micro-ohms in common use in both IIO and hwmon.


>=20
>=20
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: |
> > +          Value in micro Ohms of the shunt resistor connected between
> > +          the SENSE+ and SENSE- inputs, across which the current is me=
asured. Value
> > +          is needed to compute the scaling of the measured current.
> > +
> > +      microchip,rail-name:
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        description: Name of the monitored power rail. =20
>=20
> Why do you need it? Why this is a property of DT? Aren't you now
> duplicating label?


Agreed. Sounds like label to me as well.

>=20
> > +
> > +      microchip,bi-directional:
> > +        description: Whether the channel is bi-directional. =20
>=20
> Describe here what is a "bi-directional" channel for ADC... Maybe it is
> obvious, maybe not. For me it is not and none of other devices have it.
>=20
=46rom datasheet this seems to be a novel description of whether the ADC
is measuring just positive or allows for negative voltage as well (i.e.
the current through the shut resistor is going on the other direction).
Can we relate this to a biopolar / unipolar decision on a simple voltage AD=
C?
For that we have standard DT bindings in iio/adc/adc.yaml


> > +        type: boolean
> > +
> > +    required:
> > +      - reg
> > +      - microchip,uohms-shunt-res
> > +      - microchip,rail-name
> > +
> > +    additionalProperties: false
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        pac193x: pac193x@10 { =20
>=20
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>=20
> > +            compatible =3D "microchip,pac1934";
> > +            reg =3D <0x10>;
> > +
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            microchip,samp-rate =3D <64>;
> > +
> > +            channel1@1 { =20
>=20
> 1@1 is for sure not generic...

Standard naming for channel nodes in adc.yaml
Some bindings predate that, but for new ones please match it.

Thanks,

Jonathan



>=20
>=20
>=20
> Best regards,
> Krzysztof
>=20

