Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563115ECD43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiI0TzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiI0TzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:55:00 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5923AB2A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308480; bh=rOKmL7MDt7RmAslrvA46VcbkhmxK9GDNcgoiMKYCdOY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SrTqtz3vLLHCTPcI5jaT8hnoLWp7enlwrjasuXe9cENOjIvsymTdL8v512GeIk9zqtTDW6HxUk2isvU9OEag1jxhpxrZ439WFqBjWmaUoLRwrtDX+zjkDh0kPOGk+pUf5wPYpU0lkSOfOBHs/eEiMngtW7I9sqD/u//5RWMydxpneHfExMGM0PLMuMNVx3eUn2rGSiec6dBidWLuXUp5yaaUJlUYztZbPOebdeWluEcUiZf1MjYB3hzVDZKbBwH99TyOukcZMM+gM8Nfv2BZZU39kLHvubhOIPvGbgj5BRWOZmBHm/gklxW3snN7KVEbiIPx2G53dvxYVE9n3YKJig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308480; bh=ln/9DuY/ngdUUjXm0bwG0VwCKJITLeSyKKXuEmrP7TK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YkVVpPRjPjL2in+MB1WwaPaMvBvhO+eYQYxr6fbYeByV6QFXwQsZZjj4FNPTK/zVStbXojRxVcOXiT2eLa+4w/4Ir/TTZL13+bsiK/M8taPP4CUy9nJoXpbbiEx9VR7YXKWQEjRKksJXwFVpRSIZDUK8rahozzdD5OwDeX6nhv8DxpIbSM6LwRyBzQ1Tt0viovdrpUwD0HOyF0KvOZs02wAehRmSBf4WtcHuyCdnn9owqb2tHs1YfWEryYoJXCpAO3zaCHTAvC+cZMIfOKUVZQsIERjalIpQWZE9tfbQunzNhYzN/GeqXdGnvKIgLjhN/CBnY2ZEqfFxGXk9wNP5dA==
X-YMail-OSG: VdiAsOAVM1lbbijUtWUVTvYKNXBPDMt58xbYuXW91ByJc4HfIZ6Y8pwsOtZdrC5
 2DFS9Nw8_zcidCVowKi0FyRnhPAmfQO2X4If_WDFyRBcvRZ9RxRi9f68B9zdL9snLQ9ghguknaNT
 pSf2J0XRluQ9wr98byCZqnSx5AQNEAbBxRvqbiSIZIEFxZoTiLY07tHpX2Ggm.YUYS0HmLU71pbQ
 _0VlYi8uJQskyVoL1dTTFVTsN9obaXbv9HA0m4Gyat25W8ZzpHL9kNCPd.XsbNiI7_DZuCfjANYT
 O.E5HRz3qnmgZLrfvNFCQuVqHQ8H2i_E6pVFb6q2lbytJy9cQLWm.rW.stQW5jo3MtnFVWyyVT17
 cw.0GMKn.tjIdiUioiMDM0BQdeiOO7EmA9BObXA7K0D0eIg0XJarfSd8SLExgWDIo9aookQqApgC
 HoCpJXEqzSpQm00QK.QhKJIFAgFMsv0pxHuO7WcDEX1ZUkSaYK9pujaeB3u4zI8CROh2l9MyPCTr
 SJwBF21LBZ6DQJU4VHHkSe.lxArykKnRriLF2WV3IGtssYN3ay3JjOSEwR7af41evL0tvC3VKq_P
 Ca1BEs_MDzTcst1IssxwH5h19KD7Cazl7sPaROaaKdYli..DmFAGewM9yekuPMUwwPLeqFlUXp4X
 YRl6jNyeHF6PKUsM8ttQSpRZsyuDazn9vz4PSsq20A6.3QliOy2M7nzTt_Qo0lCCtUKKOAY5JKBm
 8ABNfLmp.R2EG_2CC2o32voocAVh2vh_5E7W2wNaoRuqaU058pXO5DnD6CmoyuLDcvNiX.nQzZBT
 lfaj2SbR9..rEW8cNMnnf1KyzK1_DPej5Cw3PaO93ZXdZ8.VYYggGgrJ1Xx.fy1z7hj6AtYd05LZ
 bnGVu0f52LXSxAmBPF17JC34Mm1DsKP46FRPenFWQb1G1fqiTrpdMxAzxSvaWO25Q6SE3sgZf1y7
 _u2f4UXklbiowOeAeKuotWhJ4.gDMSJHweo3Kna1Ejj3eqLwx0n3GfJ9FYyMz251vG__SCPpkyTQ
 TU4taseUD.9vExiZ.I_IP4KcBsh7fh9AYCwamFUqmpvjMi1Nhw2SAzImOUa3QynSk5L1Oia4YGr0
 7avfS1mmE8CP.WjX5oQxzz5XoiyB80sYPx3YOgQTOFGNMDaIktPwSCg1.j8kGsRPDjwlG2547OcD
 lXjqh_JpTXocSJoFvhko6qaHCucp9d1F7vHIyuDbN4Vh2JgBwT8PHmDVwM8tFyx5NhgOeE69ie9W
 ZEdsXgbgV4wLbcz05dVxJ5kjxhJfkRoIt66ylFrNQBAZangK.y45jBeso6a9BmSqs0CFeUrGsD9p
 .Y.23W.Z1SY_pC7ilI4APXyYkLKgd_JKYpIXxxfAAOZwtUe7azufcoO_Zs4tc1tCbEAAliIDb1SN
 pzXZ52PhGE_lg9lMrMEAc7WBTiUUvHqslict1_NGEgifhZAbLsX.l8jpI1.5iy7pwfzRd3olqXAR
 kjkHGPPa5JAsnCz9_0fpDLJeTAYSeZEiSYd5lavkRggPSYkRuRiQNJ2GMzr7SVT.VmBxUtcsjHb0
 GvH.iLHl07vPN.UR7QrVGu38SnUjzw2WIbG2_SvdLWA2oOuU6fvWdonFsRiOetR37VMZIN29vnDw
 OxeOIc036KraUsJ_M1F6Tcg_t0n2iSrrd06KKMtmjz1JePQkfZB1FBDS8Q7ErtKkcs7p8mDobaPW
 TaymC0ZpN6RaqERFs31z5oDf56TI13tGkGTPWv6ywIRD0.rKXvYMZPw4eyBzCzXSZf.W1Llzmadi
 qihqQSHNh1OCLCTtt86HidKbBufa1Q.YuJs8tZ_mgpPNChOxJuyM7cnYh2aF8E8TTJp.Rja6h6HD
 U5ade3Q1R9E4r4iQms5XLkPk4xtwJ4BydQxMhDsVpZ5ywq0sTF1QUCHga1dlZnU6yDz7N32qnpX1
 XeMXspEpRk62zgtemDxq2NKluowNe3E8DhxJTRnDjoJ0l4RNq_ns6zg4_jo8tKHDqCBu7X.7EB7J
 mgrAFgoyglqhEFtGnmQLqJmC.GjUyZns9pDC44DBeKXpJQTPDbI71QBsSioBYHlQM1zqKFpvVcaa
 jT7WPCKXcEX8cplnZbD8VRDFaAPebVOFkGfXuoAuSQKaq7WtxxCX9t8l9e2f5Gm5Yl7kU4d_.Is7
 e7Z4VO3qR2drnYz7GekW79lnARprSc7_ooEiEtDk3rjpguyhCH.2I6ZNVpucrMscqdSEFta7pnFU
 xtQAqE2NLdODdsd6S_Es8BvFpJdbW2WJMIO8hg9WMzHPacML21QiyvJU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 19:54:40 +0000
