Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4DA6BC01F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjCOWve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCOWv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:51:27 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1421A231E6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920627; bh=iOXNKeJzMcKJmHYMnw6KavWs/Fn7DObPOeEurKOnwpE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Iurpvham6ycqSSOXCkko2LlwD8dTg62HpCQ3oasx8UF3hW6g+0DDnrrHBKZeMb2A4ojCIrmAyjqEzBDsXf3kfgsMZ7f1I4bQ5H4oP3JG4l2kyOlrfrPiXHvs2tZdYci0MBWVFz30vWIim2t5wFQTebNOad6f3lQXrGzNK/Wrgxl0dlUHfLBO0P99AHIvqEkiKpNr6PW89ULbrLHDkvgVYM+Z/EY4W4NPadC5YX02HKDrAS+rRlblziGzlQztGX3vc4B554XMiYSEfPdgkEGJlUsEnaO31qLwOYL6VX0MUAmcnS3HhyBqvXuIkUMUynKAfB6S3vP19brSfQRu6bdEGw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920627; bh=MeNtSSqaIbKawRDtgUERAoJZpzOiiuSjYSBt0+7uQ80=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DFfcOcU+sK9P88R0EhcpSZdH/nbtjuOOni4C/n6GMs2FknHhZY1BGIuiWNJZmPMrze9HJdB0zTnkuF1XsG+fq3qHZ8oDfjDfslgquwoK0yqrxEcGCd1ol3Jd132gKWe0joFsmLaWd+oReNaZ5hyZG6SkpGOQs/DO/GSd/DKeF9N4mycyg4EnCFjSa187ttN88V7070wPLVJiziezr1khd+7D7En6IiWCLteIUd+6r+c4gaIa0HDFavIuwfZaEA4S1wi5mkNesxhFAg9AL00GGk/PffIEQYSXNwIIwfBrqve0r421mbiLteF6C64ciBHHz7fGHl0mfh6gcb1slI6NVw==
X-YMail-OSG: VNuHjVUVM1nWpZv.HX_1Lrx93NAoyPbqGRVK9unYFMDj4InAJjauhsZuXfc0w6a
 PPCXlNImomlZ0n9sS2Dz2JAPjjB4Nl7Zo3YtYbtdlyUDVAL8rssBiLTidEby9GvJInbAf8PrIPuh
 6VPoYFjbnyOtYnVevLZ86x_1xxrnE0VBwND6r4M2GKa2vFeW02s3bqZqPTWTupK4yrSWF.PWrMme
 epgHiQowchn2I1IDJ_WEvIUgP9TY.hRtjTSPd1gaHK4k1tAvmLThuwu.SCCLil_S42rnulbzEkaE
 Se2rtvOd5u3QjKRy1yWxj5eav6kCJPaWUNnwTmv47BaWadfqUlfEsLw_H2OSLLBD4x9yXAdYtEw4
 GayddkmqEpv3r5iu4JNoCs23MJc5Mz1mqqtX4jUfeSvQLFtq1H.Hc8KUu4Ff4YTTp0zdYzfPvBQV
 QbveOkf6zhYSfSf_B99RkjB0Wu.OJQofZZn3XGV5xI8NfTjxZQ_mok5n8Kgyi4U7f1OFStz0kOhu
 LOAeBXbIjuZr0uXm3bSWCAtad338MLBeW4eP7opmN2Et6Q5FlgyMxR8pnHs.E9_zhC5Kk24F9Vgs
 hegjyPAHENubPDcIHwsj4TYQo242BXMmnMoMiqIHEsIHsLnfLXA6eQ7pqgUSCmx1BPFvDvMDI20d
 IqKd8zcTiOjksmQ_zK1TnN20JfEHysZ_HcLt.vmaXi3bs0W7OEQ1uciH6iCDvwGtQOnfGmNg7gFA
 CpBX5r9UynE88FCikneT1iEmNEud7YdH.WutiqFqolGdCl0KiQQ0BGoQBFb7WWgDC4_7Kt6x8_6E
 2pnHUDF9hSl7VhJdWUtH77JXqw5kBCY90QfFwwb2Pp1EmSyg2R3mTC0doA8rsWg_HXugILZCOTqm
 2BXvoh4rjI8N1gbzGPSAagpxAwym8ARtNesYfXj8DyoPjhTnOF9QN3_znLpf11UPNQGvb9d4A2E_
 W.NjtG1q1ZqRR0hPp_nhzq_2dYP8Y_hJ2_poW1CIYVDRrPITykjYIFsIX10GEOGzyvO4_SdoSgPS
 xu6taApz0I3fyWyO67Bewc.mwJs6.XgfL54eWjq1ZhSjKV8XjH7evZA2XWXJHc.DVbbDJvJcSEQA
 H3moJMq4BVNoFj1rAo8f2BfGfxSTvKjQcCwyof3AdX4EdS_j9J.YuFCo9MOT1avB.AkFBB61OuIr
 9dFUNFnuxj8mdNyRZsfVpUr3qoKxrOJGAVJ1HtARz0_mz2YeEkQrTscyIAk95znxA29hp52SONp.
 o8M3MaYZwcRblQlxdAcLE.umltQ7gE.htpCwC7HeZM2Wl4MPNDi3qqGq9.uVe6vuJ5.M7ZzRWSPb
 7JOfbZQJ8FYQzDc2E0RR1bGKHDqdV0V3WWfE1UdFNC7RI0hEnb6US2yMpOiLIAz7arAyXxf65b1j
 7F8o0KFcezShaYFBoCPMIpKtPrBivvF4MKbENcnHnFi5RnBwS2HXBbzmYaOvya.ZMt6Pa7PGN.M5
 jy.RTKX6Rc.APuTAH8DGWeCwvXinsLpfbUGG1rn7zGI8HgR1OCl3HLJdLDuuChICtGUMOjMZBzDf
 kVfZSzW8x0naso8bMgnzXFILFgn.nuxjp2Y5y6qqDC_eyCESbk4vA7AAdh5piKT8SpgkrywcZJLF
 ClJz8Fh1.JH6jo7Q_LSvymTCY7u_HrnBpyc6IbApZW7Uk.X.rxtMsf5cbb5hbP_iYprwZKjMs67g
 y3nEDjPQ7bIlbodaMT2CokGWAZDv9SKiRhKwUDZ53e1k7GYzgLcmr04RpYZdVv1IG.2nPgNqyCB7
 5nOypnT4Rje2.OebxKK4JWWPpi5NcBRmyT76PNpEOKFrW2uRVfvhd0Mg53IVNwkocxj__6F_mKg6
 PitfDyX1fKXmE80WOTRnv.utrXX.I03xejpmgsUW0pVCMLNuT53qiJuNMK7PQMT5X7fwOLbJB8Wd
 FZl5ClxER7ZXp2MStsuQIe1zzvzww4jJi.yfYHK0xdEh67JcTu9y_mjvmhC7r2pyMSpFRaUSrz77
 qZLdTGc1i67elQLswWlF897N0nHCsPUjLG2BQGYH5J9TAAE6GWeWXt7HmEDapzteqncl4KGk1bWU
 DO3qvdT3N.mpW8bFCN.Pn2DM4MhH2VyvFEx1l9mxSAoaM4rcG0ILR28HmRECB.2xVx6Z9k2xr5WT
 nO2f7awihbZsqQqa_84ubHY5RJpVVOT6MeMOu7VtpLEnFRXS_9DEf2hYGf1TTlMSIPC7mVz5_fS0
 hFhWJNTDmdEdgeVJZqRJwYEM6.wDsJ.BSGqgJCTTa
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bd2ea56c-66c7-4243-89d2-b3d3e39a8c79
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:50:27 +0000
Received: by hermes--production-bf1-777648578f-mpdrm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 50e2f089a68eaebcc40c76391bc13d32;
          Wed, 15 Mar 2023 22:50:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v7 07/11] LSM: Helpers for attribute names and filling an lsm_ctx
