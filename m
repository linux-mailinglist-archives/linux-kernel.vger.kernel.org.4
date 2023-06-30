Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469EF743D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjF3ORn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3ORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808502D78;
        Fri, 30 Jun 2023 07:17:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D3356174C;
        Fri, 30 Jun 2023 14:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2887C433C0;
        Fri, 30 Jun 2023 14:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688134656;
        bh=soXGvTfhgDlUsMWqNjynUD6up10929KRevfZr4lUDbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsJ/Nvw9GWI8C9CIvS3VvBxTnOWyBLYpNYGr7pv8h4bdF98Jx9fS/P8cIlWKJe6jR
         94m2UfF0hhvZSzYdomELHKyNVUdMNKij/MkQoq2yzQBmFBia5eUGljEKtGWYR7mk/5
         yow8GVSI3j0sqUrmjZtc15quYc98HGtP0/rGX49BMe82R7rVPe18rnyTrH19y7WyI0
         wWGgxRAvqk41hvx6c0izf6qfwfzsOh52tIpCpDjB+yVBdZWhWv9Kz1wDqb5HkkCEhK
         /pp3etxuYQ5jJeDkknhqs3xDmE4d4uNrcavR7KanrgnNplykm/AyjSXVaREMnNIfc2
         814/Okp7VZOWA==
Date:   Fri, 30 Jun 2023 16:17:32 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] clk: sunxi-ng: Convert early providers to
 platform drivers
Message-ID: <z2656f5zlmntm3zf5ds72vtbd6cyw3mffj7vmeygpscjcnodw6@cwb65fhurfaa>
References: <20211119033338.25486-1-samuel@sholland.org>
 <20211119033338.25486-4-samuel@sholland.org>
 <yw1xedly2z3m.fsf@mansr.com>
 <maqh4yir66agto4lyulvrqrim7qnixwd246jusvvhsjlhhrmmw@gjbubqc2cv4o>
 <yw1xa5wj3kvn.fsf@mansr.com>
 <un3xm7ybsm54qf56ojhrtr6kehlmhdoavzcaqr2jfbcyg2kr6u@rdlq7nelycs2>
 <yw1x352b308w.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6btcpzr3xezdr3iq"
Content-Disposition: inline
In-Reply-To: <yw1x352b308w.fsf@mansr.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6btcpzr3xezdr3iq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 07:33:35PM +0100, M=E5ns Rullg=E5rd wrote:
> Maxime Ripard <mripard@kernel.org> writes:
>=20
> > On Wed, Jun 28, 2023 at 12:07:56PM +0100, M=E5ns Rullg=E5rd wrote:
> >> Maxime Ripard <mripard@kernel.org> writes:
> >>=20
> >> > On Mon, Jun 26, 2023 at 01:21:33PM +0100, M=E5ns Rullg=E5rd wrote:
> >> >> Samuel Holland <samuel@sholland.org> writes:
> >> >>=20
> >> >> > The PRCM CCU drivers depend on clocks provided by other CCU drive=
rs. For
> >> >> > example, the sun8i-r-ccu driver uses the "pll-periph" clock provi=
ded by
> >> >> > the SoC's main CCU.
> >> >> >
> >> >> > However, sun8i-r-ccu is an early OF clock provider, and many of t=
he
> >> >> > main CCUs (e.g. sun50i-a64-ccu) use platform drivers. This means =
that
> >> >> > the consumer clocks will be orphaned until the supplier driver is=
 bound.
> >> >> > This can be avoided by converting the remaining CCUs to use platf=
orm
> >> >> > drivers. Then fw_devlink will ensure the drivers are bound in the
> >> >> > optimal order.
> >> >> >
> >> >> > The sun5i CCU is the only one which actually needs to be an early=
 clock
