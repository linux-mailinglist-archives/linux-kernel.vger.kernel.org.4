Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D6F641A92
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 04:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLDDGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 22:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDDGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 22:06:17 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EDB1902D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 19:06:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d14so6422189edj.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 19:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EYa2YFejNE74kwzhMWHKbDynFgjd7/682X+VrPAEeAE=;
        b=gK5k1ZBtmCRohEwZrR0qt0vBYngBNq8VMun0vybDt6OF++pzAtZJBfZrOLlXb04UEG
         sfYpcwWjLcicdWk2irM3w9ulrklkiZGrSToa6yBq/XNdXtfTp9oEBygsElvzBDQm56t5
         VkDcl6AVCr64r8LreOE2EcAgqb2wM05iw7Euj25TZ/vvU15yMR4jsFLkQ9RCNxjRrrkx
         LGHh7eNyJvQuXHYrqHQM8qT3GRsF2XwlYzjiZEJCgieWwW+jZJ/QaXmCjUv5TOA3+nA2
         swL4a20003u1D0ZNFdG7624gItMV55lJbR5Le7lzpIJzV/NuiAK81Zjt+oLZkzb6v3fA
         RqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EYa2YFejNE74kwzhMWHKbDynFgjd7/682X+VrPAEeAE=;
        b=dn4rc4M4iFW7Q1M0+kaOgHYbO9zXd78/qj9C+i/bDKcSXgb6YBnajllpcvcS1GLQ3w
         vGsbny2znZhg07vRNCJJsFEe/EdWyYqTzGy0FPuqG+h9ibSyI1nwwmog+fqj3M514zOk
         daM+qNAJgYQepgjr45jNttBL3/JbIxuoHjMwZcrwc4DOfqAsmk6oD3i8XETYnfgHQBKA
         Wqobc8rHQefgYSrs/7+zhl5UhXghTfiJH1HMBjkGpqht7IcqAfCS6pdieeZ0WXrwQMKm
         s0DxXFNuOzT1LCV2ez64svxWs8PTx1njZfaDoKRvmEJf/dId201ZGjQf9Kgkpmq/necX
         r+Lg==
X-Gm-Message-State: ANoB5pnCHkl+WNKCPGPKjEN/CtMzKmKbR8CJKghMeG/02sHRU3yof6Bs
        BrR+gBexSAZReVUe0ruQLBBd4sv6/G2N4hQCFsrWTEiUCwk=
X-Google-Smtp-Source: AA0mqf613KLoEJYymi+2W1nXb7IzDwxmxw2eioUbxwfS7vDez/tp4zso1p5B/Kjjlfl56VbC7+7M5S1awk2UA5oLvqM=
X-Received: by 2002:a05:6402:143:b0:463:f8aa:d2bf with SMTP id
 s3-20020a056402014300b00463f8aad2bfmr69933534edu.358.1670123174155; Sat, 03
 Dec 2022 19:06:14 -0800 (PST)
MIME-Version: 1.0
From:   Zopolis0 <creatorsmithmdt@gmail.com>
Date:   Sun, 4 Dec 2022 14:06:06 +1100
Message-ID: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
Subject: PATCH [1/2] gamecube/wii: graphic quantization registers driver (GQR)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----NOT PART OF PATCH----
I'm sending this to the open mailing list because get_maintainer.pl
couldn't come up with anything better.

Anyways, just upstreaming
https://github.com/Zopolis4/gc-linux/commit/e6829693235dda1c494737e28542de2711ce0055,
with the second fix to come.

I've left the commits intact, as they were already signed off. If
there were bug fixes, I would have sent them as an additional patch,
which I will probably do for the other patches to upstream.

These patches don't depend on any other patches that need to be
upstreamed, unlike many of the other gc-linux patches.
----NOT PART OF PATCH----

From 7c625cb05dd90f29ce310c598dc84a195ca52b9f Mon Sep 17 00:00:00 2001
From: Albert Herranz <albert_herranz@yahoo.es>
Date: Thu, 22 Jan 2009 20:31:39 +0100
Subject: [PATCH 1/2] gamecube/wii: graphic quantization registers driver (GQR)

Add support for accessing the Graphic Quantization Registers of the
Nintendo GameCube and Wii video game consoles PowerPC processor via
the proc filesystem.

The Graphic Quantization Registers can be used to influence how the
psql* and psqst* instructions operate.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/misc/Kconfig   |   9 +++
 drivers/misc/Makefile  |   1 +
 drivers/misc/gcn-gqr.c | 129 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 drivers/misc/gcn-gqr.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 358ad56f6524..83525024c5ee 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -57,6 +57,15 @@ config DUMMY_IRQ
    The sole purpose of this module is to help with debugging of systems on
    which spurious IRQs would happen on disabled IRQ vector.

