Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF05702D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbjEOMsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjEOMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:48:41 -0400
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE05E61;
        Mon, 15 May 2023 05:48:33 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2f8a:0:640:b50b:0])
        by forward502a.mail.yandex.net (Yandex) with ESMTP id D8B225E760;
        Mon, 15 May 2023 15:48:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UmZpAmsWpeA0-jIilLbUc;
        Mon, 15 May 2023 15:48:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1684154911;
        bh=VPLW2FeB4P4oqrQH+SA+K09MXHahJVX3Qt+tVJ0HPgM=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=rTpsKBaUYNrDMqgZCzLo+rwpffAx4rwp/78vMHKSMBcXFL97/r+qXEFutrlS14p+b
         N9nHSir63pkmLnLwQrG3WImQ0FBxl7jeeKkDEOfQZ65h5uMvMnGVnAXZuYrvbTErYJ
         D+Or/YXVjjel4iP4+1vGSHhehg2xFB46eJHxymes=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <783af132a3eab7c79c95de5113c6bdb0adce19b5.camel@maquefel.me>
Subject: Re: [PATCH 22/43] dt-bindings: mtd: add DT bindings for ts7250 nand
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lukasz Majewski <lukma@denx.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 May 2023 18:48:31 +0300
In-Reply-To: <20230502114858.7152572a@xps-13>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-23-nikita.shubin@maquefel.me>
         <20230502114858.7152572a@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miquel!

Thank you for looking into it.

On Tue, 2023-05-02 at 11:48 +0200, Miquel Raynal wrote:
> Hi Nikita,
>=20
> nikita.shubin@maquefel.me=C2=A0wrote on Mon, 24 Apr 2023 15:34:38 +0300:
>=20
> > Add YAML bindings for ts7250 NAND.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0.../bindings/mtd/technologic,nand.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 56
> > +++++++++++++++++++
> > =C2=A01 file changed, 56 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> > b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> > new file mode 100644
> > index 000000000000..3234d93a1c21
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/technologic,nand.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Technologic Systems NAND controller
> > +
> > +maintainers:
> > +=C2=A0 - Lukasz Majewski <lukma@denx.de>
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: technologic,ts7200-nand
>=20
> would -nand-controller instead of -nand work as a suffix here?
>=20
> You mention ts7250 in the title, should we have a more specific
> compatible than ts7200 as well?
>=20
> I see by looking at the mtd patch that you actually try to match
> both,
> so they should both be defined in the bindings.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: gen_nand
>=20
> This is a old hack for very simple controllers (converted to DT
> probing
> 12 years ago). The logic used by this driver has been deprecated for
> like 10 years and does not really apply to modern APIs. I would
> really
> like to keep this driver contained with platform data coming from
> arch/
> data only.
>=20
> I suggest you create a real NAND controller driver based on the
> generic one (should not be very complex, just duplicate the code so
> the
> migration to the up-to-date API is eased) and you flag it as "must be
> updated to ->exec_op() somehow. This way if someone starts the
> conversion, it does not need to cope with the 5 other users of the
> generic driver which anyway share nothing in common besides the
> deprecated ->cmd_ctrl() backbone.
>=20
> I read the comments on the cover letter, people are kind of pushing
> on
> having this merged quickly. I am fine accepting a legacy controller
> driver and migrating it to ->exec_op() later, but the current driver
> conversion does not fit the approach taken years ago towards a
> cleaner
> mtd tree.

Did you mean that i should at least implement legacy nand controller,
like, for example, Xway (xway_nand.c) ?:

        data->chip.legacy.cmd_ctrl =3D xway_cmd_ctrl;
        data->chip.legacy.dev_ready =3D xway_dev_ready;
        data->chip.legacy.select_chip =3D xway_select_chip;
        data->chip.legacy.write_buf =3D xway_write_buf;
        data->chip.legacy.read_buf =3D xway_read_buf;
        data->chip.legacy.read_byte =3D xway_read_byte;
        data->chip.legacy.chip_delay =3D 30;

And the best solution would be switching to exec_op completely ?

>=20
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 '#address-cells': true
> > +=C2=A0 '#size-cells': true
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - reg
> > +
> > +unevaluatedProperties: true
> > +
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 nand-parts@0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "technologic,ts7200-nand=
", "gen_nand";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x60000000 0x8000000>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <1>;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition@0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "TS-BOOTROM";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x00000000 0x00020=
000>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read-only;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> Partitions are not useful here, but if you want them, use the
> partitions container instead, please.
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition@20000 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "Linux";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x00020000 0x07d00=
000>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition@7d20000 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "RedBoot";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x07d20000 0x002e0=
000>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read-only;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +=C2=A0=C2=A0=C2=A0 };
> > +
> > +...
>=20
>=20
> Thanks,
> Miqu=C3=A8l

