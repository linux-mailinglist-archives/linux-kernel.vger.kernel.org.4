Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40372CD20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjFLRnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbjFLRnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:43:51 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88281A5;
        Mon, 12 Jun 2023 10:43:47 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686591826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3yPOTXCRxjiq83JhCf8TF77n1ddicw+WEeLTca96Y34=;
        b=a88fHfmFvyyzdoMee7LdEDcKNqERY2G4x61EefQR8oJZ8sOq5Fx54AJjIjpkVeIFZvCy4W
        RibDP8Dy6qYMdYgwl3/8szxKc1tU0vNAkJbv3ddc5v2OLPdsuVCTlom+nGL8l5zNQdhCpH
        pjhfBugeY0katXlwaGMl73LeHj6GN12OokUlqddQz0jj00gLMAzBAn5S7SVFaDg3xLoeih
        +g4dAMVlyO0aoBI6q2eFlkIxHr5jG/e59JQLsbrcrHznX4QX8TjQMmUKNRhbdSn89MhVs7
        0b7qs08SCanIcbUusFFFvpO58b/zuHxw+bssuXhi+hWWVPMIUDBAcR1x9ofspQ==
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
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 286A7FF806;
        Mon, 12 Jun 2023 17:43:43 +0000 (UTC)
Date:   Mon, 12 Jun 2023 19:43:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 05/12] dt-bindings: mtd: brcmnand: Updates for bcmbca
 SoCs
Message-ID: <20230612194341.33820376@xps-13>
In-Reply-To: <d49a915b-bea5-12a4-a72a-38f925ffb025@broadcom.com>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
        <20230606231252.94838-6-william.zhang@broadcom.com>
        <20230607101452.4c265d7e@xps-13>
        <84e97108-29d4-5103-14f4-03e3c0eba165@broadcom.com>
        <20230609105857.7256c02f@xps-13>
        <d49a915b-bea5-12a4-a72a-38f925ffb025@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Fri, 9 Jun 2023 12:05:19 -0700:

