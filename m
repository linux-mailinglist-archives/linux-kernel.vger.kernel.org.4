Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25184683918
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjAaWMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAaWMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:12:14 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8087AA0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:11:57 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id o1so2416960ioo.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3AHumE1fvyGvCr+o0Dr5iJMZIqcLfB1X5OF/4ARAJI0=;
        b=XLc92KTLFH16GWDdNT7SHcpgmsqKSTsXGpGTVROSPUr50R2pM2xwoGkxBWjdWTFQTE
         2FMHAj1gqC1Q2FO8gq6W4tFeVk12oyDVgTOPedfm9ya9fiYnQGAjRWmbtNiRXCPjnjIZ
         IWMgfzqTot6rOvosvJ1nPHJb9GXVO4C+H0ymk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AHumE1fvyGvCr+o0Dr5iJMZIqcLfB1X5OF/4ARAJI0=;
        b=H83rOpHDon8UvKWYYL2byyjVMLw4AAGQWXrTbzpUX26B/qfm+R4aTW+2v7zwA5vt4j
         GS0S9I835/n1U2bI6A3GxFfaRY9GZv99ePHp2EZ0Qyiqcbfq6AwHrVyhq/aLuGR0bB5j
         +E5HSVjkDFSuHLY6+VxsoBYtVr7XP0uxua2/0C+UanePdLR+EWwcFiBjoOOHlMIiy1cL
         f/WTNjhjPTllHcSKs2eYO7jnxFjPC1Cs6q/O7wBG28X2LhhHSoggNYI9i1BGdxbPg88G
         89ejzN7jMOQX1YHAvgEco0w0IEtH8/LBfl4MfLkE0XjTAQ6deUVA2+XSjqV7b0X6jQ5d
         qBAw==
X-Gm-Message-State: AO0yUKXQC683nUXCElqgWhRfpIdxvMyTfdtQ1uDLc/W1ujrofxjdjJtr
        /b1N86V/CqiCHZiNivMfLw1vF/U3EvF3R28q
X-Google-Smtp-Source: AK7set9E1s+UnV2n8K+dF5WXu5/DxjKyFC7lpZeWFJedrFyuwHRVmMMD5yuyPg6X5btmitLTgj8kdQ==
X-Received: by 2002:a6b:5112:0:b0:719:6a2:99d8 with SMTP id f18-20020a6b5112000000b0071906a299d8mr119742iob.0.1675203115854;
        Tue, 31 Jan 2023 14:11:55 -0800 (PST)
Received: from localhost.localdomain ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05663819cb00b003b49e7d990asm837869jab.30.2023.01.31.14.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:11:55 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3] ver_linux: add missing software to checklist
Date:   Tue, 31 Jan 2023 15:11:54 -0700
Message-Id: <20230131221154.39291-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to add missing software checks to bring it in sync with the
Documentation/Changes list. Make improvements to the output with
separator between different sections.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v2: Fix extra line in usage

 scripts/ver_linux | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index 1a8ee4ff0e32..adef5dc67038 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -6,20 +6,29 @@
 # differ on your system.
 
 BEGIN {
-	usage = "If some fields are empty or look unusual you may have an old version.\n"
-	usage = usage "Compare to the current minimal requirements in Documentation/Changes.\n"
+	usage = "\nMinimum required software versions to build and run current kernel version.\n"
+	usage = usage "If some fields are empty or look unusual you may have an old version.\n"
+	usage = usage "Compare with the current minimal requirements in Documentation/Changes."
 	print usage
 
+	separator = "\n===================================================\n"
+
+	print separator
 	system("uname -a")
-	printf("\n")
 
 	vernum = "[0-9]+([.]?[0-9]+)+"
 	libc = "libc[.]so[.][0-9]+$"
 	libcpp = "(libg|stdc)[+]+[.]so([.][0-9]+)+$"
 
+	print separator
 	printversion("GNU C", version("gcc -dumpversion"))
+	printversion("Clang/LLVM (optional)", version("clang --version"))
+	printversion("Rust (optional)", version("rustc --version"))
+	printversion("bindgen (optional)", version("bindgen --version"))
 	printversion("GNU Make", version("make --version"))
+	printversion("bash", version("bash --version"))
 	printversion("Binutils", version("ld -v"))
+	printversion("pahole", version("pahole --version"))
 	printversion("Util-linux", version("mount --version"))
 	printversion("Mount", version("mount --version"))
 	printversion("Module-init-tools", version("depmod -V"))
@@ -28,6 +37,8 @@ BEGIN {
 	printversion("Reiserfsprogs", version("reiserfsck -V"))
 	printversion("Reiser4fsprogs", version("fsck.reiser4 -V"))
 	printversion("Xfsprogs", version("xfs_db -V"))
+	printversion("squashfs-tools", version("mksquashfs -version"))
+	printversion("btrfs-progs", version("mkfs.btrfs --version"))
 	printversion("Pcmciautils", version("pccardctl -V"))
 	printversion("Pcmcia-cs", version("cardmgr -V"))
 	printversion("Quota-tools", version("quota -V"))
@@ -36,7 +47,15 @@ BEGIN {
 	printversion("Nfs-utils", version("showmount --version"))
 	printversion("Bison", version("bison --version"))
 	printversion("Flex", version("flex --version"))
+	printversion("Grub", version("grub-install --version"))
+	printversion("mcelog", version("mcelog --version"))
+	printversion("iptables", version("iptables --version"))
+	printversion("openssl & libcrypto", version("openssl version"))
+	printversion("bc", version("bc --version"))
+	printversion("Sphinx (for doc builds)", version("sphinx-build --version"))
+	printversion("cpio", version("cpio --version"))
 
+	print separator
 	while ("ldconfig -p 2>/dev/null" | getline > 0)
 		if ($NF ~ libc || $NF ~ libcpp)
 			if (!seen[ver = version("readlink " $NF)]++)
@@ -51,11 +70,12 @@ BEGIN {
 	printversion("Udev", version("udevadm --version"))
 	printversion("Wireless-tools", version("iwconfig --version"))
 
+	print separator
 	while ("sort /proc/modules" | getline > 0) {
 		mods = mods sep $1
 		sep = " "
 	}
-	printversion("Modules Loaded", mods)
+	printversion("Modules Loaded:\n", mods)
 }
 
 function version(cmd,    ver) {
-- 
2.34.1

