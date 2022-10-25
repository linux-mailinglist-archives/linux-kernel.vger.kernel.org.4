Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58F460D3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiJYSrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiJYSrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:47:12 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6FC102501
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723627; bh=GsR8n5DLonAkMQhlHsNkvfFq5hr8VBPzd/KLtP3/Tbs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TqhHtmiNnou15b/izAg56BMBmlIdPkn/Q5TTjf6IfYFJJUxSo3UnmolzgXiQsRu90LksoH/rPIEgAsD1b1X/9qzCtPk7vo3kUfwziwBDYNB91OgjAOevQIXLsQB+Vxse3Aj+e6FbD2u/4TtHuf38FcfNZpTjaA1GDEA8jCvrLN2l+Vzd4dVehXDa951bOCWgOw2ejC4oX+8bjmAvbMSaaOA7YD2Qqku3TETYtFCTTyn3NoQZFUXyUJxRiieLCrZcezr83VkcTdDayN4tQ07kuWH/TPyF2uXOYEP9f5hrVUxDapN1ZPDWbAXUhsRDF3ZkJom0XWjNdne7+5DiYKFTHg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723627; bh=X9pdM0OTIyN5MN7dfjPwP9CO9vr6mwjpjQBIoFZSAZj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VnACgApgR+5JuVjMVA1h21DsRlkP+W3ll8sJbSwHfjmj8IKMsvk6hbGz86BWgnTNXAwY02mcSwg9ZZ1gX2k5WbSyQLEqItuuynE51YYuB1mvs8FXoFeoGYtULSEaOS1+zBWcGOpCvAv6zaNLeHbwLEFKjrxlXw1Hk1iuadEJGW0EZGtHphEt98R++W+5PeeHEK3zkwN6wikp6HaLK9nrDXV6OVbsUJG69TEsfBCk3rPPOL1lnMh/RlHXyzpf3abinlU6Z1Ka7wFxvJkPkGfpuaBntntmdQmGyyseE41m3fTpzZpUOISx1vHe96ZzziqWRvDWeBTeTRRTGTz6GkbZ+g==
X-YMail-OSG: omd.OqcVM1kxn0jOgXIoooUYtXb8LSPkFedjLI4zl8x6EpN.QANDUbqqCkT7uzI
 15rNjfPBRFH75tGExO8eCjh7dMo4geH2Cz56rxwGpcfl18t4X017.F9pFFVNXoSMoZaUFQGhHZ1d
 1mTqeLXXtSI1vISwtmdLQuPJsFsqlMvRIFb204LR2ikS7LySWIw0LQDiu6XX3LTU5DZYbklHKRNT
 ktB4GrmyP.qi2jJOJehT7M9a3JeRAclrUyO2LZfqCD74p35C1j57Rrtasbk647vlnMcM0joJEhv4
 k4ZqToRbyVWGR4yf_wjEDcAGoiMUAxGLxRAf1zTRMsV_TfUsuzUdYBVWWZg3YOooPMqVa3J06uga
 QJYpK.jgoPBflfSoVWDVH1RGsgZnEWxOg6804tiUstgJFn0E8wwdE4wBa8titQpJKytjUcObBdhs
 ICXsmz.dd4llhFaIcYu5QBy8GOq2amtN1NJ0qB1qSJMaWO1XStIPOXC9vFXHHDaxDKqdOlKZ8oFF
 PVy.dEpb9JAvqfjl4K_G052uaZl2rhbH5LOB2TXgEu2LDxbj07naWgV1TU165jKNghV7x0yA6eRP
 wNP_PqDk_qtXqlib.qPfeWMTjeXWzgrbR7kMZ8b0rMjQsd8IqZdusC1b7MdN6yQq8Aju0EyEXMPU
 Lo2uNKQ8ixpTS7kb77TanK1qpD3en5L3bIE4c3I9KCXRHn7NQg1AHFtZG2uEPECOIdv0SWEMOHsd
 a5kJifK2tLgmpl4rZv8zOopqqxNtJ6Fz4EadJ2_MisJ2JdsNkCPSlMr58rglR5z8cvJ8u7JDH0vF
 sxlAduk3WbzPfoDbM3HfDy8F7G44vFbL8TzyDHnhl8WSYXXElDlZd4AgGX0JVgIWmKP0EWsQ5VvN
 tKPwBOXbVDnTUH91OKL_MLKUaS0yCgEM8UFIYOVCcu7JI8.KA8EnhYoKHWOMuf0ZKHtuhF_3fJAv
 7b2TQNgzZJy1aMyxe4Lycis1G9cP02iZIRUzBBPoPZqG7QAPO1DfbggTEMrGf25wQE8itEL2AgDC
 bphyTl4aZ_wi70NeGbXks..mN7m6erGDkYHMOwBMpIAWXzFD6YzfcjrkI8P4I55iEiGAEJBM0JSJ
 mV_2iLO6rm9RtgPudZI3W_Pew.W_63IgY2c0AY2FupmbniQFnqTibWPziTo4bwMnceK0ENTc1oU.
 2ySZc58c44gcE.TaRZwxM5KPLi6k9DK_4ZaASJ4BHJmzTfu059l2thDfNt4gw33JgtmUrPQhZaBT
 HO_IZrPRM.zeIopjUIB3c.23gYkqCYuFgdpE_dsa9HM1qzCANCmpw5I6U8oMYipcDYfas5YwM8a.
 R08I3KmT8xY4LRpcjjD_OYJLgdtgwjZhNSOWo1moWI6BmWoBuWqi0j766hgUKJSN_8VMsAA40TkG
 es9WV5yrxQJK_S7Q6JPFPmkYAnJUuMDl_LunUFHvZsttcfwween5qDj1urPH7TzW_CU7gC8W2dH.
 2fD9j8g4RRHCLATbOq5Ono.SD77l.Q_aiHX6B2uSUG09Ok5YPfjVE06PNXHrpi_Lok4NRCUygb6I
 UT1By4KLha2lnzlJNE9Anxa2JEsncQ8Bu73ON3.FAhWKOHAmBI7BdSUSguAGGKbDsZ.VC8TYQc28
 mGu3Nq1GzJuOtGhNXA5aSblydB5fYyLM3wU7uENqyQ9W5gt.62LTqqT1.j6tRktcKixzlInt6.K7
 P8se5Eoc3l2boU244BAbLT9I3Qr0mqRM9__TD0nGNLO1LsohSUa13s_9QaPk8_uaWS9SWqlT9OKW
 7Fetwp8rDIMzsh45tW2J3i1vUnGiBphmhJ.CbP2qQXllS9UPYxvcbeEby7vutGT1xOczip9atGuU
 9xM8UXZLc19dxxz8nK7JZb2nnfm8gBxE_2C7ix2yKtPmeBc_tv.h_colEaStolfklMHVbYZ3g.8e
 yVmYvlZ_XqXW3GeRg8ckYnOBRdVHptMPO_DKkROJdDjYrioPchrwtVTCEhKsy55zizJKG4V6ppDZ
 EUbOvsdxZeaK0EcH2q0UKoAhS2FoWe5NU9X_a.96Rd2W4ukaPB3d7ChpS9KfWIVtNBpd7WKfxQAP
 9fkenDbnZ510KVNyVAuyPRNFb_24RX7fCK2H7hMyj4rNxPomMsj55Ag3401YnQXNzqDTsWH4ZA0L
 jmy7lyizSEg6b7PDxMBUdY2llhPR1gzVh9ArehbAFewf51H_uX7gdo3v10Q1QrsctydisvumkuG5
 oNwGDC2v.JKhO6QJBxT7UUKuypRHtwCyqjmgEO41f0I8oF2lAn6sboh3tJTnC56DwkR_9epH.jRM
 hmYpssqVJ6GbR.BjmQAa6jrjp
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 18:47:07 +0000
Received: by hermes--production-ne1-c47ffd5f5-mfswp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ff43769a0d5883148e3027385165ea8;
          Tue, 25 Oct 2022 18:47:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 5/8] proc: Use lsmids instead of lsm names for attrs
Date:   Tue, 25 Oct 2022 11:45:16 -0700
Message-Id: <20221025184519.13231-6-casey@schaufler-ca.com>
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

