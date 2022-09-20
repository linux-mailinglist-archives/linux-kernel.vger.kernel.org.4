Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFE5BEC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiITRfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiITRf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:35:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1796746D9F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:35:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lh5so7878950ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=q3ItRxAU/BxmLQ4LgAu2LZCds3bc6ZWDAT8CVSuBctA=;
        b=L7MGMS5Vt/CFqXHz2tNq5GjrmRDNs2FHaP3oHkoVigpYySA2PiuSES/U9tKioSrzBD
         LR/Yq4K8iTlbnaDydJMhUNVB1zElGo/lje8Zfg3RWnjwVIzh6RfQQgSYZMAgoA89JzEb
         I3QSpNmqSN3yeTdWaxbAYv1Q93MXaaXNEU+u0kYmRGSoSLvOoJqNqj4b4HHC3XUsR2Zb
         fWqcI3HCmQ/orbL3oshYY2hsyILX0234gLAO6peP+daaWTRUu8DZGliXyaSRRmU8VqTt
         WSESYc7m9Tnd1T73ycKa3KiTQIDKkO+9LdTKBm5GRoxk/aC7BfRQX87vKeay8vzkwIJR
         RXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q3ItRxAU/BxmLQ4LgAu2LZCds3bc6ZWDAT8CVSuBctA=;
        b=o0K6VV/Xy8DZnpn8mZ4p/9WyEg17n4S77NyFlVD7GoMTxSeXuppIFbYm0WEBw4ol0b
         qEgvIG/AIV9Lb+fPIWgaqwo17yvXCa/esTZEkOS1x0NHuC8nV5EMdJq/UJstBUfMR+Du
         Gj51k/tyFy5rdziG+ZyRp71brLTI0NrCZPltiqEpiRbgYV/GmFYMEjG93tFA7ckat3XW
         /WEXtS9qfHkLkMcBQO/4LAkvbwtAhbDkEvTozNfxFu9qBHpbmXulXcEPKAOw2YUDNqkZ
         3MCehVELLYvpBo9ahZkBx4Pa+oDeHWbAMV/bKHrAACoBdXDE3r8VJ2ZiEBO2jw16754w
         1lXg==
X-Gm-Message-State: ACrzQf1UNZUZfBN7e9OijBdBNIpeOymSqjoDo8bXuT7yuo3J00IL3A71
        0nU/5C+ZaYG7ZTAe3DFN6xgromCiIQ==
X-Google-Smtp-Source: AMsMyM4rLL8K5sid/7uiFqINM4gT7UcvR6j8C8YClaQEY7G1y689ZNiNu39HIs3Cv9kd6PoOImgpWQ==
X-Received: by 2002:a17:907:2cce:b0:77a:6958:5aaa with SMTP id hg14-20020a1709072cce00b0077a69585aaamr17505452ejc.245.1663695325547;
        Tue, 20 Sep 2022 10:35:25 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.206])
        by smtp.gmail.com with ESMTPSA id d24-20020a056402001800b004511957d075sm181960edu.80.2022.09.20.10.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 10:35:24 -0700 (PDT)
Date:   Tue, 20 Sep 2022 20:35:23 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: mark more files as permanent
Message-ID: <Yyn527DzDMa+r0Yj@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark
	/proc/devices
	/proc/kpagecount
	/proc/kpageflags
	/proc/kpagecgroup
	/proc/loadavg
	/proc/meminfo
	/proc/softirqs
	/proc/uptime
	/proc/version

as permanent /proc entries, saving alloc/free and some
list/spinlock ops per use.

These files are never removed by the kernel so it is OK
to mark them.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/devices.c  |    6 +++++-
 fs/proc/internal.h |    5 +++++
 fs/proc/loadavg.c  |    6 +++++-
 fs/proc/meminfo.c  |    5 ++++-
 fs/proc/page.c     |    3 +++
 fs/proc/softirqs.c |    6 +++++-
 fs/proc/uptime.c   |    6 +++++-
 fs/proc/version.c  |    6 +++++-
 8 files changed, 37 insertions(+), 6 deletions(-)

