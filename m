Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C39636C46
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiKWVUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKWVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:20:08 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65245EF81;
        Wed, 23 Nov 2022 13:20:02 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.241]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MS3zP-1oVAmo2pB5-00TQgl; Wed, 23 Nov 2022 22:19:37 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 6891F3C0EF;
        Wed, 23 Nov 2022 22:19:36 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 6B16E1C7; Wed, 23 Nov 2022 22:19:33 +0100 (CET)
Date:   Wed, 23 Nov 2022 22:19:33 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 5/5] kbuild: check Make version
Message-ID: <Y36OZVnAZBqxcrBw@bergen.fjasle.eu>
References: <20221123151828.509565-1-masahiroy@kernel.org>
 <20221123151828.509565-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Maq/TkbjpaCwn4xr"
Content-Disposition: inline
In-Reply-To: <20221123151828.509565-5-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:/9KcQRCK2bBQpiBsYL5NkiW1zveXPgDA6HF3VgiDYd66guiX+Hp
 WgA3ZmMCzSfbfrz/S0yn6uZz1hmohMyhUJgLSt646npE7Y+bC2VD6juBc5azyA8qnfOdaWU
 U4Na5yjcdUjWN/r/u/nL1nIUvibSkwkk5MqZyJ2LaRp/yY7bPECF1CBtsBhn6icW2hpiZYf
 RCZJUa3fyYY0aWbNuixcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:br0VPB7P5HU=:q5sJH8bUFHecxtl3AZdhkP
 FYdHbbHrL1Or8eyONyf17m6A8DEq6wlzE+jRAyFlmOM0MimNM5/dDmnBOEq71H/8iUpGm9ScK
 VUoHBXGDgRNqQJ26+nAktUCUy/yHkkmFjB60IXF/JBCop6RihXfmYg2AKTrrISjQxpigQia40
 WT3+c6S9+ro9SZx/fCW8wLfRCB+TyHSF2rOnfZkLnsNkvoh8gr4K6bGkHkzGgC0w6gRcu8KJR
 ztd7BX83wkHMSf50aVIo8DYEAsfKfNL/bdimyD/pNSggdCWOTXQrFV78JDudqupF2m7gBC66c
 IIFFv0C2tnbkiBJPrEltTMF4YkoZeOG0YQFlRxI1y5ZpGuUfWCuyLX1IABnOclLu26YnlL4gQ
 2MMPVu81ACv4Mw6YidqsAhGPEf4RiiFxI3VOp0taixabKmtlwhSSe65XgSeQCEcpCrju7JvCQ
 AJdqSMyDsOWF2zspTGiFfv1xK2YWxxeKqOB9Lg2hePJsimTk4DO64/6Z8Vi0MiUMf7yz5a5e0
 3QiInUJHXgQWyIIkTyxfY+ZkrbSbH1NLb5ccBcA+ZUsWrTMLY8S8HeUPZu6jU5gin/QehKM4Q
 2w29Q91vz5NIgonpd7HtuBMXyLEy+SrRc1SDg0rae0fIwUlsNyiJS5KZJfMbE6okpY+btwobi
 hbDq3qSLae9bL1p8snjwH8FLjboYr2wRAQQARXuUDZj6Cpr7myxKzB8MIbj1UG4Cys1iZXRxk
 wZqeioVcRXFuRBhF5WpF7UbNpJJc1VPJJS9Mr3YY4FzxY22la3g2Lg62th3uPky4XDzIjfbo1
 YgM+8BX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Maq/TkbjpaCwn4xr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 24 Nov 2022 00:18:28 GMT, Masahiro Yamada wrote:
> This is implemented based on test-le. It will work until GNU Make 10
> is released.

=2E.. and as long as nobody uses make versions w/ minor version numbers,=20
cp. patch 3/5.

Kind regards,
Nicolas

>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> (no changes since v1)
>=20
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 60ce9dcafc72..797fafbc1b45 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -368,6 +368,9 @@ else # !mixed-build
> =20
>  include $(srctree)/scripts/Kbuild.include
> =20
> +# Check for the minimal Make version
> +$(if $(call test-lt, $(MAKE_VERSION), 3.82), $(error Make $(MAKE_VERSION=
) is too old))
> +
>  # Read KERNELRELEASE from include/config/kernel.release (if it exists)
>  KERNELRELEASE =3D $(call read-file, include/config/kernel.release)
>  KERNELVERSION =3D $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBL=
EVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--Maq/TkbjpaCwn4xr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN+jmQACgkQB1IKcBYm
EmmE7hAAmLPqlfjpFXmV+/c+cPJEKP6laxzbiEnmKhKdRjpVWoRZKHzgmFPasa2p
idphyfO7XE2o/+qw1bAF6X2+N6JicJzaEN+a12KQFGomJ5iAxjCaNJled3GUnmx4
wI78Ypuu3ILrUwGWrNUklTf3S6yy3Krqpoor/5IOGdHYQWmOTYXjvbYK5DS43TkY
GsjhwR3Fi+w25Ljv7l9HXQatoiVkEG57aH47OFkBuDjCyZfkTpcL8DE89mltzeLa
DpGeNt/ipe1wpvrPRI17hF6lJQCZS/qZtx1RXuen8/MzB0xBvfVjGz3De/Io6kgd
9GHTDftA2qobq1yLzkWXVJgbfYDgvpNRVfdwLWu8wIHwVhSBqrX2uOgRDWKOKX2G
5E2aacd7nMF446f+JoAeavOZSAU/HZkH1LYkEbvrs10zWhuYhF3Pbu3i02BXDhfU
aCufPsuAh1UiZ5KeYEweSKFwVoLqZ5xmr3A73UXH3mNHbWpdLuGd6hv65q804DIJ
DdbLs+HToE5Jw+lSAVNhIUSX6wZRDX4mWa/3s1R4gHqwTt8P4bqGg1/9+wmwNb1a
OAW8qGsoDAqG3mahozsIrLUpPwCUC/F3S7OKdJQaS4Ly2oLWq/42x3u7kK1ap2Jl
KVMMWrjoi/1gD5KngOBApV6ypIe321/RNHJyVgZ/LdlBeolI5yQ=
=VP5l
-----END PGP SIGNATURE-----

--Maq/TkbjpaCwn4xr--
