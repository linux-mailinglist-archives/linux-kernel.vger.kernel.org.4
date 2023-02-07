Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F568CC72
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBGCKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjBGCKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:10:01 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296BB32E49
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:10:00 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id u75so2910975pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 18:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twi5qezXVrXvljZR32CwVOgUlBky4yiX5EIZlBsZGKM=;
        b=H605XTSNckRPIcJCYwimDOMlVudKiTi3+wYiqZL2TXofzkKxZDWCZxGHdo5/HU9qV+
         8ocrTdl9zRCSdKqDWczP7TWC7jEuq1foTSiVvsDPWkZIdJJCY2BT1dmoo2B9D2tdb89p
         Iuxr+UlYRvU3cl5QjB6VtKxs5AGSimX/1IGND4oJh3Gaie09kOvxHNRX6eDvgkXsDHDk
         DcMJMpgPcitw1yfjucm3NwMjtadnFBmNYrIOgPrk8IWKvnTuPTVgb7Rh9ZeKOX0cepB4
         rrCb1m6Vzi9hL2cALqfqMtT0YO6eZXG48bhJ4GlLMvzsJoabHeoQVczI+bxybF1tU7CB
         JDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twi5qezXVrXvljZR32CwVOgUlBky4yiX5EIZlBsZGKM=;
        b=FNI5LjdNS1Um6H3lTKeQvwby2m5f4hrfqxt/KmUZDVvDm3Kze6sLZzo5GBOPP2Jmup
         nq43ttKf/BHOb+9UgGiGWZ1ssCTRhRIbOSm6eYyl90aAuhgzlkL3T2C5OXdy7k5vXVQJ
         LmVubWtmGFKAQ1VBehj/0cUiHasTqh2K8EX7y3fPKRdPAimN5tr7DYoXo1jen5zf0BbZ
         libnLiakm9hJB/e2o+cN0yek329rD2WxCxVYvCv3ScVy+w/RiEECfcX1EaWNkQzn3F+6
         qYrQFfgcP6DMH/MZD1dAt1OMClqAYocUJ+tehmFIvknKcoTSJp8v4SEAP+jAP0NIgkTb
         bN+g==
X-Gm-Message-State: AO0yUKXF/2MWvYeHuaWYE+mBGYUqk7y/f6IEIZeAM9hxONHA6KVna3WW
        DwyeczZd56z0cdtGRCyMdbQ=
X-Google-Smtp-Source: AK7set/fGSroEhUgOMyTAVPr8nPJA37BY6oLlQW0JU++IFPWLNG8tgzXMupiCjYdYAYQfblhN8SYWw==
X-Received: by 2002:aa7:94ad:0:b0:58d:95aa:88a0 with SMTP id a13-20020aa794ad000000b0058d95aa88a0mr1373510pfl.24.1675735799379;
        Mon, 06 Feb 2023 18:09:59 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id d198-20020a621dcf000000b00593225b379dsm7843765pfd.106.2023.02.06.18.09.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Feb 2023 18:09:58 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, arnd@arndb.de,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] selftests/nolibc: Add support for LoongArch
Date:   Tue,  7 Feb 2023 10:09:42 +0800
Message-Id: <2d77fe4e895847ae1ea09088dcfa411ce2f57f5f.1675734681.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675734681.git.chenfeiyang@loongson.cn>
References: <cover.1675734681.git.chenfeiyang@loongson.cn>
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

From: Feiyang Chen <chenfeiyang@loongson.cn>

Add support for LoongArch (64 bit) to nolibc selftest.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 tools/testing/selftests/nolibc/Makefile | 78 +++++++++++++------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8fe61d3e3cce..ea2b82a3cd86 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -13,52 +13,56 @@ ARCH = $(SUBARCH)
 endif
 
 # kernel image names by architecture
-IMAGE_i386    = arch/x86/boot/bzImage
-IMAGE_x86_64  = arch/x86/boot/bzImage
-IMAGE_x86     = arch/x86/boot/bzImage
-IMAGE_arm64   = arch/arm64/boot/Image
-IMAGE_arm     = arch/arm/boot/zImage
-IMAGE_mips    = vmlinuz
-IMAGE_riscv   = arch/riscv/boot/Image
-IMAGE_s390    = arch/s390/boot/bzImage
-IMAGE         = $(IMAGE_$(ARCH))
-IMAGE_NAME    = $(notdir $(IMAGE))
+IMAGE_i386       = arch/x86/boot/bzImage
+IMAGE_x86_64     = arch/x86/boot/bzImage
+IMAGE_x86        = arch/x86/boot/bzImage
+IMAGE_arm64      = arch/arm64/boot/Image
+IMAGE_arm        = arch/arm/boot/zImage
+IMAGE_mips       = vmlinuz
+IMAGE_riscv      = arch/riscv/boot/Image
+IMAGE_s390       = arch/s390/boot/bzImage
+IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
+IMAGE            = $(IMAGE_$(ARCH))
+IMAGE_NAME       = $(notdir $(IMAGE))
 
 # default kernel configurations that appear to be usable
-DEFCONFIG_i386    = defconfig
-DEFCONFIG_x86_64  = defconfig
-DEFCONFIG_x86     = defconfig
-DEFCONFIG_arm64   = defconfig
-DEFCONFIG_arm     = multi_v7_defconfig
-DEFCONFIG_mips    = malta_defconfig
-DEFCONFIG_riscv   = defconfig
-DEFCONFIG_s390    = defconfig
-DEFCONFIG         = $(DEFCONFIG_$(ARCH))
+DEFCONFIG_i386       = defconfig
+DEFCONFIG_x86_64     = defconfig
+DEFCONFIG_x86        = defconfig
+DEFCONFIG_arm64      = defconfig
+DEFCONFIG_arm        = multi_v7_defconfig
+DEFCONFIG_mips       = malta_defconfig
+DEFCONFIG_riscv      = defconfig
+DEFCONFIG_s390       = defconfig
+DEFCONFIG_loongarch  = defconfig
+DEFCONFIG            = $(DEFCONFIG_$(ARCH))
 
 # optional tests to run (default = all)
 TEST =
 
 # QEMU_ARCH: arch names used by qemu
-QEMU_ARCH_i386    = i386
-QEMU_ARCH_x86_64  = x86_64
-QEMU_ARCH_x86     = x86_64
-QEMU_ARCH_arm64   = aarch64
-QEMU_ARCH_arm     = arm
-QEMU_ARCH_mips    = mipsel  # works with malta_defconfig
-QEMU_ARCH_riscv   = riscv64
-QEMU_ARCH_s390    = s390x
-QEMU_ARCH         = $(QEMU_ARCH_$(ARCH))
+QEMU_ARCH_i386       = i386
+QEMU_ARCH_x86_64     = x86_64
+QEMU_ARCH_x86        = x86_64
+QEMU_ARCH_arm64      = aarch64
+QEMU_ARCH_arm        = arm
+QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
+QEMU_ARCH_riscv      = riscv64
+QEMU_ARCH_s390       = s390x
+QEMU_ARCH_loongarch  = loongarch64
+QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
 
 # QEMU_ARGS : some arch-specific args to pass to qemu
-QEMU_ARGS_i386    = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_x86_64  = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_x86     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_arm64   = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_arm     = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_mips    = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_riscv   = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_s390    = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS         = $(QEMU_ARGS_$(ARCH))
+QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS            = $(QEMU_ARGS_$(ARCH))
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
-- 
2.39.0

