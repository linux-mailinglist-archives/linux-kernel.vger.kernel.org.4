Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6E4723A99
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjFFHxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbjFFHws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:52:48 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BD7E5F;
        Tue,  6 Jun 2023 00:49:01 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686037739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/kMANKOTi/tFXc0hJon5PuO8vrm2esi8pRQ+Mx6YY8=;
        b=SwWxSbuUS5bFt445yNo85PxVU12H/0UMPIIxIOPbJ+m8fp+ik9pyEFL9NVwAyFZM051N3p
        NzPltO+/RkB5DCY7R5Q3SUrvfqqTOkBhUMf6bQ0+iNpyp0bnWnQzOOAPWUy6Kf/anzqLKJ
        qI0X+azrFp6wSGK9Kk2uxHsMFEFrDth7G0jL19IeTZF0tsQx6PJ//DZi3RjOg9olqslz2a
        U9Um1/ClMPL01vI3zWobFe0x5c+c5lu//SeRWEvzhSRGKg6f0v0FnMzToupmHjV3Yhq6v9
        NPulL984sOp8TDlGDUCGWKdiWblwR1e2yaprd0pGsntkXZEP8+3AGYt8J33hPw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D55B1BF20C;
        Tue,  6 Jun 2023 07:48:56 +0000 (UTC)
Date:   Tue, 6 Jun 2023 09:48:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "conor@kernel.org" <conor@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <20230606094855.1ab005eb@xps-13>
In-Reply-To: <9fc57052-5049-ed50-ca95-cfd1d0420dd9@alliedtelesis.co.nz>
References: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
        <20230531234923.2307013-4-chris.packham@alliedtelesis.co.nz>
        <a23dd485-a3d9-e31f-be3e-0ab293fcfc4a@linaro.org>
        <785368df-1881-e62e-6172-d902cee814a8@alliedtelesis.co.nz>
        <eaf9d7cf-c9f5-a5d5-67af-c43761c3c6cf@linaro.org>
        <4ea0b16e-0cec-00db-c598-e0364a7edef8@alliedtelesis.co.nz>
        <9fc57052-5049-ed50-ca95-cfd1d0420dd9@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Chris.Packham@alliedtelesis.co.nz wrote on Tue, 6 Jun 2023 04:38:01
+0000:

