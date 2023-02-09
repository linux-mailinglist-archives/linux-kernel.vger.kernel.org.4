Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558A669099B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBINNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBINNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:13:51 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0EF42DEA;
        Thu,  9 Feb 2023 05:13:49 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9C97C20011;
        Thu,  9 Feb 2023 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675948427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/um9DAF/yUoTwrJOpk9LfwRlNxfzCt4/642EDtLaqo=;
        b=m5VHCGUTSEtIsz5XE7R0YfuVyzLpi4Hy3GdkgSlRmAoMOsu0iRE8cQJATs/H/QgoEY2/m6
        2vRdgfZFXNls9s4DQ3BYNGxtSBSDuPpUxBRrPejodH/yeFROO5p/cNBsaHZw0ijOpfoL/+
        bKYZ33w9Z+q3hyL6jcit0M8QZEXRcaEIzv3uX6eah+g6ochsm2jd8Mff/dEly1L/aUB29g
        9p9NRABdyzYDWSj1iBgaP7ktVM4JxAwhP73HhP7pj9qLmRCttvSNnSakjLPR0I64YAGL9m
        3EKbn0RdsBe+jh0TwDZDbDvY8OqgNab1p1mPt6m3QwWYuIkvbTDVSUuYmu+8DQ==
Date:   Thu, 9 Feb 2023 14:16:10 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: renesas: renesas.yaml: add
 renesas,rzn1d400-eb compatible
Message-ID: <20230209141610.31146ea9@fixe.home>
In-Reply-To: <CAMuHMdVL1YGnX4X2R_O1tMhRt07R8XUD2eWeFFgTcm7ShZrdcg@mail.gmail.com>
References: <20230207145444.166950-1-clement.leger@bootlin.com>
        <20230207145444.166950-2-clement.leger@bootlin.com>
        <CAMuHMdVL1YGnX4X2R_O1tMhRt07R8XUD2eWeFFgTcm7ShZrdcg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, 9 Feb 2023 09:48:09 +0100,
Geert Uytterhoeven <geert@linux-m68k.org> a =C3=A9crit :

> Hi Cl=C3=A9ment,
>=20
> On Tue, Feb 7, 2023 at 3:52 PM Cl=C3=A9ment L=C3=A9ger <clement.leger@boo=
tlin.com> wrote:
> > Add "renesas,rzn1d400-eb" which target the RZ/N1 EB board when a RZ/N1D=
-DB
> > daughter board is plugged on it.
> >
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> > @@ -431,6 +431,12 @@ properties:
> >                - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for =
the RZ/N1D 400 pins package)
> >            - const: renesas,r9a06g032
> >
> > +      - description: RZ/N1{D,S} EB
> > +        items:
> > +          - enum:
> > +              - renesas,rzn1d400-eb # RZN1D-EB (Expansion Board when u=
sing a RZN1D-DB)
> > +          - const: renesas,r9a06g032 =20
>=20
> Don't you want to have "renesas,rzn1d400-db", too, in between the two
> other values?

Do you mean like that ?

 - enum:
    - renesas,rzn1d400-eb # RZN1D-EB (Expansion Board when using a
   RZN1D-DB)
 - const: renesas,rzn1d400-db
 - const: renesas,r9a06g032

And thus using compatible =3D "renesas,rzn1d400-eb",
"renesas,rzn1d400-db", "renesas,r9a06g032" in the EB dt I guess.

Thanks,

>=20
> > +
> >        - description: RZ/Five and RZ/G2UL (R9A07G043)
> >          items:
> >            - enum: =20
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
