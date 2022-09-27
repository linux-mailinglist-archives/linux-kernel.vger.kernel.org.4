Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885F65ECDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiI0UGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiI0UFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:05:21 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7831E05CF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309065; bh=xxpwA503SgDEv4fjB9ztfiL1XrN6vvUJr3yy4tHT8qQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XVzBxOoP96VDqM9WFzwgEV3iwKYVuCBpfmcczTtR3aavmamrsbb5i+aqJu7TvLsxNd3zZoiPOBmFDz278CuYhQkdoKnoPvxOGMzxLtz2m4D7crbdcNKU1QqgNQn7bczddh6K+0T2x54NUsHhFUO5XE1GycAM3o6svdyYwYJxrlZuGHBdAByJbQJumP/AFgqkDNxtRcB0dW/nG55e//vIWSD2mJL9pM4RU9GCHYYvr/uhlnXLMP5EQ4FZYs4LCFJo93EuGgiDL3hbxzettLo3lMmZkb6xJAfT4j1IpbUTYI4Z4Q1Q9o9/Wz/4YOwP1ID2SLf5xpZXZlInySwG72lHYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309065; bh=NMpQfb/gCVqsYgn8tyB+6Jg+AYKo6d4e1tuZcFXqbJs=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bzJfKhr2qQpfDA+CBEov80ToOh7ynENKs7pFG7unM0IT/donAb5M1CzKAfVVUSBb7xbd3aur55zyObpDWeYzljEd2DsEULe1O2ZK1nQJ/1q5+6xnphR94PHxMRBacqhymA9S8w8qQvaEYzTC+1McM2QLjIGjMo46hgZaNvnG7LsK/P7/oVpifmhKW4DBcd5WZ3iTR8efplRDweiTt1AKfZcejNHyvpyTFGG2c1sSveBkTFf+F/shtlXjHL/JdqejAWknB4+uCsiswj/Oh+YAbGaOmigonzIh7KcNTD+eYDL7Sb9VLzJaTLS7/Igq4iBbhYSSezqYdeetS+LN8uBcbw==
X-YMail-OSG: g3v3n4sVM1nZF2Pow189pfGMEpyDHrMcUxLjCtOnfUlSvdSNsozwVd3cjc4RgQ9
 ZvsOVpR8aGq3IpOq_t_W_fnzfvTVK_wLu8C.I7GjTaW4Ze2MK9VxleA3zhNfBbcrMQraBMqDVilY
 .vTiqBjLOMeU4c53sTbibTWRVr7nBsBhBh5PMXJmDuKl4gA0P5lkjWVsJTIJ52.kIS1u8wv.gpQs
 E5EIzbZS4G1kxr2wSYGDUO4mnX5U5ghKtt8bM1V0pyqVtpPodTZGWeEFfDww.C2HiXhNx0jp647c
 djHuyTFzVMH7RugxwDbX1mU6D.ALrxbsFoBO1WUvv_6E0rKlu4o_Ga.YHsYQ.YPGt7URktuJQPx6
 .D_o177mAktjuPCm8DyHzd8338fDXwuPdzLLPkX60B.G4s9XgdGmJ0PZaRUhWa2uaS4w6IwreEjm
 IkUEHcaSvp5IZUuD.AJN7liFERNyzqHn7Zu.L8v62EWRCSOEDckbgxUcX5eZ.o3JMEG4bndg.hTk
 f3MeumZuj6RkdXZTLYLwTaMRv1m6nQOiThhrdvCTENq8GQVafZEP741bw.8_2fY0qvEOiVZboeUk
 wbV3G_PNQ0d6w806fBxmorJhtKmCPEy3UeKdsLVv1gChgGyetggvxbUm1.Wt.VuDyeY7DNgLDuVh
 ihcvJrIthuDQYIxm8SY.TYH_L7f4bdX3egRDhli8ncPS7MhPgROKqtXrfZDusHo0ivqjTSO7.VM3
 epA9_wAWF57_DF1DVXqb2PpKxo5fUeRW1tipjflcYHWKQqqnYZKkENHCHEurD9wAL_9Ls0HAo972
 4NDv6jIv7OBqxoBOOCpHN6sw99UMqcYHwCttsLfLAhoNoCqT4pNeW6irCPVZaXRzAfbJce8DdQUs
 FiNDM15DF76bMXRpmuO0qI.sk1uiBdSHkcaBMiur_4BYM1CZCoJhAsWp9xdYQlihSMmERr2N.SFk
 l5bdUoQehZ4QQJAw8JnU56RVZ6xvqXkH4RHHmIHaoqLw4Ovm8PpnrKrNGAlF6haUcOgWCMj8am4W
 nkqoLV8t7n49sIsVG8uICyQnZGKJjM7JruWL9jqX5KUCVCJO5oL8p3MnoKYfTZBu0fnFRaFxBQpX
 QAAE1nvf5P7C7hSn3aGl4aDH3iS7up5YJQ2cQBSD7GbxksARUMeU60ESBUmiO3aOlLtdLh_rAF44
 tx9kgxbgjIx65S.U9gmAejdGxH5J8U90QfHlH9zAJyDvgmZ1FO8opCG4v3zaT78r4QxmzJO4dpYp
 dqvOPNMltMQ3PtNjS3mz8FPeEXCTuB.U5Mba5YLUID2mgs1HwIBqGMNowqi43cw83CoXtGdaUAgO
 RVMvE0s3ot2MiYxSdGzSSoATzqUQ2VzNwWeX15rwb.QzrZWB6vweB8JgLv4UgU9IASKM736q4d7.
 X99xTKWSFTmfyJ04DyjFyufInhhXcNw3JsuTF0d_LtYW5HED5ZE5dhd6vkW8e.IdOIwL3SGHSQ0U
 k3x4ZwXyn44vng5kTUSWO8cWtgocrY2TXom6VjeBE0gi9Tz0Ee0duZ0E8WT6SS2b8Q0YUCDwB3U9
 yigqEf76_nbTqvrXiNehNo0qw3j.1WcXyrKVwdvPiMb5NvPc.s1w7nX6EF2jaoHhKbhxrPY1tQaw
 aKquq1cvnd3UsI1nMgdVwYiuD6oEte.CCpVtMnbGTGYunEJ7Rtj5E7HMYa75dgxMcdhBzKZBMKsy
 Y2LwJ.YGPwIW9R426IMtF_LsC_qWutcxNgLvJAhdrXsVi4_kfCeuqg18MDpHvb2VcpJ1JBeEEUzN
 OXHjTGhKYMVSD81tBl6jMjfY_dI2sVqTz9C_9ONKfeh2LqF2HJW_8.i_OrbLHTU2FdY.X9DeVSQD
 M7B8y18snQ18uInmOW_nh5xny78fWrTGc7ItB5nVkn0SyCRoCGMPo4W5v62zASW32_61eGTUrX8_
 w5m2g1OKc8VrZ_hsuREQ8GAJGij5cB73DNkOe9UBkYx4mt8H8JAkPn_3DGpQw.Bm7aUgFcHEr71W
 18osYrhCEuLXtBfQCOXwRs3VYXXt.TOTsGZj1MEGiTvsFBu8mokMGBM6eYqIZ0SaciOjK3Y7wNT_
 YYkfAZOWTsU52WPIKKYREG3c6V7auXjymehAOb8CONa0Y8Uv5FiQ6LeN0FMldORuCjyPxsO78Cny
 GeESxsmNc2J_vx6Cmy7WH59zAFZAzHbl0nEDHUSscy0rItSaLQ6vE10.Qx99DHu4TOrGpXn0GpJR
 i2_go9wFqZalBgRy8zKUQk7YKg73rwGiHvkfnxiK1VIzCpPhh1h8yuZDhpnJEVw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:04:25 +0000
