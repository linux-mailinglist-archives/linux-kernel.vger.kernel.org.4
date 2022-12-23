Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F894654FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbiLWLY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiLWLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:24:22 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637EE6578;
        Fri, 23 Dec 2022 03:24:15 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.99.43]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MmlfM-1oQ1Py3ebe-00jpQW; Fri, 23 Dec 2022 12:24:08 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 40B7E3C1BD;
        Fri, 23 Dec 2022 12:24:06 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 125C73615; Fri, 23 Dec 2022 12:24:06 +0100 (CET)
Date:   Fri, 23 Dec 2022 12:24:06 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/5] kbuild: drop V=0 support
Message-ID: <Y6WP1tzHZl0XUgG2@bergen.fjasle.eu>
References: <20221222162535.1578462-1-masahiroy@kernel.org>
 <20221222162535.1578462-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PZ/LjElDUI8+SjYR"
Content-Disposition: inline
In-Reply-To: <20221222162535.1578462-5-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:L1PIZbY/VRK5fNVYZ8Lkc7DEua23ujjgRCW7hY+2Wqvguq0vLbI
 L2PJb0Ox5J7ysFTOdbZgH/fDKzd2ZDpoEUw1o8TQB9k+xDKuyd6UZSZ5XU/qf3m+bb3LsDH
 ALJC48LpqAVdxZhXYCZ+k+N0DOcK2HfgjvT71aclxbdZwH6GWtVnCCQ1luh4neSKc/FzLAK
 GeYJFbIdPuRw9eZ6Js/PQ==
UI-OutboundReport: notjunk:1;M01:P0:ip0wU9zBdbo=;xqOwEwW0FFxz50vLtE/l5kl5qrv
 bXSAvneI3/4pXZ5kRMl1qHDVcSuj606aIm4fw8ha3CqNZje66xkTt0LeXLcDeQQKrzrfcWoJN
 AxWh1I0sI2IfWEFu3xEgbUvRRNiZRVYA7Yl2e/DnvMjr7AT3axjups3/nY7k3TdncSF3WgJQQ
 eEYXOYyxzAkbT5Lop5DSF4dy9gQizKSk6IDHL66xHPEHdbDdb9AGyjJ/TBFNBw0VMBA8VS4w8
 xvfVR1zM1VzLQe7ksCwKGL64z7kY3Fs095GDd5DNyIV0osjVvwmyPxWlasv3swYLA0CrD0gOL
 y1Zol1R0CaCHgCkUHSMqzkZtfzcUpRmNkZ4wLDxWdqQJ3AowMrZ0VKp8v37DzRbfihmIQagwf
 nhfoaZeZaOG2IkfXm3Z8zEs/5Y0E0fFDFrhmD1dawvFx9FzdOw4ehEdu2DW0L+wSMuhX+QRXc
 NCSsSiTP0huCW+xYzSEENkbyg7CfgToM3am/zCXayZx6IkR0k207uQCgl3NeBUqUbwc2DZ1KG
 4Eai6qLSBVBpmieDBkMWByXT8c7ce3DBWNAk9n4gRrtEohoEoi1khIJGENUng+7F+ZKP09dU3
 Eu+jDA+gNX93+wugtirp+GUAy6UenDbp26LNzDLb1ukdXO20e+1XTBYd8IyfHsHIy6iIl0Ad5
 D0RNGCq2ujilhoEMIbCZpJKNa3qlqOwIFdN16aInag==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PZ/LjElDUI8+SjYR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 23 Dec 2022 01:25:35 GMT, Masahiro Yamada wrote:
> The top Makefile sets KBUILD_VERBOSE to 0 by default, it looks weird
> now because V=3D1 and V=3D2 can be OR'ed as V=3D12. The default should be
> empty.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Documentation/kbuild/makefiles.rst | 4 ++--
>  Makefile                           | 7 ++-----
>  2 files changed, 4 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--PZ/LjElDUI8+SjYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOlj9UACgkQB1IKcBYm
EmlhZBAArgK7qCvHXnnsNFhrEnFiw59PyFNJzB4pqvi4+dfwglnkbgQoDR8o5hvU
cpTDLpfMYTn3go3/gj/5McVsIxsGbL33CCFCCX8ENtrJ141dibNzWz5AvkC0UdU3
+FI3NdToUutXVTXu1B4nG49cf9lz57GYROR/hl+sVVD0IyDcaKv9nm5WCdvcPVD2
cioQw51OD3iHwsRXixmt7hhjYKKspWJR09JuEgmOAhY5uWt2g4A2YEg86Vdkr8uL
py28ROn9x8CRXlspE3RLG6pJkoAK6vCWzkj4OyMvq0u2nBTUfcTcTa8z4X7ED+mE
jMI81uFsFRPvloQxNhjDfH1XZPJtEvwmAht4kFCFZR7/1rkFGb1S2JvVE1WzP8E0
wGM5asV4QwcfGqfB06N2h+EQrgsN2GyddfgALVv+Oi5zRPV0jinmRUBe5IClmJd9
olx/tkfnY1Ya4FdTi47OurCBgsUxFhFNhT0PppyNycEzfpKNWbmHZmeDo6sr07iH
9zvTcOBtuG3xFh6DRdbCzEGj9BFDhs0yOOe1GSELKR9bMksTuI8xlpOe1cYd13MS
4r6t6C8uAx956ZvcXE4uQvddgSVPI4J15qekGsmJh3XloaBxLEFQ17ar9pb/5c9L
rXNHRJsgfxXXRh/gt6pICOP3VwcGkWC6gUTQK9yxy6I+TmmHNrQ=
=48pm
-----END PGP SIGNATURE-----

--PZ/LjElDUI8+SjYR--
