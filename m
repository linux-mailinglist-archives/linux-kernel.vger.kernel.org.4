Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC6656FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiL0VIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiL0VH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:07:57 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8FF8EA3;
        Tue, 27 Dec 2022 12:58:01 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3ECB2E30;
        Tue, 27 Dec 2022 21:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672174681;
        bh=iTS1x7uqMwlfDspIo0ctetklGe1k7CRp879cIKlVM7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZB0y63PL8nRqMpxjH0+jRziK+uxsALhqd3h1fSdNRG1D2CGP2OSz6i5ixTajQB2iM
         N6HqHfHBnWcme5y08pEvGXbH0S1ZwETT0XKDO3CUz/e8tAAQkizNt3Q+rHjkLOgcv4
         BfnpPgyazO/cP8j0HmMCeh9aupQMbGLpQOzFNLG7lmVi/8N+ylz3NIvmBf8Hz63Sif
         Nf/dScKChCJYpNd8z7IsS2lPWECwgev//fPgj8Vl5BRiSJOmeFY5yqiCPOz4BVK5Al
         ny2NQF6dHyB+fquGjP6HBt8l06Jz707dJt00Ziv8/H9CPDU7F0biyfAv5gtORcmegr
         j63mmpctEGDzA==
Date:   Tue, 27 Dec 2022 21:58:00 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] perf tools: don't include signature in version strings
Message-ID: <7c9637711271f50ec2341fb8a7c29585335dab04.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
References: <CAM9d7ciuh1H2Mfx5ToYGT1fOm8E3jrQhkzg304JKDd7BhT=h5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ffs6rullg2twhoaw"
Content-Disposition: inline
In-Reply-To: <CAM9d7ciuh1H2Mfx5ToYGT1fOm8E3jrQhkzg304JKDd7BhT=h5g@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ffs6rullg2twhoaw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This explodes the build if HEAD is signed, since the generated version
is gpg: Signature made Mon 26 Dec 2022 20:34:48 CET, then a few more
lines, then the SHA.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/Makefile | 2 +-
 tools/perf/util/PERF-VERSION-GEN  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/M=
akefile
index 6e7b88917ca0..ba5d942e4c6a 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -267,7 +267,7 @@ $(OUTPUT)%.xml : %.txt
 	$(ASCIIDOC) -b docbook -d manpage \
 		$(ASCIIDOC_EXTRA) -aperf_version=3D$(PERF_VERSION) \
 		-aperf_date=3D$(shell git log -1 --pretty=3D"format:%cd" \
-				--date=3Dshort $<) \
+				--date=3Dshort --no-show-signature $<) \
 		-o $@+ $< && \
 	mv $@+ $@
=20
diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSIO=
N-GEN
index 3cc42821d9b3..d7dc7c28508c 100755
--- a/tools/perf/util/PERF-VERSION-GEN
+++ b/tools/perf/util/PERF-VERSION-GEN
@@ -19,7 +19,7 @@ TAG=3D
 if test -d ../../.git -o -f ../../.git
 then
 	TAG=3D$(MAKEFLAGS=3D make -sC ../.. kernelversion)
-	CID=3D$(git log -1 --abbrev=3D12 --pretty=3Dformat:"%h" 2>/dev/null) && C=
ID=3D"-g$CID"
+	CID=3D$(git log -1 --abbrev=3D12 --pretty=3Dformat:"%h" --no-show-signatu=
re 2>/dev/null) && CID=3D"-g$CID"
 elif test -f ../../PERF-VERSION-FILE
 then
 	TAG=3D$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
--=20
2.30.2

--ffs6rullg2twhoaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOrXFcACgkQvP0LAY0m
WPHoIA//eeiiIeKt45hgGc+DwXvODY4HJ5hU02r1VswlhBE32IMxKlX1N88wuSIO
GM38QwPqOBXKCsOopzIkOWHZvyguaTfQGNyPYj5OOQALjPP+O/NxavlBTj0jPe6I
QLpFXMjtUni7plwFToRDf6hjyos8+wzG/rjR7paXJGIiqIKwYzvPVqreSeIDRcK5
Ne0czh6Mq93y0t0EGSZYOqNjxGiX8GCkYnAPTv7sR9Pdud95ElibovLbkGj+Bgc6
71kLIbDdg7WiyhgYNwRte12T8TKHCJNuabg1fU9sBgtkkWjlbgv8xCbe4ZGLB01T
d8esRNGwN/i29fBnuNGMb+6K86fwoeWhzYmdRRDitYZ0zsGX53pTbHvw9qt0dmrO
iMS+lWWRPXdWHogk77naFEuN+haIMJ0BFC8rLQE5dgM758HZL0w6R5Du3PCu0qhT
7eBcqRNj9soCmHC2gGgNVn7NO3E34D92j8mOHuunwXAk8BKXuG7IQeaJhwauKT35
g448csj21hHg0JC39HjoDa1W/rt/nODMtIBsJ+MWBfqXqI3EdPNmhfrGgRBJlqQh
gKpD9ePGl+5rLbjwuDRTmvrxWeivuwTjBKm+na4fNpjZlFAnw/9pJ+I7U6Z2n/+O
te2OF+j8c7biwKiT7iwYClrTOYnInC+UdDKJCxV9DZV4hK0hkd4=
=haTx
-----END PGP SIGNATURE-----

--ffs6rullg2twhoaw--