Received: by hermes--production-gq1-7dfd88c84d-mgq76 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 59c24ac7dff90509b43b845d0fe4485e;
          Tue, 27 Sep 2022 20:04:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 20/39] LSM: Specify which LSM to display
Date:   Tue, 27 Sep 2022 12:54:02 -0700
Message-Id: <20220927195421.14713-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195421.14713-1-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
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

Create two new prctl() options PR_LSM_ATTR_SET and PR_LSM_ATTR_GET
which change and report the Interface LSM respectively.

The LSM ID number of an active LSM that supplies hooks for
human readable data may be passed in the arg2 value with the
PR_LSM_ATTR_SET option. The PR_LSM_ATT_GET option returns the
LSM ID currently in use. At this point there can only be one LSM
capable of display active. A helper function lsm_task_ilsm() is
provided to get the interface lsm slot for a task_struct.

Security modules that wish to restrict this action may provide
a task_prctl hook to do so. Each such security module is
responsible for defining its policy.

AppArmor hook initially provided by John Johansen
<john.johansen@canonical.com>. SELinux hook initially provided by
Stephen Smalley <stephen.smalley.work@gmail.com>

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h             |  17 ++++
 include/uapi/linux/prctl.h           |   4 +
 security/apparmor/include/apparmor.h |   3 +-
 security/apparmor/lsm.c              |  42 +++++++++
 security/security.c                  | 127 +++++++++++++++++++++++----
 security/selinux/hooks.c             |  21 +++++
 security/selinux/include/classmap.h  |   3 +-
 7 files changed, 198 insertions(+), 19 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9f80b685542d..8d3b875cd04a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -257,6 +257,23 @@ static inline u32 lsmblob_first(const struct lsmblob *blob)
 #endif
 }
 