+config GAMECUBE_GQR
+ tristate "Nintendo GameCube/Wii Graphic Quantization Registers (GQR)"
+ depends on GAMECUBE_COMMON
+ help
+          This option enables device driver support for the Gekko/Broadway
+   processors' Graphic Quantization Registers.
+   These registers are used with the psql and psqst instructions.
+   The registers will appear in /proc/sys/gqr.
+
 config IBM_ASM
  tristate "Device driver for IBM RSA service processor"
  depends on X86 && PCI && INPUT
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ac9b3e757ba1..cebdac81a336 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_SENSORS_TSL2550) += tsl2550.o
 obj-$(CONFIG_DS1682) += ds1682.o
 obj-$(CONFIG_C2PORT) += c2port/
 obj-$(CONFIG_HMC6352) += hmc6352.o
+obj-$(CONFIG_GAMECUBE_GQR) += gcn-gqr.o
 obj-y += eeprom/
 obj-y += cb710/
 obj-$(CONFIG_VMWARE_BALLOON) += vmw_balloon.o
diff --git a/drivers/misc/gcn-gqr.c b/drivers/misc/gcn-gqr.c
new file mode 100644
index 000000000000..66482653f8ef
--- /dev/null
+++ b/drivers/misc/gcn-gqr.c
@@ -0,0 +1,129 @@
+/*
+ * drivers/misc/gcn-gqr.c
+ *
+ * Nintendo GameCube GQR driver
+ * Copyright (C) 2004-2009 The GameCube Linux Team
+ * Copyright (C) 2004 Todd Jeffreys <todd@voidpointer.org>
+ * Copyright (C) 2007,2008,2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/ctype.h>
+#include <linux/sysctl.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+static u32 gqr_values[8];
+static struct ctl_table_header *gqr_table_header;
+
+#define SPR_GQR0 912
+#define SPR_GQR1 913
+#define SPR_GQR2 914
+#define SPR_GQR3 915
+#define SPR_GQR4 916
+#define SPR_GQR5 917
+#define SPR_GQR6 918
+#define SPR_GQR7 919
+
+#define MFSPR_CASE(i) case (i): (*((u32 *)table->data) = mfspr(SPR_GQR##i))
+#define MTSPR_CASE(i) case (i): mtspr(SPR_GQR##i, *((u32 *)table->data))
+
+static int proc_dogqr(ctl_table *table, int write, struct file *file,
+       void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+ int r;
+
+ if (!write) { /* if they are reading, update the variable */
+ switch (table->data - (void *)gqr_values) {
+ MFSPR_CASE(0); break;
+ MFSPR_CASE(1); break;
+ MFSPR_CASE(2); break;
+ MFSPR_CASE(3); break;
+ MFSPR_CASE(4); break;
+ MFSPR_CASE(5); break;
+ MFSPR_CASE(6); break;
+ MFSPR_CASE(7); break;
+ default:
+ return -EFAULT; /* shouldn't happen */
+ }
+ }
+
+ r = proc_dointvec(table, write, file, buffer, lenp, ppos);
+
+ if ((r == 0) && write) {  /* if they are writing, update the reg */
+ switch (table->data - (void *)gqr_values) {
+ MTSPR_CASE(0); break;
+ MTSPR_CASE(1); break;
+ MTSPR_CASE(2); break;
+ MTSPR_CASE(3); break;
+ MTSPR_CASE(4); break;
+ MTSPR_CASE(5); break;
+ MTSPR_CASE(6); break;
+ MTSPR_CASE(7); break;
+ default:
+ return -EFAULT; /* shouldn't happen */
+ }
+ }
+
+ return r;
+}
+
+#define DECLARE_GQR(i) {  \
+ .ctl_name     = CTL_UNNUMBERED,       \
+ .procname     = "gqr" #i,         \
+ .data         = gqr_values + i,   \
+ .maxlen       = sizeof(int),      \
+ .mode         = 0644,             \
+ .proc_handler = &proc_dogqr       \
+ }
+
+static ctl_table gqr_members[] = {
+ DECLARE_GQR(0),
+ DECLARE_GQR(1),
+ DECLARE_GQR(2),
+ DECLARE_GQR(3),
+ DECLARE_GQR(4),
+ DECLARE_GQR(5),
+ DECLARE_GQR(6),
+ DECLARE_GQR(7),
+ { .ctl_name = 0 }
+};
+
+static ctl_table gqr_table[] = {
+ {
+ .ctl_name = CTL_UNNUMBERED,
+ .procname = "gqr",
+ .mode     = 0555,
+ .child    = gqr_members,
+ },
+ { .ctl_name = 0 }
+};
+
+int __init gcngqr_init(void)
+{
+ gqr_table_header = register_sysctl_table(gqr_table);
+ if (!gqr_table_header) {
+ printk(KERN_ERR "Unable to register GQR sysctl table\n");
+ return -ENOMEM;
+ }
+ return 0;
+}
+
+void __exit gcngqr_exit(void)
+{
+ unregister_sysctl_table(gqr_table_header);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Todd Jeffreys <todd@voidpointer.org>");
+module_init(gcngqr_init);
+module_exit(gcngqr_exit);
-- 
2.38.1
