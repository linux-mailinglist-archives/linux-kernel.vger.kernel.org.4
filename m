Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E9668ADC2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBEBGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBEBGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:06:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C8723D9C;
        Sat,  4 Feb 2023 17:06:37 -0800 (PST)
Received: from mercury (93.85-246-81.adsl-static.isp.belgacom.be [81.246.85.93])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9362A6601E92;
        Sun,  5 Feb 2023 01:06:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675559195;
        bh=0/+HCuANW0/ZP4TBdMMnN50TbFZPDp2Asr7+laT78yY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MSe3V+tR42TT+00/V1Xo1KvyrrX0F3dC3OJmGTJru38u1aE3dHin4/aV9FezgC6lB
         59cS0rC+cJwmogj23t+RFr69o0d9IVziz1mBh0S4VthRTcFmYrX6uVfJmflLbvxyha
         Cuu64LyJzgylRJPUaKc1ZZPZ4ykDCWlMkBvG7oEPFvE6idR5f21zx6TiXQhlU9AW/R
         +3UWzR5mxiBdahGCGQdQDcwIyImJHFEh9MV3guxY/ckA3DvxlbFcMGW8mTTTQ9OWV7
         AjjwciOVO1gGTjJrHseV8WjSVOT6BuJhvOKw/L1XwsfbfJRtJ8xhzmR+UmStKH7vcU
         8gDmQ1frPt+uQ==
Received: by mercury (Postfix, from userid 1000)
        id 87EB710609C9; Sun,  5 Feb 2023 02:06:32 +0100 (CET)
Date:   Sun, 5 Feb 2023 02:06:32 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 05/11] mfd: rk808: split into core and i2c
Message-ID: <20230205010632.wt5m3a7w7k62w6se@mercury.elektranox.org>
References: <20230127181244.160887-1-sebastian.reichel@collabora.com>
 <20230127181244.160887-6-sebastian.reichel@collabora.com>
 <Y95jJYlqDayiaMP1@google.com>
 <Y95lSpUaOnbSAOIC@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qwl6y6rrtwcef27f"
Content-Disposition: inline
In-Reply-To: <Y95lSpUaOnbSAOIC@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qwl6y6rrtwcef27f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Sat, Feb 04, 2023 at 02:01:46PM +0000, Lee Jones wrote:
> On Sat, 04 Feb 2023, Lee Jones wrote:
> > On Fri, 27 Jan 2023, Sebastian Reichel wrote:
> > > Split rk808 into a core and an i2c part in preperation for
> > > SPI support.
> > >=20
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  drivers/clk/Kconfig                   |   2 +-
> > >  drivers/input/misc/Kconfig            |   2 +-
> > >  drivers/mfd/Kconfig                   |   7 +-
> > >  drivers/mfd/Makefile                  |   3 +-
> > >  drivers/mfd/{rk808.c =3D> rk8xx-core.c} | 209 +++++-----------------=
----
> > >  drivers/mfd/rk8xx-i2c.c               | 200 ++++++++++++++++++++++++
> > >  drivers/pinctrl/Kconfig               |   2 +-
> > >  drivers/power/supply/Kconfig          |   2 +-
> > >  drivers/regulator/Kconfig             |   2 +-
> > >  drivers/rtc/Kconfig                   |   2 +-
> > >  include/linux/mfd/rk808.h             |   6 +
> > >  sound/soc/codecs/Kconfig              |   2 +-
> > >  12 files changed, 256 insertions(+), 183 deletions(-)
> > >  rename drivers/mfd/{rk808.c =3D> rk8xx-core.c} (76%)
> > >  create mode 100644 drivers/mfd/rk8xx-i2c.c
> >=20
> > Looks like you completely ignored (no response / no action) my review of
> > v4.  This submission is therefore not getting one!  All comments can be
> > superimposed from v4.
>=20
> s/v4/v5/

not sure what you are talking about. I dropped the PM wrappers and
added a new patch moving the driver to use OF match. There were no
other comments as far as I can tell. Did I miss a second mail with
more comments?

-- Sebastian

--qwl6y6rrtwcef27f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPfAQsACgkQ2O7X88g7
+prcPQ//eszrU24MFC5Y+5iGOaGdQNIx5ftzeIJNJBwYVllRJ12qns5IJavJb3bO
j2KePqz80vwBzjQjtaFrid3dDUp+5Kip6spWCbu1mD0zPCj9xNUmWdFn78oZJRvN
U9VYMRqeGBEmh4F/2dXaDd1KpZ+Yv042fCi0er5X2LMi0OE2RtlaE62l4XTKTCB7
Kzzj/5Hv0DicX/Ecoq2ys7OcCWy7wG9hilyGYABZCWtAICoGCVMtLA8DwO+YNcDL
wg0RRRJGkUrIZ91MIFDSxsYiElqil5tNaEhqBg+XfEzjEZeZEJR/Bw59rTNvBvIn
DqkpT0C6e1kxn5aoaExjwMPmxRx9spq71V8EAQ71ZL9HIQNmQPXiyhmXMJUVuW1p
gHctZpXTwQpvqoy18NtoQ/6ZWTuNwUHqhn3z16SND0x5Uekp95zuN3YJvBrn4YIf
niEwpVUWnCUmrMAxxp9Cue5TaRpLPHk9WzWxaX5cIykOKrS0eN2NBINipTTEItZs
/2mntr82tvbsBQwQCYSWsmf0X7/4oA4IfF06M/xXKwsbQNlA6vBgKpffA1kxgKPR
8jHLlDUKVFB+RNvCiHRMkE4WBUlpliZqyRq1te8TS9Knhbz0Jj0fnbpn+G8Hu+wg
TswdQcjKJjAOHrJ3n7w+yHMUH9T3rooo+cTbf3HxO4Qn7Wrqp2o=
=x1Im
-----END PGP SIGNATURE-----

--qwl6y6rrtwcef27f--