> Hi Miquel,
>=20
> On 06/09/2023 01:58 AM, Miquel Raynal wrote:
> > Hi William,
> >=20
> > william.zhang@broadcom.com wrote on Wed, 7 Jun 2023 13:01:56 -0700:
> >  =20
> >> Hi Miquel,
> >>
> >> On 06/07/2023 01:14 AM, Miquel Raynal wrote: =20
> >>> Hi William,
> >>>
> >>> william.zhang@broadcom.com wrote on Tue,  6 Jun 2023 16:12:45 -0700: =
=20
> >>>    >>>> Use new compatiable brcm,nand-bcmbca to support BCMBCA broadb=
and =20
> >>>> product. The old compatible string is still kept in the driver so old
> >>>> dtb can still work.
> >>>>
> >>>> Add brcm,nand-use-wp property to have an option for disabling this
> >>>> feature on broadband board design that does not use write protection.
> >>>> Add brcm,nand-ecc-use-strap to get ecc setting from board strap for
> >>>> broadband board designs because they do not specify ecc setting in d=
ts
> >>>> but rather using the strap setting.
> >>>>
> >>>> Remove the requirement of interrupts and interrupt-names properties =
to
> >>>> reflect the driver code.
> >>>>
> >>>> This patch also includes a few minor fixes to the BCM63xx compatibles
> >>>> and add myself to the list of maintainers.
> >>>>
> >>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >>>> ---
> >>>>
> >>>>    .../bindings/mtd/brcm,brcmnand.yaml           | 64 +++++++++++++-=
-----
> >>>>    1 file changed, 43 insertions(+), 21 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yam=
l b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> >>>> index 1571024aa119..1fe1c166a9db 100644
> >>>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> >>>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> >>>> @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
> >>>>    maintainers:
> >>>>      - Brian Norris <computersforpeace@gmail.com>
> >>>>      - Kamal Dasu <kdasu.kdev@gmail.com>
> >>>> +  - William Zhang <william.zhang@broadcom.com> =20
> >>>>    >>   description: | =20
> >>>>      The Broadcom Set-Top Box NAND controller supports low-level acc=
ess to raw NAND
> >>>> @@ -18,9 +19,10 @@ description: |
> >>>>      supports basic PROGRAM and READ functions, among other features=
. =20
> >>>>    >>     This controller was originally designed for STB SoCs (BCM7=
xxx) but is now =20
> >>>> -  available on a variety of Broadcom SoCs, including some BCM3xxx, =
BCM63xx, and
> >>>> -  iProc/Cygnus. Its history includes several similar (but not fully=
 register
> >>>> -  compatible) versions.
> >>>> +  available on a variety of Broadcom SoCs, including some BCM3xxx, =
MIPS based
> >>>> +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iPr=
oc/Cygnus.
> >>>> +  Its history includes several similar (but not fully register comp=
atible)
> >>>> +  versions. =20
> >>>>    >>     -- Additional SoC-specific NAND controller properties --
> >>>>    >> @@ -53,9 +55,9 @@ properties: =20
> >>>>                  - brcm,brcmnand-v7.2
> >>>>                  - brcm,brcmnand-v7.3
> >>>>              - const: brcm,brcmnand
> >>>> -      - description: BCM63138 SoC-specific NAND controller
> >>>> +      - description: BCMBCA SoC-specific NAND controller
> >>>>            items:
> >>>> -          - const: brcm,nand-bcm63138
> >>>> +          - const: brcm,nand-bcmbca
> >>>>              - enum:
> >>>>                  - brcm,brcmnand-v7.0
> >>>>                  - brcm,brcmnand-v7.1
> >>>> @@ -65,11 +67,15 @@ properties:
> >>>>              - const: brcm,nand-iproc
> >>>>              - const: brcm,brcmnand-v6.1
> >>>>              - const: brcm,brcmnand
> >>>> -      - description: BCM63168 SoC-specific NAND controller
> >>>> +      - description: BCM63xx SoC-specific NAND controller
> >>>>            items:
> >>>> -          - const: brcm,nand-bcm63168
> >>>> -          - const: brcm,nand-bcm6368
> >>>> -          - const: brcm,brcmnand-v4.0
> >>>> +          - enum:
> >>>> +              - brcm,nand-bcm63168
> >>>> +              - brcm,nand-bcm6368
> >>>> +          - enum:
> >>>> +              - brcm,brcmnand-v2.1
> >>>> +              - brcm,brcmnand-v2.2
> >>>> +              - brcm,brcmnand-v4.0
> >>>>              - const: brcm,brcmnand =20
> >>>>    >>     reg: =20
> >>>> @@ -111,6 +117,19 @@ properties:
> >>>>          earlier versions of this core that include WP
> >>>>        type: boolean =20
> >>>>    >> +  brcm,nand-use-wp: =20
> >>>> +    description:
> >>>> +      Use this integer to indicate if board design uses
> >>>> +      controller's write protection feature and connects its
> >>>> +      NAND_WPb pin to nand chip's WP_L pin. Driver defaults to
> >>>> +      use this feature when this property does not exist.
> >>>> +      Set to 0 if WP pins are not connected and feature is not
> >>>> +      used. Set to 1 if WP pins are connected and feature is used.
> >>>> +      Set to 2 if WP pins are connected but disable this feature
> >>>> +      through driver that sets controller to output high on NAND_WP=
b.
> >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +    enum: [0, 1, 2] =20
> >>>
> >>> Perhaps strings would be welcome. I'll let binding maintainers say wh=
at
> >>> they think of it. =20
> >>>    >> Practically there is really just use cases of 0 and 1. I could =
use a bool flag but to keep consistent with the driver code and in case the=
re is any existing usage of 2. =20
> >> =20
> >>>> +
> >>>>    patternProperties:
> >>>>      "^nand@[a-f0-9]$":
> >>>>        type: object
> >>>> @@ -136,13 +155,23 @@ patternProperties:
> >>>>              layout.
> >>>>            $ref: /schemas/types.yaml#/definitions/uint32 =20
> >>>>    >> +      brcm,nand-ecc-use-strap: =20
> >>>> +        description:
> >>>> +          This flag is used by the driver to get the ecc strength a=
nd
> >>>> +          spare area size from the SoC NAND boot strap setting. This
> >>>> +          is commonly used by the BCMBCA SoC board design. If ecc
> >>>> +          strength and spare area size are set by nand-ecc-strength
> >>>> +          and brcm,nand-oob-sector-size in the dts, these settings
> >>>> +          have precedence and override this flag.
> >>>> +        $ref: /schemas/types.yaml#/definitions/flag =20
> >>>
> >>> How in practice do you access the strap value? Don't you need a phand=
le
> >>> over a specific area in the SoC? =20
> >>>    >> The strap value is latched and stored in the NAND controller re=
gister so there is no extra phandle needed. =20
> >=20
> > Ok.
> >  =20
> >> =20
> >>>> +
> >>>>    allOf:
> >>>>      - $ref: nand-controller.yaml#
> >>>>      - if:
> >>>>          properties:
> >>>>            compatible:
> >>>>              contains:
> >>>> -            const: brcm,nand-bcm63138
> >>>> +            const: brcm,nand-bcmbca
> >>>>        then:
> >>>>          properties:
> >>>>            reg-names:
> >>>> @@ -153,7 +182,9 @@ allOf:
> >>>>          properties:
> >>>>            compatible:
> >>>>              contains:
> >>>> -            const: brcm,nand-bcm6368
> >>>> +            enum:
> >>>> +              - brcm,nand-bcm63168
> >>>> +              - brcm,nand-bcm6368
> >>>>        then:
> >>>>          properties:
> >>>>            reg-names:
> >>>> @@ -173,20 +204,12 @@ allOf:
> >>>>                - const: nand
> >>>>                - const: iproc-idm
> >>>>                - const: iproc-ext
> >>>> -  - if:
> >>>> -      properties:
> >>>> -        interrupts:
> >>>> -          minItems: 2
> >>>> -    then:
> >>>> -      required:
> >>>> -        - interrupt-names =20
> >>>
> >>> Why do you remove this? Removing "interrupts" from the required
> >>> properties is fine, but constraining the interrupts property when it =
is
> >>> relevant is still expected. =20
> >>>    >> There is no requirement for interrupt name even if it have two =
interrupts. Driver code does not use interrupt name but the interrupt index=
 instead. =20
