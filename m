Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F2574197E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjF1UfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjF1UfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:35:21 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB30D1FC2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687984518;
        bh=dn71ai0Ke54aOHw2jYDnLVqkVoyPtJRVPjZChFWAozI=;
        h=Date:From:Cc:Subject:From;
        b=aJVKFu+UTmno2hzADcVUw+OEj7muptJeUv4/K6ywvLu6uPE/BDkVrmUbo1f/vgQ/C
         RPi9lJDjHwRKM/axScOrmq/bIRfZu3RJt3eZD4k4CjbNyRIAIS0fiTCtNoaKjEFwf9
         hG62OPFwnBsb2rOdHwMv2qShEYbcSJKpt6s2Vyl6GgIpgIqy/hkovjmhkeIVSK/Y9g
         leTYDMc28uW0vVhP2UtjqQJ1Ihwp7aTp+HvaVgNvJTlzuZTf+O5lmkWqDU5Dl2Hr2T
         DTDF7By8/YwXb1E4aKJ+mRhv4VG2fQvEIKOZRejAwmsS+t+olu412bVO2Jiaxy0Phx
         R+/PrDZP989Wg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C58B01174;
        Wed, 28 Jun 2023 22:35:18 +0200 (CEST)
Date:   Wed, 28 Jun 2023 22:35:17 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: don't take signature to be part of the commit SHA
Message-ID: <cmhc6xudksabuza2jrhgs5yg2a2xbohadyyazitg6463uskhjp@enclcjvmbx4r>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vr7ohxlsyreiktpc"
Content-Disposition: inline
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vr7ohxlsyreiktpc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I had just received:
  $ scripts/checkpatch.pl 0001-splice-always-fsnotify_access-in-fsnotify_mo=
dify-out.patch
  WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<ti=
tle line>")' - ie: 'Fixes: gpg: Signatu (":35 CEST")'
  #25:
  Fixes: 983652c69199 ("splice: report related fsnotify events")

  total: 0 errors, 1 warnings, 60 lines checked

  NOTE: For some of the reported defects, checkpatch may be able to
        mechanically convert to the typical style using --fix or --fix-inpl=
ace.

  0001-splice-always-fsnotify_access-in-fsnotify_modify-out.patch has style=
 problems, please review.

  NOTE: If any of the errors are false positives, please report
        them to the maintainer, see CHECKPATCH in MAINTAINERS.

This fails when the Fixes:ed SHAs are signed, since the output is
  $ git log --format=3D'%H %s'
  gpg: Signature made Wed 28 Jun 2023 19:05:02 CEST
  gpg:                using RSA key 7D69474E84028C5CC0C44163BCFD0B018D2658F1
  gpg: Good signature from "=D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczlewe=
li.xyz>" [ultimate]
  gpg:                 aka "=D0=BD=D0=B0=D0=B1 <nabijaczleweli@gmail.com>" =
[ultimate]
  gpg:                 aka "nabijaczleweli <nabijaczleweli@gmail.com>" [ult=
imate]
  53307062b2b644dc0de7bde916d6193492f37643 splice: fsnotify_access(in), fsn=
otify_modify(out) on success in tee
or
  $ git log --format=3D'%H %s' 983652c69199
  gpg: Signature made Tue 04 Apr 2023 15:57:35 CEST
  gpg:                using EDDSA key 408734571EA70C78B332692891C61BC06578D=
CA2
  gpg: Can't check signature: No public key
  983652c691990b3257a07f67f4263eb847baa82d splice: report related fsnotify =
events

The fix mimicks what was done in commit f24fb53984cf ("perf tools: Don't
include signature in version strings"): just don't ask for the
signatures being validated.

With this, my patch passed validation.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Grepped through for /log /, /show /, and /git_command/, and this
is all I found. Unsure if there's other git executions that need
to be fixed, tho.

 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b30114d637c4..d3a682bc9c20 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1164,7 +1164,7 @@ sub seed_camelcase_includes {
 	$camelcase_seeded =3D 1;
=20
 	if (-e "$gitroot") {
-		my $git_last_include_commit =3D `${git_command} log --no-merges --pretty=
=3Dformat:"%h%n" -1 -- include`;
+		my $git_last_include_commit =3D `${git_command} log --no-show-signature =
--no-merges --pretty=3Dformat:"%h%n" -1 -- include`;
 		chomp $git_last_include_commit;
 		$camelcase_cache =3D ".checkpatch-camelcase.git.$git_last_include_commit=
";
 	} else {
@@ -1226,7 +1226,7 @@ sub git_commit_info {
=20
 	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
=20
-	my $output =3D `${git_command} log --no-color --format=3D'%H %s' -1 $comm=
it 2>&1`;
+	my $output =3D `${git_command} log --no-show-signature --no-color --forma=
t=3D'%H %s' -1 $commit 2>&1`;
 	$output =3D~ s/^\s*//gm;
 	my @lines =3D split("\n", $output);
=20
@@ -1277,7 +1277,7 @@ if ($git) {
 		} else {
 			$git_range =3D "-1 $commit_expr";
 		}
-		my $lines =3D `${git_command} log --no-color --no-merges --pretty=3Dform=
at:'%H %s' $git_range`;
+		my $lines =3D `${git_command} log --no-show-signature --no-color --no-me=
rges --pretty=3Dformat:'%H %s' $git_range`;
 		foreach my $line (split(/\n/, $lines)) {
 			$line =3D~ /^([0-9a-fA-F]{40,40}) (.*)$/;
 			next if (!defined($1) || !defined($2));
--=20
2.39.2

--vr7ohxlsyreiktpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmScmYUACgkQvP0LAY0m
WPGe9Q//WwC94kk6tXtKFC/p/oC39bxAfPeu04v6vs4zF8ZZlQzMJyi4Au93/3UR
dKvcMZgXCMuWp4xrXNnxiMGzs4WfE69/lm15wTWrfKFn6nvFrv83MY0EyW0I8MPr
V93wwm6D7F4qURBi1Q4GfGARHdHatyqS04PFHLviFVqHvZVe8SSIzWjTaPcvX4md
nV/UtJ0iuROtp9rYB2npXQHfb/B9jWXNhDrOJA0OoyTUHjdoWInuH76yIvMFc3dw
lvvR7TtWR70S/nG0oSean5qXP50ffntIXhcBDgmlY5UDbrr12idmP11/TKaPyi2g
0BHY3RswjUY8aSrF11V0bg25SliBs7wivuq927FnqSvvOQQudAswshKHb6+8b/VK
HUuo3fqJLxCGqW6NnDwWJHz/7jDo25lcc3Lv0JaPa2m23BrpLEftgvF+Vg/MF+2a
xY6WGjsyAHVeWcsAPbGDogmWEp5K/310onNrlucUXqWBwYAPX4znJYtAR/2AqySO
0DnDo1juV5Yt/S2rajYQQsSY/UFcJkhaXSij4rIRMF3oCkCmsEBmgW5VUUk3AIvr
+Zcm3gb3DhP+gFk7LQBaseDbETxTaUHXmH5eAjevEosvN5tbHvn4P4jWI/wUtVpj
miASHzKHAMAOspipufaqtyYQpwKlVp95QhqA0erGtR9JeYdU4Z0=
=DlOu
-----END PGP SIGNATURE-----

--vr7ohxlsyreiktpc--
