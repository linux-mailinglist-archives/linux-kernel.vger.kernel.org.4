Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7005E664570
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjAJP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjAJP6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:58:14 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E73FC4A;
        Tue, 10 Jan 2023 07:58:12 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9DCC2100007;
        Tue, 10 Jan 2023 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673366291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ls2ZHhB4etdhWoWPPLqYUa/37vhJl28tR8qb5hvwZ/s=;
        b=Fm2cxqae7qTWtMWT0LqewzuhPawG7GgGOlqOXEaY6yzG5ygk09t/nSmIMN3jfeCOUA+Ubt
        /zddmJrMmKoYhcjsi4azTVvtDH1YviODyTOc0szzDibgkXbgp8b2NOgVIuhh1tUg1Zz0D4
        8cP3FU3Fi/UoxXvfB/oYdiQKYfnBlEUPVuPbLJNby5H+/l+AhxTdmz+ajjLoEuWMaFXExY
        xTuV4jurbPXEe8o1k0nt0mS/QKPugy73i2WjyPGA31V0yla1yWL+oh3Z4JXk3fok3rlIJM
        tMG8GMkr1VIoD2/JcH7XIBKkw8dMqnVCMnt5/IUjISFXg448Se0uPrHen3OnoA==
Date:   Tue, 10 Jan 2023 16:58:06 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v4 07/12] riscv: dts: allwinner: Add Sipeed Lichee RV
 devicetrees
Message-ID: <Y72LDlIOYo/I8dii@aptenodytes>
References: <20221231233851.24923-1-samuel@sholland.org>
 <20221231233851.24923-8-samuel@sholland.org>
 <Y7bW32i3EUmGHqSK@aptenodytes>
 <05c1ee07-0750-d40e-8498-55ea07b52ab1@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ARnt4yApiZMkzLk7"
Content-Disposition: inline
In-Reply-To: <05c1ee07-0750-d40e-8498-55ea07b52ab1@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ARnt4yApiZMkzLk7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Sun 08 Jan 23, 12:42, Samuel Holland wrote:
> Hi Paul,
>=20
> On 1/5/23 07:55, Paul Kocialkowski wrote:
> > Hi Samuel,
> >=20
> > On Sat 31 Dec 22, 17:38, Samuel Holland wrote:
> >> Sipeed manufactures a "Lichee RV" system-on-module, which provides a
> >> minimal working system on its own, as well as a few carrier boards. The
> >> "Dock" board provides audio, USB, and WiFi. The "86 Panel" additionally
> >> provides 100M Ethernet and a built-in display panel.
> >>
> >> The 86 Panel repurposes the USB ID and VBUS detection GPIOs for its RGB
> >> panel interface, since the USB OTG port is inaccessible inside the cas=
e.
> >=20
> > Looks like the panel-enabled variants would better be described as devi=
ce-tree
> > overlays as they are not specific devices but are peripheral extensions.
> >=20
> > What do you think?
>=20
> I don't agree. The Lichee RV 86 Panel is sold as a complete unit, with
> the SoM+board and LCD pre-assembled inside a case. It is not possible to
> purchase the board without a panel, so the panel-enabled variants are
> the only variants.

Oh my bad, I didn't go as far as actually checking what it looks like.
So yeah if it's an individual device on its own I agree it deserves its
own dedicated device-tree.

Cheers,

Paul


--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--ARnt4yApiZMkzLk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmO9iw0ACgkQ3cLmz3+f
v9Gixwf/bUuAN5mWXtPd6SPwUdDiuGj3HtcGDNKL8Buq00SJTlZQyMbyz3F3TYcm
bQ0/KlisJFv5fPbJW8aRI2TqOpFDnGtAGSkQ5JgyeJhiQbYjKBtHjvesPiDMsBxV
ri99hwxNmZuFw+AswqPtGC4mbau4lnRJFC34lvZL02vlzxHYTapOsbPR1CtWb+Ww
xL6bPOYB1pRzRHpR5i8fxDcxbW0/l36BwJf1UivHjFtxvYZcjI79Lr/1E33ZAbGg
VJekuVkb7+v78TVIiN7YBYuZdYEydq62ARy8WP/VnExZLpWXvv6vNMSgfCSIPu9u
Psc6c5fjpitNLgprsqst0bobNwUoWQ==
=/4VV
-----END PGP SIGNATURE-----

--ARnt4yApiZMkzLk7--
