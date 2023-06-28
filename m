Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D745B741035
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjF1Lli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjF1Llg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9352D63;
        Wed, 28 Jun 2023 04:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93919612B9;
        Wed, 28 Jun 2023 11:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C800C433C8;
        Wed, 28 Jun 2023 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687952494;
        bh=OyoCDf1tAD/QNiqSsyVhKq60iGJ68c6n5MAKq0cjA40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caa9YoCv1OL30PzlUz+wP8BD+McvM7Eg6WqaG8NlKUHEP1BhJaNXRebcl5OsDqG1L
         plXGg8rMFBfEfWj8rL1MopnUA9hw5PXaa+5K/31Q2W6wFZiU3vwCc8fnOrq1hfeSxW
         V64kutLb4R3DRpeIFxiLnYJdPXGdM+JVLUbhpKZkRkwm135nxHDIyksF7rVcD9kGsB
         9DITw2GkLpnS/iMvnTqRIFbGN5r1sefU71bN/GBrQHW++86xa5gxEwGAQsKXGOLrqO
         xLcYxvHxYRZxyOIFywgap0JGqS6SVTXAhzROx6VSKaYuPymVij9HY4WoRQ13lR8mR2
         Q5O+Xxl0brsrw==
Date:   Wed, 28 Jun 2023 13:41:30 +0200
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
Message-ID: <un3xm7ybsm54qf56ojhrtr6kehlmhdoavzcaqr2jfbcyg2kr6u@rdlq7nelycs2>
References: <20211119033338.25486-1-samuel@sholland.org>
 <20211119033338.25486-4-samuel@sholland.org>
 <yw1xedly2z3m.fsf@mansr.com>
 <maqh4yir66agto4lyulvrqrim7qnixwd246jusvvhsjlhhrmmw@gjbubqc2cv4o>
 <yw1xa5wj3kvn.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mf236bogpjscjsps"
Content-Disposition: inline
In-Reply-To: <yw1xa5wj3kvn.fsf@mansr.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mf236bogpjscjsps
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 12:07:56PM +0100, M=E5ns Rullg=E5rd wrote:
> Maxime Ripard <mripard@kernel.org> writes:
>=20
> > On Mon, Jun 26, 2023 at 01:21:33PM +0100, M=E5ns Rullg=E5rd wrote:
> >> Samuel Holland <samuel@sholland.org> writes:
> >>=20
> >> > The PRCM CCU drivers depend on clocks provided by other CCU drivers.=
 For
> >> > example, the sun8i-r-ccu driver uses the "pll-periph" clock provided=
 by
> >> > the SoC's main CCU.
> >> >
> >> > However, sun8i-r-ccu is an early OF clock provider, and many of the
> >> > main CCUs (e.g. sun50i-a64-ccu) use platform drivers. This means that
> >> > the consumer clocks will be orphaned until the supplier driver is bo=
und.
> >> > This can be avoided by converting the remaining CCUs to use platform
> >> > drivers. Then fw_devlink will ensure the drivers are bound in the
> >> > optimal order.
> >> >
> >> > The sun5i CCU is the only one which actually needs to be an early cl=
ock
> >> > provider, because it provides the clock for the system timer. That o=
ne
> >> > is left alone.
> >> >
> >> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> > ---
> >> >
> >> > (no changes since v1)
> >> >
> >> >  drivers/clk/sunxi-ng/Kconfig             | 20 ++++----
> >> >  drivers/clk/sunxi-ng/ccu-sun4i-a10.c     | 58 +++++++++++++--------
> >> >  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c   | 56 ++++++++++++--------
> >> >  drivers/clk/sunxi-ng/ccu-sun50i-h616.c   | 33 ++++++++----
> >> >  drivers/clk/sunxi-ng/ccu-sun6i-a31.c     | 40 +++++++++++----
> >> >  drivers/clk/sunxi-ng/ccu-sun8i-a23.c     | 35 +++++++++----
> >> >  drivers/clk/sunxi-ng/ccu-sun8i-a33.c     | 40 +++++++++++----
> >> >  drivers/clk/sunxi-ng/ccu-sun8i-h3.c      | 62 ++++++++++++++--------
> >> >  drivers/clk/sunxi-ng/ccu-sun8i-r.c       | 65 ++++++++++++++-------=
---
> >> >  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c     | 57 +++++++++++++--------
> >> >  drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c | 38 ++++++++++----
> >> >  11 files changed, 332 insertions(+), 172 deletions(-)
> >>=20
> >> This broke the hstimer clocksource on A20 since it requires a clock
> >> provided by the sun4i ccu driver.
> >
> > The A10 is probably broken by this, but the A20 should be able to use
> > the arch timers just like all the other Cortex-A7-based SoCs.
> >
> > Do you have a dmesg log that could help debug why it's not working?
>=20
> The A20 works as such since, as you say, it has other clocksources.
> However, the hstimer has become unusable.  If anyone was using, for
> whatever reason, it won't be working for them now.
>=20
> Before this change, the kernel log used include this line:
>=20
> clocksource: hstimer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_n=
s: 6370868154 ns
>=20
> Now there is only a cryptic "Can't get timer clock" in its place.
>=20
> As it is now, the hstimer driver is nothing but a waste of space.
> I figure it ought to be fixed one way or another.

Yeah, definitely.

IIRC, the situation is:

 - A10 has just the "regular", old, timer
 - A10s/A13/GR8 has the A10 timer + hstimer
 - A20 has the A13 timers + arch timers

We also default to the hstimer only for the A10s/A13 which aren't
affected by this patch series afaics.

We also enable the HS timer for the A31, but just like the A20 it
doesn't use it by default, so it's probably been broken there too.

I guess one way to fix it would be to switch the HS timer driver to a
lower priority than the A10 timer, so we pick that up by default instead
for the A10s/A13, and then convert the HS timer driver to a proper
platform_device driver that will be able to get its clock.

The downside is that the A13 will lose some precision over its default
timer, but I don't think it's a big deal.

Maxime

--mf236bogpjscjsps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZJwcagAKCRDj7w1vZxhR
xe08AP4ohM6byryVMfvTgitb1BFSBhJ6x+I71Oex+5G7vPvqAAEAglGVPkTLpB/P
1ZNfSD09bTdBia8t2ImilUQ19q5PoA4=
=atgh
-----END PGP SIGNATURE-----

--mf236bogpjscjsps--
