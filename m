Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843967165F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjARIgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjARIfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:35:16 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AA25C0F8;
        Tue, 17 Jan 2023 23:55:41 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.8]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZCOl-1pDQZ60UCH-00V6J2; Wed, 18 Jan 2023 08:55:13 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:219:b8ff:fe08:dd7c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 04C833C087;
        Wed, 18 Jan 2023 08:55:12 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 5B3371C7C; Wed, 18 Jan 2023 08:55:11 +0100 (CET)
Date:   Wed, 18 Jan 2023 08:55:11 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3 2/2] kheaders: use standard naming for the temporary
 directory
Message-ID: <Y8el34qPsCq49bKd@bergen.fjasle.eu>
References: <20230117-kernel-kheaders-gitignore-v3-0-e686b93b0732@weissschuh.net>
 <20230117-kernel-kheaders-gitignore-v3-2-e686b93b0732@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="67NBECsffgd7Rpuu"
Content-Disposition: inline
In-Reply-To: <20230117-kernel-kheaders-gitignore-v3-2-e686b93b0732@weissschuh.net>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:aMxYp1DxzfTUZdEWrLrhpKKxEN5TlPiy2IK7TGfoY3rG6U+/aru
 sHurwZ7TnTdVViiHxd0SdfkO431HgyCRxd6kbBuApnIAeVOsHFr3+QRf7i0tDktx29vyBMa
 7rGAj+rRTLLp28v05PFBgwIZ4Yxw3J+MtW0minHR7KJv3c7/M/rzkZ7AY8U+QO6LOdxfEUq
 TdvgsB4zYHHKLj9bciZiw==
UI-OutboundReport: notjunk:1;M01:P0:HfV3AwTnIt8=;DfPvW6GbR+flBSgt7JwNH+a0Fmo
 etZMKQAKKD02ePfDB4ZcS+o4hr7ojoPsRB+zospZuX5eiMM3zBnqM5uo+CJVQ4UGkG3eq2ugP
 fHmqK93EgtWoMUyNFr9DmWFtjTD/uR0vMDA4FgwdPDr5Xmmg1kzfc8S6HL7FJS6LhekRhy10f
 YYhjkr2LcSW3C3g3+hSocHPjiimGysLf4FwQbV2I3CCXdOi+nXnUqFj/y1uBz+qrrQTk2ae8O
 jA+UYeKq4qxYQOAIHm9crWEMefjpxFC6A71ZC8cJInmtCCuohHt4d1R0N6t+hU/e3Z+vTw24D
 wQ+ewTzhPCtif95VbP5/nnu6LvbpoBHjWrCOYkLCf240sCNRwDA4ikc19QXTxuSgpOdMTLrZB
 JwVTYzFx+EiAvbwvA0DPWVEd5L7p2w74t2Y/y79Xul0IhAkqK/nH6Qm7yv8f3sgK1h6EwzOiA
 eJbPB36n2GIIFcNgfaZm53FDS1aqHRtHJCTCldO4Hd9IPp/C8BrkrYK5ToSRLsJ/Vl8GQPAIu
 W6//afLMiI9JlEHrJ8sXJRunaG5UZZuwOBsqW9NjJPCzUDSve9GlEIJtb0iGZVDvE/bB2vN8F
 8+FRcKfYW5kZ3t7DG7xmFNt9wfh32Asyky02ti4hLCIjHL6VSUTK0fkJCHjWTvXdo8sg6Ama2
 SjhPOdwEM4Q+BvchRIYRX5IX0CbKwREpUlHWUJkEjw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--67NBECsffgd7Rpuu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 18 Jan 2023 05:05:35 GMT, Thomas Wei=DFschuh wrote:
> If the kheaders archive generation is interrupted then this directory
> may be left on disk and not ignored by git.
> By using the standard naming schema for temporary files and directories
> the default .gitignore and "make clean" rules will apply.
>=20
> Suggested-by: Nicolas Schier <nicolas@fjasle.eu>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  kernel/gen_kheaders.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 473036b43c83..b477b763f262 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -7,7 +7,7 @@ set -e
>  sfile=3D"$(readlink -f "$0")"
>  outdir=3D"$(pwd)"
>  tarfile=3D$1
> -cpio_dir=3D$outdir/$tarfile.tmp
> +cpio_dir=3D$outdir/${tarfile%/*}/.tmp_cpio_dir
> =20
>  dir_list=3D"
>  include/
>=20
> --=20
> 2.39.1

Thanks!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nicolas Schier <nicolas@fjasle.eu>

--67NBECsffgd7Rpuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPHpd4ACgkQB1IKcBYm
Emma3xAAjFSXPAeJG5tdbFmUVd1WnUhzMDacYopa9a8QSKDiVw4FFG0dYegX6YEl
PBotDzyEBwapXpkJ6kyI68bMrZoG8fB3xRjnyXQZ/jLq45/Wsz0I8YKVKKJlD+LI
EJxeCVCfAp4m97SsRz+zwfJWFucEuNTz3hz86Sj/CHRQpAByeH1o+pRcQ/Yv3bzd
7rnx+Rb61P7B06oP67OWocPYc92iehHtNNWiPagsP4yzzw+03r7Jue4RCicRSK6p
rknBWotBsCruFiHiO3kDhLOPZhHSZM/5uWiMDRMM+VK+x+lXzA8Y+0apGsRSJ+8t
enR0PpixzTy4hE4/zSDwz99k6ticXfsLIy6kw4dcA4xZ46i7FZfKMVeiIICDc1li
pYxhmYrXot+X3Ja4yqrA+YkexWTgQHQtHTt4i6xASscCUJB7pb0TF7M/XsJRtpje
usKgEqnIpf/5+Cwm5d9sgheWbgA8Mco30sC4sPQGGvpTMheegnTaX5im/77VphXO
gtQr1FYYhC1q67VIkvzj+/86J9jnn4An/MXmnOZ6YVuKieaVkaDC9aubVBYDgz80
M5h9nR4xQ83BU/ii8hj981BxQSEYnrpo4aqB99q69yIG2Kfzo2sebf6FkqwT2gFo
OMNW1pSZX0qmqEgDVwfzYxn3husB5trAvv4QFE2Qam4FFjOK7K0=
=uoCd
-----END PGP SIGNATURE-----

--67NBECsffgd7Rpuu--
