Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DF25E7910
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiIWLG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIWLGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:06:24 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B9C1176ED
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:06:22 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id u28so7994711qku.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=sTF6dQakgPpXr5iVRpqW1hla4CNVgTWr0VvcWgxpoec=;
        b=JplPongremwXfMLNMuFB9TRiXndsKpa20Si/rBZJExuW8d2I8wkjfDhjjPYTcwrJX9
         EHEtdGe3dYCok9azXtooPkn+ef3dHY9umZcxXgkri4OT/CwLS/PNs28YOAaencl50C6T
         UxOt83dqJE6uiOA+f/tvKMaRrlmoqaaVtWZTEWr7WyLcKqYgZt71SV5xLAwCj/cyXrCF
         uW04wPD0Q5P97bi8UulSpHp074fhDCSXRp1/1rs59Osf2iHSzY1n6iaw82YwlgaDE2qw
         n7NCtlFbKN5HJqfxH3f26dO/JpT7lq6DZnXtASDqLSN/w+HhwkZdK1+qnnyGlh1NMVBs
         HjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=sTF6dQakgPpXr5iVRpqW1hla4CNVgTWr0VvcWgxpoec=;
        b=iM2PM75G7VMtqFeupun+Z0M5qOdEIPv6I4qU5E09g6z4BzRq+BSx5XRv4qcKAircj/
         GNsX88I+ZW+ht6rEGWKKhvQgBm57XVZtg0EmDmJBldvjH3A2FpP+a71zehVUDd3kMo/i
         LHf088X5DX9/4zbWWdYJQagomBnKCxo/ylO/XJpS0ib8taEsZmYLTFi2ogfZkJqijEnn
         bmNGFyUCaERoqeAQaGWUgojqzhKwEhdehnoJO/4NanXmU2bPmfe/A8BThTw2E4zrfo4/
         B54LoSB785cbC+D1G05LmtB8sN4YQbLpZBJJML4/6vP0ch2Prpn22Ghr/NTaHdVd9OSe
         53Dw==
X-Gm-Message-State: ACrzQf2MkF6g8jF3bF3IlF3/ZewvhnEe05mUi0CjfbjEV04sA4zBZCd8
        t2ZDOMYonGcHgBkmDwE/Z32zzRcHto8yAg==
X-Google-Smtp-Source: AMsMyM5lb2LvBdnigMd7hllUOPEPao8jlNwyP6bwRJRTIolZLgXUzmG841seTQ6rWJkiIDIezzBsGw==
X-Received: by 2002:a05:620a:2785:b0:6ce:7dc2:2b2 with SMTP id g5-20020a05620a278500b006ce7dc202b2mr5113978qkp.395.1663931181444;
        Fri, 23 Sep 2022 04:06:21 -0700 (PDT)
Received: from localhost.localdomain ([154.16.192.108])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a244700b006ce7316f361sm5694313qkn.118.2022.09.23.04.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 04:06:21 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     masahiroy@kernel.org, unixbhaskar@gmail.com,
        danielmentz@google.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel:gen_kheaders:Replace md5sum to sha256sum
Date:   Fri, 23 Sep 2022 16:33:32 +0530
Message-Id: <20220923110332.24090-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thought to apply a better encryption mechanism.

Replace all occurance of md5sum to sha256sum .

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/gen_kheaders.sh | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 0c78e64f747d..1abf2d83039c 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -3,6 +3,7 @@

 # This script generates an archive consisting of kernel headers
 # for CONFIG_IKHEADERS.
+# Replace md5sum to sha256sum
 set -e
 sfile="$(readlink -f "$0")"
 outdir="$(pwd)"
@@ -37,22 +38,22 @@ all_dirs="$all_dirs $dir_list"
 # When Kconfig regenerates include/generated/autoconf.h, its timestamp is
 # updated, but the contents might be still the same. When any CONFIG option is
 # changed, Kconfig touches the corresponding timestamp file include/config/*.
-# Hence, the md5sum detects the configuration change anyway. We do not need to
+# Hence, the sha256sum detects the configuration change anyway. We do not need to
 # check include/generated/autoconf.h explicitly.
 #
-# Ignore them for md5 calculation to avoid pointless regeneration.
-headers_md5="$(find $all_dirs -name "*.h"			|
+# Ignore them for sha256 calculation to avoid pointless regeneration.
+headers_sha256="$(find $all_dirs -name "*.h"			|
 		grep -v "include/generated/compile.h"	|
 		grep -v "include/generated/autoconf.h"	|
-		xargs ls -l | md5sum | cut -d ' ' -f1)"
+		xargs ls -l | sha256sum| cut -d ' ' -f1)"

 # Any changes to this script will also cause a rebuild of the archive.
-this_file_md5="$(ls -l $sfile | md5sum | cut -d ' ' -f1)"
-if [ -f $tarfile ]; then tarfile_md5="$(md5sum $tarfile | cut -d ' ' -f1)"; fi
-if [ -f kernel/kheaders.md5 ] &&
-	[ "$(head -n 1 kernel/kheaders.md5)" = "$headers_md5" ] &&
-	[ "$(head -n 2 kernel/kheaders.md5 | tail -n 1)" = "$this_file_md5" ] &&
-	[ "$(tail -n 1 kernel/kheaders.md5)" = "$tarfile_md5" ]; then
+this_file_sha256="$(ls -l $sfile | sha256sum| cut -d ' ' -f1)"
+if [ -f $tarfile ]; then tarfile_sha256="$(sha256sum $tarfile | cut -d ' ' -f1)"; fi
+if [ -f kernel/kheaders.sha256 ] &&
+	[ "$(head -n 1 kernel/kheaders.sha256)" = "$headers_sha256" ] &&
+	[ "$(head -n 2 kernel/kheaders.sha256 | tail -n 1)" = "$this_file_sha256" ] &&
+	[ "$(tail -n 1 kernel/kheaders.sha256)" = "$tarfile_sha256" ]; then
 		exit
 fi

@@ -88,8 +89,8 @@ find $cpio_dir -printf "./%P\n" | LC_ALL=C sort | \
     --owner=0 --group=0 --numeric-owner --no-recursion \
     -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null

-echo $headers_md5 > kernel/kheaders.md5
-echo "$this_file_md5" >> kernel/kheaders.md5
-echo "$(md5sum $tarfile | cut -d ' ' -f1)" >> kernel/kheaders.md5
+echo $headers_sha256 > kernel/kheaders.sha256
+echo "$this_file_sha256" >> kernel/kheaders.sha256
+echo "$(sha256sum $tarfile | cut -d ' ' -f1)" >> kernel/kheaders.sha256

 rm -rf $cpio_dir
--
2.35.1