+/**
+ * lsm_task_ilsm - the "interface_lsm" for this task
+ * @task: The task to report on
+ *
+ * Returns the task's interface LSM slot.
+ */
+static inline int lsm_task_ilsm(struct task_struct *task)
+{
+#ifdef CONFIG_SECURITY
+	int *ilsm = task->security;
+
+	if (ilsm)
+		return *ilsm;
+#endif
+	return LSMBLOB_INVALID;
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..531c6e8d2d18 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -281,6 +281,10 @@ struct prctl_mm_map {
 # define PR_SME_VL_LEN_MASK		0xffff
 # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* Set/get the active security module for /proc/self/attr */
+#define PR_LSM_ATTR_SET			65	/* Set the display LSM ID */
+#define PR_LSM_ATTR_GET			66	/* Get the display LSM ID */
+
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/include/apparmor.h
index 9c3fc36a0702..c9e08102c96f 100644
--- a/security/apparmor/include/apparmor.h
+++ b/security/apparmor/include/apparmor.h
@@ -28,8 +28,9 @@
 #define AA_CLASS_SIGNAL		10
 #define AA_CLASS_NET		14
 #define AA_CLASS_LABEL		16
+#define AA_CLASS_DISPLAY_LSM	17
 
-#define AA_CLASS_LAST		AA_CLASS_LABEL
+#define AA_CLASS_LAST		AA_CLASS_DISPLAY_LSM
 
 /* Control parameters settable through module/boot flags */
 extern enum audit_mode aa_g_audit;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 25423a3aa572..f47134da6723 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -15,6 +15,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/ptrace.h>
+#include <linux/prctl.h>
 #include <linux/ctype.h>
 #include <linux/sysctl.h>
 #include <linux/audit.h>
@@ -642,6 +643,46 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	return error;
 }
 
+
+static int profile_interface_lsm(struct aa_profile *profile,
+				 struct common_audit_data *sa)
+{
+	struct aa_perms perms = { };
+	unsigned int state;
+
+	state = PROFILE_MEDIATES(profile, AA_CLASS_DISPLAY_LSM);
+	if (state) {
+		aa_compute_perms(profile->policy.dfa, state, &perms);
+		aa_apply_modes_to_perms(profile, &perms);
+		aad(sa)->label = &profile->label;
+
+		return aa_check_perms(profile, &perms, AA_MAY_WRITE, sa, NULL);
+	}
+
+	return 0;
+}
+
+static int apparmor_task_prctl(int option, unsigned long arg2,
+			       unsigned long arg3, unsigned long arg4,
+			       unsigned long arg5)
+{
+	struct aa_profile *profile;
+	struct aa_label *label;
+	int error;
+	DEFINE_AUDIT_DATA(sa, LSM_AUDIT_DATA_NONE, OP_SETPROCATTR);
+
+	if (option != PR_LSM_ATTR_SET)
+		return -ENOSYS;
+
+	/* LSM infrastructure does actual setting of interface_lsm if allowed */
+	aad(&sa)->info = "set interface lsm";
+	label = begin_current_label_crit_section();
+	error = fn_for_each_confined(label, profile,
+				profile_interface_lsm(profile, &sa));
+	end_current_label_crit_section(label);
+	return error;
+}
+
 static int apparmor_setprocattr(const char *name, void *value,
 				size_t size)
 {
@@ -1196,6 +1237,7 @@ static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
+	LSM_HOOK_INIT(task_prctl, apparmor_task_prctl),
 	LSM_HOOK_INIT(capget, apparmor_capget),
 	LSM_HOOK_INIT(capable, apparmor_capable),
 
diff --git a/security/security.c b/security/security.c
index 80133d6e982c..43d2431dbda0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/prctl.h>
 #include <uapi/linux/lsm.h>
 #include <net/flow.h>
 #include <net/sock.h>
@@ -81,7 +82,16 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+
+/*
+ * The task blob includes the "interface_lsm" slot used for
+ * chosing which module presents contexts.
+ * Using a long to avoid potential alignment issues with
+ * module assigned task blobs.
+ */
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(long),
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -691,6 +701,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *ilsm;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -699,6 +711,15 @@ static int lsm_task_alloc(struct task_struct *task)
 	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
 	if (task->security == NULL)
 		return -ENOMEM;
+
+	/*
+	 * The start of the task blob contains the "interface" LSM slot number.
+	 * Start with it set to the invalid slot number, indicating that the
+	 * default first registered LSM be displayed.
+	 */
+	ilsm = task->security;
+	*ilsm = LSMBLOB_INVALID;
+
 	return 0;
 }
 
@@ -1765,14 +1786,26 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
+	int *oilsm = current->security;
+	int *nilsm;
 	int rc = lsm_task_alloc(task);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
+
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
-	if (unlikely(rc))
+	if (unlikely(rc)) {
 		security_task_free(task);
-	return rc;
+		return rc;
+	}
+
+	if (oilsm) {
+		nilsm = task->security;
+		if (nilsm)
+			*nilsm = *oilsm;
+	}
+
+	return 0;
 }
 
 void security_task_free(struct task_struct *task)
