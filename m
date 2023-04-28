Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A36F1F61
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbjD1UbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346312AbjD1UbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:31:15 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E240FB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713810; bh=lQV4qS4iAA6JHAaUPQfN8v1+i+4alOLehWL92wPtJI8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VJMSF+G63FPYv+EzPs4zgyGfUwYljnMv//V5Q8xFlRuf0RfsPI6DPfdhzEsf+8a4A/yLxk280mu4AQZDfu6Eg7V2i+EFcpWryVihv9cpYG4zExqU+nUq8IfqOmCkgjagvU2G6w2Ioo+ycIxOrSrmV2dliE1Xw90Qe4gnqrbmVLyX/H2Ec437MddkZucXWiVQjKgsDSSaUhIdBjEEqGroK1yMpemUIIQHmTgPxEscmV97oQyi16MSumAq7EcjCnobc/A4FMLqaXo0Md09sKW/V7UTa+QcyTkgmKAO+x+1g4QL/aIz5f6p6smb7VO1nsfaTTom0OsrBWAOnEXAM6sXDQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713810; bh=sI3IyCxe5MrqDWFbKc7Dx5Od3LU0ApAfdJSTAKsS5R0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ns2Gw5wC9UeO7HpzbBP+gdE6qyz9sKcMXfbRMnScpx++GG2gMGBy1kebX/ZE1qMvmFCBp4a60F3VlgoV/NR9SiqUql8E8tFgnTJECU/RQx6eaG9qnYthxiBCOTXnmkyY2/5NwQdHBq+hQ2I/Vz4+HGd6ZZCX5tqWOBQq+cJ4SpotqtQOhapd9Wt47hkShIyF1L02hlzTyjTz1xYGx16N8RWLv/P5E5gPKf1BgOMfn/jNWb5ROJrXMP+4r4qFm3iTx81la98V0qDrl5WPmcqXjTq9gDDCh+35VrFEZh6+4vUuS8QPN5GXPdz1HrXLC6y2Bgw3xXXNJBvNX7VRKmB1yg==
X-YMail-OSG: saad7NQVM1m16MBQ1lkoGZRGnmRKqD.ZqS6AU4n5TDtR1FHxSmbw4xOusFRqHSS
 BXRqcriplXreczI3mADA23a1EQj3saNLmfDtKMEmvB5hbJeSJ7wWIpXIlH4nZVUYTT7BqhCaDZf6
 kzRlqfpkkiXLKKM90aIxQkNUY72pUpqg0XSYCYsxoUXOw0Rco71kZYRxoAOT6isqSrNI58yN4ZYR
 y.RUxxyQsHeRAF1WhAAc_oOXgda58wFIfmPPmzV7z_mEeB5FjuTNxVUX_bKSHli3Jn5rur2kfXxl
 RtJ9oGbnfX9ekhpU90Dis5QKlzyp3Rg7YqJLjhq10sTO9j6Zt.wKmHOMZAHfRImxus1qzdclqfhu
 rE5masRMn31Tb5CxGXBDlA_2ost.y1cfiptFdE8Rt96jbUFzjkDAwlR41lVY2SOoGZ1_Mh5wOTEe
 vIXK7uydVS.bk_Ozyde6nAmGZ1qqKJ3FrKBoA6VGIYs5SMyr1chsj7vJl_a.k28VWdF4pK0G4gxz
 6UI9U6le4ijIQPUW.CETXQxNWD0f5FEL2m.9k4T0k3_DbZEiBndrJ33hxs0WjOg8H2R5HT_aV._j
 ZUu_Zy9BTO8j_wI71Uo8OyJ6uMO.Ihi7Fzg8qDlYA0aZVmI1N1Z3pV9Uuxp1VTA4t45QxarLbAkh
 jwrub_IyA6AoLejjg57be021K1fGzfWf04voZF0eS9vRsuZA0ksFuEvpTQw5_bGiFNmSUNh2Ch8y
 jA.OPkr9DUQtqFNxNDqKWj.f__LUJ6XJE3G.iEFf4t2mbz4mdFcxRMf3yI.OGTwrvmK_IyEy6yJk
 WYFmJ2aNpkjbFrjYYobi1Qmtx7JwQGKg3cjFMZLa8AF5gcj1seCjE.AehaoeMSh19DKIrhii5sP2
 fkzdM2VNbhzlUAcoEwfvinV2Cv8F4kZLHlYCdVWSKQ_s9HRnul2.nx0.F6bpcgATcTZu2gLZKm.a
 R8i.coEPfSTXOBFEXgbQq_7_E.7NdiT0LOUBJL72rQee6PENuLwZgcpPweHI4Ic5rKdacAE90jFV
 wnyLOkxgY5kIckoU4_Gz_2DLNG4n8MmYiUEL.TBC5AWvl2zvklOKsnOV7DFoFRhzpNzjLcu01hwk
 87bC.vSUmVtsq3CieRds6NcALxtv0qArHF6qkYO3qVhNaedsrf_1jppJPiAGj.QdytjSitdry1Bj
 l5r8lNGgpXzlnAf71Huald_dCksfJmJA1Ayd2kGvQxsXyNJMeIALl8uF5MU7q3oaNxWAS3qJ_mDf
 tmzzS9htZLf4z6zBTlkLZzFirYvLOWOA.rxbOswej3AljRYNXHgbL53mHOfUxHX6PKcY7FvRQrzc
 CYAMKZwLI6qCvc_27VwZbV.S3J..dta.2RRk0WIMhIxOxuExp2XhRJRW8QTYr.cGYFSLLBmuefc9
 NPLAFG._VZ1RC9E9IXmQ.WcjVi6p9R30iEN5aotTxd59JDrsS4MB21YarHfkoEMdQ3TzLFfIgaqx
 FsxwDe7nblTwOMpxr32BJ0kys2PEcBq33Zpgz2w6Nj2G4Sq6EWZONyBI0edXP60.OyGrCv5az.zV
 iDfJUVnDafE54VVQ.B7DXJlIS9MEB3o9D8HZp4ld5oGF3enE37jgY0.RkKoJA0k.6jfmNzFXlLbb
 G8gWPELObpChuPLSnnnGOSIqnkdrntZx4OsnqzR2LtVq8xeYWB9mkolZURiynOWpaweZnejABXxP
 59ID.qg10caDyXiu6D__SoJqPVs9lo17oJUYBKEaKaeMxG2cmCXeBjvN2OWVCdq3TgYKXFx2S_Vs
 _OIKLboHi2MYLMepzSbhEPfSFIGDuobhXg8bve0bMEOTW2iSyOInZwDYijaXAnStmfQmmdOu4m7J
 j1i7jYJDB8uR3PHXitCgaWAxTfEm4CsiXsZBu82Ndm2s3rht6YR5eY288qrgH1TG63WRPtNyNsRY
 q.I3K0QlzX3Cbs2PDP7ynKC7DlvhRtDtLlg15Ret4BWztAp1dyfdBw0l2_iOeEqefa7u7RwHOvH5
 p9TAZNHMgc8e4ZGWAipysChpqkxc1ZyRqbsvKT3iQ0TK6gFamWZG1mStQnaAvMbvocn9ovVZ3302
 f9tL_nusPwterIbt9QUope1iacihD.MtN6IxGNz7fnJI2f0WuhNXr1w1LkcqiOoFva4nOXbP_NEv
 83rnJJxYhG9AZiCrjM0Hw7VbQJDlYPpznkGFOIMmPTBQFiAXiEKlLr73gn8hteQ5849bHsbBYu78
 NvMr.pMyOeAK8A8mr0S8Sii0PoGzlQ60lEy7EEf3xpsdeokfAwjWqRhn4nAgvzyKv_WgveQSYEC_
 w78aGovMgsFHwTAL.QPw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 624ab670-8d7e-4b30-b922-5cafcc9fef08
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:30:10 +0000
Received: by hermes--production-ne1-7dbd98dd99-84p8v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 16afe408a2c159011f8a869d3993f797;
          Fri, 28 Apr 2023 20:30:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 07/11] LSM: Helpers for attribute names and filling lsm_ctx
