Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EF35ECD41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiI0TzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiI0Tyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:54:39 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010CD3A5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308475; bh=E4e61Bm8ZJonsCrNDeOIQGYY+j8P5/t3Ul9CF7XsaQM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HRXjg+L2909FmXXDn7fb0VEGKRAv3Sy2jxBaOku/dqU8uQsV5/qbe86QZ1i1TCAdZIPRm9onzdmHy7cR6wUe/XbMkvBFduaG0ZT3J/WcR1TfGM+ougxmK2APxmqiOxykBM2GHdjSbO+G9WY94WJ73BoLRF5dOU6UMda+GlX/vJeBWYnpTcndvKFbpDAfr4VdGITE24VbFAoAXtFF0M3tDnj8zyst129eFsXwoWf+rAmfoYG5ucxADqQpdyLLBjJoiQ7ped5/CYQIYY94HLcDPZPVDame5yAqkBa5ffPhst6Mn4vHDkAYI+20wlzuukb+LjJeJWSwxYat9c9Gt7DcGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308475; bh=s7cNGujeoJujZvib9KgbbJVKSPHL63DrjV8ner8TEta=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WS2ALvL1+51wY3kf1ij3u1QVmykZcFDtJ0u2/MYYouvEIoU3YFg/dBN+xQx+U6ADJWAX7BBUOaJ/Gxg/8pJsCA2GRfi0eivx/TU/W/Kqz7KTfjseQ0bvotSG1YKU6mxM1JAPkOp9if/7ExHWbni7E66MQ69/RdvBBRtYnHkGc97mNWlQUaYZAd2dQFm6xTmB8DucKb6+GVxvQ6hjp8vXChS94ZC19AGJr2W4xWGDBmkKbmPa/XOcnycgvxd4o0Vf8UnECAUBqpWAP8T4KNPHSoKJmNWxRkmpDMTV8AB1VQn9xide74Vdy8A2CRFj9x3LrtDNj6QjTlNtOluDIMFxBA==
X-YMail-OSG: OGGK4DwVM1mroTEvPOyIaR1XxZV6nTy6WezbLhtDKsxRu12GI393P.MRaCifSoS
 PgXgRl.cL7Xk0AoqH29_9wof5mlWj3l.rHCDKvBV4sBSI8_KYrA.MpmgrGhREKHerBAdYzE_vvXm
 LPe1eb_6WbjLPlGpScI44S.WBaaxmntSmw.pVmUy.nGGrx3OlvdFBG7i4nvLJNOEzMIC4W_frDCu
 IQkMbUoKqy7mKcsPjkfBdZUSbxy1JHhaNckoninAmhoPWVee_gPNVwY6KeDGVZ8Ly2i_6lXGTD49
 01R33W8rLBNvurM6ZLu1t7cZx9bD00tjxlnmWJ18WVZOxQjlsyP3uzG2Jrqs9QP.XS4y78AKDDWp
 jpB37Kt4aIprFv.g_YpR77kZpMoy8GAel0ARH6CQkUAPLgjzvn3eKn8_mqeJWqzqtVUE07UeLajp
 _shIPFwBtSBmpgiZgT7nbTOWvkdT4cXhHGUzlxsgfHL3sCdP.EYEGZ7nK_iz_K8wGZoeSNhIgZQ6
 QFQBZB7EFZub_6mPOGCq9xdMY4NtmX3vk9A3RKYSz8fEVeCtdhp7kfcn4jPcY8dErhVZnryso7c4
 Z2zNX5aGWHRiRU.52rZytlqOAFT9AvRfxtCmXaLteOioV8LwIqUztpc7m4N14PbT2dreHtXUcWhG
 X.a_AszLJ6fR7yQzoU4LSF9Cq3N.GBNzycd1v1lvwL2SXbFzF_5edAqGhgctqD6lAbc_C8VqdCHu
 0YHsYP5uZ.FKIE2msE.2hFnlCq0noYImGMEfIJgve4z3.qt96G8OrHtrDlDpR3KmYJ9mUVIUXPD3
 r3BiTGAlCFjNDijRdBGaF2pTPcWpx2BOEYS3SjzlJdHzCUtCll4b._6GopiS1TXC0lluowA90q4t
 FI6qFO5qR9wYFzwdK.1RSyJO3koqpzN_HuxwjN2LRsQ8rWNC5njcuO2zF0811LsFnf0XdgJqO47V
 0weYyE_UtF._F8yyeJuz6Ib4ErkXpOPNplJ1pGwpIs7ZrcMZuQki1UnpK2xDEv_IzEJVzZofFayP
 vqa6H5VovVLesW9PCHbHklWcn.sh6idaeryLfwJHAJn5xc.rVjWDcE9uzNpdne7_MKccKveMB9_t
 JcBYYJWZigfttYNWQo89UHyWUh9KwgxSuwpafVvsY3gMdyP0U_dMiDABBzp9qEZYjnsfadTCLQEr
 Aj9jJE2erAPOsxnv5H8W0U7zoiRucIzVNMob4Ldqoi3YL7nABVi0BBxL_aUjz_g0kkXPYUFWLiVW
 Uu5noJtVtjY0B5J16_ZQUN0iAv2SPOLggH6fTbHeHuLcE8znFs5ywWk_bR4LTgweqWpvW51mma6V
 8.ZDJT75.YJ0VMuGLCtnv0Sl0SuKRnI1DRNPXz9axSU9ah6_j4awFN4eaF0UFv6C2OgFRWF877vc
 .EafWf.aRnbEG1qzbOnC1GElIUcPREZyqT1awWIzuuyzOHrqMRKLm5tJ9i_cugbz1CnoDn0Gua.U
 LAqdWdanbZyxE1b8y4dNpddEVWnoOciUzd5twizUsgj6fd6XrBbVMI9ErnT2QJOceAFja4Brzqx3
 aYltdu2MhT93FnzqhfqmOUwEwqUSqFfEglzWKhyP3JoQByKZgrkg1KGgno4P64JmV97r5Yn7bjMi
 Bjb9rxAiCrttJbm3SFc98GLciCo8tROoNfWD1Xko29gHuGZUO5FWuOKZ7Q6j6DvkWPZLnS7Ys9iY
 WYTJMW1iur_pd68xJp3xc2IKpbpggdf0j6pviT_pGgQ_weR3zqoNpc1d8YNg7JZEl3jQrKIjkXjg
 GWr0k_G3UhM1H6bHjcyhZj33A51upD_ksrGm3l4WNyDZAtfl4xYSlfsY0pagRqqEUQ29QrNk62FW
 dvOeRvnbIWqSAsi5olT8wpD_rKF1lxovY9_Frj8WRlB1e7BZC42T4dEXTLl9rrDeYn2BkZS1yyKb
 seIGDvMwT8CudpkgUHnVaPYFZnLwZoF9chZzPhNSzN2XqMkmHA3q_U3ER_iu9NDxNaZpersZ33Bc
 TPQcm6rR10NP28FBdHuENtwiGJNgbp_Q5aQigxLN21pU4i7Zv6CVGR3gta313tH21RN6EC4kjEJ1
 OrBp8t94cSSJ6kZ8wLsMDOh0bzINMQe9eKvyxZPg.FTaozUtfyna0Lizpxj.cuIm2bhJ2PzJQyRK
 R5dOOjrX0i3_2sQzQKO.hgvs4xDVUDlFZ_PA2REKPa4jklFh7yjnpUoLF5DMIo.8P3L2yoZovEaQ
 NvlB9XN8Idcf_vyJhkCh3DUevnnK1pC4toA7vEdymbap1L_X9djk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 19:54:35 +0000
