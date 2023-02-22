Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786AF69FF80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjBVXaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBVXa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:30:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299D24743B;
        Wed, 22 Feb 2023 15:30:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMXSq5Bd7z4x7W;
        Thu, 23 Feb 2023 10:30:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677108621;
        bh=g/Dd9pfsCqtQ0dcB2dd7QOIbKcEGIbhHLUQLHIDgcj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bivFhPfmFs82vqkne74txWI8/teBZFFzUWpgsssDUPwC5zgtrjv8khu7J0DTEnD2f
         h206rSOpUu+fHvs6yDYPUmiBMp1BYPe32Eg2jtA53g8IPLO0lbK3myID1t4viWGlWM
         s24G/qaq8XcSluCyksKlDaLcv4mwyYU63oRM9dtjQ7oU+PgwIBC8Dhn0TbgVmSviny
         HPq8/82/Oa/YRqbrUvUbMi+kPyqjPsQuk/fYpSJ5ZV2pI2q3jqnDd5fcipwTrpN3KB
         2poF3cFOUgdhC6IniFri1jiduJojLYo2VoTgRhDbprfq6/lK8wshPWeuCdZ18+qC7v
         GBZ0fPSZ0cFEw==
Date:   Thu, 23 Feb 2023 10:30:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: manual merge of the hwmon-staging tree with the i2c
 tree
Message-ID: <20230223103018.08088e0c@canb.auug.org.au>
In-Reply-To: <20230220090724.6c3d6f87@canb.auug.org.au>
References: <20230220090724.6c3d6f87@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+BSaWVfPmKIhXbUwC.FmBNS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+BSaWVfPmKIhXbUwC.FmBNS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Feb 2023 09:07:24 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the hwmon-staging tree got a conflict in:
>=20
>   MAINTAINERS
>=20
> between commit:
>=20
>   e8444bb9fd77 ("MAINTAINERS: Add HPE GXP I2C Support")
>=20
> from the i2c tree and commit:
>=20
>   d5f80ff774d1 ("MAINTAINERS: add gxp fan controller and documents")
>=20
> from the hwmon-staging tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc MAINTAINERS
> index a58c22a7adc8,98e16168d6e9..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -2232,15 -2280,16 +2232,18 @@@ ARM/HPE GXP ARCHITECTUR
>   M:	Jean-Marie Verdun <verdun@hpe.com>
>   M:	Nick Hawkins <nick.hawkins@hpe.com>
>   S:	Maintained
> + F:	Documentation/hwmon/gxp-fan-ctrl.rst
>   F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
> + F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
>  +F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
>   F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
>   F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
>   F:	arch/arm/boot/dts/hpe-bmc*
>   F:	arch/arm/boot/dts/hpe-gxp*
>   F:	arch/arm/mach-hpe/
>   F:	drivers/clocksource/timer-gxp.c
> + F:	drivers/hwmon/gxp-fan-ctrl.c
>  +F:	drivers/i2c/busses/i2c-gxp.c
>   F:	drivers/spi/spi-gxp.c
>   F:	drivers/watchdog/gxp-wdt.c
>  =20

This is now a conflict between the i2c tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+BSaWVfPmKIhXbUwC.FmBNS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP2pYoACgkQAVBC80lX
0GwNHwf7B0nXbmexpvtpFrJNTwTRGjJl9maiyVm+nLHHl+5N3Qq4L+2EovRGmPVk
E3IiByeSZ0LNCrLkPawsWbMaxKhFsdg/5akMjLgGkpmG1WobxucxHGBPKv/SNFCy
AmumxpdGdiOeqZ2Y5LmM88rhBMHbsFqeIG82cNg7Am706E2BeJ43FbvBjLeGt7pq
q5h8gF65KIP8/++yPECb6vuk04kV5idAO0Xrxih9AQO2oGlr9Ptl6N9ov6T6kmWb
tqcRF8SL8UwXsXNg/G3slmJqXKFcW4a3m32tAk65VKjQedKP5STMWf5pgs9gKl8s
Rr1zjd0gam3VxPk06MSRF9LtXXje1A==
=0Uvm
-----END PGP SIGNATURE-----

--Sig_/+BSaWVfPmKIhXbUwC.FmBNS--
