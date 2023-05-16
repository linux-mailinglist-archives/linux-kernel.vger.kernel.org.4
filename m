Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36343705A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjEPWBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjEPWBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:01:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A9D1706;
        Tue, 16 May 2023 15:01:31 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 03C2E66058F7;
        Tue, 16 May 2023 23:01:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684274490;
        bh=6VuzT6ae7G/wqb/mbM+/UZDAQjp/Is1WP9mWxQ5YyIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzwHnsUgq6M5aQDQ7BliujRzwfM+sKCjIweA7mkDMTVE76Lslbg4iU4+F+MGRG9kP
         tvHeMh++vslPUk/x39l/R4op0k2zaIp0wV52A2tSkH2PUdR/5t7t0GzFHRC7AdBEZK
         OLoMQ/vJH/RIvnjZwZBhITKeusFpWGXSZM6Zt6UDIAPHRsDnOxdOj7KHYx64nsSOGE
         BavuGd84nu17CWUqcd9N3T0WFa+p5oh9V3BNERaR6kPG9Pcy1mLL9zbv937Bq0/Whn
         RZvVp3eeL8zkxYALmjjPVNulIbJ9fnTV51LyLndbuWXkj/qvtcNRPChnzta8lDPKB6
         bCUF/ohnOBS6Q==
Received: by mercury (Postfix, from userid 1000)
        id B264110620FE; Wed, 17 May 2023 00:01:27 +0200 (CEST)
Date:   Wed, 17 May 2023 00:01:27 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
Subject: Re: [PATCH v8 05/14] mfd: rk808: split into core and i2c
Message-ID: <20230516220127.ohumwhchhzzmw7he@mercury.elektranox.org>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-6-sebastian.reichel@collabora.com>
 <CGME20230516212700eucas1p1fbde1b6181c18d821e0796b6b6a4fa00@eucas1p1.samsung.com>
 <2d234cd8-f883-800b-af97-116a949b64af@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mutsuecdbukxiwro"
Content-Disposition: inline
In-Reply-To: <2d234cd8-f883-800b-af97-116a949b64af@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mutsuecdbukxiwro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marek,

On Tue, May 16, 2023 at 11:26:59PM +0200, Marek Szyprowski wrote:
> Hi,
>=20
> On 04.05.2023 19:36, Sebastian Reichel wrote:
> > Split rk808 into a core and an i2c part in preparation for
> > SPI support.
> >
> > Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com> # for RTC
> > Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 =
Model A + B
> > Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro=
64
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> This patch landed in today's linux-next as commit c20e8c5b1203 ("mfd:=20
> rk808: Split into core and i2c"). Unfortunately some boards (for example=
=20
> Hardkernel's Odroid-M1) stopped to boot after this change. This is=20
> caused by the lack of updating the related defconfigs. Could you please=
=20
> add a patch that updates the MFD_RK808 entries to MFD_RK8XX_I2C in the=20
> following files:
>=20
> $ git grep MFD_RK808
> arch/arm/configs/multi_v7_defconfig:CONFIG_MFD_RK808=3Dy
> arch/arm64/configs/defconfig:CONFIG_MFD_RK808=3Dy

Sure, I will prepare a patch for each of them. Thanks for the quick
report and sorry for the inconvenience.

-- Sebastian

>=20
>=20
> > ---
> >   drivers/clk/Kconfig                   |   2 +-
> >   drivers/input/misc/Kconfig            |   2 +-
> >   drivers/mfd/Kconfig                   |   7 +-
> >   drivers/mfd/Makefile                  |   3 +-
> >   drivers/mfd/{rk808.c =3D> rk8xx-core.c} | 209 +++++------------------=
---
> >   drivers/mfd/rk8xx-i2c.c               | 200 ++++++++++++++++++++++++
> >   drivers/pinctrl/Kconfig               |   2 +-
> >   drivers/power/supply/Kconfig          |   2 +-
> >   drivers/regulator/Kconfig             |   2 +-
> >   drivers/rtc/Kconfig                   |   2 +-
> >   include/linux/mfd/rk808.h             |   6 +
> >   sound/soc/codecs/Kconfig              |   2 +-
> >   12 files changed, 256 insertions(+), 183 deletions(-)
> >   rename drivers/mfd/{rk808.c =3D> rk8xx-core.c} (76%)
> >   create mode 100644 drivers/mfd/rk8xx-i2c.c
> >
> > ...
>=20
> Best regards
> --=20
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>=20

--mutsuecdbukxiwro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRj/TcACgkQ2O7X88g7
+ppkcg//WH2Y+C6FPh41OdSO5Szxw3CQJ1Ku3dNvcQAt3BHSGl0ATOPFmYc1j2v8
/DNrXu+6aPU46ko+iu0Jrtlng4zdkl50sLLbYfvoNZQvNtI7oDYVV9ej3NO7diCr
+aN0krfeFW2MiaGcs6/U5B0/wgXCgeRf+2sCLCNxCfUji7xLT9HOQHUf34d6ZRAq
rU8iIcB7K9Kg1UUDCjn8FSUgKduyy2YriowTgO1Q1Bx93jYZ/wka+qtA9lRJC+bC
6g/9f2H7hs9IkfwVgGimp5iR++FF0G7wfY7XBZyuyVcsMLPZ9JIdCtl88oISGAFp
A94yL7MYgxtAuu6gOpnIWQVSits/WgfmfMfs95twzPQ0Vngdxm24bn4wGR7mUrMK
sd8krWaSfDPxahUkfN43p1WjDXY1WMMT6e0UPNR/MwhE+6fjI1PVc2BNSEsDQGdu
wlCYwIoPhBBGBh7L1dCKXEThlSdZsUd1N6R1QYZ3qQmYnF0KWHgnp7GDEREabHiO
RzWc0uHFa/Rnq7p1z/zZlBkUfryUqHRaLO7WIx4hzAj1w8CIMSkV08XA6Hb8X84u
/7ijOEH/selxYiETdAnkuobE9lf4cbpzU2vN7O0P9rQT7j/QIp6Mm/VsSMQaL74C
8mk7Q3O6xhh/f1/Y5M9lInSJ7hfkj5WrYCPF2Upb0a6hwfleQg0=
=tOhN
-----END PGP SIGNATURE-----

--mutsuecdbukxiwro--