Date:   Fri, 28 Apr 2023 13:26:47 -0700
Message-Id: <20230428202651.159828-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428202651.159828-1-casey@schaufler-ca.com>
References: <20230428202651.159828-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value. The .len value is padded to a multiple
of 64 bits for alignment.

All are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 13 ++++++++++++
 security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
 security/security.c      | 44 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 806bff425af9..36ace59f9171 100644
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
+	return LSM_ATTR_UNDEF;
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
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index b89cccb2f123..0b225adfe5f7 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,30 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+/**
+ * lsm_name_to_attr - map an LSM attribute name to its ID
+ * @name: name of the attribute
+ *
+ * Returns the LSM attribute value associated with @name, or 0 if
+ * there is no mapping.
+ */
+u64 lsm_name_to_attr(const char *name)
+{
+	if (!strcmp(name, "current"))
+		return LSM_ATTR_CURRENT;
+	if (!strcmp(name, "exec"))
+		return LSM_ATTR_EXEC;
+	if (!strcmp(name, "fscreate"))
+		return LSM_ATTR_FSCREATE;
+	if (!strcmp(name, "keycreate"))
+		return LSM_ATTR_KEYCREATE;
+	if (!strcmp(name, "prev"))
+		return LSM_ATTR_PREV;
+	if (!strcmp(name, "sockcreate"))
+		return LSM_ATTR_SOCKCREATE;
+	return LSM_ATTR_UNDEF;
+}
+
 /**
  * sys_lsm_set_self_attr - Set current task's security module attribute
  * @attr: which attribute to set
diff --git a/security/security.c b/security/security.c
index 94b78bfd06b9..8c877d639cae 100644
--- a/security/security.c
+++ b/security/security.c
@@ -761,6 +761,50 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
+ *
+ * The total length is padded to a multiple of 64 bits to
+ * accomodate possible alignment issues.
+ *
+ * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
+ * if memory can't be allocated.
+ */
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags)
+{
+	struct lsm_ctx *lctx;
+	size_t locallen = ALIGN(struct_size(lctx, ctx, context_size), 8);
+	int rc = 0;
+
+	lctx = kzalloc(locallen, GFP_KERNEL);
+	if (lctx == NULL)
+		return -ENOMEM;
+
+	lctx->id = id;
+	lctx->flags = flags;
+	lctx->ctx_len = context_size;
+	lctx->len = locallen;
+
+	memcpy(lctx->ctx, context, context_size);
+
+	if (copy_to_user(ctx, lctx, locallen))
+		rc = -EFAULT;
+
+	kfree(lctx);
+
+	return rc;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
-- 
2.39.2

