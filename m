Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160C67307EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjFNTQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbjFNTQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:16:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB252128;
        Wed, 14 Jun 2023 12:16:04 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.236]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKKIZ-1qPoxh2nlv-00LjFL; Wed, 14 Jun 2023 21:15:38 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 220443E93E;
        Wed, 14 Jun 2023 21:15:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1686770133; bh=pTWkF4VOUn3gjdmfNdfjBaBKSNBR72X/bS5jYM68Fiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JTgVcwbtToZuzZQacu8ZJRRdpFjJMiVFtHD99Tuzqa+B9yzrXEIvAHyrmaCtnvIoQ
         E6N2CnVvwgZa3AHtP/6Ur7cx3J97KajgmIH+bRXjYdgZPZKv2fe3VwKQzv2Ecc/d0H
         RNKJtPzGNpsZtPVZq5ff2jera3spGWuz8+aSCDR0=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id C09A66E09; Wed, 14 Jun 2023 21:14:59 +0200 (CEST)
Date:   Wed, 14 Jun 2023 21:14:59 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: deb-pkg: Include modules.builtin* even if
 non-modular
Message-ID: <ZIoRs8nkOsHMDlLv@bergen.fjasle.eu>
References: <36a4014c73a52af27d930d3ca31d362b60f4461c.1686356364.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hIonlCXWamAkeMab"
Content-Disposition: inline
In-Reply-To: <36a4014c73a52af27d930d3ca31d362b60f4461c.1686356364.git.josh@joshtriplett.org>
X-Operating-System: Debian GNU/Linux 12.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:vN9WQWF/0Hlv5vtca/FbhTNnxT7T+Lr7hj/pfp2g2he6t5xwsRT
 PZjbYjpWlSGu4i1bJkQ+/b4Kkt6ptxziAcwQSKjUyqgqRvczujeJbpnmWZB3ELMs3tkxb+G
 QcWIsgr2URns4aFi9DQgb+2DCeU08RU/hH1l+qeJ/gS7eeCSKEKYt9+xUZbR7K+2DfJrY0M
 6vtdVG3Lg86/DhFJuhbSQ==
UI-OutboundReport: notjunk:1;M01:P0:WaNimcq7GJ8=;E5qrh5UpQFBzHUNOAIYZRLh5tzV
 bGjW78Z/PVe3KUDfpTegX8duLAP+yNcwoI2Xasvs4xAPTeXx5Mj/cG2AAKmXTrjweksC7+yCa
 tcHsuVt4/m9efoP8KmNH1QoV+vDUnH0+CqrCd1ePdqowS8qB48uH4ykMAMIIp3DohuK7Bq5p/
 DtYYPScuiQkn7GuF6ve6yVUegY9UuyokL2ZIfcx0tzl5Vc+7U5Ve91+5QYmuJhxYdtW0+Qd9B
 UbN/RmT6DBC2/jrA3+Gmb3Q4ZswpDOb2zOX3XOz/Ng6S98cP0RTSNTFBuUtQMH0oxWYBUjHN3
 1nfYPJ7RnfTJ3YPJr3ge7MDVgVTEdjqEf9Ob/4QFsE60pADCZhBIp5R2qhz5qqN+NAV3f5KQO
 VgbquWPLwfDJ09gme5iKZ6eoz2UczDPrWLBOQx3E0SOmmTBg+P5XOniDwlfpBKlCr8KooF2Rw
 0ncPJwPTfH3GhrA4Xb0tC0Rw+CohgU5EFWSwiOH4BM5RHv+PtaeLZJLZ1uYpZ0TsfldM6A1Xo
 H1PmQ97lpUL8W/t1ChPb6xzrCZc/GURraQ71p8FCVGkioTh4Og9j2Azf36hWAIbOWRR1s8w39
 nhoHm32iPyfQBaroX/lXxVS5C7zeihJp9f36ZjkRr7W9dTBUP31aFQOgeY1fR00w/0da+pWJo
 /MRiR4F/234MxS4n+QuSlm9YCwkO++N4ZJXo2DzwXQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hIonlCXWamAkeMab
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 09 Jun 2023 17:28:09 GMT, Josh Triplett wrote:
> Even for a non-modular kernel, the kernel builds modules.builtin and
> modules.builtin.modinfo, with information about the built-in modules.
> Tools such as initramfs-tools need these files to build a working
> initramfs on some systems, such as those requiring firmware.

Searching via source.debian.org, I was suprised that there are really=20
numerous other tools as well, that attempt to read modules.builtin.

>=20
> Install modules.builtin and modules.builtin.modinfo into the linux-image
> package even for a non-modular kernel.
>=20
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---

Thanks!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nicolas Schier <nicolas@fjasle.eu>

>  scripts/package/builddeb | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 252faaa5561c..91261529f2c7 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -70,6 +70,12 @@ install_linux_image () {
>  			mkdir -p "${pdir}/usr/lib/uml/modules"
>  			mv "${pdir}/lib/modules/${KERNELRELEASE}" "${pdir}/usr/lib/uml/module=
s/${KERNELRELEASE}"
>  		fi
> +	elif [ -f modules.builtin ]; then
> +		mkdir -p "${pdir}/lib/modules/${KERNELRELEASE}"
> +		cp modules.builtin "${pdir}/lib/modules/${KERNELRELEASE}/modules.built=
in"
> +		if [ -f modules.builtin.modinfo ]; then
> +			cp modules.builtin.modinfo "${pdir}/lib/modules/${KERNELRELEASE}/modu=
les.builtin.modinfo"
> +		fi
>  	fi
> =20
>  	# Install the kernel
> --=20
> 2.40.1

--=20
Nicolas Schier

--hIonlCXWamAkeMab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmSKEagACgkQB1IKcBYm
EmnATQ/+IlARi8T/NGKRunXx1DIRYwp75S2NZD1xH8p5Elb1XPbmutGh8bFl2r+R
Y9piduxWqF9eTiknuImfP1osIS3B2fTMLyHqsrYBUM6ICGOuCoPzrWxvWUr5RoOV
Pomxt9PcgizNztwJYnGnJTdecs5gGbjt0K9Ox/KE3kYvDHOQHo3lhyVfqQCr6Nt3
taMaaHaiMIYiQd+qnzwXpwDlxiKxURqhEImeIz4o7Jl+9EkFAbV/vz7qGZuv9fGj
y0DerTA+D+Qek1cl+lIeWyJjvOOTD/00WLTs0zm3W1LYbE5qb9JdPoPZw6C46X0/
+TiaR9UhRABXe6SbXdr69oWENrnElkftQTIY5RtP0pqLCt8Y6Zc4CakoT2sP1VrL
EslRYshg8v+srW0l1qq8wT9rR0KZ71s5heFCnYYKoezH+4GMgtvDnrajk6lODiyj
ar8FzFm9k5TRr+hnT9TfDixxzaEBjVpOXVSrWKHgQCRoZxweDTj1zU1Ct2VHPA8g
mcYhtN2nW296cmh0nhdRQJKVHCTKxbQbrpRwuTVrf0Mh9g7Clpr3O1bLL2gXVIqY
95t3PXdxF2o40J1lbVrHyOuhFUc1p7HxU5PnrvmzcKH699csn05APjvjykgLmJt1
fmuzMiV/DYqHD/fWKHlt0byEMzX6fgIeuSnDRMUxOvVh0OM4n9Y=
=fqJl
-----END PGP SIGNATURE-----

--hIonlCXWamAkeMab--
