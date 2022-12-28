Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7AC6571E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiL1B5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiL1B5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:57:47 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB25F292;
        Tue, 27 Dec 2022 17:57:44 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 1C1E2CC0;
        Wed, 28 Dec 2022 02:57:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672192664;
        bh=eYffNI74F2vb3LyOB9M8P9PzlF3gRsq+btlJ4EZaKsI=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=ArgKPDLjuMAAgwc1bXl9tRoUXAJpUIwUE1VjZ9yy3wjDWv/Q58nKprah+ErHnyoIg
         wk2DSgYzXj614ACZORCfsp7WIgCuGP6AaOaPk7xt0aSPc6O1S5wYfFp2w/r0dhMc61
         7s5QjWqjTKDXHfdD7j9PW3VaCHanEv7v5e71oy1NLXyKKSQGIEnPYf0BYpBJh5SaPh
         QpQAWjZlE+16hyQOgXUMXlRqzqheI/TKeU6tHsHjuBGCtoew/8ZGoC7vJNPXiKHwF3
         cgLLUyD4QSyA3G9Sdh4zXdbjDP8FL1x0c/xDTSzvWH/NxY4XWxjrRON///iZicTO/A
         SDZijC1Mpf9lg==
Date:   Wed, 28 Dec 2022 02:57:43 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 2/4] perf python: fix clang feature detection littering
Message-ID: <fef2531b8fd62727cd7e8a1b77a1b07b6610a135.1672192591.git.nabijaczleweli@nabijaczleweli.xyz>
References: <44bb9a29bd7a0385c25ebfd69abd0a41ac2d753b.1672187710.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aqy3d6gfmumzsrak"
Content-Disposition: inline
In-Reply-To: <44bb9a29bd7a0385c25ebfd69abd0a41ac2d753b.1672187710.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aqy3d6gfmumzsrak
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This left behind tools/perf/a.out,
not .gitignored and not removed by make clean.

Fixes: commit 5508672d7f4949f15c316ffd947228f130498534 ("perf python:
 Remove -mcet and -fcf-protection when building with clang")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/perf/util/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 1cee26c63613..ba0b1e078855 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -6,7 +6,7 @@ cc_is_clang =3D b"clang version" in Popen(["/bin/sh", "-c",=
 "$CC -v"], stderr=3DPIPE
 src_feature_tests  =3D getenv('srctree') + '/tools/build/feature'
=20
 def clang_has_option(option):
-    cc_output =3D Popen(["/bin/sh", "-c", '$CC "$@"', "", option, path.joi=
n(src_feature_tests, "test-hello.c")], stderr=3DPIPE).stderr.readlines()
+    cc_output =3D Popen(["/bin/sh", "-c", '$CC "$@"', "", option, "-o", "/=
dev/null", path.join(src_feature_tests, "test-hello.c")], stderr=3DPIPE).st=
derr.readlines()
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is n=
ot supported" in o))] =3D=3D [ ]
=20
 if cc_is_clang:
--=20
2.30.2


--aqy3d6gfmumzsrak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOropYACgkQvP0LAY0m
WPGCWA//cfQLE8O5E+UT7OwqHPNuPAt460g7gyiKgNf+Aab+HvwHgKf5S06cumbq
BqUEOSk3xaeOpI6SQvDV+wUExKB5P8I153NkCKR8h3xK4MejhGMWWiHsDMtPeQQ+
BhVT960hUC6IgRZVDz+EDIfMZ9GcBaIp9awjC+RSpcwFHEhOC9VnW0t7tZYMxSG9
C3yoBoz/NsfX7JzEFuQ5QVYK+1CkepdPfeLSuxT4jcFNfOY1iOm+MSeqVHg5JToA
jdiT3jtmbEWOa/CfarWG2gP+xq6Nox+5tZjTa4oVLmvaYSpAZoz1c+wtXxBZdMbA
fwq0ijtOdSQSWejWhlR1HIR4/G07f5DdkJcuJsRG0AEhYxx7oMgCAHJ431o/zCkW
PgKDvXtgrPUOx4A2G/hFlLtnAEehnT9eXOfSPe5gyAgV1Lrb/Cc8jWSTwGfpc0Ws
QsfLmR5zeigGo4or4/CrxqkbWi104Z+S5xsuSdGoKD0rA1PwA7nNmlzsoLkEb79e
6dfRf1pCrZC52w9yuzlvHLjdwUoW8uNidGEZNpgcNXVngRGMeE95w3qJJ17qGhUF
YmZP5/w/fd+F/tD70nwOmfLfLZDRM0GHtWCgm5L8w87t6mFZZ/FQmmfvjXdn3p45
soU6DfFqE/hBi5uIJz8Z/z7Gsi+GYlDyD+4DLQRCPhTM3MWSxyQ=
=Ygqd
-----END PGP SIGNATURE-----

--aqy3d6gfmumzsrak--