Date:   Wed, 15 Mar 2023 15:47:00 -0700
Message-Id: <20230315224704.2672-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315224704.2672-1-casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value.

All are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 13 ++++++++++
 security/lsm_syscalls.c  | 51 ++++++++++++++++++++++++++++++++++++++++
 security/security.c      | 31 ++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 329cd9d2be50..a5e860d332b5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -263,6 +263,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 /* prototypes */
 extern int security_init(void);
 extern int early_security_init(void);
+extern u64 lsm_name_to_attr(const char *name);
 
 /* Security operations */
 int security_binder_set_context_mgr(const struct cred *mgr);
@@ -491,6 +492,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -508,6 +511,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline u64 lsm_name_to_attr(const char *name)
+{
+	return 0;
+}
+
 static inline void security_free_mnt_opts(void **mnt_opts)
 {
 }
@@ -1420,6 +1428,11 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+				    size_t context_size, u64 id, u64 flags)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 6efbe244d304..55d849ad5d6e 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,57 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+struct attr_map {
+	char *name;
+	u64 attr;
+};
+
+static const struct attr_map lsm_attr_names[] = {
+	{
+		.name = "current",
+		.attr = LSM_ATTR_CURRENT,
+	},
+	{
+		.name = "exec",
+		.attr = LSM_ATTR_EXEC,
+	},
+	{
+		.name = "fscreate",
+		.attr = LSM_ATTR_FSCREATE,
+	},
+	{
+		.name = "keycreate",
+		.attr = LSM_ATTR_KEYCREATE,
+	},
+	{
+		.name = "prev",
+		.attr = LSM_ATTR_PREV,
+	},
+	{
+		.name = "sockcreate",
+		.attr = LSM_ATTR_SOCKCREATE,
+	},
+};
+
+/**
+ * lsm_name_to_attr - map an LSM attribute name to its ID
+ * @name: name of the attribute
+ *
+ * Look the given @name up in the table of know attribute names.
+ *
+ * Returns the LSM attribute value associated with @name, or 0 if
+ * there is no mapping.
+ */
+u64 lsm_name_to_attr(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lsm_attr_names); i++)
+		if (!strcmp(name, lsm_attr_names[i].name))
+			return lsm_attr_names[i].attr;
+	return 0;
+}
+
 /**
  * sys_lsm_set_self_attr - Set current task's security module attribute
  * @attr: which attribute to set
diff --git a/security/security.c b/security/security.c
index 2c57fe28c4f7..f7b814a3940c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -753,6 +753,37 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	return 0;
 }
 
+/**
+ * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
+ * @ctx: an LSM context to be filled
+ * @context: the new context value
+ * @context_size: the size of the new context value
+ * @id: LSM id
+ * @flags: LSM defined flags
+ *
+ * Fill all of the fields in a user space lsm_ctx structure.
+ * Caller is assumed to have verified that @ctx has enough space
+ * for @context.
+ * Returns 0 on success, -EFAULT on a copyout error.
+ */
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags)
+{
+	struct lsm_ctx local;
+	void __user *vc = ctx;
+
+	local.id = id;
+	local.flags = flags;
+	local.ctx_len = context_size;
+	local.len = context_size + sizeof(local);
+	vc += sizeof(local);
+	if (copy_to_user(ctx, &local, sizeof(local)))
+		return -EFAULT;
+	if (context_size > 0 && copy_to_user(vc, context, context_size))
+		return -EFAULT;
+	return 0;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
-- 
2.39.2