Received: by hermes--production-bf1-759bcdd488-njfbl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0b959d6dc02d7e129b663c80c767d31c;
          Tue, 27 Sep 2022 19:54:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 02/39] LSM: Add an LSM identifier for external use
Date:   Tue, 27 Sep 2022 12:53:44 -0700
Message-Id: <20220927195421.14713-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195421.14713-1-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h    |  1 +
 include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
 security/apparmor/lsm.c      |  2 ++
 security/bpf/hooks.c         |  2 ++
 security/commoncap.c         |  2 ++
 security/landlock/setup.c    |  2 ++
 security/loadpin/loadpin.c   |  2 ++
 security/lockdown/lockdown.c |  4 +++-
 security/safesetid/lsm.c     |  2 ++
 security/selinux/hooks.c     |  2 ++
 security/smack/smack_lsm.c   |  2 ++
 security/tomoyo/tomoyo.c     |  2 ++
 security/yama/yama_lsm.c     |  2 ++
 13 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/lsm.h

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 23054881eb08..407f57aaa6ef 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1603,6 +1603,7 @@ struct security_hook_heads {
  */
 struct lsm_id {
 	const char	*lsm;		/* Name of the LSM */
+	int		id;		/* LSM ID */
 };
 
 /*
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
new file mode 100644
index 000000000000..5647c3e220c0
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
+ * LSM_ID_XXX values 32 and below are reserved for future use
+ */
+#define LSM_ID_INVALID		-1
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
+#define LSM_ID_CAPABILITY	44
+
+#endif /* _UAPI_LINUX_LSM_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b71f7d4159d7..fb6c7edd5393 100644
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
 	.lsm      = "apparmor",
+	.id       = LSM_ID_APPARMOR,
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index e50de3abfde2..c462fc41dd57 100644
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
 	.lsm      = "bpf",
+	.id       = LSM_ID_BPF,
 };
 
 static int __init bpf_lsm_init(void)
