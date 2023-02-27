Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9A6A4BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjB0UAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjB0UAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:00:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD0D23D85;
        Mon, 27 Feb 2023 12:00:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A81B60F19;
        Mon, 27 Feb 2023 20:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47520C433D2;
        Mon, 27 Feb 2023 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677528039;
        bh=nIYRAsxkz1v+ws6bi8EI0HS1rSe3IrjqOcAGXmBmfvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRGsMbLuyZPLSAbz4jorliDG0dEsvZIpvrMYkGkNcp2vH/PoICuXPGrt54SV2I/No
         Ct+MT9H5cbHP5+3Tg4IMSdpVd3sX3qMQ4ZT2sbuSN30P0zvcDjOFPREif7TlgUoukw
         pSMM+SaYIWy9hEFN7JniyEsj+iQjSVJ4I9TrLU/lxi4mmcOwizJJRrIyzz/qiJjKId
         s1Gr9MLrz/BGBv1KLz4v1K+2FM6eueSNbuwe3Wu/mOJSth73/paDJBoY4uqWJy0Cnc
         QBzJZF1KQ9FuBZV1fVpwc/vDr61Tsv0VSpQbHNx5Y5fXI1dpFCjF82PIferw66R1sM
         K3+3Ac+OtKOOA==
Date:   Mon, 27 Feb 2023 20:00:33 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/19] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
Message-ID: <Y/0L4SKKtl49C95j@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-20-hal.feng@starfivetech.com>
 <CAJM55Z_QMtzKeRFN1iGf498z4+vga6RBgwybCQi6aOUYCr_P-Q@mail.gmail.com>
 <2af3f84b-2c2b-dc79-c76c-9411fcbcf7ca@starfivetech.com>
 <Y/zykfydb+bJ7G2l@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B8EZkuBv+mrJ7yYe"
Content-Disposition: inline
In-Reply-To: <Y/zykfydb+bJ7G2l@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B8EZkuBv+mrJ7yYe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 06:12:40PM +0000, Conor Dooley wrote:
> On Thu, Feb 23, 2023 at 04:50:20PM +0800, Hal Feng wrote:
> > On Tue, 21 Feb 2023 16:03:08 +0100, Emil Renner Berthing wrote:
> > > On Tue, 21 Feb 2023 at 03:47, Hal Feng <hal.feng@starfivetech.com> wr=
ote:
> > >> From: Emil Renner Berthing <kernel@esmil.dk>
> > >>
> > >> Add a minimal device tree for StarFive JH7110 VisionFive 2 board
> > >> which has version A and version B. Support booting and basic
> > >> clock/reset/pinctrl/uart drivers.
> > >>
> > >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > >> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > >> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > >> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > >> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> > >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > >> ---
> > >>  arch/riscv/boot/dts/starfive/Makefile         |   6 +-
> > >>  .../jh7110-starfive-visionfive-2-v1.2a.dts    |  13 ++
> > >>  .../jh7110-starfive-visionfive-2-v1.3b.dts    |  13 ++
> > >>  .../jh7110-starfive-visionfive-2.dtsi         | 215 +++++++++++++++=
+++
> > >>  4 files changed, 246 insertions(+), 1 deletion(-)
> > >>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-vis=
ionfive-2-v1.2a.dts
> > >>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-vis=
ionfive-2-v1.3b.dts
> > >>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-vis=
ionfive-2.dtsi
> > >>
> > >> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot=
/dts/starfive/Makefile
> > >> index 039c143cba33..cd73519b907b 100644
> > >> --- a/arch/riscv/boot/dts/starfive/Makefile
> > >> +++ b/arch/riscv/boot/dts/starfive/Makefile
> > >> @@ -1,2 +1,6 @@
> > >>  # SPDX-License-Identifier: GPL-2.0
> > >> -dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7100-beaglev-starlight.dtb jh7100=
-starfive-visionfive-v1.dtb
> > >> +dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7100-beaglev-starlight.dtb
> > >> +dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7100-starfive-visionfive-v1.dtb
> > >> +
> > >> +dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.2a.=
dtb
> > >> +dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.3b.=
dtb
>=20
> If you could rebase on top of v6.3-rc1 for the next version & use ARCH_
> not SOC_ here that'd be great.
>=20
> > >> +/ {
> > >> +       aliases {
> > >> +               serial0 =3D &uart0;
> > >> +               i2c0 =3D &i2c0;
> > >> +               i2c2 =3D &i2c2;
> > >> +               i2c5 =3D &i2c5;
> > >> +               i2c6 =3D &i2c6;
> > >=20
> > > Let's keep these sorted alphabetically.
> >=20
> > OK, will fix it.
> >=20
>=20
> > > It would be great to have some sort of order to this file so it's
> > > obvious where to add new nodes. I suggest we do
> > > - root node
> > > - external clocks
> > > - other node references in alphabetical order
> > >=20
> > > You're almost there with this patch except the uart0 node is out of p=
lace.
> >=20
> > Will fix accordingly. Thanks for your suggestions.
>=20
> With Emil's suggestions implemented:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Actually, there's one thing that I don't think was (explicitly?) mentioned,
could you sort the external clocks alphanumerically too?

Cheers,
Conor.


--B8EZkuBv+mrJ7yYe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/0L4QAKCRB4tDGHoIJi
0nXJAP4hYlkGws9Z9BDo3Zh/bnJEjDLHBMPp6+W/6GLJrhOJ3wD+ILqazBj8LQ78
52UY1mFT5kiamfu0N2L8qR1Q/5KWPAw=
=EYae
-----END PGP SIGNATURE-----

--B8EZkuBv+mrJ7yYe--
