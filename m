Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4AB5ECE07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiI0UMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiI0ULf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:11:35 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB1161CC0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309450; bh=VRtZuuBpPgsM8uOtBXMQpIGUIsr6EPrGhfcIFfQx1vo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mLnKGe03WonMD5s/RkROI+cVhXWRQTOi4iZCn0d9NHR9nG3wS2MAwko7slH4fgbkhF/PmsF4F7GO/UhZq6MA0/r+qFqIgZaAZw9br1EidCuU4P8jFBY0M47KPlXndumCmYOsa8DjDxy3KKom5g7jGslD6jOwiXu/iu6lMf900SRDTJJVBp7UYoN5igyoV1BCaRvGJx4h5gdtsQjafOgFeTut6bphH5BEAAi1bT4YVPVtc14nfr/5PBZ5uDJnIuZcHkfd5GNe41RrxTvW0k0x0b7iWUbAvG/4QbtAyG3vSxqrd8DGexMkeyUkpClO3AIMtz2alrsfxDizg/cXXw0aTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309450; bh=Hlmjb4vdDFh6T9J5jNkowwKMAEWXqPydgbqZQLiAlt/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gC+kk4PBugx+teaE4/AD4fwjbvj+O2cjEF12bRMS5+j9iVHsb8FZjqHQtpt3Po3GjffD2+20VHX7I/gmyn+utSbL/US8d3PCGCZfvwqfd1ieZVBS/dcU3NjKeJnvPiQWrGihU1ljBtS1QsmYKqB1jGJEqAQQt+f85/hXKq0LC2gTzb5wOCHxH5xZLwDbJbCF2PLCQeEpYW5TtLpP2vOwNgGrBS0k2ozKICK+lAfBjnES06Jux7pKocXLHLDBvfWiaplaDSovYOu8P/s52unS4ABDnAMl7+dNOgBvqk3Yqzj7zP2fnfAdvOZoA71ff5opPqxgufSIQYZu59h9VATuRQ==
X-YMail-OSG: 0N2SD1YVM1knFXgVDtekHGh4.QgY5Ois3oIKVUBAZjmUwf.11uy.0sDVR982BXl
 e0L2ONY6bgcnRBKnq5SIDPUgZP0bRu7fIrLEq.osj0OdH8RAEudJ8qd7FT_eVcsK2f6FBpgE36LF
 mK4FDEO0HPtZJhrQAXcDNr3bhnCikJ3t9OSLGQxXK3yhFCiSJO_fFMIf31zsRFzItVPsAp4JVyfJ
 lJ1widtA.iz.LvTgjPekZ.3eda.Jdw4X8jhTYZfvQacFsEv0HQmO0RaZ7h86fYKbc.CyyJwuns95
 CuLs4RVMiY01dZZey_DQRBWTdg0ASY6DEKaDoMkkmPUqCcdaWrWA0pH3s8Ltjvhplj0dz42aF9BJ
 MHJ06zT5XjI41LUv5FYlSluF6nddsEAXUTrY.6IjkDxgQi4VsDaR_4C.im7EOMQqy7S0NveXWX0o
 A3ERhLm40TcofiKGCl4A01TddrAG9fwzSLJEo8LKggQ06n5h_b32fkJY3ZApn6kCyQIxXUPU7Clz
 75XfSvLhqpKN2GKHvaLGUNOhKfETvQDWg3mTDym2cwB53aOipBWtp39flRXPZnqucJJB.rZL5.LR
 1AGrqvdKZjG0yg5SIN5ixCJLMaYmTicZEVB8HUoYh4iHhKc5mOig96YNqEtZ4OZtjvzJQlbrTBH7
 jDK_LGM3CouU9bf_rkT4WMKHQMDPrtscdDq5sgY4UZDtx_ogiCKSbLUE6W5t_X_PRMGAEJzyf2ff
 kK.zZeIyLuuFuFQ6_O.vvZTo3qcFtWh24YpqurCImBA2TlK4pTv4O13A5Mu_J7Q4TSnRbYR5PPi4
 bK7ciTTQwiBJou2TqiYU_myJvQSpTEQbKv17Bsnv3fXzawCBvE5COCMyZrmtQS0aPAbzTo4J08Ex
 lcqT8e275AkAOQ7ZNj46iIl0MtHcq0ems3K8NXkfBWdwqciHFAnX5kSvw4z795GEres5xWY8jEzO
 sNuvqiGe256xdB08Ter6lGta_coAfaTrQ3zWyqvPxofLW9HI2hYwlYBr7ORUAoLi.G0L6JCIpcQO
 pOykByyRDPI_Yx2EgCWDbSELQpMkuVLPjtTSmVBDX47pvG7Wt_D0o3vh8MmR3QFImAhYwppY._Bl
 fWt8ukIv8LCrTnxovKuqPez3mFWm7r3EnVhJ7YOM.YfasF0E2U5EyfFOmoeHLKTS0EyPVljmuJCI
 6xz0UadTkRGmlYs0PlbCtTgRt1oG0BR8UF0yu7Aty1ixBiDOZea1HA8sJ_WBa31CXz7RgLffjH3N
 w30ndf5muuh7ovED9ZpAktcF6Gsdz09HhUNTlU4653SYa8ZZDabI2SxFjH..JYyNo6krxKrvonFF
 UPm0jGk3m5yGDCfg5k56Ktz7J5lhjiI6YAjJo08GHWncGxe_m8vcQyIchLywlPX4ZiMpGIAxleY3
 djLhji9BxjkXD9dg6d4e5VjtIe82WyMk3yhhAcFnR1h2VHIfVKPMY_dWOqtrmS7Vpfz.C0rSrru1
 6Z4yWdKmcxtWD69bqvMp3.hsGbVdd3BOhNbFQ2IvOOEV5MnR_6MYB1d_MBayQ7rByngNDeQjO86L
 y4_F.LjbpZxGd84vep9ut3DvpYEVtJwf4bpfFxCD0GGhRgaa4PK5KPFxCGvbXHgGemPsVCa49Om6
 YG98FG1TJA2vmF.GJT7mSThtNvuZ7sQrOSBMb1yoHBIu8Rgwo3CSOa3O6xDCXPM8eor9a0QSQ56S
 AUtUnEHP1Ai2QbKEFme3HunB8tiJ11VYejSPkhLGYxPIukIWosoqMHsa6nhsATcDCOsLmBP_cuMR
 AiSVhwI8CkBsPgEedyeOGR8XbI_dh214y9QWmKqPfExqMd1ShBgOZErpHOlsp9qcCExbVFV3Ll79
 QZ5RmimoBpZKXhlO5KPPQxtZAIcSVMoH.o7Lhpx.ZJXQUlgnIwQUVdIfvGGASGGpnXR2RG9QXHlw
 hiWNfXPGMCVf0EllI7pCVQZAbxUb2uNSLuqzNcXhVxdvKVen4HRYnYCb9K6Ig7gDiIwUYc84hNiI
 8xJvhIKma5eXfWNunmNSxfZMpSdxp2xhHs1luFdHsVqobFPrNr__ZEY.laDWOltL1ZA65wZDDHct
 qfxoZQcr_YfMcEGOoSo8vqazFhX3SDLt9.W2XhKxUZHoB6ehWQq7G509cAVLoefuoOETXOd5yapU
 0sZNhx5ocJa04plahH2ynG3YXy5b7KC_bYUB.CeKEV1SRb1tZyjVV8VnDvZWQSI_gQTRjV1X9S50
 jWUks60r1U4S_rHqnZXLCP45v9Zyky0aLmUyK95DqRExUYkWHtPPKOJxdZaql1JEIJdUv.2nqMmT
 BKxgFKGKZ9WIFpqArDDOCPCl13ZNv2eizopYO4j8k
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:10:50 +0000
Received: by hermes--production-gq1-7dfd88c84d-nvfk6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 55a7229bea084bb6b28fa3beefd2f4cd;
          Tue, 27 Sep 2022 20:10:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 30/39] Audit: Create audit_stamp structure
