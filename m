Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C901636AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiKWUS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbiKWURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:17:41 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D8043AEE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234659; bh=j9RdGcq2KLZ9SRgLIOfH7nW4YaoWEDXDkA2l59EQANA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=sWcBYEOrBkxwivZqnZBTIkdQJxGds3Dt4w8aDCXZwLi+u1/pO6gETAIrzLHqzzPhF+YbWP+db48cUsuxlQyL6liYIjWJ5XLsTRioSYREV49gLHQI/Hp99zZHgNpx0xK8Cx4ABRplpQNZaLthDsysDBY+YqLCAvcKcS4YLWayLCyv6bZTywQ/aj8zQeaJIigr7mHP2KU7WyzusWWGOSNMDRf9xygh84kTxlXoWF6fORpML9CAlYaky2YxKFLtO6YW6htZa+xOid0cJw9iCjOqL2MGKCNafSNUpHkYE1MfmW1VCG58YTVCUKm3AvdqzBZU09konTX/5tiTlGKDKC6uwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234659; bh=8UHyaG4LGl71MEIWvw3TNTPVn+hPITRTa+JAAVqCBje=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=N02G0NkEU8X+qEe9lS4N955BgRUnTppkV9C6WdKvb/fzWo4/wTfQcWWgizQ+NU6g4LaEg2ooSkPW/ROjAaOCwF6T/WKOg/6h6ABpz/DVRKC6TUrNZ5XxS7RmojndwMpPu6r9vYOK04Lgo3Gjw1hwH3rrW2MBcDdfh60kTW+Xqd+CTisFV3eByDASfB7UPJw6aVY7oiHYBGPuks0qNZZn7HMgKUnBpLvizP+QWJooZisBgN5Wfcao+SWskVWsR7aUotSx2CxC0hmbrAOWgE42Gbeqde/oof8J+iCvyR3pbs8wX78GLdreOZOYK83CUBPMUA+U+1HW9croeZwOl0P/2w==
X-YMail-OSG: bmwgmBsVM1lU4316vgYQSMMy4ou7bqoTOXiPvHdHW06ft4xMca8_C2TltouykDb
 vg2h5TwghebdlokeB9Bo77V6z1sIVmxvtzKZWBuW8SiTyYYaeyNA754b3EjH1zbqDOrGwdaAuCfn
 vY.DsrntWsESBNc2MufzlI_c2bdwVZQMKIWZvcukkchkgrLYXsW0go3w36MBm6ZYh4lfVs0zYz4p
 Kwr1EUSv2TF2a45zWqv03XOr3O3hbHd.K7lGL6IF590nbMAbYq1A1DiuiJJ8ojl71tIdZrj5liA3
 dicEmFr338VrnC2ric77qMHPtO49uyYkiC7RMEFubuvPr4qOs4sqgpsQGA4E4lMuCXIXODvLVIbZ
 3Xc8l6MGqnZbPqgvZ80OIPjbOUVxaUd.Sq7F4ERvCWnpxf338XhVyFiuacPgjobdUuz4Xv5iyeAv
 YftlHd8IA3PFuMdKjv9dH3aPbSadLKBxG_bxpiFXRDW1BB6vYQMZ2deQdEi_RUuoJkyHmefHhDc5
 LQALyGc6cJ8qEwIrB4BXjQnA6hy.NUCA_eVKOZ1dzH_3D.gUR_0BP3zrRx3OzzwhfQYvuJr4eTzT
 VBZhZ4ABaOZfBVo.zPcEY1mElXj14LxPPP1fLQmM7ZhUxbDkGkq6.JmLXDlPGXCmL7fFhB_SoboW
 8c1qaWSARQrQaVzrVWP09MXPzXPL3NutwLDQaQNWbZPTYirw7aFE6_BxgdwfWBsXIkLTO7NcDhG9
 3OtteFtq39ecbWixKxNAbj5SQiHMEqn_3eEttTqQzrtzclerk3m5WOQ6q4evKSuj5xZIkeexVCWv
 G.iPUopqKQAEd57osXpfmnALxHEgPn99aOtTnwIFZSYrckIuPskrWG0idRZDyv2miq3gI9ba9i9G
 CvaudwXIG74zOYS.OTtZuPivWzMyQKhiFQMi1.zuyx9PvIKzOPgjIdemK7usWVam0p3hACQjI2k2
 WcgphK__6SYLGK2kUj8CLJgFpZo8_5GrMK869J3LlO4UKjqCDQ.RaexBzdE8SB3KIzoFkJtMXya7
 3qgI2v3A5udrNNGybL8KgFo_Ljtgktp5s6KMYTNUTn3ZcezRM6ChwMrterzsjIvZom87UsbHya_X
 X9P5txMU3.tccIKvqKx6CK.e7Tsv5XIMHUHl3sa0PYj.EEF15Ez.jogH2.tN5Ef7r3Muk8xLYrl6
 8IJ7tuLAH.rNKy1bD.LSZ6XHx3illgdhKnEYe2C_GT_uVGtVKE10Di5NIQoUyqEdltwAb5dgvdM2
 PqWJVEPLUFMwhMnbdPI4U78Q_jffjUitFhXYeTfr..OKxjOdX0iaKumnNt_AfjdZAHgktOusGHX3
 kYIh_486i1TNIbJAYumQaMpz.w2gz8JtatmHpiIXDFQ_wYZRzv9IsNPXdTrpWX65VXByoOmDPuXe
 HT6vNjPR0jCDbv2fDdlXvN3CPidAiT6XFnaFyl.P7kwbL4z0EMg8.EF7x16bXA6remb5Wucxj6p6
 BIgrXWpb02..wMc22tkccYmI6w9BMBXOe1tVpNJ6j3Um8pJdc8ewINYydpM4J0JjRrCV0gesVsM1
 GTUC3cSCrF6xsOEwRf3tegAoKYmXuOiENNy6vOmRAOWnKrEojBsN3HoDZCrN0vUmxbVShD0xsDIl
 CXNxhdQTT9mjULbsPXInOwez8wSuNrEHLfkAVwGx6fnoOa.2GPiRuwGmgsTZgTJG6dtwn.0Uni_P
 k9q5B6E2SJ6a3Q__9fA6fw0ABRxqjaJfPOgSgW1dKC3JwDc5_f5zcLonFgz_fuB0Dcqfgz0jbuON
 dH_gWf24LRfJedWO5Cl7L0HU2nsQ70QcWrpq.Q1GTCZMPVopyF8VNoCkxoR6mSR_LFuzsE60sbka
 gNwpdoolTKdX26i5ZHN5YdWetFyEvM.HvqzuPFGf5p64emyEfkqYWYiQlRtOofef6NE7xKD8XpH6
 iQnnah8n87GxuUpP3q_XWu__ck7mfdzkMNepjVUpjospqL3EoxcrDR2eApCcbnVYfNqkEdpH_gI3
 vcJ.ZNqL7vZ3ya5Prha8zmClB7lbB3qrDvWhDJ0_cU5NpKjU_7r1Nnx.fXqgoFWMZqBdDIDcjoWg
 KrMwCIbWEWKTkOkVxsWw.mCk41di7pRzQn8NDpxyaZaSCVoXEnhabwEeVYBcjIY1YEEO6pxLEld0
 rQFFUgUPQrBtN.70tHVjb0Q.xlOfF87Olfa8d_P_90miQD05uOTq.zs0fOEJ4cOajd59wQe2TBUk
 6XHUA5HFpIUAlq01bOGUVkkpI81YUpROBFlRWbJh57MhQpWGZ
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:17:39 +0000
Received: by hermes--production-ne1-6bcfb7fb87-5nqxg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c337f88fc64cf6889317bc459f114f1a;
          Wed, 23 Nov 2022 20:17:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v3 4/9] proc: Use lsmids instead of lsm names for attrs
