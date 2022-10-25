Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3328860D3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiJYSp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiJYSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:45:34 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D23E495D6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723531; bh=vaNHeu+uBrJ/jXIPtDlBaZHKQlALl1G+dML+hKWuQRo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iMMEG0wJa4SfMXdRJKMN8J7PN9/SIJvKYP9TVEVv1io0mphxnIph53Ni26K/zR+zVeLqUgZHXSubUCad4p1Czb3jQIl7ROnRtNtLlQiVqFM08NeoqsyN/YdsJz4oTCY0f+njCFiDAuAOgB9Z88S/yP5jzIsOQ94D2vk46U4QdR1jAmh/xYGu9VMdI5R1p72dc8ig1vifUprWPqB6H40FEvn8kMt/LhEqyrjcDLauXBtknM4jw9RJoZvoSRgKRnewONxHSTXdjxAqNkh/6KWZPwalQHcZh92or7FVVTSBKFpsGh59aGRrjt6ioplACRt4QLLvmEPDmGM4C+P0oq4D5w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723531; bh=85isr1awwlY2VeM0BK5wNTk3zDRa0JtRBNDGKL13Mq6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AUykBW1y2GjLIGDw13vTSYWVR3bQl/t19vS/Nm2SoNg1BTkK2EPJwnMykRGYvhw34lJkISFf4/F/BgfQqv5oWEoXWbFUiQ9NF4n+5BJl05E1TDER0IRC24or8p64y4B13SS74XobnWFtvS1fxGtz8gW0tggf9N3dcGARZa0J9AvvBMmlY8+cl2t+tG2TNl17TLSTPZFT2o3zhCJpziH10oCJHagFYjrdW5+W9MxtAUe0/c9+GHDdUtHUtVQcHUaywuJ7sjdOAcu98YLiMRNn7PQMtWHgB5RA4I3D0oy6QRBbO3nwOSW5IZmGa6WWCJ59iJxSDlZ16PvHM6K6PTH8oA==
X-YMail-OSG: Bl4ACdkVM1kHeHDYatofCBccP9gAU_TU5WJGB00POj8tpMfZ.qngYQQFiICWS_H
 43u83w2l6ib_s6dp2DRY9yO8IauyWAaYTC6NSkq8JXu83VFwDT4whXqwasGD.Mb5uYS7gvouzu58
 BLVY7Ligw28YnKCABy8MbQZCiRhVTSh3RtNBXsoyEh6FIquBUvM6VSqhnJYVmRPnXY7tD44GEOco
 qzIARaU_V6zo7hye2mE4SREv9rEcRYYBs07IQ3iYqB9zBEO.2_q9neLSoil.6DbXuC_X_Xf3UIjv
 5b5wGxhuXv4gIJPGguZIsO.pSAnjybx9llW9rT1SP92a7dG1oI1HMDqgGDXwqpx2dpFNxTEMJQgc
 Wnau7KaQS3Cz.mGKEq7Dh0rd3JQzZy9PIqZKP7GY1yZPN5KnM5EQXoHdwEbco7D.hI8NXLpMcO_c
 Mqxdhd3cQRwwaNBtTR0fvO7_xnlCguXXjreeaqwNXL2x5h7EiM5KeivWUpgllO8bbnxGuCrzulTg
 Sx0YJQyNXE2sdccghE.GY9zbV8S88EcbshQ2XSEHHeuOM8S6tGj8q_hze3WtjQnNDjdI5IcjWNbs
 q8TLyJPujLdMuAl0ERNW3TzjqFE2_6Ag.Nh8SI2FC.3uLl9ToPc.kIMx2VKwY9qKHWeTL_onO3WC
 G0FUXCpge4hGLF8YJB6EXqxY6NDtKXmdbsJGLCjSDYn0r9zl3e9X7zLbdafYFAyj.r7kdmMU5mUo
 Zokqt14p8SIpDamhxrnKZQih6J4jknsa0byvwSkobMlUtLQA5wtApsUWOx94P.FO1N0fiZgTthrj
 xXSMZ4BAbWAPCS0kpd9B2bCMsxyJNEs6wUdohf43V0ECOr6RZOLkWbpZFi8eJMPF2RirSCOZkkex
 Glg2_roxsmzTOqb73yKwNhzA.ojDpVcBD3wMKETktrSqeumkexhTfNuCo224n1JRpf3XxDFqHkC8
 _7dDbDGadfT14HM7L69M6CkFQJWiCxCm.DhyUWEwlU6u4LRnI7mLJC_T6O6uw1CH9qpD6eFW2Z.R
 5vQCYppLSdbBiawPjozHHb5WZ7pTySNO4lw2aKsj5wGsxTrIVcxEownUVm9Llvw0djisjN8jfHJn
 V2ISjJ8wOMIKWHS4F4inNTG2pkWYZiOGqgNi2zrC1jQjqXCHi7vI78SJYlrq8.B5v6cqCwRYwr7O
 qgSP5Qc.rkIksay6zEIRVRIKAWFWbTZsHTZoalvtA3op5beMzW5zznAz.29JQKWFiwEBmHsBV4N.
 PS43T0jnltca.bJWsUb_2lW66OXVpS_ywRRD5fdjB2hX7JUjnKiqHxidFgkRJMhxO2373JJzfMrK
 l4fhnYF7T4ogIHvNp8Oi5NCosBCuCduXqv7DGRiwVF_DGreFoWFQ5KzCaN1U6BeDA8Leo560XTRN
 EZmYMyuz_r5_2X8hy52.EHksmV1fiHEDYMrfx8RWKgF2hlps3qsBpmeVtCAm.pFPyW9nHK0hnSRS
 jax5MHLziMvgLF5UYuMHdvTHTqJPGoO2DN8CvgacH3L0inxfaAGomobUXMg9B78rt.wckNA._neA
 a3jsiGy5Xr_IDr_HFEI4..QJI6Gps4cVNDpbTf_ir1Cc3_cryLlKbIZIkdpKocuM2h23dg_4Cj0H
 7no4HP80WYAUEpUEsoZNpF1FsrWcS9b5tD2RvmGZyo81n6D7B4SuanzEYgD7QV3PMean_ih98p06
 iR97NGS.Y3JMWv3dnP.qy4RH0dTUnY1glS_b5e7e0eOvUBhxBoefMnLT1.AwvmHOhU64LDJT5sin
 4ePJOrIz4fu2z4b8rdshhjVqFRqqunVg40tj2usW..kKlXkITRzr74O2tvEOKJO7UR6FrQjbaMuk
 jzgSQA8Yndx1PDiSNMTt9DYh3SA2f1ff5.FAzQLyJiczvLdkj0eBekcBoQuWiKqWFpCcUzt8bim_
 XnRKi587TOiHr7vvv5QRPU.aiJhMsUBwkcaXBveHBg5oeZlWRIomT9FxucD_s36eeYGhwae2v87L
 mF_v8n9_i7yn4bnHbBx8zHy4zePt8dxoHTxVQpZdma3DoSYvxDRBO1KSpa6HfXG67AqFqKmmu9q_
 DlC6Es8yTvTJ2n7XbsQLZCgHqCE8JL2Gl8DLb4fIwMSFv8Aot0lr2tejrox6cV5T95ErTsHQl0W4
 oyVdBIZQ._DRn1od4JrrF3sfr1Du.f4BfTtYOQ4muCkAbtKZ8u5L2XBdRFXElliqayBwMHUZunme
 EKy1bR7_ZQsgNw2NYqnB4hFgctXIYp7qTVKdyum.gv9IT
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 18:45:31 +0000
Received: by hermes--production-ne1-c47ffd5f5-h6ptj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cee108ccde84a9105dc7ebe9516c7326;
          Tue, 25 Oct 2022 18:45:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
