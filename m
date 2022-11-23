Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DEF636A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiKWUAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbiKWUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:00:05 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83CEC657A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233570; bh=GsR8n5DLonAkMQhlHsNkvfFq5hr8VBPzd/KLtP3/Tbs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lM4f8R9eO6+fZgwXgvgFW5Hw6Hf94ti7Tg+vKuk0zaZXFDMErKUa2rMNWQP479mGw8i5ttp6Aa7zlSCp74RjM7v8tJgmumsIsc02FtP1CQnhdRX6MnsaWldTZyiIISzbzcM3SXGuUuo4DnctgipgRSAN0TT1Wv6pu8Q91z/NBFHJge2YCG8ej7QgEr6ZdSxIo6mWJkhzRH/ecPlWsppm8xFnnkp87K3VT+fbu6VbdcSCYQWqB7TnMgFbAXwomekxp/hQ7UXjkLII4d5B7AkHeFPrl7KvWPxsM4DI8FmceUdOHjKuDmpQ/Cy/GKYmsQQFu86gpdrX7Vj1jXvUDqgelw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233570; bh=oM4rcWbkzLvoM1p3KrHdrVHUzQMtHqkGwwSyQSGUynd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qoOjQ6bpT9e1UTIGBA2sLFe6x2gD0ZfIX4mnPVb0mwcKL6EKQHQNtDjHgsV3CQrnyD2A+ixmiVgr9T5bLaePt16saPI9xBeoP1T6nsjNXFfRe6rLSRwMqn6s6Z2VNt8PdGmAPP/v1sg0l0riYmM9hVg3JT9K/FRjY13EDdunNzRzBWAK0oCpq7g/ZqjZ72bBiqqZjBZQo9h15K7WP9jei7ikaWrgWw0BvcE6zjkRp9dU7gbSXKVFovlOTaYK3BtpcIb6IiL9cAi2M5ZF9KJ09/3NPLmYm9sxrNZOMXEwU2KdAxv0q3yhDTLvfEBZXG6Vax+a+A/KaMKhYHJSnYQL8w==
X-YMail-OSG: 8bi7WtIVM1lN79oudyRAD6Jwv6qMUK0m3cAg5RBUxB9XUaI26GTN4FUfIAfsK2R
 UCC3wsZ7sOC3JOB.5KhwAbFpM2veZrDJhoSkmGFnjabJmr2qTTFAN7S9H5ToU36cz.i5wRRWcaAV
 Wz5CQz.qEsfQ4ECNlvXdPsnRDsQQus6S2iBbUWSHq1BRBdGX2wgUtFTZHb2xDCkdVaR4OOw7w6UP
 4a4gB_AD7th_HH5azuQoChp_5frS6FyIqtsdwwLgUBdlsYo0fujyQ8.iUdJYKyHkiPz4wBt7SSog
 YdBjp5OvhPZB0EMf7k1J23sD6EW3mi3Ey7OV60DZvdfr7W_FgdmLideQ3_mJrcfbh3nPWco6Mtte
 dMDHvx6LbYP_l2TiE0PqhqykhxutpUkGOUP6UQ67HjI_0IBZTMxonWgKvsZ_a9qRGV.icfldakCJ
 8LoSPBKK7WX96ci.YUYRC2xr3NLFSGeuUfzSZtN_VVK2bWsM5_lhurF09cCz8HLI.KK2DoDDsZAO
 1RrS6s6bRGKx1SXoqM_xvveMpCbmo66XmABD5MXkhWg77fPsKekY0nbge9VRkiOpcZIaW.SiyR3R
 IH8wrfw5TQl4T_dvRixH5U.1kjHsNDyA0dOYk4l3RlN2FtyR60aq7sK43TsBlE_Ka9Hui2GBHlZm
 Hk89gElJGbxIxzrH7UnGQNNvb8_ZhDYGU2elIia2FcYM1amQdNyTSOOqr31_yssh.Fu1a8p1XBWo
 t67z8ZdV8.s8ACSOYuZVDmoo6rSrn.jZd9cI3Cl1b8yjrNbcE2tNBoDuMgJLk_GaG9G8qa15XO1R
 V1aBlRdRSyIWX.3GvL8fbX9q0aTBdz8wDIe2dmhwbIFCcB_e4w89gaqk5x.uzQZqJQtGyVCf09o1
 Ri_i_JmTW1jIHose7dSazoZZWqhUEpHpP_CKk_qzdA9.l0r4X46A4XaWkcz9EGHQy.VoP8yloTVZ
 DsY99loqRG1nK0VITUvnqUwg75wjWD34G7Xw0Ash1HIxdVdip9fvTyyuhNQGOyZp7W0G6UHq2RGI
 zP1HbOH8vvFgNG5SbslYAd57Kx6tPb5XdiTCOL8PuF_rxzRu1SoOH2K0Crjf02KDI4CFV2Y4B16K
 U3ibh1xy9s14lw9c0Zq2XR7stUJkyg4v7VRQXgHOyfel.JGMPI_a.5ESbr39QW__uXtPAZsqb7Pr
 H1qjd80VrS4JTb2TFIThK5JkN25VpMTbwyjRNUgwsUZRszj.mqEfMvT2u_Um5LMuGh6RfLfatO7e
 eRHKRDpO7bvPP4.H.tF17GGKcAyKbJ6sg940u0gCnz72O2kXz7P5q0qdX4IkGGc_DMlBzQUC58Dj
 bO6A_JII0y7hZ7A3bIhVkghtURWxRq1SvxJup9cL3EAvshLf8Ny8cMjJEiR0c6AhlF2Cvc.vMf0k
 OcFSTDIgFTQsO0pGs5OdH9fMtB_reZpMhR45PtKJeLkrrxhNWNBGGqjZyB.YHehGeTNwDXbdt5Zu
 06.1I__dwlk4yXkriaTTSh3hVWoQtbO6ZPaC7F1SqJX.NxzbCI9N9BEX9rpv1ZKE7ReBFWr00D_V
 VXIvoQAvsysRJbQTb1WVO4w9frOPKxvSesCRRW3rGBhc3bqnT.E0n9d4rQkbeMIL1Za6H0bj1gwa
 gFHvsS4mGx2kwT8sG9PQDnqYOsiuEIK7.PDksEcANNf6zwS4IGqmB2wR0u4yXWG8GWoxeizVoNMP
 bLItbzPI7lc5aWPAhfnLWHbLhyLRNaG88cx8sZMh6Reqe_K0T7LFueFj5v6u9seKJHEAzlvXgAKG
 S6FtkA8yo_KOhr9_KGx03zgY5AXiWMyrVaZc.r27Giu_pzE6DT1ok0Axy2DP0Vh7rMd5Iqossi8j
 ZTDJzzQXfdEApSU.8hBBJufSmSjT0a9E8lStCvKpuf9MUoA50TNVooejWZRnwzx3grQ139EKZgzv
 13PdMg2D.IM6wWZ5zaejmDtS_DX1AuadgQCYm7CJ2Zk6Tnqqh55ONBHDGSh9VxFmy3sW3coTaJk_
 akebIrzyIDKjULfeplKBmp3XPX3BOxicwitxG43_tzcHJCWIiVAVBE9amMFe6k.lv31C7rvwqHcC
 8zufKPKGfC_DoB.4QvjATtqrU4HdhdY6i15NU5Mr0Dz_klSZ1peHxj1VGU4DwxTjNSvnLTBHSf40
 x_jQuXjFcrnhIZFRHwrZ3r9xMIp3928BOncH7hkNQlVqdsGcc1hrMdAt0NnajZDz7h9W4pQr1Do0
 A_BULcuPAqHjEgWLQfMTiNsuvyHk2k.emevaPepA.19I-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 19:59:30 +0000
Received: by hermes--production-ne1-6bcfb7fb87-kkrkf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3db3b97863d7dcf681a7c4ed78d526dc;
          Wed, 23 Nov 2022 19:59:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 5/8] proc: Use lsmids instead of lsm names for attrs
Date:   Wed, 23 Nov 2022 11:57:40 -0800
Message-Id: <20221123195744.7738-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123195744.7738-1-casey@schaufler-ca.com>
References: <20221123195744.7738-1-casey@schaufler-ca.com>
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
index e1678594d983..8e0bf4a88553 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -481,10 +481,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
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
@@ -1325,14 +1324,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
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
index bf206996a2af..29d4fc6f789d 100644
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
2.37.3