Date:   Wed, 23 Nov 2022 12:15:47 -0800
Message-Id: <20221123201552.7865-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123201552.7865-1-casey@schaufler-ca.com>
References: <20221123201552.7865-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 9e479d7d202b..e3dfcb9d68f2 100644
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
@@ -2730,7 +2731,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 	if (!task)
 		return -ESRCH;
 
-	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
+	length = security_getprocattr(task, PROC_I(inode)->op.lsmid,
 				      file->f_path.dentry->d_name.name,
 				      &p);
 	put_task_struct(task);
@@ -2788,7 +2789,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
-	rv = security_setprocattr(PROC_I(inode)->op.lsm,
+	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
 				  file->f_path.dentry->d_name.name, page,
 				  count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
@@ -2837,27 +2838,27 @@ static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
 
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
index b701d0207edf..18db9722c81b 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -92,7 +92,7 @@ union proc_op {
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);
-	const char *lsm;
+	int lsmid;
 };
 
 struct proc_inode {
diff --git a/include/linux/security.h b/include/linux/security.h
index 5b7d486ae1f3..ed2aae04db3b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -482,10 +482,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
-int security_getprocattr(struct task_struct *p, const char *lsm, const char *name,
+int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
-int security_setprocattr(const char *lsm, const char *name, void *value,
-			 size_t size);
+int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
@@ -1326,14 +1325,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
 					  struct inode *inode)
 { }
 
-static inline int security_getprocattr(struct task_struct *p, const char *lsm,
+static inline int security_getprocattr(struct task_struct *p, int lsmid,
 				       const char *name, char **value)
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
index 6e8ed58423d7..7d6e4f788f93 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2082,26 +2082,25 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
-int security_getprocattr(struct task_struct *p, const char *lsm,
-			 const char *name, char **value)
+int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
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
2.38.1