Date:   Tue, 27 Sep 2022 12:54:12 -0700
Message-Id: <20220927195421.14713-31-casey@schaufler-ca.com>
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

Replace the timestamp and serial number pair used in audit records
with a structure containing the two elements.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.c   | 17 +++++++++--------
 kernel/audit.h   | 13 +++++++++----
 kernel/auditsc.c | 22 +++++++++-------------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 98c5ace6f453..7facf6929f64 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1822,11 +1822,11 @@ unsigned int audit_serial(void)
 }
 
 static inline void audit_get_stamp(struct audit_context *ctx,
-				   struct timespec64 *t, unsigned int *serial)
+				   struct audit_stamp *stamp)
 {
-	if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
-		ktime_get_coarse_real_ts64(t);
-		*serial = audit_serial();
+	if (!ctx || !auditsc_get_stamp(ctx, stamp)) {
+		ktime_get_coarse_real_ts64(&stamp->ctime);
+		stamp->serial = audit_serial();
 	}
 }
 
@@ -1849,8 +1849,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct timespec64 t;
-	unsigned int serial;
+	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1905,12 +1904,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	audit_get_stamp(ab->ctx, &t, &serial);
+	audit_get_stamp(ab->ctx, &stamp);
 	/* cancel dummy context to enable supporting records */
 	if (ctx)
 		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
