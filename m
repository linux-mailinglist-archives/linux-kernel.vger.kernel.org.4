Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6454069890A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBPAFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPAFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:05:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF733AAC;
        Wed, 15 Feb 2023 16:05:33 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D1BA660206C;
        Thu, 16 Feb 2023 00:05:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676505932;
        bh=ZlDBJn4RWwjKQzT8VzqDU1PeJALUheC5yAkAvOEDtrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0aTRzczc9yYo8glChk2Y9ogjd7hUVQV4UhlCa0TyAOb/hoom50cGFBVFFA2rL6KD
         PaZii5CDtbPNAntJaEfKhbcGyK4W21Zixi8Xj8tEatn0RsTQAiSc4ZmdDqwX2yFPKk
         CpzEOvOZlOqrXilTYmTdYWqgPRlsvIId94LnPHtFA118zy9Gd+///Mz59Qyypk8jHv
         9aXvJ9Rrlv9s4D9axfxXhc1GHl2trnxlLl/IujpQR4nAWRKfpmgE3tlGJM7fhTA5dl
         G/MMVdr8itvafMZgEvLnvnASoZoXvOlvCGifjHncwyo52vhWFD8FZq/Gv6a4AxZY3F
         qQ6iAhejboH/A==
Received: by mercury (Postfix, from userid 1000)
        id 6504110603FE; Thu, 16 Feb 2023 01:05:29 +0100 (CET)
Date:   Thu, 16 Feb 2023 01:05:29 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Asmaa Mnebhi <asmaa@nvidia.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: odroid-go-ultra: fix I2C dependency
Message-ID: <20230216000529.fmdsgapwygxvmzsh@mercury.elektranox.org>
References: <20230215124714.2872813-1-arnd@kernel.org>
 <3e9cd799-48ee-51b8-f969-303690ca626a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fft6xlxzrapwt65b"
Content-Disposition: inline
In-Reply-To: <3e9cd799-48ee-51b8-f969-303690ca626a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fft6xlxzrapwt65b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 15, 2023 at 02:24:01PM +0100, Neil Armstrong wrote:
> On 15/02/2023 13:47, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > Since this driver can only be built-in, it fails to link when
> > the I2C layer is in a loadable module:
> >=20
> > x86_64-linux-ld: drivers/power/reset/odroid-go-ultra-poweroff.o: in fun=
ction `odroid_go_ultra_poweroff_get_pmic_device':
> > odroid-go-ultra-poweroff.c:(.text+0x30): undefined reference to `i2c_fi=
nd_device_by_fwnode'
> >=20
> > Tighten the dependency to only allow enabling
> > POWER_RESET_ODROID_GO_ULTRA_POWEROFF is I2C is built-in as well.
> >=20
> > Fixes: cec3b46b8bda ("power: reset: add Odroid Go Ultra poweroff driver=
")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Thanks for the fix !
>=20
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks, queued.

-- Sebastian

>=20
> > ---
> >   drivers/power/reset/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 7059bd1f2ee7..8c87eeda0fec 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -144,7 +144,7 @@ config POWER_RESET_OCELOT_RESET
> >   config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
> >   	bool "Odroid Go Ultra power-off driver"
> >   	depends on ARCH_MESON || COMPILE_TEST
> > -	depends on I2C && OF
> > +	depends on I2C=3Dy && OF
> >   	help
> >   	  This driver supports Power off for Odroid Go Ultra device.
>=20

--fft6xlxzrapwt65b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPtc0IACgkQ2O7X88g7
+poHqw/9GijL2hON8VPcJhFQYQGjFv+fmJ5tlKPFgAaTz+DvvVgYA+XIjbWzZRDl
j3Q3Kk/NJsbKUT9QtIaWDQQtcoMB26TOVEQZJEA7re49HKkS+bTMDTD2/65+B1DI
r0dlzAK6sEEidxh+wFWZTBt0ByvqrnaDnS/L2Hk/Pbs/8rKNOOR5UQIoYmkT2Mqt
EzgFQBDyCOclwtuWBKWXsrBdoHeKvd2GClcvqoz/NRLwK7UpcRLe8oUG/700BrOE
id00hqxN9DGFsFu0L6R5aUFNZ0crdZf7PFmdF5PJNo3+7usAY1ivKg7N+lC5Jqbz
0Ckf/STjXtkcjgb0GTq5PhB4jXMgrkoMmLS2EzcNO4guHdTjSYTDJiLw8XCqNshx
qY52NIljL0FDxqkCYgvpPugtK4/FvIF66kTXyiefEhFQ+7YeJ3mp583/Z9VxieNb
MOxZ/HohZolzh9dhHV9NtGAq5wm6SzGW9qRvWJLJ5ftv0qA9ziAU1DuMTF0d800g
5j19X2qE+kJWC5y3edfuyoDrxBD86/+fyMxV0yXcIOukn95HvXD/nE0k2v0D9PkS
yONZIGbfnMsbTaoIHvLOhK881eN4ImtewGB6iJkZ2qpF//bL8vjgEsHUAC4lBeVp
/Swu/SAKx2nElV7ii2kgTu3jFLQ9EanfQQZLC6w35AIwpWhL/8A=
=EH9a
-----END PGP SIGNATURE-----

--fft6xlxzrapwt65b--
