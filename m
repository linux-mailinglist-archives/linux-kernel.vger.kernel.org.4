Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BA5664D95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjAJUmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjAJUm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:42:29 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7B34C726
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:42:28 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id v65so2438448ioe.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtVKtP8Lxx7daYgqOcXdWIZVvJLt1nqV/FZcrxkRzTQ=;
        b=bQs+qgvCvhQLdUaXZHf8iUel8bbVyAXacC8l0s406r1NvuXxtOLwCXZHqA7qqecjvs
         VgEYnE/7+F3nXkoxu0yNjMyIAPUgTxWVlqA3W/uNNbKq/CLziZBMt+Xb5nRQzts/y+hk
         eQ9cx+yqfVjMK9OmzdULg0kulzjAcRIUSwhTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtVKtP8Lxx7daYgqOcXdWIZVvJLt1nqV/FZcrxkRzTQ=;
        b=YmJCNpj3itlz/tu/fJToD/rv4Jr7dGnR4HL+X+5YurUrixNOT1dkrC5SqwxAizEkdc
         XMhGYKgMcbKrqcapUg+mE4d9b46tYD+YfALcnxtnPDbRLv24I77I6SAr5JRdrrHRtWZC
         Rk0ritAJ4xC2mGQ1vLZO8deR7NyfCiaAK4NzgbDdKZQmx8950Rrf5jdNGQlEdywk1PzF
         8wvFcZlPoK7RmWqQ23Z/+ZM87LCMZeToz+jol2VvYaNLNxOj3S0dxI0ELQm9B+3AbwGl
         s1plLkjMHMv8OE+E+DLTmOFJ7Pi9chIVe3vrSCYaH7pqmr93VnWPRQBMCwDMXcqAZhj5
         n5Mw==
X-Gm-Message-State: AFqh2kprhU3dPq8AewumV40n21LRKRHa4Bi+nXOG3g61/tJujW/AZfG/
        k5OS4Y82+kMYUBtpvgqnfqdTRplRGgWcAEf8
X-Google-Smtp-Source: AMrXdXsEXy2UQ71cXJCRowOPf/GvRHEN5XkyS1EoNEp0o2BuxmcPxMDuv/iDf79g9SMyfvJ/VrNTFQ==
X-Received: by 2002:a6b:410f:0:b0:6e2:d6ec:21f8 with SMTP id n15-20020a6b410f000000b006e2d6ec21f8mr9742544ioa.2.1673383347822;
        Tue, 10 Jan 2023 12:42:27 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q25-20020a02a999000000b0038a360671adsm4023038jam.27.2023.01.10.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 12:42:27 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] ver_linux: add missing software to checklist
Date:   Tue, 10 Jan 2023 13:42:25 -0700
Message-Id: <20230110204225.35503-1-skhan@linuxfoundation.org>
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
 scripts/ver_linux | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index 1a8ee4ff0e32..6131f6f1b35b 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -6,10 +6,14 @@
 # differ on your system.
 
 BEGIN {
-	usage = "If some fields are empty or look unusual you may have an old version.\n"
-	usage = usage "Compare to the current minimal requirements in Documentation/Changes.\n"
+	usage = "Minimum required software versions to build and run current kernel version.\n"
+	usage = usage "If some fields are empty or look unusual you may have an old version.\n"
+	usage = usage "Compare with the current minimal requirements in Documentation/Changes.\n"
 	print usage
 
+	separator = "===================================================\n"
+
+	print separator
 	system("uname -a")
 	printf("\n")
 
@@ -17,9 +21,15 @@ BEGIN {
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
@@ -28,6 +38,8 @@ BEGIN {
 	printversion("Reiserfsprogs", version("reiserfsck -V"))
 	printversion("Reiser4fsprogs", version("fsck.reiser4 -V"))
 	printversion("Xfsprogs", version("xfs_db -V"))
+	printversion("squashfs-tools", version("mksquashfs -version"))
+	printversion("btrfs-progs", version("mkfs.btrfs --version"))
 	printversion("Pcmciautils", version("pccardctl -V"))
 	printversion("Pcmcia-cs", version("cardmgr -V"))
 	printversion("Quota-tools", version("quota -V"))
@@ -36,7 +48,16 @@ BEGIN {
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
+	printf("\n")
 
+	print separator
 	while ("ldconfig -p 2>/dev/null" | getline > 0)
 		if ($NF ~ libc || $NF ~ libcpp)
 			if (!seen[ver = version("readlink " $NF)]++)
@@ -50,12 +71,14 @@ BEGIN {
 	printversion("Sh-utils", version("expr --v"))
 	printversion("Udev", version("udevadm --version"))
 	printversion("Wireless-tools", version("iwconfig --version"))
+	printf("\n")
 
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

