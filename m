Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A53664377
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbjAJOlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjAJOll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:41:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE3B1707C;
        Tue, 10 Jan 2023 06:41:40 -0800 (PST)
Received: from mercury (dyndsl-091-096-058-120.ewe-ip-backbone.de [91.96.58.120])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A8E176602D2B;
        Tue, 10 Jan 2023 14:41:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673361698;
        bh=noDPjMVeI9vYdt2QvseE4f0h7KVZlOjXF8BvL2KT+n4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAiLMZMANdiUvLl8Y3CDcGpi1lOsUHy13F/gyXp7+1skrtfMLKf7/f7ZKEA+osIr7
         9RWuzBdeARpDcAuiWyi+9/JOaBqIcgLpbBZAR6qYgTAO1WqltSyT8Kc0tjC5QcUCbe
         XCLnvKhaG3AV321s7FZ3bmT9pVodUfz9kuTeRliVrjwcpLAMU9JaI+xvGFrBo4c7Og
         mTAOhiK2ey23l0RwBupz4RW4SFh0cfyaJgSN0seZKR/jpL3pE9eyC+oi5AHW1Flzkv
         fML9Etyhdb+bc+c2qZiKATh2luHfOEnvVX/QpVVSZfs7mZFcfIN61USxOk5UAw+rmc
         NSsN4yC5kYx6g==
Received: by mercury (Postfix, from userid 1000)
        id 644311060774; Tue, 10 Jan 2023 15:41:36 +0100 (CET)
Date:   Tue, 10 Jan 2023 15:41:36 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCHv8 3/7] arm64: dts: rockchip: Add base DT for rk3588 SoC
Message-ID: <20230110144136.oixsqxo7iv4aotwb@mercury.elektranox.org>
References: <20230109155801.51642-1-sebastian.reichel@collabora.com>
 <2865022.7s5MMGUR32@diego>
 <20230110121754.2olqdzbe7wst3u4n@mercury.elektranox.org>
 <2076503.8hzESeGDPO@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zi2fwssvq5bzmsvx"
Content-Disposition: inline
In-Reply-To: <2076503.8hzESeGDPO@diego>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zi2fwssvq5bzmsvx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 10, 2023 at 02:32:29PM +0100, Heiko St=FCbner wrote:
> Am Dienstag, 10. Januar 2023, 13:17:54 CET schrieb Sebastian Reichel:
> > Hi,
> >=20
> > On Tue, Jan 10, 2023 at 12:47:23PM +0100, Heiko St=FCbner wrote:
> > > Hi Sebastian,
> > >=20
> > > Am Montag, 9. Januar 2023, 16:57:57 CET schrieb Sebastian Reichel:
> > > > From: Kever Yang <kever.yang@rock-chips.com>
> > > >=20
> > > > This initial version supports CPU, dma, interrupts, timers, UART and
> > > > SDHCI (everything necessary to boot Linux on this system on chip) as
> > > > well as Ethernet, I2C, PWM and SPI.
> > > >=20
> > > > The DT is split into rk3588 and rk3588s, which is a reduced version
> > > > (i.e. with less peripherals) of the former.
> > > >=20
> > > > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > > > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > > > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > > > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > > > [rebase, squash and reword commit message]
> > >=20
> > > I guess that means the list of Rockchip Signed-off-by lines above come
> > > from the squashed patches?
> > >=20
> > > If so, I guess I should add Co-Developed-by lines for them, as right =
now
> > > the list is incorrect (author should be first, then everyone through
> > > whose hands a patch went)
> > >=20
> > > Meaning I can add those Co-Developed-by lines, so no need to resend,
> > > I'm just verifying what I assume about the lines :-)
> >=20
> > Yes, those are SoB lines from squashed downstream commits.
>=20
> so I've made the block into=20
> Co-Developed-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Co-Developed-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Co-Developed-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [rebase, squash and reword commit message]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> and will apply that if you don't shout in the next hour or so :-)

LGTM.

-- Sebastian

--zi2fwssvq5bzmsvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmO9eSAACgkQ2O7X88g7
+pr8Uw//czVLTawBJxJH0DifrXdNuMncQWYITl8xVok0CQ6cWmDH6l1JJhmYp10o
KT1rJDR1woV1hUj3myGwLH0B3Z6n49Ji/rkf6teWFmmepH3bniMUkAjNGtQd7qtt
C7rCp2JSqRIvXGqhK3lwGMe2fXrDsQynO30b+juoehdQbRdSToOfy1t96xSprQWJ
qGYUDyfPazG1shL5Z7Sf5M1NdlGS4JYCkCwtXto+TK9BmfEV07ytq5Sr0LfQ6SL4
dicaOLN0xqo7Hlzf7k0jmcUbwlkvmCQ67BpZ6jU4+A9WF9EFaxU08enH420YNpQD
5oux8rcRaoSxDKj2/KuuOMIsK6/ZMxS0Nv5B8yI0IV7/5MIDuHK99AFQr5O+b5KV
jcN+AqmRB0G0U/iubWIpym4JKS0VXLI8n+cTPDqM07vB7agamFDUFjJm1/ai0XSQ
QZvHZm4nmZA3jHpvh7EmxcfoxZXsnCqT+ihRDnO7I9tExRtE8czALr1M1hsLEVMb
5E863qT8SmVHwQHxX/f6TgxcTMapCKGFj4ADECWJnXY6/hnlLe5qutclqLoQH3GB
AKb3dX8PgLHyBlvSiQWJkgxEiAqHV8JGU+ZKlv32zeurjsdUv7Cd/zM14JenDD33
OkXop5a8i1Q2nLNqE2Mrw2SmsMh5biFkQeYdr3/bPQTramj85Qc=
=qJeq
-----END PGP SIGNATURE-----

--zi2fwssvq5bzmsvx--