-			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
+			 (unsigned long long)stamp.ctime.tv_sec,
+			 stamp.ctime.tv_nsec/1000000,
+			 stamp.serial);
 
 	return ab;
 }
diff --git a/kernel/audit.h b/kernel/audit.h
index 4af63e7dde17..44cabf7ea660 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -99,6 +99,12 @@ struct audit_proctitle {
 	char	*value;	/* the cmdline field */
 };
 
+/* A timestamp/serial pair to identify an event */
+struct audit_stamp {
+	struct timespec64	ctime;	/* time of syscall entry */
+	unsigned int		serial;	/* serial number for record */
+};
+
 /* The per-task audit context. */
 struct audit_context {
 	int		    dummy;	/* must be the first element */
@@ -108,10 +114,9 @@ struct audit_context {
 		AUDIT_CTX_URING,	/* in use by io_uring */
 	} context;
 	enum audit_state    state, current_state;
-	unsigned int	    serial;     /* serial number for record */
+	struct audit_stamp  stamp;	/* event identifier */
 	int		    major;      /* syscall number */
 	int		    uring_op;   /* uring operation */
-	struct timespec64   ctime;      /* time of syscall entry */
 	unsigned long	    argv[4];    /* syscall arguments */
 	long		    return_code;/* syscall return code */
 	u64		    prio;
@@ -265,7 +270,7 @@ extern void audit_put_tty(struct tty_struct *tty);
 #ifdef CONFIG_AUDITSYSCALL
 extern unsigned int audit_serial(void);
 extern int auditsc_get_stamp(struct audit_context *ctx,
-			      struct timespec64 *t, unsigned int *serial);
+			     struct audit_stamp *stamp);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -306,7 +311,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
-#define auditsc_get_stamp(c, t, s) 0
+#define auditsc_get_stamp(c, s) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e8f632736d2b..bc0621282a9a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -992,10 +992,10 @@ static void audit_reset_context(struct audit_context *ctx)
 	 */
 
 	ctx->current_state = ctx->state;
-	ctx->serial = 0;
+	ctx->stamp.serial = 0;
 	ctx->major = 0;
 	ctx->uring_op = 0;
-	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
+	ctx->stamp.ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
 	memset(ctx->argv, 0, sizeof(ctx->argv));
 	ctx->return_code = 0;
 	ctx->prio = (ctx->state == AUDIT_STATE_RECORD ? ~0ULL : 0);
@@ -1925,7 +1925,7 @@ void __audit_uring_entry(u8 op)
 
 	ctx->context = AUDIT_CTX_URING;
 	ctx->current_state = ctx->state;
-	ktime_get_coarse_real_ts64(&ctx->ctime);
+	ktime_get_coarse_real_ts64(&ctx->stamp.ctime);
 }
 
 /**
@@ -2047,7 +2047,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[3]    = a4;
 	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
-	ktime_get_coarse_real_ts64(&context->ctime);
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
 /**
@@ -2516,21 +2516,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
 /**
  * auditsc_get_stamp - get local copies of audit_context values
  * @ctx: audit_context for the task
- * @t: timespec64 to store time recorded in the audit_context
- * @serial: serial value that is recorded in the audit_context
+ * @stamp: timestamp to record
  *
  * Also sets the context as auditable.
  */
-int auditsc_get_stamp(struct audit_context *ctx,
-		       struct timespec64 *t, unsigned int *serial)
+int auditsc_get_stamp(struct audit_context *ctx, struct audit_stamp *stamp)
 {
 	if (ctx->context == AUDIT_CTX_UNUSED)
 		return 0;
-	if (!ctx->serial)
-		ctx->serial = audit_serial();
-	t->tv_sec  = ctx->ctime.tv_sec;
-	t->tv_nsec = ctx->ctime.tv_nsec;
-	*serial    = ctx->serial;
+	if (!ctx->stamp.serial)
+		ctx->stamp.serial = audit_serial();
+	*stamp = ctx->stamp;
 	if (!ctx->prio) {
 		ctx->prio = 1;
 		ctx->current_state = AUDIT_STATE_RECORD;
-- 
2.37.3

