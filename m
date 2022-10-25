Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A3A60D3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiJYSpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiJYSpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:45:30 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B8D46621
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723527; bh=JARP/NpAJnvAW8bEed4MotaU2iP9MbULMTHRb5KT8J8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MT7KGERcFdu7OGGDNJ1XEIYvlfePYeV5a1zBFRPMhh699oOMWOaog3NbpnIGwg79yHXhBkCEMpRGS9fK9EnKwm10UKo9jHGDhZ5/0XoqxhN6lmoaXiS8vcf9XoCpw5c5iJS7J4X26aDwcsLirEeES9h4z+bNWajR1nXEbvzNwiwgNaOTTeHfNXUGOB2b38CZcxjcrCicXeL/Qf7eI5II0IgZb6H/tXAK7iEhnWhXit7cxtKfj2q5xf6Vz90buarlzkE/a6pp+YzMmwXrT7olswOAS0dBUjcJu5O5nmiHkK1HR19JC/u7CwoVQc5uTaD6QLT/mkx7WXkrFiplS6W7EA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723527; bh=DtwKq9JjMQ6drYhmCRTA0DAh8uYBLRsZsyciouYTIT1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=q70tsLz5dbiA0hPPH2QqClmY5Ui/ToBF+nKmQysy2HPkq+hjHTqsVv0nJe/hOU25m2lFfDCzDo1Hgntla9rCUxajrgv7f9w+DsNsTh+3COuIrLfKX/iBsLGemhtyJWYFnGuhGVYfqfNFljL1psdYgMPT7Gpyzx7zkOTyow33w2FKGeYsgaPR10crOJkSAuMiI/vgOZZszNqO+iItnZWbePdi9vINDCHMZBDWonWkEhr6CnZGhKKuGO/DRC0OQs5Knmo83PPwMawDdCE5h55FIhTLh6WBK+4VWBkc2HcQP1itNwzUHUfXKxHziJlbCcBEQkWGw9KBpgAme3/OdXMfJw==
X-YMail-OSG: eQg4j8UVM1mPENE3C0V766mLSXyH1A1lDtcNkJvUS0bXbGED1MsyUiFXiGfxPSS
 vP8Fyf2auyQ4ZNxWAgI1lxid2Ijy1Fxw86.cAgyg2Rwa.iIYAyC6vCxw8SZuTy7nEy1IBCmUgqvh
 B7vxI7d5Y6tzRqoFLXarpVztzcLkvZ7pDQGouNF3dr5PkWHvNudO9YuwwJO3qsP1XL30n24MTUdF
 OLqLVgtti9PuZMdvcPoy7KUZdpA2VJsOU3nnfzz39Twtu7Q2FKWzAFEc3UvS37Z0ztqQr6dM2rBg
 g40JZ8yDmXGHu3wt.2AAmvRo4SHQbc056LANZZG3K780UARZppLnHw_Gp.Tfw2QZUc1F9SnYcWMa
 iStO5lp1fyTFX87.mpT2zGuACVFIKiOosAjXwRe9iuv8D6dScUUFI3YEe6mRj8WmYahMEEsROSYZ
 M._OKYWWcfnpZ40W4sgKeHG7kGzf5eIIwiYyUDwdk6jgcCo0insuLw5Kziia2eiGtgm7SeV.tUjF
 Xu7p.3_ZqSzOsp2H7IhYuOgw5LuPFvPqgmslQqNijcb1AJ3CcKyjbyNz3MDDsGGpOHPmf.bosWyC
 Ij_L01Zup2ev0qsLsGble1gYF7LKEur.uogRXFba9txXOQpf9plBoNh5z7YO3WulhPq8IpnEZwAL
 tOE9gpRZa1B5zSS85Ocz1veDfB2wtcL3xupB4JBruK_xA1Ys6yP4UipBnXowVWix5kZHFEqQ3.Vh
 QOCObvMxphytD_fj_ySN_ybef7fFPQ5c2F300evRSlAoTh8votNSNA1tUb1rq_..4mqcMN.s6j1Z
 DsQXVATJeZIvis5dbrhkOUmUa_GYjjbUC1eh6LKB8HG_llWu7jtoATs8VIcpjJEvmAszLk5BsMW0
 e2sTiw4P6HrEjUnycmWCiSDwa9Z1GWEnpc5qINLMqZH0eSQpIFAbwQHfhtfLnqeR502a9mbSq29e
 70jeH762cTofuHAWvBlxdU6tTPmCgmfc36jQjV2mh95c4Z1kfBFbLK3BoJGyHTjbvCvBTEuDiJ_e
 p1Bcxw2gxHLEfbckaOqbVFVaiVfG6l.z7ttZUcKdefNs9xaKLzYzvb6QpDX3avvSUe.pZ3pwntX5
 l5tvYXIoWX4Wc_lfBgSX82XN0Q9JgXp0r60fdKYG7xm2tOZLPhI1GsjQ6MIO9b.pAXu_I3TBkp5k
 6fQsnyb5_3Zg4MgeJUP_3bGSlbeguzx7.Ert2XDwxv4.GIjV2AI.GvGpWnQ4XICxf5BqstTwK4_.
 BOR4Vh2bm1wZxdrUwiMy3dM_SlT4XgDZqeRrgn2KHvjconKLvsWjT3vbeYVp7odMmEU6CO7hc7M2
 NJ2q.umUDV1J4j3ERHUZ2a9S3qZLusvTNBPSzmx8td5ZItfl5Yrb4C5uXCzP6LVhTuMc85CpqzoF
 KplrBsE7xGn76gs98kIOWWQCwlfAPziJxLBRmMNTLxnmv6_86uWeoiA8vI6udAshjMKhOoxEyK8a
 5sYtIBEkYj5XUhRALyrJUtFc7O4Ub427Rzl8Tetd3R62THlaYUqz1HE.oKEdUEd1OlGUtAhwxRs2
 nHlPwsqsGPkBX6y15FhEub0t8UvyMgwnqWNd9w4494kLPq84nSFoX6orKeZAUdCcLCXaJW2lbxyt
 7qcNLad9HPMdIQ9cUc1JqHkkCLE2Y7FeJ.3cGzbkTragc1wVOP2sbeNeoglFgSFXpvm01wYoInN_
 D9U4hoKqF.iUL49h39QnQ4tu7TM.cdA5W1WzWfJDfmDdSw1YF2JIqMUyq8RS1Tubj3SfdvpqUqNG
 VMfdZ_kNeP5IAbwYTcAIKYjM37WK.KEY_4l4nfjCSOzz.RRcwRFOCVOha3YFaKKx6yxKcMBgX.8L
 iZUrx_eONgkb1QImiUDsqV4w3lLf9yTFqkWXN3rXEGOIv4IQw2g4rQtYdJfm4i8Y.9nbN.JbbRuG
 pTSryvxo9P0D5beANzozFnsIYeDSRguUe4ppGGYZPFVPIdteMCzqVvm4.NjFblmLX.vCitb2DchS
 BHxl9TNCdeyjdZ3pzyOE9S5y_6af7QxpheVvXHtjlHpW.Yt4S_9ciUFJWZTUZmBa0CBaPG12VmqT
 gKWTT1suCCdXMZOmJD93OPBcaA5JG6.FiUes_UDO62z_QAV7HTQ36v1DU3O95a4HIBj3wbPtzy3o
 d.JLXh2iUKx9zi462ncBFnh3Qe0b24vuKaR5Gd0WQDHcHDPqC.XOOPFdQb_blsSzYMAvTTvSlkDA
 5Fwit954cZDj26eiEc0IiDegOYsGLIUGJH2k8_MbBW4dU
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 18:45:27 +0000
Received: by hermes--production-ne1-c47ffd5f5-h6ptj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cee108ccde84a9105dc7ebe9516c7326;
          Tue, 25 Oct 2022 18:45:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 1/8] LSM: Identify modules by more than name
