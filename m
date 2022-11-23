Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933B4636A53
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiKWT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbiKWT6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:58:01 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D230C1C11F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233475; bh=vaNHeu+uBrJ/jXIPtDlBaZHKQlALl1G+dML+hKWuQRo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eHy6sP/WR82UG4S77tqPHKVhrHxgXTeJP1bSSOCPI0aJJtCmXliUaFjOMtwiLAdu3wSqlXaPPVhaj0PGMvYF1BWDOeZAUr0ZsR1ieRHE3i/gnnS75h4Sr6FQeZ1aYS5uN4uxnJQ/r+uzOk5YYtcowtrHMfm/guvb/53AAlMgmvlFdJbwkhcWWf7boSzvgLe6ow4fNn/ueQgM1rZkMdSTGfTK8ytRL9HXl+bxQLTA9VYL9TBdmD62GF6ru4Wgtdva7HI2QEIRwkoALE4PZ+zP42yWDZjbAKQyUEuROmeo1Jf6jGTk8bDCdQ3Pdq8I0XCqZyrB6r8ZeyKwZTveg0tXXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233475; bh=zE05qdxpj4K731pyyqTe6kjCPXlT8TPgcDvuMubnjdj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=h7p6putSObBwliLjPCu18lTiZwRlz4TW9B28xMU0ciLlpqa7/Bk0maF5YrVTAXw5jqcFukfPE3/2Z/wgfjLL2MJHHmUmtjC6vwJNrF/wm1xtbbcJFh3o80bp4IxQU05ePGH7t1nj3CLwHOsUkekVIhZPipszHSvAlSIygYKmJqJuA1yCWGig9/NVo5lxPVTNyJM5OWuueLs5a3+Q0k3KCw/mumoYljowaeD83ooTCFalFNw1qn6NUGhxXu2ODIl/qJrIsgvdNkCvekRqi7/8GpjX/m0ZXa2byRhv+PJGMod+xoaTZeyfVc/BnTV6pM4CVXz1AmxAOpidNV0OotzfMw==
X-YMail-OSG: GIg79akVM1li41DiYr0E7pr9tXnyszRRcdtr__H44ckniLk5u1NimjhFmK1U9sh
 5VV8JS72eJBg_24iwxa4Evu9qtxAwcG1D.tqy4Een7HV46EPOGd21LncO_6MU73OM4Egs5XiF29O
 8_jkCBag_SaLHBtmopTibDqZZSSir3n7LKphXhpyO_K_cbEYniETG17G3srpcjM4VzhAvSoJiBny
 HMbcYILTj6vDp7GSFSpBF6Y6LCemMqITfJuCs_u6T1rFGWgZOKWhSU9G1wYDO_OyJj4OM5JFKIii
 ou8ss6dZEpije3mlSEVq.XEncutrL1FCjLRnjzsaWfWthdFUtxQcYjuVNk2moqL9PAs2VZEqAb.H
 3fOyPqxDXFu4BdN9ffRd1cRzQ3Jf4.clBB.Vud4TGQG_c0Q.oC629g83W0GhA.EivL4.NbZppaQP
 pqqj0hzVxyy.k1N6mcKI3rBoNFjJmEvLVJNUdkM.cVCRfpKWOovKOfrVrYHmLlbdXhC42JYfgMuD
 Waqne5U1Mx2z2nzgMloAHrCsXDzgb8kw.wJPHRhBe1EeGhWtSsv1Vhdj.nlqFPNbW3nnlF_Nud9D
 tVK07ELSwcZQYIqmVTWWEJOdT4KTnhNoHRHmZ5EYjo5lZT71zP2WbZnBwmLJwMisHrfndcNrLAFE
 WnEASIXU6w03g.hWRovOnjXrUbd.j6MTooD8_.oWGUqHA7GCWFyFib4X7Tsm9Hp66FV1q3YoEfF4
 821LBwsrNHlnSop4RReq4NJgR2G27hKSd7Y2Kdg6v92MzmmBw59le7zvTCW_JgcPZ5msV4YkvKom
 66h_.g65NPWfXInlSe0pdE4lwEPzmD1rWX8HFjDppUwLP.NC1eSDZ_wDKgaYmuW4BzwvCwbkzrDR
 zeefZmFKUEB.HrEKbLgzuhBvoM_yiA_yukVeS6.3NUhKzWl4dXv5vPXo1N0c8Og3zGyQPI8tYME3
 PjXOUC6DJSHY1RwVW56CvtONrFCxUfWNCMdDKJlz3aWi9L5cycPGjwAdujC_Ts.uZn4tlEFju0lH
 s4tatJ56MO3A7BlCbTwFrWP5qGlOeoS6K4NMARkmyoBar3AKeLeEW8H7.tPPQb8Pa_FxFUYukqIz
 XHv3PT87YRBjW2gSbFPfS69xvejyZdqu9izARdqxV4kIR1lcLFTBSYLuVXwJ24Pcecr10PkWvpZI
 eG2fIkxctjVt46qjFKesm.Tsupt3fRWsulEx2AkVWAUL5TNCOeFPLRrTDIEE_h.KEft.wBG3ldZj
 HdeZewsVGL_VtlvNvRi6.LtUYa9cKtFPxPmz3qgy7R6_GdWzLaxRot9ubvhhCuHUnmf84TKy90Iw
 YSutsaQSYE0OosDpube.C_Z4Qa8q.2cj7GwMPXin60hPLZ5itaufo1wmxKwn.tVVZfryNWCZ2YK3
 iC712SjVGbqB6F_REgVhg0NmXLYPJQQswYEMw620F8.rcHStdydNlDw4duhh7gMAHuCC2tIeTkrV
 cY_f8UoIu13A1cxifenK7x5onu36G4kn4_qkjf7Njy52GA8GNFk9F8GnUU3Vkox1fAJwqb9UmCgr
 KKbkyJFRJwci_PZl8q6Qos.Ke77YKGq6i7Hkfhenfj2n1dZEqRkCkCaSjQHIbQt1mrSHJe0vHAyZ
 c7i2Q.OWHM2XLSL2PbB1L4HxemNrr7cXyX3PNzp.sL54gMANXhjONestZ3VJ4WFiF5bIMLU1w95i
 JX46cw1UTbm3OAUxcMQCunql_Qls54AIOeOKket6PT_.LF0IjYekeSEegVTa7jUahP1NgHUqdNx8
 dkUuw1HzDhciSZm2W4vJ.qtfJcGIPE4qYax1shETYEm5f0MrBCpOm_jGxEd965e30i.HPb.Iv4Gt
 P8k7LiGxr_VSdjH6l6Y8s5B1rBTWNgj9Smy_krVXsesL1VzqCcYyFyt_glfqfB.4M.HLKc0JOhOs
 sK.VoFlsFmyP5c0oQAZnOykC0ABGD14a83J3GbhkPjotJbu1smrrS3V5r5DdZ_OIOMgC5Tu7SGUH
 QUDLF882nNAFqG_hi0gO3ZGY8iVaNZ4jbduvm6KVYbPIjyiSFOZH33kxGGptbdWRxZr1.rulmaJo
 Fk_9qT7cSSnhYYNMyff61dRuHR7zH7RFEBSSNEFQ_DlmLIQdvX0N1.mxp3WWIUlMOlvTRSLmRHX7
 u47woWTe0xyPiQeASg0UOgOAAuObHSu8tnpepxG2cK7SKaWZv5YLydv5Dz9qHg7P3AJbsO3fR9Ut
 8cHnk1p4ydllAUcme5rUSQb205GAdPtKh4drP
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 19:57:55 +0000
Received: by hermes--production-gq1-579bc4bddd-hbm49 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dd0bf7e44b76ebf62a48c0cf31f93899;
          Wed, 23 Nov 2022 19:57:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
Date:   Wed, 23 Nov 2022 11:57:37 -0800
Message-Id: <20221123195744.7738-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123195744.7738-1-casey@schaufler-ca.com>
References: <20221123195744.7738-1-casey@schaufler-ca.com>
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

