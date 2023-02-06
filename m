Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F125668B42A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBFCdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFCdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:33:13 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CC61714B;
        Sun,  5 Feb 2023 18:33:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P99KY0PqSz4x2c;
        Mon,  6 Feb 2023 13:33:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675650786;
        bh=SLdOLyM7vaI4ciB/in3dg4uOiTibeXrg8ha3uWc292A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ifd6OVRfeRaYJcTZeCkIthPrQHmDPMeXRs1VrVKvHRMKJZajoB21yYpWFyKaWNJeU
         M87oDj9QGAWRqE4zbPtlhTEjITRy0/yNofLgWBErptA/2ipRgjw2QKoxp+kT8hiLFM
         OM2FFn/0nMBEMZ9w4+cSu3Vd5kfwhYf4YKYIuhe1SNfHn0URkYPybQhvdF3qogdGEc
         qn2ZLbZSUKL+tE44TSMP0IzmMzAoU/hzIZYeQSlM4AZODWXwsvUx7dazrvvNieWjns
         fKhWzhwnztqsulplkx8Z3emAG0jqtEDZcNZqI+lRMPeJakXAuO41KzkFKBvf8p7Km6
         qvOTqB85lODmg==
Date:   Mon, 6 Feb 2023 13:33:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <greg@kroah.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: linux-next: manual merge of the iio tree with the arm-soc tree
Message-ID: <20230206133303.3924bc31@canb.auug.org.au>
In-Reply-To: <20230117122552.64f70650@canb.auug.org.au>
References: <20230117122552.64f70650@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T/Sp1kehmK3iEHj_5CAOB8X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T/Sp1kehmK3iEHj_5CAOB8X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 17 Jan 2023 12:25:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the iio tree got a conflict in:
>=20
>   MAINTAINERS
>=20
> between commit:
>=20
>   59ce53421673 ("MAINTAINERS: update file entries after arm multi-platfor=
m rework and mach-pxa removal")
>=20
> from the arm-soc tree and commit:
>=20
>   08025a3bd9e0 ("dt-bindings: iio: adc: ep93xx: Add cirrus,ep9301-adc des=
cription")
>=20
> from the iio tree.
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
> index 390d79c20a59,9ff472ca1244..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -2071,8 -2091,10 +2071,10 @@@ M:	Hartley Sweeten <hsweeten@visionengr
>   M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> + F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
>  +F:	arch/arm/boot/compressed/misc-ep93xx.h
>   F:	arch/arm/mach-ep93xx/
>  -F:	arch/arm/mach-ep93xx/include/mach/
> + F:	drivers/iio/adc/ep93xx_adc.c
>  =20
>   ARM/CLKDEV SUPPORT
>   M:	Russell King <linux@armlinux.org.uk>

This is now a conflict between the char-misc tree and the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/T/Sp1kehmK3iEHj_5CAOB8X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgZt8ACgkQAVBC80lX
0GxPgQf+LedsDx4QVR/YBtAz9S2spftU9+0DtSPqMogP7IufHDpM+G/VuvXtsiOl
9dWJ6IIAuB9M+Wq75KUyaThZr4uiFQKKxRf1fB32uYkKAp7UB5GzglzXS0yqo2DS
SMm6aLHpsoUjV358m2fLdvENk3Iz8t1qAiLJdZY7scKrm53vODQSr7CmOv5983LV
QlI9I/GtbAM3z+3mBjZGfmZmBa2aSD+xzhM34wWTRGEDfQKzORUza0vJ+LB3Bjkq
29w5uJpcMNWOnaeosCxLfA8nMlsrSW+hUKtTO1fBHzvTbxkQYWoJCNLR1pdNA48b
r2pQI8JZqMfUrALg9oEaJUsxHWJ+mw==
=m2d2
-----END PGP SIGNATURE-----

--Sig_/T/Sp1kehmK3iEHj_5CAOB8X--