Date:   Tue, 25 Oct 2022 11:45:12 -0700
Message-Id: <20221025184519.13231-2-casey@schaufler-ca.com>
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

Create a struct lsm_id to contain identifying information
about Linux Security Modules (LSMs). At inception this contains
a single member, which is the name of the module. Change the
security_add_hooks() interface to use this structure. Change
the individual modules to maintain their own struct lsm_id and
pass it to security_add_hooks().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h    | 11 +++++++++--
 security/apparmor/lsm.c      |  6 +++++-
 security/bpf/hooks.c         | 11 ++++++++++-
 security/commoncap.c         |  6 +++++-
 security/landlock/cred.c     |  2 +-
 security/landlock/fs.c       |  2 +-
 security/landlock/ptrace.c   |  2 +-
 security/landlock/setup.c    |  4 ++++
 security/landlock/setup.h    |  1 +
 security/loadpin/loadpin.c   |  7 ++++++-
 security/lockdown/lockdown.c |  6 +++++-
 security/safesetid/lsm.c     |  7 ++++++-
 security/security.c          | 12 ++++++------
 security/selinux/hooks.c     |  7 ++++++-
 security/smack/smack_lsm.c   |  6 +++++-
 security/tomoyo/tomoyo.c     |  7 ++++++-
 security/yama/yama_lsm.c     |  6 +++++-
 17 files changed, 82 insertions(+), 21 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4ec80b96c22e..e383e468f742 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1602,6 +1602,13 @@ struct security_hook_heads {
 	#undef LSM_HOOK
 } __randomize_layout;
 
