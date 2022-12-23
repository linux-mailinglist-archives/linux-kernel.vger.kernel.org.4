Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B82654F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiLWLYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWLYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:24:09 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1088E6578;
        Fri, 23 Dec 2022 03:23:58 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.99.43]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mw9Hm-1opuFQ32ii-00s6aE; Fri, 23 Dec 2022 12:23:44 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 9391D3C0EF;
        Fri, 23 Dec 2022 12:23:43 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 550E73615; Fri, 23 Dec 2022 12:23:43 +0100 (CET)
Date:   Fri, 23 Dec 2022 12:23:43 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/5] kbuild: print short log in addition to the whole
 command with V=1
Message-ID: <Y6WPv5zlqkBaEgHQ@bergen.fjasle.eu>
References: <20221222162535.1578462-1-masahiroy@kernel.org>
 <20221222162535.1578462-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5aEPSinXPR/Kx373"
Content-Disposition: inline
In-Reply-To: <20221222162535.1578462-2-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:v0b1tf6t7WOqHUl8RpqSrffnGCSScFv6lScz7+9d5Cv6c4VSNfZ
 On3yuF74ZzdLFyUdOzdMPukHV0jjrTK+N1NCY1r3diV+lCQxDaF33nL6FFlTj2/QlGWMx8w
 YuLBZkmcBbmIsngLjM2uKReTVv0VEvwlm2LXf4S36DWYBIw20FUdR/zC1uhCJPaiTLB3det
 F2+ke9AE3wUgsI0KRc64g==
UI-OutboundReport: notjunk:1;M01:P0:ERrgtqR2kq4=;Q+XoZXsWDzYS6Ta55JCAXBGb9u/
 J0wU+D6+8o+Oa6HzfOjfVRsUa4T+4rRGowSsLcKBDQtKX8WJWOaKSVgVdjtlPDXT2HZ5OgnOf
 Ey9FwW7kZl4Mq5lOjhOPJrVg6LUTvOt/M7dPpPorsnTnDu3Vt/BB8XHGbvB1FZFTxEyaF6Sqw
 IVmqg+0RUSa4bDGY7ITE4HOXNwgBhYcoCidBpUQaiG+vlZV/0OdXIrxNDowSI16IwiDeO73Gs
 PhJK7+rrCGsk0ADKhdNnt2TR0mI2Jku5o7wQlijyMQ72af9SkkVlMKBuKsQPGJTaGCIUCFaqK
 1ROa4K866CYw8cAWmHsk+/osSrpZpECA4l651rH4WVxfSxnMBxf6ul33GD5zYAGBuZF7YgWyl
 CND0R5SBEfxb4RoMqJKn3MkTiHwU09EzsQJLE9rwSe/caTkWYeXPihwDZDo8WJ7VoGJ3MDO0y
 1iRE1LUyE3pOjLu+r6PrQXfz/7cR6fT5UO5UNbma3DcH/yy/B3T+u99YCFoh8Kcxbd81mQuYd
 SQoQod7ChcWxKyf5qG3K0cJOTOfvZ9zaJNh9x97NbzWVvm2QrxtnTuW9i3EvydPHnYllYwjLj
 pF2hS6bkPDFZ8NGZSjH1IfLWijRvVlcpRmwgSFkdF7b81xnP0sCXUboJeUu7y79XA/JoUaaZG
 ieg/kUuffYP8RD+hK89YB/RkPD+21b7V3iFdHV5dPw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5aEPSinXPR/Kx373
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 23 Dec 2022 01:25:32 GMT, Masahiro Yamada wrote:
> "make V=3D1" prints the whole command instead of the short log, but I
> think it is nicer to print both so that you can easily spot the build
> rule of your interest.
>=20
> This commit changes V=3D1 to print the short log (the line starts with
> '#'), followed by the full log.
>=20
> In parallel builds, the short/full logs from the same build rule may
> be interspersed. To avoid it, please add -Otarget along with the -j<N>
> option. Kbuild will never set -Otarget by default because Make would
> buffer the logs and lose the escape sequences. (Modern compilers print
> warnings and errors in color, but only when they write to a terminal.)
>=20
> This is also a preparation for supporting V=3D12 because V=3D2 appends the
> reason for rebuilding to the short log.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile               | 18 +++++++-----------
>  scripts/Kbuild.include | 26 +++++++++++++-------------
>  2 files changed, 20 insertions(+), 24 deletions(-)

I think this is really helpful,  thanks!

Tested-by: Nicolas Schier <nicolas@fjasle.eu>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--5aEPSinXPR/Kx373
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOlj74ACgkQB1IKcBYm
EmkIBg//RqwAgMVlbW56UoxgfQSiU/4y+pCmEwOSXeZQZOKgB9GS+BkMcIMBw0pq
LYE89E2wsOddAv26erdM5NC1oJbQFQoQIFsP98OKJpMXddAIRn1kXgUtS2kM1GeQ
28INaFQPr1ixSUb4zyzZjBv2s05ypsHlAYBsaQURuccYXBy61NTFyF4mDysBnXuE
nDHCpKkexep5hnbocNYSp+uv6MmF0vQr4BfG5L4pDNKqFDRy0L7RwT+F9dAHF7Au
x/rgziFjg1t7klVhTugrMzYk2oIaH4QuxgMiVmZvYFwN0K6MN62uLu++14tlGhC8
XQ61bAMR4p+bG+R6w7sY7obnwqUCgfSw8NPzQHR3cUGiVzlcZxKdQJPFRJBxciW7
p9BxGhwab79iHvddvgpWTNH8nyU1Oe4XBSZ20TkXzA7CFXTN0+PAHeg0hoBqRUOa
OtqCX7SMsQOET+fys+F+lLrLrMb1Uuz9fs5cnBTjvDxXQWFk/13Zeem19n2pM/no
fUaCWz0T9oBx8qnOT2dNRBgkxezSBg7DaZY2f0ZJnJ14uypKm6mM8svp0xSA9nb6
OtA34DcunTkrD4oPkU0TC8D1dmIc4w+CQIWXRXxJ87+FepQF875ElUm79KNtlHu7
eCk+BhIkouwFeFwZBdWhojx3gQbCkvYXqB/Mqs2h2Q8GGt1BDis=
=LAdQ
-----END PGP SIGNATURE-----

--5aEPSinXPR/Kx373--
