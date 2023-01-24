Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1486467A423
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjAXUnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjAXUnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:43:47 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B654ED37
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:43:29 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q130so7639588iod.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIlqV9Qpz6oByYh5hQgQTaqP4XgG1W2NO/yu5mL2pGE=;
        b=SjnXhaDQRRIJXtQ7Eslf9Q4kxz7Ng8YX89Dbm37Q+x2/lK1OF5AVb84hOOw8pde9Uu
         XZHVZLqIpRyYO8E4YbnoNwpeZQrU0Sna2cg1ePzwKKo5Ma5ixUtRR0hx7cmoHj/DOK6R
         x7Koh35sqtrvkv+HWEx+3xg5R6OIwsP9e3H6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIlqV9Qpz6oByYh5hQgQTaqP4XgG1W2NO/yu5mL2pGE=;
        b=553hbdRZ0tPk/+qf5fDDSRfCMtZEkxG08wJdOGkSAc9gsSjVKy9OjpqHQ2jimohQbz
         cO1xEFV4s8y6gTJFvPgqeHFg3AEQZtJxUSU12qhDWiDx0dzjyafyT2dpF7ySIZ0s18gv
         L7WYed1KlzwKDBsHSd02Jzf7LxMYXW4OgVlTYjZ4atw892cZngrXYn9PiWEm7qrUXicy
         BSRUIWDcoZUID0h9lkPy+p3AEeAO748E7M86vrnHKjn92EtkGJNdsCvMF+hwi222yb2/
         GzfC22IK2m1fQqd/aC5Bf//8ZcCj8oTSOoecOaucmNRd9XrCWwZg9Rz6a5aIHVz/xGpx
         pwAQ==
X-Gm-Message-State: AFqh2krqy7+Evl27vA3ldz8NC62eXUpxFQDlm15mMYi30dRzRp5XvaFN
        xjnfI1xXLhAsztf8BpW16gsjAxP0TxmnaDb2
X-Google-Smtp-Source: AMrXdXs1RIhoQAmh7aTC4gfVyBvxH+Z/I//Hmk3J8r5dE+jZvzntWqViFBzdynP7Ek2QSsSY4ONJ0Q==
X-Received: by 2002:a5d:875a:0:b0:707:d0c0:1bd6 with SMTP id k26-20020a5d875a000000b00707d0c01bd6mr887780iol.1.1674593008142;
        Tue, 24 Jan 2023 12:43:28 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l9-20020a05663814c900b0039db6cffcbasm990758jak.71.2023.01.24.12.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:43:26 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2] ver_linux: add missing software to checklist
Date:   Tue, 24 Jan 2023 13:43:24 -0700
Message-Id: <20230124204324.33858-1-skhan@linuxfoundation.org>
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
Changes since v1: addressed review comments

 scripts/ver_linux | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index 1a8ee4ff0e32..2daee7e88c45 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -6,20 +6,29 @@
 # differ on your system.
 
 BEGIN {
-	usage = "If some fields are empty or look unusual you may have an old version.\n"
-	usage = usage "Compare to the current minimal requirements in Documentation/Changes.\n"
+	usage = "Minimum required software versions to build and run current kernel version.\n"
+	usage = usage "If some fields are empty or look unusual you may have an old version.\n"
+	usage = usage "Compare with the current minimal requirements in Documentation/Changes.\n"
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