> >=20
> > It does not matter in this case how the driver uses the interrupts. If
> > names have been provided once in the bindings, you could expect another
> > project using the same bindings to use the interrupt names instead of
> > the order. So you must keep the names. Just don't mark them required it
> > they are.
> >  =20
> Certainly any dts file can still have interrupts names with one or two in=
terrupts but to my understand it is not required to have the name when ther=
e are two interrupts. Anyway I will add this back so this constrain remains.

That is true, until you enforce specific names. Then you are tied to
these names, otherwise you may break the bindings. It it is not
_really_ useful, then don't do it.

>=20
> >> =20
> >>>>    >>   unevaluatedProperties: false
> >>>>    >>   required: =20
> >>>>      - reg
> >>>>      - reg-names
> >>>> -  - interrupts =20
> >>>
> >>> This should be done in a separate patch. =20
> >>>    >> I thought this is also related to my update for bcmbca chips be=
cause they don't need to interrupt and interrupt name. =20
> >=20
> > The fact that the driver does not use the interrupts does not mean they
> > should not be described.
> >  =20
> >> =20
> >>>>    >>   examples: =20
> >>>>      - |
> >>>> @@ -215,8 +238,7 @@ examples:
> >>>>        };
> >>>>      - |
> >>>>        nand-controller@10000200 {
> >>>> -        compatible =3D "brcm,nand-bcm63168", "brcm,nand-bcm6368",
> >>>> -                     "brcm,brcmnand-v4.0", "brcm,brcmnand";
> >>>> +        compatible =3D "brcm,nand-bcm6368", "brcm,brcmnand-v2.1", "=
brcm,brcmnand";
> >>>>            reg =3D <0x10000200 0x180>,
> >>>>                  <0x100000b0 0x10>,
> >>>>                  <0x10000600 0x200>; =20
> >>>
> >>>
> >>> Thanks,
> >>> Miqu=C3=A8l =20
> >>>    > >  =20
> > Thanks,
> > Miqu=C3=A8l
> >  =20


Thanks,
Miqu=C3=A8l
