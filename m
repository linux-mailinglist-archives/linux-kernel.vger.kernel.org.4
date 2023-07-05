Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EDC747F81
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGEIXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjGEIXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:23:15 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BF173C;
        Wed,  5 Jul 2023 01:22:59 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688545378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rydOgVNykw77d4FJDzENpk9IP9/IhrYgK2eGBj+DtDo=;
        b=f7GkieLtVuK91DIemhGTaVzwZ65cQ3DEVfd/8UNvgdZ8qCyHjuqj9fwfYIVIRyCrozRBF4
        g3NATy9M3Z27XB/jzpWAjFCjwvAyJIWV66A7TQl6pK79srxl7lU7NsQbVsbXNREj2wt3rA
        g0FrNqsc+yg6ryTQ3qkalrjhezmZm+ydJH0l2BO56yVWQ48E6Hcp7Yzzwbv2JJeGNAcVLP
        +tR776beHA4wQxRana4fVs8xujefzWiM4oKX6MmIHf6vDnS5yez9clfALcUsI2EhMNKmoD
        mcw1FjIASORh7mw8SYkni/S35iWzuzu0DF1z/CDlFe9TnWZQu8AW+b6cWjbcNg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A6694000B;
        Wed,  5 Jul 2023 08:22:55 +0000 (UTC)
Date:   Wed, 5 Jul 2023 10:22:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: nand: meson: support for 512B
 ECC step size
Message-ID: <20230705102254.0aeb94ea@xps-13>
In-Reply-To: <365898fb-3719-38e0-4383-e04ccc0b475b@sberdevices.ru>
References: <20230705065434.297040-1-AVKrasnov@sberdevices.ru>
        <20230705065434.297040-2-AVKrasnov@sberdevices.ru>
        <20230705093702.6c0421d7@xps-13>
        <365898fb-3719-38e0-4383-e04ccc0b475b@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Wed, 5 Jul 2023 11:03:30 +0300:

> On 05.07.2023 10:37, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > AVKrasnov@sberdevices.ru wrote on Wed, 5 Jul 2023 09:54:33 +0300:
> >  =20
> >> Meson NAND supports both 512B and 1024B ECC step size, so replace
> >> 'const' for only 1024B step size with enum for both sizes.
> >>
> >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >> ---
> >>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.=
yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> >> index 3bec8af91bbb..81ca8828731a 100644
> >> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> >> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> >> @@ -49,7 +49,8 @@ patternProperties:
> >>          const: hw
> >> =20
> >>        nand-ecc-step-size:
> >> -        const: 1024
> >> +        enum: [512, 1024]
> >> +        default: 1024 =20
> >=20
> > I was actually wrong in my previous review, there is no strong default
> > here as the existing binding (and code) try to use the closest
> > parameters required by the NAND chip: we pick the "optimal"
> > configuration. So if you don't provide any value here, we expect
> > the strength and step size advertized by the chip to be used. This is a
> > common default in the raw NAND subsystem.
> >=20
> > Please drop the default line, re-integrate the missing R-by tag from
> > Rob and in a separate patch please mark nand-ecc-step-size and
> > nand-ecc-strength mandatory if the other is provide. IOW, we expect
> > either both, or none of them, but not a single one. =20
>=20
> I see, no problem! "mandatory" means update description of both fields li=
ke:
>=20
>     description:                                                       =20
>       Mandatory if nand-ecc-step-size is set.

Nope :-)

Something along:

allOf:
  - if:
    <nand-chip>:
      properties:
        contains:
          - nand-ecc-step-size
    then:
      required:
        <nand-chip>:
          properties:
            - nand-ecc-strength

And same with the opposite logic.

>=20
> etc.
>=20
> ?
>=20
> >  =20
> >> =20
> >>        nand-ecc-strength:
> >>          enum: [8, 16, 24, 30, 40, 50, 60]
> >> @@ -93,6 +94,7 @@ examples:
> >>        nand@0 {
> >>          reg =3D <0>;
> >>          nand-rb =3D <0>;
> >> +        nand-ecc-step-size =3D <1024>; =20
> >=20
> > So in the end this line is wrong and once you get the description right
> > as I mentioned it above, this will fail to pass
> > `make DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mtd/ dt_binid=
ng_check`
> > Please drop it from the example, don't add the second property here,
> > it's best to show a clean example where people stop tampering for no
> > reason with the optimal values. =20
>=20
> Ok!
>=20
> Thanks, Arseniy
>=20
> >  =20
> >>        };
> >>      };
> >>   =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
