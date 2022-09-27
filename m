Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C65ECD51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiI0T40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiI0T4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:56:17 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEBD6C110
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308574; bh=wWevsx4y9ytHpAb+FeSpRHdrwxpSrBe5tU/kTHTMo5M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PC4o7aBcxcphqlEl2yA59vlsItwBtEl4F21D/S9ySWtMGz2ygrTNgesCLMj6x7fdL4jzs/JHWelO3WN+HaaZ7QdElktvKMb6t64tVz2hGiev0fTdNWqtxFsOyu84qp3mzmM3YHEZBCHOdDcUxYxCSbYh7vLdNG+s+jfHziQ9XYAoj5z7kGDd4HELnSrsvzcZUcWBC7Vi0DPMpuDNw4XEHedFR4+R373DjX+rMMIp5IGcMoBeuyGbAYwciX1I7bFsgq2zWtw8nt7psw3D0yp9N8WN5lq3JNkdBe12pXKgI18iJYuV7xkDU3VBtbNyBuBq5J83k3o67mm7crf9BYt9AA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308574; bh=8XVfmKAz1o66r9uV6PFt2Q3Rom2uM9TrxJE5QlpteNQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FBJ3JicKxsY6wH89AHlfY0gMPh9je6ExDSbeckXfNcIu5m2L68uiJxNt7Hlq3lTIbNN35WHn0ZE5kyFB6LEL2keKa+wqIsV++gXrhW0s437kXjj5ZvmEhBWio6Dhf9+WlDnK9yVFTanmobGbv4hCKwjE2ks/KxsIqECyBKFGAtNWPQc6EEWWAd+tEf0r3LYJxND9dktDxbdeG4xd+qDJDQwHtt7aqcTrmMqNob+MtU1UcwuT3KLbt2bwTsMimt6eR1gKoDgL6bymsRrIiHcouyc972VCHdeyGdFo38URq1ELPXNtPPB9FvmIGzjIFyj6Fa25x7v8kFuryyROBaB0vg==
X-YMail-OSG: I2CSW3AVM1nb0YQQGdE.wa9FSCfuGfasyRSztr_qwwYCG1rVXBfVGWnCbHdlB_b
 RKS7FN.wsdqiOktTbSPsKqOSRbLYEyPyMBn5BaSid_T7oz7wUCN2wdt_wpVPdV5ri9lexrtazzB8
 1OzGX.y8o1LEms_jyGTdumxwwAU_wDRYp6rXP6xlE_q4s0nhaIg6I5VQJt_6gTaesNWQTFCcJ5WW
 0.rwfjenhUoaY3Q53wXI1zXlvw3qKDdbwPx2GbTtqHrU4qeNmY0TeKatLqYDI7RG6ZFfW3lNuQIG
 H64dEFEeukuB_NujUa1oL5u7nGg98IlXBd5RYY437clNqsrG_fkcboKz4Cx42.qFQuro4gk8234r
 WDjnbgInjG_Dah7Z58U2PVcdHZK5R5shD0pttHsxadeW4lTSitNaaOJ6ktWOVud0hyk.iZWEM31N
 Uok6hx9m9yrvnXA2B35o.DCNVE0aFGtD2haKQbYYoztizrImCmNkctN2C4n8WP8OkSc3ywtAeyj9
 StH2tXKj1J2WLiajL3nmwSjzold476_5nMZg4ZjBUo6d6TxMoaNSA2Pc5ulRVWO8sapzJwJlpnSX
 7rdM_c80MvKj311W3764GCOUkAYbYDsAkn.4yLrf9HzElapoWsw7b0yJpVPBotiOMbpVJ1YRwscl
 0xt6G_KeAGZn7xWPUw1WVrRtnYxQfyr9m5YrhVsPFBllEpOEQBKAkz702oxspfnv0IdygI4H5x3T
 74bCQZr9LiGrdEot1F9FQ5fMdJm91cDd5keQbpwvyuDnx8A9l_6ilYYMqgvHxVVX0BzEMbAG6SRC
 lzlBJaz1yuMW8YC9UCjiQT49KkP1qxw5NxeCX.lJUHgdkG7LGVafJRxy6S29aE4PpJCnoowuhNAF
 2bbH9rTxTHWjdmLsk354eK6EGCJOp5CGaxCiN14L1W5Vbj_7lE5._K0CoDf8SoMe.Nl_S98ogfKL
 kbrZBmFxxXx5fYcOG4zq2juEHZOi85GNWHi_ninVavuuTz1sW1Ht9jkUjsUznhT8TurNNNy_.teM
 XxL1wTy_pZjqpracx2j4x2n0c0M3k1K0naNqhHMEMTfd7CDB8tVpna_PRA088Uo2rAMB_vQaaAf0
 aZwomyVYs73cOZIl_kH4A8GXRCe.lkZgCvn7VRslIwYUE8AQvxcV8cAZuom1PvCEeeSZ3GzWcNPf
 _1BrdsPx6WVFcl7DHd5HiO4iOj6eTZX.HnSeEk04zP.669t5bOngOzzjRBus8VE8Q4_JZJw1Wsjg
 bloNRny.loPjbo_JzOVwjuk5fuviTXtS7_7LgpW.FOcZiKbu__T2nWJeUuRSJaxBc7j18Hjcsj9Y
 lvu6oUGXt7oztoe8Av_VaoYv8BOYE.wI4cfh7iYWXUSI0HWrumbk3jYOiPBmzPPOcbmRmCvNDkbt
 AN6_fIHb31D2kJTR_MiwL.HWmmaEFu.OTiWEwpkwVSWFu0wIARvyv9SozAJ6tjoTClI0JNxXzjtL
 K7ebVgsKaOyQrcMsN2Z2F62wShyCbhIE91Ms0HHZgVMHHuUY4OxZZ8TuugCoz4cuzXqsRds0zDri
 Dhe58vLA7O9viqCM3ky7X5La4C6J4klwNjmzacwxM3Id.834LMHOWaeo4826N.RAGo3eyoHBrBUF
 vHOCXsqE9vdzo_YqQveQu1Sk6D4pn6jmnjSJDUkHaMUM_RdxxM0KMeGFXlJ0Km03ecSAApE06y8t
 WDo9rEpqwr0WypEPq1UyiO75J4c8SoHgM33YlzA.s7TF2xVuME0vQmn6coyvEWjhuy7n2mz1unGS
 4tS7kwH.JGFVotdWe5_cp.3DRhQVa_WZ9h66v4Xnw5OgeWQldksnYIw.2bGsHWfuO9wZv51ja4Lb
 tGsO97vs0ZJc3kYvEJl.bneQKkPk_TXtEhLf9uR2XXTTTJbfDqUkm.mAF7WPncrBk2yNWcqj6WXQ
 CM.Igl21N.akpjLry.bEEMmeguEPd8wuAh044o5sTF3VlJO_W0Ua02zvI6UJp09ESjgJkOZMEbeN
 hOorWoLED6Xj_TIEOIt2bVi.XZbK99LIOv55mFo6JPZl6lEevn8rFqBnDt2R.U5fIi02.uAOWmnP
 I7BmKNlj4K6NwQzjm.wylQUUx15wgKlPuL0jVs48.8UcA1SQQmynTdBtTyclmtZfwww.k.31pqAG
 RhJe6qXzgUHg12zuYwpqAiAv39nLs3O5nR1HAtSQc8EjInkIr5yqHX59SLfu5xlFpxPOzoIoXMDs
 hUZH6mWf8BjzmTkjmpktva3wILeNUAq5LQ0QXDDjzmyIRKyE8x525xNHVBfMmAek0FH9JbJFYHtC
 iHRKs5hH1C45vQzWTQNIVLYeEOJWJPPQMuHDRHQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 19:56:14 +0000