> >> >> > provider, because it provides the clock for the system timer. Tha=
t one
> >> >> > is left alone.
> >> >> >
> >> >> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> >> > ---
> >> >> >
> >> >> > (no changes since v1)
> >> >> >
> >> >> >  drivers/clk/sunxi-ng/Kconfig             | 20 ++++----
> >> >> >  drivers/clk/sunxi-ng/ccu-sun4i-a10.c     | 58 +++++++++++++-----=
---
> >> >> >  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c   | 56 ++++++++++++------=
--
> >> >> >  drivers/clk/sunxi-ng/ccu-sun50i-h616.c   | 33 ++++++++----
> >> >> >  drivers/clk/sunxi-ng/ccu-sun6i-a31.c     | 40 +++++++++++----
> >> >> >  drivers/clk/sunxi-ng/ccu-sun8i-a23.c     | 35 +++++++++----
> >> >> >  drivers/clk/sunxi-ng/ccu-sun8i-a33.c     | 40 +++++++++++----
> >> >> >  drivers/clk/sunxi-ng/ccu-sun8i-h3.c      | 62 ++++++++++++++----=
----
> >> >> >  drivers/clk/sunxi-ng/ccu-sun8i-r.c       | 65 ++++++++++++++----=
------
> >> >> >  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c     | 57 +++++++++++++-----=
---
> >> >> >  drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c | 38 ++++++++++----
> >> >> >  11 files changed, 332 insertions(+), 172 deletions(-)
> >> >>=20
> >> >> This broke the hstimer clocksource on A20 since it requires a clock
> >> >> provided by the sun4i ccu driver.
> >> >
> >> > The A10 is probably broken by this, but the A20 should be able to use
> >> > the arch timers just like all the other Cortex-A7-based SoCs.
> >> >
> >> > Do you have a dmesg log that could help debug why it's not working?
> >>=20
> >> The A20 works as such since, as you say, it has other clocksources.
> >> However, the hstimer has become unusable.  If anyone was using, for
> >> whatever reason, it won't be working for them now.
> >>=20
> >> Before this change, the kernel log used include this line:
> >>=20
> >> clocksource: hstimer: mask: 0xffffffff max_cycles: 0xffffffff, max_idl=
e_ns: 6370868154 ns
> >>=20
> >> Now there is only a cryptic "Can't get timer clock" in its place.
> >>=20
> >> As it is now, the hstimer driver is nothing but a waste of space.
> >> I figure it ought to be fixed one way or another.
> >
> > Yeah, definitely.
> >
> > IIRC, the situation is:
> >
> >  - A10 has just the "regular", old, timer
> >  - A10s/A13/GR8 has the A10 timer + hstimer
> >  - A20 has the A13 timers + arch timers
> >
> > We also default to the hstimer only for the A10s/A13 which aren't
> > affected by this patch series afaics.
> >
> > We also enable the HS timer for the A31, but just like the A20 it
> > doesn't use it by default, so it's probably been broken there too.
> >
> > I guess one way to fix it would be to switch the HS timer driver to a
> > lower priority than the A10 timer, so we pick that up by default instead
> > for the A10s/A13, and then convert the HS timer driver to a proper
> > platform_device driver that will be able to get its clock.
> >
> > The downside is that the A13 will lose some precision over its default
> > timer, but I don't think it's a big deal.
>=20
> The options I see are converting the hstimer to a platform device or
> reverting the change to the sun4i ccu driver.
>=20
> I don't personally have much of an opinion on this since my systems
> aren't affected.  The only reason I looked at it was that I noticed
> a new error message in the kernel logs.

Thanks for the report then. I'm not really working on that anymore, so I
won't submit a fix for this either.

Maxime

--6btcpzr3xezdr3iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZJ7j/AAKCRDj7w1vZxhR
xU/MAP4nBZQyAlUVBuR6U+ZxpV7DXvxxPIMUKO59y81FQV5CfgEA13jfp1KMflbh
r354osmGcBVwT6TLOpA25y1M//vJQwg=
=V4XC
-----END PGP SIGNATURE-----

--6btcpzr3xezdr3iq--