--- a/fs/proc/devices.c
+++ b/fs/proc/devices.c
@@ -4,6 +4,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
+#include "internal.h"
 
 static int devinfo_show(struct seq_file *f, void *v)
 {
@@ -54,7 +55,10 @@ static const struct seq_operations devinfo_ops = {
 
 static int __init proc_devices_init(void)
 {
-	proc_create_seq("devices", 0, NULL, &devinfo_ops);
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_seq("devices", 0, NULL, &devinfo_ops);
+	pde_make_permanent(pde);
 	return 0;
 }
 fs_initcall(proc_devices_init);
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -79,6 +79,11 @@ static inline bool pde_is_permanent(const struct proc_dir_entry *pde)
 	return pde->flags & PROC_ENTRY_PERMANENT;
 }
 
+static inline void pde_make_permanent(struct proc_dir_entry *pde)
+{
+	pde->flags |= PROC_ENTRY_PERMANENT;
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -9,6 +9,7 @@
 #include <linux/seq_file.h>
 #include <linux/seqlock.h>
 #include <linux/time.h>
+#include "internal.h"
 
 static int loadavg_proc_show(struct seq_file *m, void *v)
 {
@@ -27,7 +28,10 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
 
 static int __init proc_loadavg_init(void)
 {
-	proc_create_single("loadavg", 0, NULL, loadavg_proc_show);
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_single("loadavg", 0, NULL, loadavg_proc_show);
+	pde_make_permanent(pde);
 	return 0;
 }
 fs_initcall(proc_loadavg_init);
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -162,7 +162,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 static int __init proc_meminfo_init(void)
 {
-	proc_create_single("meminfo", 0, NULL, meminfo_proc_show);
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_single("meminfo", 0, NULL, meminfo_proc_show);
+	pde_make_permanent(pde);
 	return 0;
 }
 fs_initcall(proc_meminfo_init);
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -91,6 +91,7 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 }
 
 static const struct proc_ops kpagecount_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_lseek	= mem_lseek,
 	.proc_read	= kpagecount_read,
 };
@@ -268,6 +269,7 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
 }
 
 static const struct proc_ops kpageflags_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_lseek	= mem_lseek,
 	.proc_read	= kpageflags_read,
 };
@@ -322,6 +324,7 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
 }
 
 static const struct proc_ops kpagecgroup_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_lseek	= mem_lseek,
 	.proc_read	= kpagecgroup_read,
 };
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -3,6 +3,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include "internal.h"
 
 /*
  * /proc/softirqs  ... display the number of softirqs
@@ -27,7 +28,10 @@ static int show_softirqs(struct seq_file *p, void *v)
 
 static int __init proc_softirqs_init(void)
 {
-	proc_create_single("softirqs", 0, NULL, show_softirqs);
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_single("softirqs", 0, NULL, show_softirqs);
+	pde_make_permanent(pde);
 	return 0;
 }
 fs_initcall(proc_softirqs_init);
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -7,6 +7,7 @@
 #include <linux/time.h>
 #include <linux/time_namespace.h>
 #include <linux/kernel_stat.h>
+#include "internal.h"
 
 static int uptime_proc_show(struct seq_file *m, void *v)
 {
@@ -39,7 +40,10 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 
 static int __init proc_uptime_init(void)
 {
-	proc_create_single("uptime", 0, NULL, uptime_proc_show);
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_single("uptime", 0, NULL, uptime_proc_show);
+	pde_make_permanent(pde);
 	return 0;
 }
 fs_initcall(proc_uptime_init);
--- a/fs/proc/version.c
+++ b/fs/proc/version.c
@@ -5,6 +5,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/utsname.h>
+#include "internal.h"
 
 static int version_proc_show(struct seq_file *m, void *v)
 {
@@ -17,7 +18,10 @@ static int version_proc_show(struct seq_file *m, void *v)
 
 static int __init proc_version_init(void)
 {
-	proc_create_single("version", 0, NULL, version_proc_show);
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_single("version", 0, NULL, version_proc_show);
+	pde_make_permanent(pde);
 	return 0;
 }
 fs_initcall(proc_version_init);