> On 6/06/23 08:44, Chris Packham wrote:
> >
> > On 4/06/23 21:26, Krzysztof Kozlowski wrote: =20
> >> On 02/06/2023 01:06, Chris Packham wrote: =20
> >>> Hi Krzystof,
> >>>
> >>> On 1/06/23 19:05, Krzysztof Kozlowski wrote: =20
> >>>> On 01/06/2023 01:49, Chris Packham wrote: =20
> >>>>> From: Vadym Kochan <vadym.kochan@plvision.eu>
> >>>>>
> >>>>> Switch the DT binding to a YAML schema to enable the DT validation.
> >>>>>
> >>>>> The text binding didn't mention it as a requirement but existing=20
> >>>>> usage
> >>>>> has
> >>>>>
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "marvell,armada-8k-nand-con=
troller",
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "marvell,armada370-nand-controller";
> >>>>>
> >>>>> so the YAML allows this in addition to the individual compatible=20
> >>>>> values.
> >>>>>
> >>>>> There was also an incorrect reference to dma-names being "rxtx" whe=
re
> >>>>> the driver and existing device trees actually use dma-names =3D=20
> >>>>> "data" so
> >>>>> this is corrected in the conversion.
> >>>>>
> >>>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> >>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >>>>> ---
> >>>>>
> >>>>> Notes:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Changes in v8:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Mark deprecated compatible values =
as such
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Allow "marvell,armada-8k-nand-cont=
roller" without
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "marvell,armada370-nand-=
controller"
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Make dma-names usage reflect reali=
ty
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Update commit message
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Chang=
es in v7:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Restore "label" and "partitions" p=
roperties (should be=20
> >>>>> picked up via
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand-controller.yaml but=
 aren't) =20
> >>>> What do you mean by "aren't"? They are not needed. =20
> >>> (sorry I keep responding to snippets rather than putting all the=20
> >>> replies
> >>> in one place. For posterity here's the same response I provided in a
> >>> separate message).
> >>>
> >>> I mean I simply cannot make it work and I'm out of ideas (I'm also=20
> >>> in an
> >>> awkward timezone so it takes 24hrs for me to ask a question and get a
> >>> response which leads to me making guesses instead of waiting).
> >>>
> >>> nand-controller.yaml references nand-chip.yaml which references=20
> >>> mtd.yaml
> >>> which defines the "label" and "partitions" property.
> >>>
> >>> I thought marvell,nand-controller.yaml could just say `$ref:
> >>> nand-controller.yaml` and it would mean I'd get all the definitions=20
> >>> down
> >>> the chain but this doesn't seem to work the way I expect (or more=20
> >>> likely
> >>> I'm not doing it right). I thought it might have something to do with
> >>> the different patternProperties pattern but even when I make that mat=
ch
> >>> what is used in nand-controller.yaml it doesn't seem to pick up those
> >>> properties. =20
> >> Then you are doing something different than all other bindings. =20
> >
> > Not intentionally. I should probably check that the existing bindings=20
> > actually work as expected.
> >
> > One thing that this has that the others don't is including "label" and=
=20
> > "partitions" in the examples.
> > =20
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Add/restore nand-on-flash-bbt and =
nand-ecc-mode which=20
> >>>>> aren't covered
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 by nand-controller.yaml.
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Use "unevalautedProperties: false"
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Corrections for clock-names, dma-n=
ames, nand-rb and=20
> >>>>> nand-ecc-strength
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Add pxa3xx-nand-controller example
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Chang=
es in v6:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - remove properties covered by nand-=
controller.yaml
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - add example using armada-8k compat=
ible
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 earli=
er changes:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v5:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1) Get back "label=
" and "partitions" properties but without
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ref to the "partition.yaml" which was wrongly used.
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2) Add "additionalProperties: false" for nand@=20
> >>>>> because all possible
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
properties are described.
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v4:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1) Remove "label" =
and "partitions" properties
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2) Use 2 clocks for A7K/8K platform which is a=20
> >>>>> requirement
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v3:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1) Remove txt version fr=
om the MAINTAINERS list
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 2) Use enum for some of compatible strings
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 3) Drop:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 #address-cells
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 #size-cells:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 as they are inherited from the nand-controller.yaml
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 4) Add restriction to use 2 clocks for A8K SoC
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 5) Dropped description for clock-names and extend it=20
> >>>>> with
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minIte=
ms: 1
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 6) Drop description for "dmas"
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 7) Use "unevalautedProperties: false"
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 8) Drop quites from yaml refs.
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 9) Use 4-space indentation for the example section
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v2:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1) Fixed warning by yaml=
lint with incorrect indentation=20
> >>>>> for compatible list
> >>>>>
> >>>>> =C2=A0=C2=A0 .../bindings/mtd/marvell,nand-controller.yaml | 223=20
> >>>>> ++++++++++++++++++
> >>>>> =C2=A0=C2=A0 .../devicetree/bindings/mtd/marvell-nand.txt=C2=A0 | 1=
26 ----------
> >>>>> =C2=A0=C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> >>>>> =C2=A0=C2=A0 3 files changed, 223 insertions(+), 127 deletions(-)
> >>>>> =C2=A0=C2=A0 create mode 100644=20
> >>>>> Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> >>>>> =C2=A0=C2=A0 delete mode 100644=20
> >>>>> Documentation/devicetree/bindings/mtd/marvell-nand.txt
> >>>>>
> >>>>> diff --git=20
> >>>>> a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yam=
l=20
> >>>>> b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..433feb430555
> >>>>> --- /dev/null
> >>>>> +++=20
> >>>>> b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> >>>>> @@ -0,0 +1,223 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id:=20
> >>>>> http://scanmail.trustwave.com/?c=3D20988&d=3DyNj85IkMld8k0XBdA9CH4p=
QjE5peaXAdz-exk_Hdww&u=3Dhttp%3a%2f%2fdevicetree%2eorg%2fschemas%2fmtd%2fma=
rvell%2cnand-controller%2eyaml%23
> >>>>> +$schema:=20
> >>>>> http://scanmail.trustwave.com/?c=3D20988&d=3DyNj85IkMld8k0XBdA9CH4p=
QjE5peaXAdz-PkkPSLlg&u=3Dhttp%3a%2f%2fdevicetree%2eorg%2fmeta-schemas%2fcor=
e%2eyaml%23
> >>>>> +
> >>>>> +title: Marvell NAND Flash Controller (NFC)
> >>>>> +
> >>>>> +maintainers:
> >>>>> +=C2=A0 - Miquel Raynal <miquel.raynal@bootlin.com>
> >>>>> +
> >>>>> +properties:
> >>>>> +=C2=A0 compatible:
> >>>>> +=C2=A0=C2=A0=C2=A0 oneOf:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ma=
rvell,armada-8k-nand-controller
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ma=
rvell,armada370-nand-controller
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - marvell,a=
rmada-8k-nand-controller
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - marvell,a=
rmada370-nand-controller
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - marvell,p=
xa3xx-nand-controller
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: legacy bindings
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deprecated: true
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - marvell,a=
rmada-8k-nand
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - marvell,a=
rmada370-nand
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - marvell,p=
xa3xx-nand
> >>>>> +
> >>>>> +=C2=A0 reg:
> >>>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> >>>>> +
> >>>>> +=C2=A0 interrupts:
> >>>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> >>>>> +
> >>>>> +=C2=A0 clocks:
> >>>>> +=C2=A0=C2=A0=C2=A0 description:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Shall reference the NAND controller=
 clocks, the second one is
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is only needed for the Armada 7K/8K=
 SoCs
