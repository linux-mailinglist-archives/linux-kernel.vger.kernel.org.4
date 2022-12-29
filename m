Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3436658DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiL2OL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiL2OLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:11:54 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F1120B3;
        Thu, 29 Dec 2022 06:11:48 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.69]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N01hu-1ox3Oc43ao-00x10N; Thu, 29 Dec 2022 15:11:09 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 8907D3C0EF; Thu, 29 Dec 2022 15:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1672323066; bh=2Zpriy6L/1pOB+hemgNsRhjV8hFkAPd7mHXMqLvG/l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4N78R/6POnxd9Dt1RB1yflYdfhoq6670NXPKoASiOXp2tz6joN7Sv22W9rnVXhzvx
         rFPnxP6E/yApeA+HDprPS+A+m/ctAFHXNl2A6DIQ/Dm30yCvS/Kt0hJpcWC90zdnLZ
         cXjC5BQe9Oo6ZjLWiUyDp2X1BrJlzRAdnT9F34sM=
Date:   Thu, 29 Dec 2022 15:11:06 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] kbuild: rename cmd_$@ to savedcmd_$@ in *.cmd files
Message-ID: <Y62f+iQdStrD4SIS@fjasle.eu>
References: <20221229091501.916296-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vEEAKUL2uvjESWyj"
Content-Disposition: inline
In-Reply-To: <20221229091501.916296-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:O5j8polP/xWcMmbTqbIrMxCJ6Xe258BBsoJ4LkeStOHu3UsrPrJ
 2soCMMYp3NALSiU/tqRIdtbybMRGJHP4gxtbu5n7Rb8Uy50K+0n63vKUSVL6XpUMsRYlj9W
 YTUTnVU7cU2dTlvAR/iwtFP5WXSduuIqt6G2AFVHRfg1937L8LB2UIOn/sB+fYn+KDA61EC
 WZ/18tqYU+X9pUMTTLrYQ==
UI-OutboundReport: notjunk:1;M01:P0:zNIcZGcQKPc=;da2twQjJ/yt7eDQmy07pePNxDFR
 HAwlkZGOMK3r/fsxA5fhhat14aBhs2fZKuRQyyemOAut5FtfafZyRtgH/+RoHl/5OlzhdaMK3
 F4gDjC5U8KN632XDNDxNZsxMm2xi4dQydpnAygX/CKOxUyTPsfFobQmbrRIBr4tww9caBj86c
 xca6otxiIZ5GF2iZRUNxVSDAimWyeMB84nn9zMjratjKmJYwldnbqK1mx+RRCJQ0RlsW1AD1d
 Cp4jGoTZidBtmp17ka++6ZWUFsyymtnwdO6Pw+/UpCRA/pmsxfibLLVxEzfRjMu+r71WbRLdp
 KlpahZl1+uCcw0iz+zuiMMJRvR5hY0AjLwZqiMa1pyHitNCDKZY91l3853J/BihgjmRZpNntX
 561jdw+p2ShSxPxXQLMoUQ6ht+FIG7kIAQhauTIgpLFMpwTTyUIXQehuN4qr1WazsE9VReyZL
 7PDhGPBCaFi5wn7wctjxzN0FHRTx6mbI8QXzSVVE14mqKBC0H0/TNmh8xLOzpaDzwL1IgNDqJ
 eWmm9wX28/1reqO/pKlJFvjwwr2l5a49gsE7kHuf4QXHjub8F+PfFkhHKcm0JZDsn5BoRRRaT
 be3k1tXAwY3T9lB47XL5lSwBcWZQuMwWgDlz5BFqftxtPdu9rlF7oJ2VF96TE9IY0DDcDWlhe
 JX4U+S1Sn6rpfVhdTIwb2urzKHFSJ1C+XR1DF6uJKQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vEEAKUL2uvjESWyj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 29, 2022 at 06:15:00PM +0900 Masahiro Yamada wrote:
> The cmd-check macro compares $(cmd_$@) and $(cmd_$1), but a pitfall is
> that you cannot use cmd_<target> as the variable name for the command.
>=20
> For example, the following code will not work in the top Makefile
> or ./Kbuild.
>=20
>     quiet_cmd_foo =3D GEN     $@
>           cmd_foo =3D touch $@
>=20
>     targets +=3D foo
>     foo: FORCE
>             $(call if_changed,foo)
>=20
> In this case, both $@ and $1 are expanded to 'foo', so $(cmd_check)
> is always empty.
>=20
> We do not need to use the same prefix for cmd_$@ and cmd_$1.
> Rename the former to savedcmd_$@.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Kbuild.include                      | 8 ++++----
>  scripts/Makefile.modfinal                   | 2 +-
>  scripts/basic/fixdep.c                      | 4 ++--
>  scripts/clang-tools/gen_compile_commands.py | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
>=20

Thanks for fixing this, I wasn't aware of that at all.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--vEEAKUL2uvjESWyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOtn/kACgkQB1IKcBYm
Eml+uw//e2998yeXwD29AYaVBxVPQHEYBiJrBn7saYKXhSEJBVPfQT+9BoD9kLSZ
ZwMbKgNvOcBqCHOHr2BIwg4CmE13jZfUtCuFgfokVOO9AR5Z9RzT8G2pm9dselR2
6ffA5t8rOhuWKAtEmQ6m8hitOMZyxrMkE7VTmyL1kjJzUZxt80FdHkPLQHS8gLzH
okEC/lT/KLCCiDbqdUEeq1xJ+7+pVBAHDrMdRZyKcNRd0+eYBK1LVPtr5913jLmx
hnW6wk+rWeiwxROL0SjIE4XmHViIYDTwtofs89VpRwkYJICCbFftbLhk3KLjgjRf
zLV2VGxFZ4ShyT55A92e/GjhO5NwFYtjG7RTl4lbmuo0NMQNFPfwYsqdOw/m9gNd
cfaDh3ACOoQUvN/TvBDnSje24E2timPf4V4Ue73cOQGf6cE9uaWPDvEDCNKM2lg1
ZCN9PEdofHWzPyOGnB60pyITF0MPVF6h0FfKv1VhSahz9JibOVefX8pre4F+MEol
rWVp+M0Qcb1hF+Nm3ZUNRP7zFW/ZXGiKjBy68/mev/Ej/S93zqdjYUxJAZBBWKkC
sxbqE8uxYei5qAMy8Qng9lJny+K3OrcZkE/eQH3j80y1Nemt0goIzwdoSwMRFD5/
Og4SqHNERuE+rboN6IDSgFjPSf5ax2ojh8hmkk1vuFZDrRZMRGQ=
=Ipm6
-----END PGP SIGNATURE-----

--vEEAKUL2uvjESWyj--
