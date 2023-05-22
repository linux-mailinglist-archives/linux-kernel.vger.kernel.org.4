Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F95870C0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjEVOSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjEVOSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:18:08 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC51C1;
        Mon, 22 May 2023 07:18:06 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E542D1BF20A;
        Mon, 22 May 2023 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684765085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PeTVrsjUDAtWE8pXMg3vBOwvIgnFQmi76IvB7+G2Xhk=;
        b=onPSy8lKC6/e4Rt5ekprsPsbNZQvE5Sg4kOVrnAc9zqf0jESk2HESEGtxOvHwE40Ya0qvT
        I4t1NdiTLWOUNHm5Wyu89KR7GWDYkwdZGj4KhuYSbRikzySwaI4cfD2Y7UjsfkjhP0MGlk
        NjYOftn4OWnkCW54Fz9VdenuPbT1DdC+U08J7n+g2M50Q8XFRO6V5HOXt0sGuM7vA6v7nI
        MrQCmvXfM73HwwGm7YPoydk5AqYP/miwORTuqjL5jZj4y7W2sYmzRXuKe7/J8U3Y330n5y
        B+gVx2yiI2Czr8LNAdwvnRz2NvOVt/PAHEvS2Sq1gVjoEX2+n17DQIFAgnWCrQ==
Date:   Mon, 22 May 2023 16:18:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lukasz Majewski <lukma@denx.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/43] dt-bindings: mtd: add DT bindings for ts7250 nand
Message-ID: <20230522161803.4f13d35a@xps-13>
In-Reply-To: <783af132a3eab7c79c95de5113c6bdb0adce19b5.camel@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
        <20230424123522.18302-23-nikita.shubin@maquefel.me>
        <20230502114858.7152572a@xps-13>
        <783af132a3eab7c79c95de5113c6bdb0adce19b5.camel@maquefel.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

nikita.shubin@maquefel.me wrote on Mon, 15 May 2023 18:48:31 +0300:

> Hello Miquel!
>=20
> Thank you for looking into it.
>=20
> On Tue, 2023-05-02 at 11:48 +0200, Miquel Raynal wrote:
> > Hi Nikita,
> >=20
> > nikita.shubin@maquefel.me=C2=A0wrote on Mon, 24 Apr 2023 15:34:38 +0300:
> >  =20
> > > Add YAML bindings for ts7250 NAND.
> > >=20
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > > ---
> > > =C2=A0.../bindings/mtd/technologic,nand.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 56
> > > +++++++++++++++++++
> > > =C2=A01 file changed, 56 insertions(+)
> > > =C2=A0create mode 100644
> > > Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> > > b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> > > new file mode 100644
> > > index 000000000000..3234d93a1c21
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> > > @@ -0,0 +1,56 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mtd/technologic,nand.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Technologic Systems NAND controller
> > > +
> > > +maintainers:
> > > +=C2=A0 - Lukasz Majewski <lukma@denx.de>
> > > +
> > > +properties:
> > > +=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0 items:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: technologic,ts7200-nand =20
> >=20
> > would -nand-controller instead of -nand work as a suffix here?
> >=20
> > You mention ts7250 in the title, should we have a more specific
> > compatible than ts7200 as well?
> >=20
> > I see by looking at the mtd patch that you actually try to match
> > both,
> > so they should both be defined in the bindings.
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: gen_nand =20
> >=20
> > This is a old hack for very simple controllers (converted to DT
> > probing
> > 12 years ago). The logic used by this driver has been deprecated for
> > like 10 years and does not really apply to modern APIs. I would
> > really
> > like to keep this driver contained with platform data coming from
> > arch/
> > data only.
> >=20
> > I suggest you create a real NAND controller driver based on the
> > generic one (should not be very complex, just duplicate the code so
> > the
> > migration to the up-to-date API is eased) and you flag it as "must be
> > updated to ->exec_op() somehow. This way if someone starts the
> > conversion, it does not need to cope with the 5 other users of the
> > generic driver which anyway share nothing in common besides the
> > deprecated ->cmd_ctrl() backbone.
> >=20
> > I read the comments on the cover letter, people are kind of pushing
> > on
> > having this merged quickly. I am fine accepting a legacy controller
> > driver and migrating it to ->exec_op() later, but the current driver
> > conversion does not fit the approach taken years ago towards a
> > cleaner
> > mtd tree. =20
>=20
> Did you mean that i should at least implement legacy nand controller,
> like, for example, Xway (xway_nand.c) ?:
>=20
>         data->chip.legacy.cmd_ctrl =3D xway_cmd_ctrl;
>         data->chip.legacy.dev_ready =3D xway_dev_ready;
>         data->chip.legacy.select_chip =3D xway_select_chip;
>         data->chip.legacy.write_buf =3D xway_write_buf;
>         data->chip.legacy.read_buf =3D xway_read_buf;
>         data->chip.legacy.read_byte =3D xway_read_byte;
>         data->chip.legacy.chip_delay =3D 30;

I don't know how urgent this conversion is, this is really the minimal
step...

> And the best solution would be switching to exec_op completely ?

...and this is what I would really prefer, yes. I don't think it's
huge, the controller being very simple and straightforward.

>=20
> >  =20
> > > +
> > > +=C2=A0 reg:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 '#address-cells': true
> > > +=C2=A0 '#size-cells': true
> > > +
> > > +required:
> > > +=C2=A0 - compatible
> > > +=C2=A0 - reg
> > > +
> > > +unevaluatedProperties: true
> > > +
> > > +examples:
> > > +=C2=A0 - |
> > > +=C2=A0=C2=A0=C2=A0 nand-parts@0 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "technologic,ts7200-na=
nd", "gen_nand";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x60000000 0x8000000>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <1>;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition@0 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "TS-BOOTROM";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x00000000 0x000=
20000>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read-only;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }; =20
> >=20
> > Partitions are not useful here, but if you want them, use the
> > partitions container instead, please.
> >  =20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition@20000 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "Linux";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x00020000 0x07d=
00000>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition@7d20000 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "RedBoot";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x07d20000 0x002=
e0000>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read-only;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0 };
> > > +
> > > +... =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20


Thanks,
Miqu=C3=A8l