> >>>>> +=C2=A0=C2=A0=C2=A0 minItems: 1
> >>>>> +=C2=A0=C2=A0=C2=A0 maxItems: 2
> >>>>> +
> >>>>> +=C2=A0 clock-names:
> >>>>> +=C2=A0=C2=A0=C2=A0 minItems: 1
> >>>>> +=C2=A0=C2=A0=C2=A0 items:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: core
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: reg
> >>>>> +
> >>>>> +=C2=A0 dmas:
> >>>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> >>>>> +
> >>>>> +=C2=A0 dma-names:
> >>>>> +=C2=A0=C2=A0=C2=A0 items:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: data
> >>>>> +
> >>>>> +=C2=A0 marvell,system-controller:
> >>>>> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/phandle
> >>>>> +=C2=A0=C2=A0=C2=A0 description: Syscon node that handles NAND cont=
roller related=20
> >>>>> registers
> >>>>> +
> >>>>> +patternProperties:
> >>>>> +=C2=A0 "^nand@[0-3]$":
> >>>>> +=C2=A0=C2=A0=C2=A0 type: object
> >>>>> +=C2=A0=C2=A0=C2=A0 unevaluatedProperties: false
> >>>>> +=C2=A0=C2=A0=C2=A0 properties:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minimum: 0
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 3
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand-rb:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 1 =20
> >>>> Drop minItems.
> >>>> =20
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1 =20
> >>>> Didn't you have here minimum and maximum? I think I did not ask to
> >>>> remove them. =20
> >>> I did but I couldn't figure out how to do minimum and maximum with an
> >>> array would the following be correct (note removing both minItems and
> >>> maxItems as dtb_check complains if I have maxItems and items). =20
> >> items:
> >> =C2=A0=C2=A0 minimum: n
> >> =C2=A0=C2=A0 maximum: n
> >> =C2=A0=C2=A0 maxItems: n
> >>
> >> or
> >>
> >> items:
> >> =C2=A0 - minimum: n
> >> =C2=A0=C2=A0=C2=A0 maximum: n
> >>
> >> See for example Documentation/devicetree/bindings/arm/l2c2x0.yaml =20
> > Thanks, so my suggestion below should be OK then. =20
> >>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand-rb:
> >>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> >>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - minim=
um: 0
> >>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 maximum: 1
> >>> =20
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand-ecc-step-size:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 512
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand-ecc-strength:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [1, 4, 8, 12, 16]
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand-on-flash-bbt:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.ya=
ml#/definitions/flag
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand-ecc-mode:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: hw
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.ya=
ml#/definitions/string =20
> >>>> Drop label
> >>>> =20
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partitions:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: object =20
> >>>> Drop partitions. =20
> >>> This is the part I can't get to work. It should pick it up via
> >>> nand-controller.yaml but nothing I do seems to work.
> >>> =20
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 marvell,nand-keep-config:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: |
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Orders the =
driver not to take the timings from the core=20
> >>>>> and
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaving the=
m completely untouched. Bootloader timings=20
> >>>>> will then
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be used.
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.ya=
ml#/definitions/flag
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 marvell,nand-enable-arbiter:
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: |
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To enable t=
he arbiter, all boards blindly used it,
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this bit wa=
s set by the bootloader for many boards and=20
> >>>>> even if
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it is marke=
d reserved in several datasheets, it might=20
> >>>>> be needed to set
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it (otherwi=
se it is harmless).
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.ya=
ml#/definitions/flag
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deprecated: true
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0 additionalProperties: false =20
> >>>> unevaluatedProperties: false =20
> >>> It was hiding by '"^nand@[0-3]$":'. Should I move it here? =20
> >> You cannot have both additionalProps and unevaluatedProps at the same
> >> time, so we do not talk about same thing or this was never working? =20
> >
> > Hmm, I'm a little confused then. At various times I've been told to=20
> > put 'additionalProperties: false' or 'unevaluatedProperties: false'=20
> > (although never at the same time). I'm not sure when to use one or the=
=20
> > other.
> >
> > From what I've been able to glean 'additionalProperties: true'=20
> > indicates that the node is expected to have child nodes defined in a=20
> > different schema so I would have thought 'additionalProperties: false'=
=20
> > would be appropriate for a schema covering a leaf node.=20
> > 'unevaluatedProperties: false' seems to enable stricter checking which=
=20
> > makes sense when all the properties are described in the schema. =20
>=20
> So I think this might be the problem. If I look at qcom,nandc.yaml or=20
> ingenic,nand.yaml which both have a partitions property in their=20
> example. Neither have 'unevaluatedProperties: false' on the nand@...=20
> subnode. If I add it sure enough I start getting complaints about the=20
> 'partitions' node being unexpected.

Sorry if that was unclear, I think the whole logic around the yaml
files is to progressively constrain the descriptions, schema after
schema. IOW, in the marvell binding you should set
unevaluatedProperties: false for the NAND controller. What is inside
(NAND chips, partition container, partition parsers, "mtd" properties,
etc) will be handled by other files. Of course you can constrain a bit
what can/cannot be used inside these subnodes, but I think you don't
need to set unevaluatedProperties in these subnodes (the NAND chip in
this case, or even the partitions) because you already reference
nand-controller.yaml which references nand-chip.yaml, mtd.yaml,
partitions.yaml, etc. *they* will make the generic checks and hopefully
apply stricter checks, when deemed relevant.

Thanks,
Miqu=C3=A8l