diff --git a/security/commoncap.c b/security/commoncap.c
index dab1b5f5e6aa..4e9b140159d8 100644
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
 	.lsm      = "capability",
+	.id       = LSM_ID_CAPABILITY,
 };
 
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index fc7b69c5839e..1242c61c9de4 100644
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
 	.lsm      = LANDLOCK_NAME,
+	.id       = LSM_ID_LANDLOCK,
 };
 
 static int __init landlock_init(void)
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 7e5c897ccbb2..276c8a7cd6fe 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -20,6 +20,7 @@
 #include <linux/string_helpers.h>
 #include <linux/dm-verity-loadpin.h>
 #include <uapi/linux/loadpin.h>
+#include <uapi/linux/lsm.h>
 
 static void report_load(const char *origin, struct file *file, char *operation)
 {
@@ -197,6 +198,7 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 
 static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
 	.lsm      = "loadpin",
+	.id       = LSM_ID_LOADPIN,
 };
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 2af4bff8d101..3d3347f3dbd1 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/export.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 static enum lockdown_reason kernel_locked_down;
 
@@ -76,7 +77,8 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 };
 
 static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
-	.lsm     = "lockdown",
+	.lsm      = "lockdown",
+	.id       = LSM_ID_LOCKDOWN,
 };
 
 static int __init lockdown_lsm_init(void)
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 3a94103f3c5b..88002731e603 100644
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
 	.lsm      = "safesetid",
+	.id       = LSM_ID_SAFESETID,
 };
 
 static struct security_hook_list safesetid_security_hooks[] = {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5e4938f3ce11..9803bbbc6747 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -7014,6 +7015,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 
 static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
 	.lsm      = "selinux",
+	.id       = LSM_ID_SELINUX,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5d8bc13feb09..2a88b4e7669e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -43,6 +43,7 @@
 #include <linux/fs_parser.h>
 #include <linux/watch_queue.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -4776,6 +4777,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 
 static struct lsm_id smack_lsmid __lsm_ro_after_init = {
 	.lsm      = "smack",
+	.id       = LSM_ID_SMACK,
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 38342c1fa4bc..71eab206ba6e 100644
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
 	.lsm      = "tomoyo",
+	.id       = LSM_ID_TOMOYO,
 };
 
 /*
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ed6d45e62e0d..b178d74bb00b 100644
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
 	.lsm      = "yama",
+	.id       = LSM_ID_YAMA,
 };
 
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
-- 
2.37.3

