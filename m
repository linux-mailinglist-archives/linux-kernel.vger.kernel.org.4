Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94001688F98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjBCGS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBCGS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:18:27 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC5418A98;
        Thu,  2 Feb 2023 22:18:20 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.20]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MV5nC-1pEVUJ1IwQ-00S3M0; Fri, 03 Feb 2023 07:17:57 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:219:b8ff:fe08:dd7c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 7ECCE3C0EF;
        Fri,  3 Feb 2023 07:17:55 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id E887B180; Sun, 29 Jan 2023 22:30:53 +0100 (CET)
Date:   Sun, 29 Jan 2023 22:30:53 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 2/7] setlocalversion: simplify the construction of the
 short version
Message-ID: <Y9bljbtdOr0yuzQ1@bergen.fjasle.eu>
References: <20230122141428.115372-1-masahiroy@kernel.org>
 <20230122141428.115372-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SVoFdigBhs0Ycd+b"
Content-Disposition: inline
In-Reply-To: <20230122141428.115372-2-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:4Ld5aMPA+HR7LNiMxwhhDn764rMqiI1rzp6eVSZoTMMpcyntsy3
 jKg9Cf3TcpEw6Zg8bd6JQpfreBRLsZ/yoWgZEFLUykpRMWZ6cGEFedzvM2cPM8FAivxrlru
 rDooRK4B7tPk/kG9pZCRrZ9hzbTuYnEK2vY/4zyOaw2H2PxsRwzKGFdqDuwM2nNuf/dBgvt
 FXgVP2TpLmd4X10uOOL4A==
UI-OutboundReport: notjunk:1;M01:P0:PN876G0nEyU=;49cCQSWsQhvLXEpaAN1wC+Fqm3N
 VbzThgJe3lD1/pEU1lSfNyQ74lhibady9NDqFFhUnjkpldd8nABtsPVoqNHUNcoheuZ0ayW3R
 YtGmQUVeThvm46YTg2cU/jjHlWMF++6I6ojEp1R+tGhUTn6DUWM2ymycUpaIU4vfj03+xj4ZB
 AIpaNN3W36XDHJFQLVMZ6ODY2W2wEXKJ8WMBxv62EoAst9cNHZnkIBCiaI0b/+ANy710nAOg5
 csGMeSHRLqTfskXkD3YVr4AUw2OopZoJWO5w68//KcovapodvKrvboAd/yYHv1E6Bqhkb7wi2
 D6hzi/fm4DL/Q1nO5M0mH86LnhIJWosOPCNUbzCCssXMp3uT5lPvhs7NRnUU6yzlo8JYCIw+o
 jvz+Kbfv1o8lxjmXVwEPGWPxD90GVUC4C66mz/ekrHnhiC8uCR3+rPlhQ574z23++3UOsPVfc
 UhaglFFhhuquf6dX9+JP0vkRG4LQ/VlmTdw1hLazur6t5VaQ0rc46hW4XWVAIPomhQJ0LAs8n
 HKcw45Jj8ks2yUv34wXunuJIQfyR2LLbIIjmwnuPb+NesC8iGN0MHny4MxVzWXt5SEVN0DmuG
 1ZMdjuBtAoWbF6QEBnPdozabufyQ9wl90Ymf8Qi1y4hklwFD3XufIX8mApddzZLGFPao6BnxF
 fMkKzDVNggcN1eVGwBXnj/0+v7C0TLleSaHzG7o5uw==
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SVoFdigBhs0Ycd+b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 22 Jan 2023 23:14:22 GMT, Masahiro Yamada wrote:
> With the --short option given, scm_version() prints "+".
> Just append it.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/setlocalversion | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 3b31702b4a4a..5cdf409204aa 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -121,8 +121,7 @@ elif [ "${LOCALVERSION+set}" !=3D "set" ]; then
>  	#
>  	# If the variable LOCALVERSION is set (including being set
>  	# to an empty string), we don't want to append a plus sign.
> -	scm=3D$(scm_version --short)
> -	res=3D"$res${scm:++}"
> +	res=3D"$res$(scm_version --short)"
>  fi
> =20
>  echo "$res"
> --=20
> 2.34.1

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--SVoFdigBhs0Ycd+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPW5Y0ACgkQB1IKcBYm
Emnm3Q/+JmfPKGLmZ9KaapxJo/XbWvHSwM5lpIgzOJ6DtPcT1aRcWEGU5ED3zJMX
eGyJVUIAIb/gcSz5SXw1jsgo0qPzCi7y7JGGu2RnrLQ6Bj8sf6vzwzEG7VID2SIQ
JQIjzk6M0Wuvenfj2AA8A50U2GnLy+Ycak1E5XxPfBDBgb4jZDpPdVZMX1mO8IB7
QTIY7tAcFqJEOLA9+fCHoy43PnMyen/Y4zjSbmk2PA5iwwmZkoOLCLnDxp0jyW7c
txGnWYg8nc6MChyvYqO/DkmRK4OtlmCvWJDl7hGORlYCrvLksU0IOYOKYiN1UHyu
tKDZfWFtbQh7K7j4pHbFQshSVs4AUR9sCuYAa61iMqudgZwYHTjXvB/XgJfjD8tn
XyflWu4Zjkvtq+SEpnYQduZ1DWxmmm9tvAFq9lmKxtoqwFRipSFL2lCmetpPSCCw
9uFNUyWwy4VRLP8zn71j2gEq7oKnkY82BsyAMm0eeYsFYyj6Oyi0y37sNimVyNdK
NccsgWpQflTp5qlI2Zk8oYdeB9BfenmUAWLQb0iibKAeMMxIJ3f/+bx7gao4lfhb
mQCoo3RJQRKhCoV5mDcIqVO3HWASdCgynftRaCssdeRw5ZoBBBpm4pyUBxC+VFDD
fbqaHIm1yolEOUfCdHxOtCDVohGXTkrXNMIUzRbvQ+uevZ6Cb3U=
=yRsB
-----END PGP SIGNATURE-----

--SVoFdigBhs0Ycd+b--
