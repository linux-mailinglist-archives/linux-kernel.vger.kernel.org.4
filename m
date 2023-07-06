Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A263774954C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjGFGF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjGFGFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:05:53 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2889910F2;
        Wed,  5 Jul 2023 23:05:44 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688623543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lv0loJdFyoV3AVvlZn4Pmp1SJuFFj/UT8jk6/AKpsHw=;
        b=XSoSSqqmC+dg4D1FnsJ6ZVW/YzNN62aPkQUj3ryPOrMUWEHAzVFi9Rn3GIJj0dGkJYus2Z
        ZUU8RnizTHDhli0m0xi81adQ50HCJsXR0kS7++DOmxVyhktuUKphg2JopBfL41Nrnjxckc
        ovnVM0Pp8b+N/MC/zWCIUeRNrT8/vgduZP/aMJtI5qG353fiM4aa5ksBhFCdJadu36YrCt
        3P3t2XXlAxkvP/DLxXGNwhNo16SHoYQh2ftsVeVyAabBLwvHNAqhP7S3xL9SYCINsvCHmZ
        O3Mofv4k+vNA+HzRLm8qBVndCfhrUQI8Os0Dl97bhZ+B5tYbC/I38teUSg2T1w==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id B87B560005;
        Thu,  6 Jul 2023 06:05:40 +0000 (UTC)
Date:   Thu, 6 Jul 2023 08:05:39 +0200
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
Message-ID: <20230706080539.11b57e10@xps-13>
In-Reply-To: <677b0b16-2bfc-46e5-6029-e3b56abcaa3c@sberdevices.ru>
References: <20230705065434.297040-1-AVKrasnov@sberdevices.ru>
        <20230705065434.297040-2-AVKrasnov@sberdevices.ru>
        <20230705093702.6c0421d7@xps-13>
        <365898fb-3719-38e0-4383-e04ccc0b475b@sberdevices.ru>
        <20230705102254.0aeb94ea@xps-13>
        <677b0b16-2bfc-46e5-6029-e3b56abcaa3c@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Thu, 6 Jul 2023 08:57:00 +0300:

> On 05.07.2023 11:22, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > avkrasnov@sberdevices.ru wrote on Wed, 5 Jul 2023 11:03:30 +0300:
> >  =20
> >> On 05.07.2023 10:37, Miquel Raynal wrote: =20
> >>> Hi Arseniy,
> >>>
> >>> AVKrasnov@sberdevices.ru wrote on Wed, 5 Jul 2023 09:54:33 +0300:
> >>>    =20
> >>>> Meson NAND supports both 512B and 1024B ECC step size, so replace
> >>>> 'const' for only 1024B step size with enum for both sizes.
> >>>>
> >>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 4 +=
++-
> >>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nan=
d.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> >>>> index 3bec8af91bbb..81ca8828731a 100644
> >>>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> >>>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> >>>> @@ -49,7 +49,8 @@ patternProperties:
> >>>>          const: hw
> >>>> =20
> >>>>        nand-ecc-step-size:
> >>>> -        const: 1024
> >>>> +        enum: [512, 1024]
> >>>> +        default: 1024   =20
> >>>
> >>> I was actually wrong in my previous review, there is no strong default
> >>> here as the existing binding (and code) try to use the closest
> >>> parameters required by the NAND chip: we pick the "optimal"
> >>> configuration. So if you don't provide any value here, we expect
> >>> the strength and step size advertized by the chip to be used. This is=
 a
> >>> common default in the raw NAND subsystem.
> >>>
> >>> Please drop the default line, re-integrate the missing R-by tag from
> >>> Rob and in a separate patch please mark nand-ecc-step-size and
> >>> nand-ecc-strength mandatory if the other is provide. IOW, we expect
> >>> either both, or none of them, but not a single one.   =20
> >>
> >> I see, no problem! "mandatory" means update description of both fields=
 like:
> >>
> >>     description:                                                      =
 =20
> >>       Mandatory if nand-ecc-step-size is set. =20
> >=20
> > Nope :-)
> >=20
> > Something along:
> >=20
> > allOf:
> >   - if:
> >     <nand-chip>:
> >       properties:
> >         contains:
> >           - nand-ecc-step-size
> >     then:
> >       required:
> >         <nand-chip>:
> >           properties:
> >             - nand-ecc-strength
> >=20
> > And same with the opposite logic. =20
>=20
> I see, thanks! And this should be for all nand chips, not only Amlogic? I=
 mean in
> nand-chip.yaml?=20

Some drivers can directly manage the user requests in terms of either
step size *or* strength, so I would keep this into the Amlogic file for
now.

> I'll include it as third patch in this patchset.
>=20
> Thanks, Arseniy

Thanks,
Miqu=C3=A8l
