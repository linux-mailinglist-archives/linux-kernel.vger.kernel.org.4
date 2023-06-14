Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21343730046
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245044AbjFNNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjFNNki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:40:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEEA10FE;
        Wed, 14 Jun 2023 06:40:37 -0700 (PDT)
Received: from mercury (dyndsl-091-248-213-214.ewe-ip-backbone.de [91.248.213.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DBD206606F20;
        Wed, 14 Jun 2023 14:40:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686750036;
        bh=PBYQcUFjQMg4J0fJHCjFD2l4P5QvWdlw692+eiww3G4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arFK4HIV6P8nM46DlbdXlMJuYDrRy5fRJxQF3mPt1ytPQvXsE6J4VmNVAGwoB6KtE
         Gl3Z7np7uwlhbbWxD6yltL2Q3M1yUNrGBrwmGSQbK/ONj8bPLvQzzkomOZMO0l4BWt
         x2BbrB8akghj0wD7OdIlYWjv8q8e8zHllbAL6XGnoMdT/LtknA/GXfCtZ2BtxygnnR
         rAfJWwZVz0hFRp3N20y53Trjavb0daJ19sOST6iuCTZ7TcGO4SW+hxZzZc4unCPZPh
         v5O4bG+zKyD8UQq/6elZx39/OrQbZMnaWZ5j7JBIDt/CvMPNOukrkT46FMKat/jIl3
         XsXhxkzE5XQ9w==
Received: by mercury (Postfix, from userid 1000)
        id 0F7C31060A04; Wed, 14 Jun 2023 15:40:34 +0200 (CEST)
Date:   Wed, 14 Jun 2023 15:40:34 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/25] Add perf support to the rockchip-dfi driver
Message-ID: <20230614134034.3p3p75a3jophi2eu@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o7ugbz6dwi4olws4"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-1-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o7ugbz6dwi4olws4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:28AM +0200, Sascha Hauer wrote:
> This is v5 of the series adding perf support to the rockchip DFI driver.
>=20
> A lot has changed in the perf driver since v4. First of all the review
> feedback from Robin and Jonathan has been integrated. The perf driver
> now not only supports monitoring the total DDR utilization, but also the
> individual channels. I also reworked the way the raw 32bit counter
> values are summed up to 64bit perf values, so hopefully the code is
> easier to follow now.
>=20
> lockdep found out that that locking in the perf driver was broken, so I
> reworked that as well. None of the perf hooks allows locking with
> mutexes or spinlocks, so in perf it's not possible to enable the DFI
> controller when needed. Instead I now unconditionally enable the DFI
> controller during probe when perf is enabled.
>=20
> Furthermore the hrtimer I use for reading out the hardware counter
> values before they overflow race with perf. Now a seqlock is used to
> prevent that.
>=20
> The RK3588 device tree changes for the DFI were not part of v4. As
> Vincent Legoll showed interest in testing this series the necessary
> device tree changes are now part of this series.

I tested the series on RK3588 EVB1. The read/write byts looks
sensible. Sometimes cycles reads unrealistic values, though:

 Performance counter stats for 'system wide':

18446744070475110400      rockchip_ddr/cycles/                             =
                 =20
            828.63 MB   rockchip_ddr/read-bytes/                           =
               =20
            207.19 MB   rockchip_ddr/read-bytes0/                          =
               =20
            207.15 MB   rockchip_ddr/read-bytes1/                          =
               =20
            207.14 MB   rockchip_ddr/read-bytes2/                          =
               =20
            207.15 MB   rockchip_ddr/read-bytes3/                          =
               =20
              1.48 MB   rockchip_ddr/write-bytes/                          =
               =20
              0.37 MB   rockchip_ddr/write-bytes0/                         =
               =20
              0.37 MB   rockchip_ddr/write-bytes1/                         =
               =20
              0.37 MB   rockchip_ddr/write-bytes2/                         =
               =20
              0.38 MB   rockchip_ddr/write-bytes3/                         =
               =20
            830.12 MB   rockchip_ddr/bytes/                                =
               =20

       1.004239766 seconds time elapsed

(This is with memdump running in parallel)

Otherwise the series is

Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes since v4:
> - Add device tree changes for RK3588
> - Use seqlock to protect perf counter values from hrtimer
> - Unconditionally enable DFI when perf is enabled
> - Bring back changes to dts/binding patches that were lost in v4
>=20
> Changes since v3:
> - Add RK3588 support
>=20
> Changes since v2:
> - Fix broken reference to binding
> - Add Reviewed-by from Rob
>=20
> Changes since v1:
> - Fix example to actually match the binding and fix the warnings resulted=
 thereof
> - Make addition of rockchip,rk3568-dfi an extra patch
>=20
> Sascha Hauer (25):
>   PM / devfreq: rockchip-dfi: Make pmu regmap mandatory
>   PM / devfreq: rockchip-dfi: Embed desc into private data struct
>   PM / devfreq: rockchip-dfi: use consistent name for private data
>     struct
>   PM / devfreq: rockchip-dfi: Add SoC specific init function
>   PM / devfreq: rockchip-dfi: dfi store raw values in counter struct
>   PM / devfreq: rockchip-dfi: Use free running counter
>   PM / devfreq: rockchip-dfi: introduce channel mask
>   PM / devfreq: rk3399_dmc,dfi: generalize DDRTYPE defines
>   PM / devfreq: rockchip-dfi: Clean up DDR type register defines
>   PM / devfreq: rockchip-dfi: Add RK3568 support
>   PM / devfreq: rockchip-dfi: Handle LPDDR2 correctly
>   PM / devfreq: rockchip-dfi: Handle LPDDR4X
>   PM / devfreq: rockchip-dfi: Pass private data struct to internal
>     functions
>   PM / devfreq: rockchip-dfi: Prepare for multiple users
>   PM / devfreq: rockchip-dfi: give variable a better name
>   PM / devfreq: rockchip-dfi: Add perf support
>   PM / devfreq: rockchip-dfi: make register stride SoC specific
>   PM / devfreq: rockchip-dfi: account for multiple DDRMON_CTRL registers
>   PM / devfreq: rockchip-dfi: add support for RK3588
>   dt-bindings: devfreq: event: convert Rockchip DFI binding to yaml
>   dt-bindings: devfreq: event: rockchip,dfi: Add rk3568 support
>   dt-bindings: devfreq: event: rockchip,dfi: Add rk3588 support
>   arm64: dts: rockchip: rk3399: Enable DFI
>   arm64: dts: rockchip: rk356x: Add DFI
>   arm64: dts: rockchip: rk3588s: Add DFI
>=20
>  .../bindings/devfreq/event/rockchip,dfi.yaml  |  84 ++
>  .../bindings/devfreq/event/rockchip-dfi.txt   |  18 -
>  .../rockchip,rk3399-dmc.yaml                  |   2 +-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      |   1 -
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   7 +
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  16 +
>  drivers/devfreq/event/rockchip-dfi.c          | 796 +++++++++++++++---
>  drivers/devfreq/rk3399_dmc.c                  |  10 +-
>  include/soc/rockchip/rk3399_grf.h             |   9 +-
>  include/soc/rockchip/rk3568_grf.h             |  13 +
>  include/soc/rockchip/rk3588_grf.h             |  18 +
>  include/soc/rockchip/rockchip_grf.h           |  18 +
>  12 files changed, 854 insertions(+), 138 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockc=
hip,dfi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/event/rockc=
hip-dfi.txt
>  create mode 100644 include/soc/rockchip/rk3568_grf.h
>  create mode 100644 include/soc/rockchip/rk3588_grf.h
>  create mode 100644 include/soc/rockchip/rockchip_grf.h
>=20
> --=20
> 2.39.2
>=20

--o7ugbz6dwi4olws4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSJw00ACgkQ2O7X88g7
+pqqmg//ZLfOtGMx2p1VeLXg8eFmo95vhmxSFozhTnnAQYb5Zay290jo4HZyard5
JQjWZuCa+4yxDg1H0r2i/4Ba8UT6BXGfYi0nVOM/Jc61TTYXlypIwTyb8t0O9PnW
RwGiUF6ftkO2B+J29AvgTzDDXYCIOnUgcutXJoKChkTN25oFq5D88XPn2jy6crmg
jXRlWQO4hi1Znh3IyQ1bY93Kui4JzrU3qXgi+06aCf8ADmDgjYxu33pJMkqXzJSx
7EErhr77XvssrnPcJCc/EEfsGOjOOOVaAIFRUr7qhSI/us3K8/Ghnb6ZIDnvnXXp
SEL7f2JvZknXvhAILe4xmPBfqqP7cGoh5W9IPQpTPz48sPWGhLxqZdfWfwjR+RJg
6zycFqoOyFtZOucNR0BUQhLdj/R9ouc6Ya1uq1zupL3BoGNd815jpWqjlHV+qu/S
2Jr8NvyTg4SwWiggYyRydLPESJka06AAwkHFFvBxajQwsRECt6DZMF46Jsfbj69l
dzp7g5l9e79GQJ4jF8OTjQkZC05CdKLzIy7rKYsiEQt9HScCww2r6Er9mjj+i3PA
6d3aKUZ1mf3ERcIBSHmtSGJDr2mYT0Q3wr3QBcALKcKPkb7qk5temqjI67fknOzi
eS4cpLgRj38ZT4+0dJYsAVZe8XNbtw+i+/7ges94PAZEttg+iHk=
=nxkL
-----END PGP SIGNATURE-----

--o7ugbz6dwi4olws4--