@@ -2031,10 +2064,15 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
 {
+	int *ilsm = current->security;
 	int thisrc;
+	int slot;
 	int rc = LSM_RET_DEFAULT(task_prctl);
 	struct security_hook_list *hp;
 
+	if (lsm_slot == 0)
+		return -EINVAL;
+
 	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
@@ -2043,6 +2081,25 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+
+	switch (option) {
+	case PR_LSM_ATTR_SET:
+		if (rc && rc != LSM_RET_DEFAULT(task_prctl))
+			return rc;
+		for (slot = 0; slot < lsm_slot; slot++)
+			if (lsm_slotlist[slot]->id == arg2) {
+				*ilsm = lsm_slotlist[slot]->slot;
+				return 0;
+			}
+		return -EINVAL;
+	case PR_LSM_ATTR_GET:
+		if (rc && rc != LSM_RET_DEFAULT(task_prctl))
+			return rc;
+		if (*ilsm != LSMBLOB_INVALID)
+			return lsm_slotlist[*ilsm]->id;
+		return lsm_slotlist[0]->id;
+	}
+
 	return rc;
 }
 
@@ -2209,22 +2266,45 @@ int security_getprocattr(struct task_struct *p, int lsmid, char *name,
 			 char **value)
 {
 	struct security_hook_list *hp;
+	int ilsm = lsm_task_ilsm(current);
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsmid != LSM_ID_INVALID && lsmid != hp->lsmid->id)
 			continue;