Received: by hermes--production-ne1-6dd4f99767-h2xxw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ed20d3b3c3bee07b1518207f2172ebcb;
          Tue, 27 Sep 2022 19:56:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 05/39] proc: Use lsmids instead of lsm names for attrs
Date:   Tue, 27 Sep 2022 12:53:47 -0700
Message-Id: <20220927195421.14713-6-casey@schaufler-ca.com>
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

Use the LSM ID number instead of the LSM name to identify which
security module's attibute data should be shown in /proc/self/attr.
The security_[gs]etprocattr() functions have been changed to expect
the LSM ID. The change from a string comparison to an integer comparison
in these functions will provide a minor performance improvement.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c           | 29 +++++++++++++++--------------
 fs/proc/internal.h       |  2 +-
 include/linux/security.h | 11 +++++------
 security/security.c      | 11 +++++------
 4 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 93f7e3d971e4..b2bda7d0619f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -96,6 +96,7 @@
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
 #include <linux/cn_proc.h>
+#include <uapi/linux/lsm.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -145,10 +146,10 @@ struct pid_entry {
 	NOD(NAME, (S_IFREG|(MODE)),			\
 		NULL, &proc_single_file_operations,	\
 		{ .proc_show = show } )
-#define ATTR(LSM, NAME, MODE)				\
+#define ATTR(LSMID, NAME, MODE)				\
 	NOD(NAME, (S_IFREG|(MODE)),			\
 		NULL, &proc_pid_attr_operations,	\
-		{ .lsm = LSM })
+		{ .lsmid = LSMID })
 
 /*
  * Count the number of hardlinks for the pid_entry table, excluding the .
@@ -2727,7 +2728,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 	if (!task)
 		return -ESRCH;
 
-	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
+	length = security_getprocattr(task, PROC_I(inode)->op.lsmid,
 				      (char*)file->f_path.dentry->d_name.name,
 				      &p);
 	put_task_struct(task);
@@ -2785,7 +2786,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
-	rv = security_setprocattr(PROC_I(inode)->op.lsm,
+	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
 				  file->f_path.dentry->d_name.name, page,
 				  count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
@@ -2834,27 +2835,27 @@ static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
 
 #ifdef CONFIG_SECURITY_SMACK
 static const struct pid_entry smack_attr_dir_stuff[] = {
-	ATTR("smack", "current",	0666),
+	ATTR(LSM_ID_SMACK, "current",	0666),
 };
 LSM_DIR_OPS(smack);
 #endif
 
 #ifdef CONFIG_SECURITY_APPARMOR
 static const struct pid_entry apparmor_attr_dir_stuff[] = {
-	ATTR("apparmor", "current",	0666),
-	ATTR("apparmor", "prev",	0444),
-	ATTR("apparmor", "exec",	0666),
+	ATTR(LSM_ID_APPARMOR, "current",	0666),
+	ATTR(LSM_ID_APPARMOR, "prev",		0444),
+	ATTR(LSM_ID_APPARMOR, "exec",		0666),
 };
 LSM_DIR_OPS(apparmor);
 #endif
 
 static const struct pid_entry attr_dir_stuff[] = {
-	ATTR(NULL, "current",		0666),
-	ATTR(NULL, "prev",		0444),
-	ATTR(NULL, "exec",		0666),
-	ATTR(NULL, "fscreate",		0666),
-	ATTR(NULL, "keycreate",		0666),
-	ATTR(NULL, "sockcreate",	0666),
+	ATTR(LSM_ID_INVALID, "current",		0666),
+	ATTR(LSM_ID_INVALID, "prev",		0444),
+	ATTR(LSM_ID_INVALID, "exec",		0666),
+	ATTR(LSM_ID_INVALID, "fscreate",	0666),
+	ATTR(LSM_ID_INVALID, "keycreate",	0666),
+	ATTR(LSM_ID_INVALID, "sockcreate",	0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..3f6f4a7a1498 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -87,7 +87,7 @@ union proc_op {
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);
-	const char *lsm;
+	int lsmid;
 };
 
 struct proc_inode {
diff --git a/include/linux/security.h b/include/linux/security.h
index abdd151fc720..c4696f14daac 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -478,10 +478,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
-int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
+int security_getprocattr(struct task_struct *p, int lsmid, char *name,
 			 char **value);
-int security_setprocattr(const char *lsm, const char *name, void *value,
-			 size_t size);
+int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
@@ -1317,14 +1316,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
 					  struct inode *inode)
 { }
 
-static inline int security_getprocattr(struct task_struct *p, const char *lsm,
+static inline int security_getprocattr(struct task_struct *p, int lsmid,
 				       char *name, char **value)
 {
 	return -EINVAL;
 }
 
-static inline int security_setprocattr(const char *lsm, char *name,
-				       void *value, size_t size)
+static inline int security_setprocattr(int lsmid, char *name, void *value,
+				       size_t size)
 {
 	return -EINVAL;
 }
diff --git a/security/security.c b/security/security.c
index 14f22d9c9d84..af62f4c1cc89 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2075,26 +2075,25 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
-int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
-				char **value)
+int security_getprocattr(struct task_struct *p, int lsmid, char *name,
+			 char **value)
 {
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
+		if (lsmid != LSM_ID_INVALID && lsmid != hp->lsmid->id)
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
-int security_setprocattr(const char *lsm, const char *name, void *value,
-			 size_t size)
+int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
 {
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
+		if (lsmid != LSM_ID_INVALID && lsmid != hp->lsmid->id)
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
-- 
2.37.3

