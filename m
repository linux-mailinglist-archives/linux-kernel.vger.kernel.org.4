Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9464E654FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiLWLYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiLWLYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:24:13 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E873C1A060;
        Fri, 23 Dec 2022 03:24:06 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.99.43]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPGFZ-1pVZgG0imD-00PgIa; Fri, 23 Dec 2022 12:23:41 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 908453C087;
        Fri, 23 Dec 2022 12:23:38 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 7F9E789D; Fri, 23 Dec 2022 12:23:35 +0100 (CET)
Date:   Fri, 23 Dec 2022 12:23:35 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/5] kbuild: refactor silent mode detection
Message-ID: <Y6WPt7Vs6/dpgP3N@bergen.fjasle.eu>
References: <20221222162535.1578462-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sxoOJP4S2kenjVDQ"
Content-Disposition: inline
In-Reply-To: <20221222162535.1578462-1-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:K2VDuAGksYAiu9aAwY475X0VPmJQDy3JRbxbH0BeKLJWZZR37Ru
 DvhNFaH8QTkyRJ+aPWO42b9betPoIjZb0MEVddqvZ0fX0m//RdBV8leNDKlGpjJzunGW5+F
 jMRCC3nnZyNgHctuc92yBTLcZWyp/C0ZW7nQzVKfnCye5XkeVqAjSyL8lQMbLunF2Aa77C9
 RZbn+7vH59JIH2o+0rItw==
UI-OutboundReport: notjunk:1;M01:P0:GB8zBaT71yY=;vEwxX9kEV0ydmcB5M+p9hHWu0T3
 WMFQ/UIx2z5u4v0KFuKzkJmaSv0OTsBDlejLN5bpY5n3s4a+zNRBzMKxs3j7+2ZafkuC08bF1
 MP4rCY/l9d0jKJ7Acm2R0sZtnFzBBXJX1o5dAHnZ36BnCP4koWAMbSc69465kkfc3/SiZzLBx
 SWEDQYwy/66pqKTALraRTGK/h6RBnTKI4QWgFszigAkkjbCSewp9mnthGvylmtVfDTaixbVGW
 UqHuVmbYnul0lXews2L4Q7+d5npwR4Cgg4Cci3+Mpou0z/zfH/Sik2eYOsA3ylonX6IMy5HRH
 EDWT5FAboYQQGaYax1H36o6KhOKMPLCGAuj1Y3UqlgXNcrLQhsJc4yMvjlrRtGNpW0FBVzma+
 zOtMKNB5xNKU6t2MZgns2yUCxcmQnAPJLx80NqNhuVzDFZNvmVXSSsAJzZXr16QOSzy1QepeP
 GXiCOqAqVocDuKL3yCZ+QJOIZxPxP1JlwCOh++YCgeQDZl4osbSkAORvS6qS0OlPdbTSxhgR6
 TIf8hY2K2B5czkZYCZiQVctN5L3Cq9SsWYmvnreZMQrVLYo1+/MqTagq+h5UHcr5QV3R1loPs
 R3GE/WfjT2Y3zvV3uzAogvlLzkuJK0D45NBBzfIiY2KzV4YcabFwjTQhyU7v1odRO7mn1hIS3
 Cm+ZRRccaSi5iQrVx0BSxrp4uK1vX4ktvoIdWhTF+A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sxoOJP4S2kenjVDQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 23 Dec 2022 01:25:31 GMT, Masahiro Yamada wrote:
> Factor out $(findstring s,...).
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--sxoOJP4S2kenjVDQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOlj7AACgkQB1IKcBYm
Emmr2BAA1Icf13siZd56wO4/AYPKHnhB/Tf0iK9xr2X66+SG79KJeRNIvXjcVN5D
+C+bNRoFq+KldD/CUJPTTiKnjmOWm2yasYv7mijys80F54tZlOl4G3lQvwPLNHjy
2tkzv5JCIvnFdpCeXYGPxNS38eJ+gRwsKRFdLKxRP3fTMps6nx640EderS+UhPcA
h8z3cu5z3aDjXteYqmqleEBwo4VqCYVc7dLL6XqN3LDv0VM4uQm4p57xj3Eh6Imf
NFrI6UvCGWLPAZ/JlXNPlJ64RtAYEFkYzTCFLrUlKQGLNoysDosU4hi4i3DSgdX8
aC3uNH9fmOzwJGEdRZtHbcE+X45S7rMlrLb9YXF7IFYjDEfeD7zjb02YLXDDYXfh
z6ot9mW92kkeJFqPw5QbCQDarABhByIczDqsK9CJ2qjF6+wBCqZz39/JGU8S1YiC
kD7U/5rcmb/T1KHJ+DbINaRp8jLaJVKq85pBVWgmg1qqOYfvEFYb3S9uG2RBJHCO
BPWooP/yEbDe9b82IQTnIe4ORJg39HZVzOrnq4Nw5Dq4hhBIXADxVbNCIVKYhqJL
qccGGyS/Jritnjg8pwvFpD/UXnaUbxYel6S9wH04nxISPANvD9wrSfkb6ieEACCZ
jv+Lv6doDpo3SQHCOl5VJ4R2TFXiwSnyc2sd/zcMXuX3lQz95xs=
=rOJx
-----END PGP SIGNATURE-----

--sxoOJP4S2kenjVDQ--