Date:   Tue, 25 Oct 2022 11:45:13 -0700
Message-Id: <20221025184519.13231-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221025184519.13231-1-casey@schaufler-ca.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an integer member "id" to the struct lsm_id. This value is
a unique identifier associated with each security module. The
values are defined in a new UAPI header file. Each existing LSM
has been updated to include it's LSMID in the lsm_id.

The LSM ID values are sequential, with the oldest module
LSM_ID_CAPABILITY being the lowest value and the existing
modules numbered in the order they were included in the
main line kernel. The first 32 values (0 - 31) are reserved
for some as yet unknown but important use.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h    |  1 +
 include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
 security/apparmor/lsm.c      |  2 ++
 security/bpf/hooks.c         |  2 ++
 security/commoncap.c         |  2 ++
 security/landlock/setup.c    |  2 ++
 security/loadpin/loadpin.c   |  2 ++
 security/lockdown/lockdown.c |  2 ++
 security/safesetid/lsm.c     |  2 ++
 security/selinux/hooks.c     |  2 ++
 security/smack/smack_lsm.c   |  2 ++
 security/tomoyo/tomoyo.c     |  2 ++
 security/yama/yama_lsm.c     |  2 ++
 13 files changed, 55 insertions(+)
 create mode 100644 include/uapi/linux/lsm.h

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e383e468f742..dd4b4d95a172 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1607,6 +1607,7 @@ struct security_hook_heads {
  */
 struct lsm_id {
 	const char	*lsm;		/* Name of the LSM */
+	int		id;		/* LSM ID */
 };
 
 /*
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
new file mode 100644
index 000000000000..d5bcbb9375df
--- /dev/null
+++ b/include/uapi/linux/lsm.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Linus Security Modules (LSM) - User space API
+ *
+ * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright (C) Intel Corporation
+ */
+
+#ifndef _UAPI_LINUX_LSM_H
+#define _UAPI_LINUX_LSM_H
+
+/*
+ * ID values to identify security modules.
+ * A system may use more than one security module.
+ *
+ * LSM_ID_XXX values 0 - 31 are reserved for future use
+ */
+#define LSM_ID_INVALID		-1
+#define LSM_ID_CAPABILITY	32
+#define LSM_ID_SELINUX		33
+#define LSM_ID_SMACK		34
+#define LSM_ID_TOMOYO		35
+#define LSM_ID_IMA		36
+#define LSM_ID_APPARMOR		37
+#define LSM_ID_YAMA		38
+#define LSM_ID_LOADPIN		39
+#define LSM_ID_SAFESETID	40
+#define LSM_ID_LOCKDOWN		41
+#define LSM_ID_BPF		42
+#define LSM_ID_LANDLOCK		43
+
+#endif /* _UAPI_LINUX_LSM_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e708c1ad7267..b859b1af6c75 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -24,6 +24,7 @@
 #include <linux/zlib.h>
 #include <net/sock.h>
 #include <uapi/linux/mount.h>
+#include <uapi/linux/lsm.h>
 
 #include "include/apparmor.h"
 #include "include/apparmorfs.h"
@@ -1204,6 +1205,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 
 static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
 	.lsm = "apparmor",
+	.id = LSM_ID_APPARMOR,
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index ef9b1d983665..20983ae8d31f 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -5,6 +5,7 @@
  */
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
+#include <uapi/linux/lsm.h>
 
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
@@ -21,6 +22,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
  */
 struct lsm_id bpf_lsmid __lsm_ro_after_init = {
 	.lsm = "bpf",
+	.id = LSM_ID_BPF,
 };
 
 static int __init bpf_lsm_init(void)
diff --git a/security/commoncap.c b/security/commoncap.c
index 986920da0c26..940e36d8503d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -25,6 +25,7 @@
 #include <linux/binfmts.h>
 #include <linux/personality.h>
 #include <linux/mnt_idmapping.h>
+#include <uapi/linux/lsm.h>
 
 /*
  * If a non-root user executes a setuid-root binary in
@@ -1448,6 +1449,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 static struct lsm_id capability_lsmid __lsm_ro_after_init = {
 	.lsm = "capability",
+	.id = LSM_ID_CAPABILITY,
 };
 
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 4a12666a4090..5b32c087e34b 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -8,6 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 #include "common.h"
 #include "cred.h"
@@ -25,6 +26,7 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 
 struct lsm_id landlock_lsmid __lsm_ro_after_init = {
 	.lsm = LANDLOCK_NAME,
+	.id = LSM_ID_LANDLOCK,
 };
 
 static int __init landlock_init(void)
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 24d041a888b8..32bdf7294a6f 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -20,6 +20,7 @@
 #include <linux/string_helpers.h>
 #include <linux/dm-verity-loadpin.h>
 #include <uapi/linux/loadpin.h>
+#include <uapi/linux/lsm.h>
 
 #define VERITY_DIGEST_FILE_HEADER "# LOADPIN_TRUSTED_VERITY_ROOT_DIGESTS"
 
@@ -199,6 +200,7 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 
 static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
 	.lsm = "loadpin",
+	.id = LSM_ID_LOADPIN,
 };
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 2004d67f7201..e8c41a0caf7d 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/export.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 static enum lockdown_reason kernel_locked_down;
 
@@ -77,6 +78,7 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 
 static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
 	.lsm = "lockdown",
+	.id = LSM_ID_LOCKDOWN,
 };
 
 static int __init lockdown_lsm_init(void)
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index d9af1d04d293..8d0742ba045d 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/sched/task_stack.h>
 #include <linux/security.h>
+#include <uapi/linux/lsm.h>
 #include "lsm.h"
 
 /* Flag indicating whether initialization completed */
@@ -263,6 +264,7 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 
 static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
 	.lsm = "safesetid",
+	.id = LSM_ID_SAFESETID,
 };
 
 static struct security_hook_list safesetid_security_hooks[] = {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index aee20bb1778d..5fcce36267bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -7016,6 +7017,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 
 static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
 	.lsm = "selinux",
+	.id = LSM_ID_SELINUX,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0c0fea933bbd..c7ba80e20b8d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -43,6 +43,7 @@
 #include <linux/fs_parser.h>
 #include <linux/watch_queue.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -4789,6 +4790,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 
 static struct lsm_id smack_lsmid __lsm_ro_after_init = {
 	.lsm = "smack",
+	.id = LSM_ID_SMACK,
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 80fbab5d2d7e..1916eb6216f7 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 #include "common.h"
 
 /**
@@ -532,6 +533,7 @@ static void tomoyo_task_free(struct task_struct *task)
 
 static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
 	.lsm = "tomoyo",
+	.id = LSM_ID_TOMOYO,
 };
 
 /*
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 4f60158850a7..2487b8f847f3 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -18,6 +18,7 @@
 #include <linux/task_work.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <uapi/linux/lsm.h>
 
 #define YAMA_SCOPE_DISABLED	0
 #define YAMA_SCOPE_RELATIONAL	1
@@ -423,6 +424,7 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 
 static struct lsm_id yama_lsmid __lsm_ro_after_init = {
 	.lsm = "yama",
+	.id = LSM_ID_YAMA,
 };
 
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
-- 
2.37.3