+		if (lsmid == LSM_ID_INVALID && ilsm != LSMBLOB_INVALID &&
+		    ilsm != hp->lsmid->slot)
+			continue;
+
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
+/**
+ * security_setprocattr - Set process attributes via /proc
+ * @lsmid: LSM ID of module involved
+ * @name: name of the attribute
+ * @value: value to set the attribute to
+ * @size: size of the value
+ *
+ * Set the process attribute for the specified security module
+ * to the specified value. Note that this can only be used to set
+ * the process attributes for the current, or "self" process.
+ * The /proc code has already done this check.
+ *
+ * Returns 0 on success, an appropriate code otherwise.
+ */
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
 {
 	struct security_hook_list *hp;
+	int ilsm = lsm_task_ilsm(current);
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
 		if (lsmid != LSM_ID_INVALID && lsmid != hp->lsmid->id)
 			continue;
+		if (lsmid == LSM_ID_INVALID && ilsm != LSMBLOB_INVALID &&
+		    ilsm != hp->lsmid->slot)
+			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
 	return LSM_RET_DEFAULT(setprocattr);
@@ -2244,15 +2324,15 @@ EXPORT_SYMBOL(security_ismaclabel);
 int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int ilsm = lsm_task_ilsm(current);
 
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
-					      secdata, seclen);
-		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
-			return rc;
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.secid_to_secctx(
+					blob->secid[hp->lsmid->slot],
+					secdata, seclen);
 	}
 
 	return LSM_RET_DEFAULT(secid_to_secctx);
@@ -2263,16 +2343,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int ilsm = lsm_task_ilsm(current);
 
 	lsmblob_init(blob, 0);
 	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secctx_to_secid(secdata, seclen,
-					      &blob->secid[hp->lsmid->slot]);
-		if (rc != 0)
-			return rc;
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.secctx_to_secid(secdata, seclen,
+						&blob->secid[hp->lsmid->slot]);
 	}
 	return 0;
 }
@@ -2280,7 +2359,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	struct security_hook_list *hp;
+	int ilsm = lsm_task_ilsm(current);
+
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot) {
+			hp->hook.release_secctx(secdata, seclen);
+			return;
+		}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2421,8 +2507,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	int ilsm = lsm_task_ilsm(current);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list)
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.socket_getpeersec_stream(sock, optval,
+								 optlen, len);
+	return -ENOPROTOOPT;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index cf89ccaa018d..aad795306bd2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <linux/prctl.h>
 #include <uapi/linux/lsm.h>
 
 #include "avc.h"
@@ -6373,6 +6374,24 @@ static int selinux_getprocattr(struct task_struct *p,
 	return error;
 }
 
+static int selinux_task_prctl(int option, unsigned long arg2,
+			      unsigned long arg3, unsigned long arg4,
+			      unsigned long arg5)
+{
+	u32 mysid = current_sid();
+
+	if (option != PR_LSM_ATTR_SET)
+		return -ENOSYS;
+
+	/*
+	 * For setting interface_lsm, we only perform a permission check;
+	 * the actual update to the interface_lsm value is handled by the
+	 * LSM framework.
+	 */
+	return avc_has_perm(&selinux_state, mysid, mysid, SECCLASS_PROCESS2,
+			    PROCESS2__SETINTERFACE_LSM, NULL);
+}
+
 static int selinux_setprocattr(const char *name, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
@@ -6384,6 +6403,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
+
 	if (!strcmp(name, "exec"))
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
@@ -7040,6 +7060,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	LSM_HOOK_INIT(task_prctl, selinux_task_prctl),
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 1c2f41ff4e55..6b8569347bc0 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -53,7 +53,8 @@ const struct security_class_mapping secclass_map[] = {
 	    "execmem", "execstack", "execheap", "setkeycreate",
 	    "setsockcreate", "getrlimit", NULL } },
 	{ "process2",
-	  { "nnp_transition", "nosuid_transition", NULL } },
+	  { "nnp_transition", "nosuid_transition", "setinterface_lsm",
+	    NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod",
 	    "syslog_console", "module_request", "module_load", NULL } },
-- 
2.37.3

