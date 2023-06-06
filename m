Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844EB72500A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbjFFWiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjFFWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B491FDC;
        Tue,  6 Jun 2023 15:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AFCB638B1;
        Tue,  6 Jun 2023 22:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFA2C433EF;
        Tue,  6 Jun 2023 22:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686091081;
        bh=+d7JeMeUUdZO2aVYQ8oGUF7pb9l8qtsCjpkX1+tKZ0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ah/xpfYXpLSl/KXOtkf2COQ1AifCQwoMbz5GdNd9ACRL9pAXI9y5pmZwAaJiuFZTy
         onaUd+OM2JgRXTnepEsVZZZyWcLJkgZfFeKsIsfdH7ovQw9K9sgVTVYjMcqM7D6nA9
         hp6MJNabTZ5pUEYGZD3ZDKgehKx1/cBeVeWGsAexmiW6Du23w+QR4x5A55TodM83oa
         91QKw/L/4nPKp2Cz68Z8OsFWACnxb0UsfN1nQG3MO4QLalWNIWmH7MH7HksH3/FyDv
         mzpv63FSaBnTJ9AtPkRKj+sxtFNOsBR6Y5Sz/icdY9vgSCXdvfBFqUv4w9/M10dyUA
         jCnwRE4nixJyA==
Date:   Tue, 6 Jun 2023 23:37:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Keith Zhao <keith.zhao@starfivetech.com>,
        Shengyu Qu <wiagn233@outlook.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com, Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: Re: [PATCH 1/9] dt-bindings: display: Add yamls for JH7110 display
 subsystem
Message-ID: <20230606-geometry-blurb-1f0f07d4bf6a@spud>
References: <20230602074043.33872-1-keith.zhao@starfivetech.com>
 <20230602-uncommon-rejoicing-e73c0c475f9f@spud>
 <TY3P286MB26116576E3E502CAE53834599852A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <1991848.PYKUYFuaPT@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1lwN/EJcI4S+S54L"
Content-Disposition: inline
In-Reply-To: <1991848.PYKUYFuaPT@diego>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1lwN/EJcI4S+S54L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 12:22:33AM +0200, Heiko St=FCbner wrote:
> Am Dienstag, 6. Juni 2023, 20:41:17 CEST schrieb Shengyu Qu:
> > > On Fri, Jun 02, 2023 at 03:40:35PM +0800, Keith Zhao wrote:
> > >> Add bindings for JH7110 display subsystem which
> > >> has a display controller verisilicon dc8200
> > >> and an HDMI interface.

> > >> +description:
> > >> +  The StarFive SoC uses the HDMI signal transmiter based on innosil=
icon IP
> > > Is innosilicon the same thing as verisilicon? Also
> > > s/transmiter/transmitter/, both here and in the title.
> >=20
> > I think that is not the same, I remember Rockchip has used a HDMI=20
> > transmitter from
> >=20
> > Innosilicon, and there is a existing driver for that in mainline.
>=20
> Yep, I think Innosilicon is the company you turn to when you want to save
> a bit of money ;-) . In the bigger SoCs Rockchip most of the time uses
> Designware hdmi blocks and looking at the history only the rk3036 ever
> used an Innosilicon block.
>=20
> Looking at the history, 2016 really was a long time ago :-D.
>=20
> > So Keith, if that's true, I think it is better to seperate the HDMI=20
> > stuff and reuse existing driver.
>=20
> I'm not so sure about that - at least from a cursory glance :-) .
>=20
> The registers do look slightly different and I don't know how much
> the IP changed between the rk3036-version and the jh7110 version.
>=20
> At the very least, I know my rk3036 board isn't booting right now, so
> I can't really provide help for generalizing the rockchip-driver.
>=20
> At the very least both the binding and driver could drop the "starfive-hd=
mi"
> and actually use the Innosilicon in the naming somewhere, so that it's
> clear for future developers :-)

Seeing "based on" always makes me a little bit nervous to be honest when
it comes to using a compatible from the IP. Is it the IP? What version
is it? etc. Perhaps "starfive,jh7110-hdmi" & falling back to some sort
of "innosilicon,hdmi" would be more future/IP-silliness proof.
Driver can always be generic & bind against "innosilicon,hdmi" until
that becomes impossible.

Cheers,
Conor.

--1lwN/EJcI4S+S54L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH+1QQAKCRB4tDGHoIJi
0ihwAQC+3gfFJAPFBOT76QYpqrSJuQHRjE1iNJt0+04zAqcRDgD+KopK8i99wbS9
4s+s9CpPS+b/RBAa5Zq6Zq0Bynk3jgc=
=XnKq
-----END PGP SIGNATURE-----

--1lwN/EJcI4S+S54L--
