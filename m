Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9DD67FEE9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjA2Meu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjA2Meq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:34:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4668422001
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 04:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674995677; bh=gQt9VX1KvePgNEJAJdcWhPr0Jz5WN6TRoAAoW9znZzs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=SLpHvAsjJ3SNOYugkehJl3+gRnBB6gZXIN7L7DX9xyIxkNHxYXOROtXbqfQpEYBud
         PkdAKQr7DxjmGg9CuZJaVWDYC/GvBLlTk+cd6jmMEDOsdkrwzoSf2Tj1o+Z8GuY59d
         y0qfBWJRgOWnnAvC4sc9FF3P9L+6wBRouWiXM6psRUteq1nd6tHjwrACPQJ93p/MCo
         RGvH+ylI7jvMq5iSanUQ8LSD/6/2PlKmU6Wsykks4ILXAlKm0OS10+xq+5vBcmi6km
         kJjDlKJ48oM09EE6iH68fwGlvYzeQdLzFVW1DqS7YSkV/bvnxaCy0jfxSw2FliuQKf
         wm/QDZCETm5pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Ux-1oQikB3vOt-00wE9X; Sun, 29
 Jan 2023 13:34:37 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] checkpatch.pl: Relax commit ID check to allow more than 12 chars
Date:   Sun, 29 Jan 2023 13:34:31 +0100
Message-Id: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:To8aw2cJRT9HKi99D3nDKzAF7HB6D3EVKkUCpVvmnu4s8/G9skO
 9B70RmrjYJKUhi7Cq1oIIPOgavukG58D2bG4pjslG1ylrMYIRtczTCW+uFzmhRB7m89+F+x
 t5OOy7w5QfcO5ocAofHzlv3/ZuHksA3+pGvzEWGYuRHnx8V0vg5ZlvEjiIxfEsPBmKMgbo+
 BQTa7776vfouTVrzMUHEQ==
UI-OutboundReport: notjunk:1;M01:P0:Y8aGokvwFWc=;kCLUfMKfd2LdofXYZe7mqHXvUga
 QJi5uKVtbXRUMmtsqDWJIdRfTkz+KrHFbMt8aigVlWkAvPwvEhwsIRH1LGDM9YFB5fDSGO/Yg
 PZ8R3eaT4agmYz+spbIPlGLrQBmwL1Yw6Jm7jWrhUECL0+mycgd4+j3EJpZWzvCWTS7Kp+Xye
 cSVJ0uA9RCTIF1q/upBId6PUvpJxVF2YF8s+mJHDUywSVTwNyBNC8KgDyoEXHsKGD5Ry35SDX
 o1Q47g8gcXwzO5EitHiyzZlDiMFsPXWJMLrXPWE6aA0cKnSNZEm8+ZbdPJR+9NK3R2sTHC0T6
 uvoByI7d988cJmv9d4pNLTVi0fChdgKA7WTsthT3T3z4cu4iX9KMlPBEQa9wNIrijLM2I5dpj
 7gk+ge+xtAbR1jczRJG3L0LSM1jP54da1r/OoH+he4/1k1awIdrauwsf+KH6yAAA3JN/6AQhn
 cGFBKW/EriloXIMOKFBFt844knPm1cCLJfbmCYiIvKQqQP+Z1jWebux1FT5pnxxL8eSGwFrdl
 KAzZq3N7BzN9IcX8a+sIh5W+qt+psNJzsJlADv9LoUwM53eq8CbekmdqTHorckQ3kwzUZPg8h
 DUVP9nDjLHIOQ/wsV/mxA7BD86J6Ox1GZgbrpaajlEKh74tOLBKO6ABpqWnu6m7Af++0BCWCx
 UN/uv6iNiEZ5St7Ma+RmT5ra7aP8iNCIGvCOm1A+YWudRwzSNywTqEYD6bVyrprUhvN/Qx1QB
 gRt7hnXQsj+p4Y0nKs12uJGKYkF5r2TVMifQmsyF8jlteup07sy8vyqWC9zp/BkKlRFufvhdQ
 1pyt89R9G7f+lXl2tcFC/DKiZDtIkKWNgD02jerZzjLg1KeT5XW6roouhalvfWdblY0Md5DfJ
 R2CLHFWJKs1QnBwNXP5r7LBPPeMr/J2jzb9WX9AtFHodqKzdK6W7FlTZ9JF49v30f3PYwkCXz
 OsPPf7xnyFuC+R9ndPPpa6XGbmg=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By now, `git log --pretty=3D%h` (on my copy of linux.git) prints commit
hashes with 13 digits, because of the number of objects.

Relax the rule in checkpatch.pl to allow a few more digits (up to 16).

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98ce1..3a2c8b5426191 100755
=2D-- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3177,7 +3177,7 @@ sub process {
 				$tag_case =3D 0 if $tag eq "Fixes:";
 				$tag_space =3D 0 if ($line =3D~ /^fixes:? [0-9a-f]{5,} ($balanced_par=
ens)/i);

-				$id_length =3D 0 if ($orig_commit =3D~ /^[0-9a-f]{12}$/i);
+				$id_length =3D 0 if ($orig_commit =3D~ /^[0-9a-f]{12,16}$/i);
 				$id_case =3D 0 if ($orig_commit !~ /[A-F]/);

 				# Always strip leading/trailing parens then double quotes if existing
@@ -3194,7 +3194,7 @@ sub process {
 			if ($ctitle ne $title || $tag_case || $tag_space ||
 			    $id_length || $id_case || !$title_has_quotes) {
 				if (WARN("BAD_FIXES_TAG",
-				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<=
title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
+				     "Please use correct Fixes: style 'Fixes: <12-16 chars of sha1> (=
\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
 				    $fix) {
 					$fixed[$fixlinenr] =3D "Fixes: $cid (\"$ctitle\")";
 				}
=2D-
2.39.0