+/*
+ * Information that identifies a security module.
+ */
+struct lsm_id {
+	const char	*lsm;		/* Name of the LSM */
+};
+
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
@@ -1610,7 +1617,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	const char			*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -1645,7 +1652,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f56070270c69..e708c1ad7267 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1202,6 +1202,10 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
+static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
+	.lsm = "apparmor",
+};
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1897,7 +1901,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index e5971fa74fd7..ef9b1d983665 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -15,9 +15,18 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
+/*
+ * slot has to be LSMBLOB_NEEDED because some of the hooks
+ * supplied by this module require a slot.
+ */
+struct lsm_id bpf_lsmid __lsm_ro_after_init = {
+	.lsm = "bpf",
+};
+
 static int __init bpf_lsm_init(void)
 {
-	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
+			   &bpf_lsmid);
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/commoncap.c b/security/commoncap.c
index 5fc8986c3c77..986920da0c26 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1446,6 +1446,10 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static struct lsm_id capability_lsmid __lsm_ro_after_init = {
+	.lsm = "capability",
+};
+
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1470,7 +1474,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index ec6c37f04a19..2eb1d65f10d6 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -42,5 +42,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_cred_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 64ed7665455f..486ff50d54a1 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1201,5 +1201,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_fs_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
index 4c5b9cd71286..eab35808f395 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/ptrace.c
@@ -116,5 +116,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_ptrace_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f8e8e980454c..4a12666a4090 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -23,6 +23,10 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+struct lsm_id landlock_lsmid __lsm_ro_after_init = {
+	.lsm = LANDLOCK_NAME,
+};
+
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 1daffab1ab4b..38bce5b172dc 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -14,5 +14,6 @@
 extern bool landlock_initialized;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
+extern struct lsm_id landlock_lsmid;
 
 #endif /* _SECURITY_LANDLOCK_SETUP_H */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index de41621f4998..24d041a888b8 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -197,6 +197,10 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
 }
 
+static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
+	.lsm = "loadpin",
+};
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -244,7 +248,8 @@ static int __init loadpin_init(void)
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	parse_exclude();
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 
 	return 0;
 }
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index a79b985e917e..2004d67f7201 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -75,6 +75,10 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
+static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
+	.lsm = "lockdown",
+};
+
 static int __init lockdown_lsm_init(void)
 {
 #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
@@ -83,7 +87,7 @@ static int __init lockdown_lsm_init(void)
 	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
 	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
-			   "lockdown");
+			   &lockdown_lsmid);
 	return 0;
 }
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index e806739f7868..d9af1d04d293 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -261,6 +261,10 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 	return 0;
 }
 
+static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
+	.lsm = "safesetid",
+};
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
@@ -271,7 +275,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index 79d82cb6e469..b2eb0ccd954b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -476,17 +476,17 @@ static int lsm_append(const char *new, char **result)
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
  * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsmid: the identification information for the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm)
+			       struct lsm_id *lsmid)
 {
 	int i;
 
 	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
+		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
 
@@ -495,7 +495,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -2070,7 +2070,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -2083,7 +2083,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f553c370397e..aee20bb1778d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7014,6 +7014,10 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
+static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
+	.lsm = "selinux",
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7334,7 +7338,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b6306d71c908..0c0fea933bbd 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4787,6 +4787,10 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
+static struct lsm_id smack_lsmid __lsm_ro_after_init = {
+	.lsm = "smack",
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4990,7 +4994,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 71e82d855ebf..80fbab5d2d7e 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -530,6 +530,10 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
+	.lsm = "tomoyo",
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -582,7 +586,8 @@ static int __init tomoyo_init(void)
 	struct tomoyo_task *s = tomoyo_task(current);
 
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
+			   &tomoyo_lsmid);
 	pr_info("TOMOYO Linux initialized\n");
 	s->domain_info = &tomoyo_kernel_domain;
 	atomic_inc(&tomoyo_kernel_domain.users);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..4f60158850a7 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -421,6 +421,10 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+static struct lsm_id yama_lsmid __lsm_ro_after_init = {
+	.lsm = "yama",
+};
+
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
@@ -477,7 +481,7 @@ static inline void yama_init_sysctl(void) { }
 static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
 	yama_init_sysctl();
 	return 0;
 }
-- 
2.37.3