Received: by hermes--production-bf1-759bcdd488-njfbl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0b959d6dc02d7e129b663c80c767d31c;
          Tue, 27 Sep 2022 19:54:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 01/39] LSM: Identify modules by more than name
Date:   Tue, 27 Sep 2022 12:53:43 -0700
Message-Id: <20220927195421.14713-2-casey@schaufler-ca.com>
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
index 3aa6030302f5..23054881eb08 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1598,6 +1598,13 @@ struct security_hook_heads {
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
@@ -1606,7 +1613,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	const char			*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -1641,7 +1648,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e29cade7b662..b71f7d4159d7 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1202,6 +1202,10 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
+static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
+	.lsm      = "apparmor",
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
index e5971fa74fd7..e50de3abfde2 100644
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
+	.lsm      = "bpf",
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
index 5fc8986c3c77..dab1b5f5e6aa 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1446,6 +1446,10 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static struct lsm_id capability_lsmid __lsm_ro_after_init = {
+	.lsm      = "capability",
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
index a9dbd99d9ee7..b1515fc67d57 100644
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
index f8e8e980454c..fc7b69c5839e 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -23,6 +23,10 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+struct lsm_id landlock_lsmid __lsm_ro_after_init = {
+	.lsm      = LANDLOCK_NAME,
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
index 44521582dcba..7e5c897ccbb2 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -195,6 +195,10 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
 }
 
+static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
+	.lsm      = "loadpin",
+};
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -242,7 +246,8 @@ static int __init loadpin_init(void)
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	parse_exclude();
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 
 	return 0;
 }
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 87cbdc64d272..2af4bff8d101 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -75,6 +75,10 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
+static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
+	.lsm     = "lockdown",
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
index e806739f7868..3a94103f3c5b 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -261,6 +261,10 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 	return 0;
 }
 
+static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
+	.lsm      = "safesetid",
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
index 4b95de24bc8d..ff7fda4ffa43 100644
--- a/security/security.c
+++ b/security/security.c
@@ -474,17 +474,17 @@ static int lsm_append(const char *new, char **result)
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
 
@@ -493,7 +493,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -2063,7 +2063,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -2076,7 +2076,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 03bca97c8b29..5e4938f3ce11 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7012,6 +7012,10 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
+static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
+	.lsm      = "selinux",
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7331,7 +7335,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index bffccdc494cb..5d8bc13feb09 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4774,6 +4774,10 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
+static struct lsm_id smack_lsmid __lsm_ro_after_init = {
+	.lsm      = "smack",
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4976,7 +4980,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 71e82d855ebf..38342c1fa4bc 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -530,6 +530,10 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
+	.lsm      = "tomoyo",
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
index 06e226166aab..ed6d45e62e0d 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -421,6 +421,10 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+static struct lsm_id yama_lsmid __lsm_ro_after_init = {
+	.lsm      = "yama",
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

