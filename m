Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C104654FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiLWL1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiLWL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:27:30 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580522BC7;
        Fri, 23 Dec 2022 03:27:24 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.99.43]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MFslN-1p5gp12y1X-00HSLg; Fri, 23 Dec 2022 12:24:04 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id CF3693C1BD;
        Fri, 23 Dec 2022 12:23:50 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id ADC623615; Fri, 23 Dec 2022 12:23:50 +0100 (CET)
Date:   Fri, 23 Dec 2022 12:23:50 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Zeng Heng <zengheng4@huawei.com>, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] kbuild: do not print extra logs for V=2
Message-ID: <Y6WPxmUSHAOcFiXc@bergen.fjasle.eu>
References: <20221222162535.1578462-1-masahiroy@kernel.org>
 <20221222162535.1578462-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MOyNmKm5mYc+g3ky"
Content-Disposition: inline
In-Reply-To: <20221222162535.1578462-3-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:Gt71Tj7jfrMEnuIBlN1aGujpmmp/GpuSdUh5qo5mNnf3e++ISDT
 AFT1CvhAB7vMd8Ig/nxGP9iMBXE073ttmIEJOIi8lc+KiCSG8bkCxAx3qRaeAJF5DdCqB2u
 vOcvTCKYT3m50DiFCBBUoONVkAzi12EBPMCrKvEpWg6XRyL5/Y21+Pev6joZPgRLMHTDLsX
 kVnnQBCDuR8CNBg+MtT3g==
UI-OutboundReport: notjunk:1;M01:P0:5zm/Zx4fDmo=;Nu0choHMauIt57Ywudd+8GFQbgb
 YhJlREhX4Kt1XJod43F6eqQgg0mjDTPLCnQwDRuYWEJbG7w+9Gs0xJyNDyRSq4UAKLGl2JTwg
 1I+Pi7yh/i/yy6LetKE52UB60wE3x5g1CWGU5LT2w5UtMGO2+kYT9Hekiqr93bsGAO+8YpBx9
 d7knwh2i/FVkWVcKw1Gx9ywHyTfzuBKzwsPSVWK6TBnRzHfOw2+zm5NQMWdGi0OS1rfesOxxc
 XKwZyhlmY2z7MgVVJhKne4r/fWfAIlbKpGy0gQW5a0Og8hgeo42RiFX1xwCnIEVz6KEsP1DMQ
 fnuWOlZ5pj3fnXSBLEE8TOoukdEyCUGXC7elSoPA8Y7YxwYFhs3AeQ1/i/9VwrZoqIdyh9vNd
 BF8Scd5NUV1UheHTapdk8DQyLtkzRKN1V80Bgf9b5vL2OlFm9Oe/lsS/QniNKkv8MJLLJaC32
 dZw9wMP1yAmL3jiPMyN9RnzOxoIxNW0nAV1XOJ5dMmigL5ZyjNdm12NExS2+LiLQfJyFHBO9X
 x2JNPiKq2RftzPMSSE23VSyRZIpVQR10QgWDQ3/KlDrzTvJ+2Wt8T2o93e1RyWQ3bfosM+R9C
 TVwRDqysamQ7+DzEYZANvpdIb6U0hbldEfH5qZXUVrdzWDDevnBxcqvqQHEo8q62jWVblYr1B
 6n0y/na6usUqEoi3IRmjlp1JqN2zJd/fO/YJJiARbw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MOyNmKm5mYc+g3ky
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 23 Dec 2022 01:25:33 GMT, Masahiro Yamada wrote:
> Some scripts increase the verbose level when V=3D1, but others when
> not V=3D0.
>=20
> I think the former is correct because V=3D2 is not a log level but
> a switch to print the reason for rebuilding.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Documentation/Makefile                 | 2 +-
>  arch/powerpc/kernel/prom_init_check.sh | 9 ++++-----
>  certs/extract-cert.c                   | 9 ++++++---
>  scripts/asn1_compiler.c                | 4 ++--
>  scripts/kernel-doc                     | 4 ++--
>  5 files changed, 15 insertions(+), 13 deletions(-)
>=20

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--MOyNmKm5mYc+g3ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOlj8YACgkQB1IKcBYm
EmkVNw/8CL/ubhKUFMOA9zeW/scQHRiMh6alvKn8TaMvoJ+htOm/riO0zQ7fzTkZ
7JffTDASXN2SL0Pwll404qStccCWgdYRK1W39DJ4/7eRXdfWoiEVNuRb5L1R33CN
N7qCeW+odreG1nikMMQe2mpJDoib7bgWRTGvC5iB1yqxVX7kGVE8fCx2OFjgqqwG
dxQz4REyJl8Gjxe3WOPcZdsFtAwA2tczeTepngKiAZjciUMj6zBcIuooDzDUyTwN
86GDkLq4CEOmmbYb1ASeASyHsrYEQax2sgAZbgUcR6uGlrAzAeJpmb/uDETFOTbn
ixAay3fFdnzXRO9+o5JvCHFH1crlCgnpgNtimTiknxNyHq1WRjZ/4vsAF59IRT8W
bcY3xokEhNMRpCselInHWeR7ZWaIOQv8+FC24fmqznyGeqeGrkW+NZ94QyNpuR7O
gx1NG6jBrXBLP/QJz9vrLF/P4oAGpGN+hAqYvAnwn8FLHwFCNdCoyzuQU36t9EOp
mMcFbY6o/eFEU7d9TYMrj236YCSeYDBMNQAb0il4Ow/JGubX5SoC565WBm/zJxao
4xm0uve1jNz9i5CGsTljRbSPNLthHdoATqfGNvVjN4uVsE1FEcTXqH3ynQcFzFO5
TBETLnZQM3HlHrpHS/ONO0dVyHcCdOVtsckOh4VwtD6AKtCHcTs=
=iH0k
-----END PGP SIGNATURE-----

--MOyNmKm5mYc+g3ky--
