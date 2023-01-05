Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADDB65F155
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjAEQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjAEQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:42:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445E844C41;
        Thu,  5 Jan 2023 08:42:51 -0800 (PST)
Received: from mercury (dyndsl-085-016-198-020.ewe-ip-backbone.de [85.16.198.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C58986602D31;
        Thu,  5 Jan 2023 16:42:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672936969;
        bh=8aKuVcvKaY4ukEOxg5ehSqgBbLHOwST3J9TZePpwcKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUKKhUv7xHnNabr8CGt6dkPSycsVA6oQ9gxQaeJB+iVpjfb0/mdr1Wh07+3Y5mBxT
         uMFvCBLPSmnkPg2Fr07UtZIXQW4O3c9spI3AwEysQOHU8XHa7JVRS6FstSuEquplXI
         vu96FvtWX6WTCQE2X1n0AfzmwqM7S9DSvhpCQOt3Opp1IItMRAyBHQ6MolwqWaDiy0
         c7dcFMUupxHQZI16Q4WdoREnsaSAo2iHNOCyQWVeIjuDEI6f5f5f5ZqunJ+ByfTnOL
         eB/6kadzAmObqYJWy/9p9HZA87niXSqhwRobknGLoWWCsgWXICc4aGLJFbCD+pprN/
         ugjiDeF7Uwr5Q==
Received: by mercury (Postfix, from userid 1000)
        id 36CB81060772; Thu,  5 Jan 2023 17:42:47 +0100 (CET)
Date:   Thu, 5 Jan 2023 17:42:47 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/27] power: remove tosa_battery driver
Message-ID: <20230105164247.ss7yckr54ce6xg6n@mercury.elektranox.org>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-8-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bpfqr5dgxvb62ozq"
Content-Disposition: inline
In-Reply-To: <20230105134622.254560-8-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bpfqr5dgxvb62ozq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 05, 2023 at 02:46:02PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The PXA tosa machine is removed, so this driver is no longer
> in use.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I suppose I could queue this directly, but feel free to just
take it with the other two power-supply driver removal patches:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/Kconfig        |   7 -
>  drivers/power/supply/Makefile       |   1 -
>  drivers/power/supply/tosa_battery.c | 512 ----------------------------
>  3 files changed, 520 deletions(-)
>  delete mode 100644 drivers/power/supply/tosa_battery.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index b7fdcfd5d4e7..3c37f3a6431c 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -195,13 +195,6 @@ config BATTERY_SAMSUNG_SDI
>  	  Say Y to enable support for Samsung SDI battery data.
>  	  These batteries are used in Samsung mobile phones.
> =20
> -config BATTERY_TOSA
> -	tristate "Sharp SL-6000 (tosa) battery"
> -	depends on MACH_TOSA && MFD_TC6393XB && TOUCHSCREEN_WM97XX
> -	help
> -	  Say Y to enable support for the battery on the Sharp Zaurus
> -	  SL-6000 (tosa) models.
> -
>  config BATTERY_COLLIE
>  	tristate "Sharp SL-5500 (collie) battery"
>  	depends on SA1100_COLLIE && MCP_UCB1200
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 38737ea9b9d5..55c1aae91d1d 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -36,7 +36,6 @@ obj-$(CONFIG_BATTERY_LEGO_EV3)	+=3D lego_ev3_battery.o
>  obj-$(CONFIG_BATTERY_PMU)	+=3D pmu_battery.o
>  obj-$(CONFIG_BATTERY_OLPC)	+=3D olpc_battery.o
>  obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+=3D samsung-sdi-battery.o
> -obj-$(CONFIG_BATTERY_TOSA)	+=3D tosa_battery.o
>  obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
>  obj-$(CONFIG_BATTERY_INGENIC)	+=3D ingenic-battery.o
>  obj-$(CONFIG_BATTERY_IPAQ_MICRO) +=3D ipaq_micro_battery.o
> diff --git a/drivers/power/supply/tosa_battery.c b/drivers/power/supply/t=
osa_battery.c
> deleted file mode 100644
> index 73d4aca4c386..000000000000
> --=20
> 2.39.0
>=20

--bpfqr5dgxvb62ozq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmO2/gYACgkQ2O7X88g7
+ppXtg//dXM5dD/nKB5FH4VpqRZ7yuXae/+iP+3qjW3N/FDEJ78zDeC5krZddlIr
cQ3Ak1OBwjnTKASHu145mBvEqNNz+qWznvQhDPev1mWcpjapBK/44P96NPb/uC4u
zQdKZOynNPZcEE9vP96XxB4Yorwffc01FiRYZ3IqdpvScT8f90IR32cwGntSMy3E
W62LTzDClL3qeeuFenCkzReprfO+Xq2m9n7JeuSulHWzCH+nJwl9jqGZ9tmMMUIm
vSTqEslb6Nygvlc/+WDp/T79iZ5HkhKyNsGe1NeVLZ0LGuoohgAVrdYDYksOHUTI
OCQsy4SAUUM7wxPigJlBq+iEDLb4Gi3OIhDpEp3coc2t5kkldt4ZfAM/Jlt+8Wly
nx5RTZdEfiCbRWzVeraXetl5XyZmadAVDZpdnpTzAQO46hbMWsmTofRR+15rH0xg
NlJqPqe/Bu0mgyhIi+w/S86ZtXZSp1eazsKd10Ugh9S62ZGd2exsn9s1hA0zE7aw
woDz0ok+/eidO39ZKpyWLwEbhZh5TBJjYWUudObGjwlwiBK4DRcKZsY3Zlaub4Cs
ej03HZ89BoCMzKfm4GR/TWPfKQOVEAQVNl8blYWOBk58Leb936Zx1v8N3GFDBrj3
p6KvH2qL3pWutzHxc60rN/uvksUiuldPhjTiQAgdz/80u8Peg6c=
=VJog
-----END PGP SIGNATURE-----

--bpfqr5dgxvb62ozq--
