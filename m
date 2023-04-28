Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D946F1F99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346719AbjD1UjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346620AbjD1UjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:39:20 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1D2724
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714356; bh=R0jF7owPjAofxGFVfe8NSr+6LkFf6NiHHVKy2FUlHAY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=BcDApmNlyB/fJOtFnCI1FpNDkOAuiSaDOHEq5dWpAO/HCI5f37jf2CueDt0kg2EXethm65sS/rMnYp89dCp1qKIufvPDUbzZtuzV4uSKF9dyPd/rk6WtTrCj67zJswQIg2GM2oIQ9hk6yGoVht24vPoEEqb0ZqbJBRBE4/Y+53IdBwyNomZUEwMvD6+2R7lLGJU3NZL1OZcc4ZCTj9gG7dZ/Gflnn9dT5xO3XTRzYZUVVRyQmnRXO5Vc+sRY1B1Ywglyka8DEBFVsbT3a/H8MZu1QuIQZm+KmhQGLxFqnwC0qVVBkRsvi4YYC+TEdkZqPrhXuVQGeZhUDhOiEMl9Ig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714356; bh=QEcyaAQ2FUOj7y3sSb407ttq4zeqqHhuI1/HOYYhNsz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tHjeYELFfknpMIg5tD2NcWmQAL6eW77I8fgmAkqLft19+PaPXo4lQlqQwiRWK+P5aKXZW9AOxlhWhQq8V1iJljj9gkIQYvkJhyH6yGsH/fpEnsM8Rmk4mu18KefulfRvArM2BMxm5p5PwEyZoK+EYhrKSxL9sDeXujgWhXPRBAR99p+YJ06Fdim65AXeVX6gQi33+/JFnd7PM8CB51vbAc/16OhdwHDVuJHLWlVNSkZyqLmX9jBBNm40HPbNaPAv0VyaDQbwGVToPcZgVn0QYlHA/k2/DVjS7KeSCu5vJ+P/xPM25ZnfPhxUEHu6bxH6WQqeb3xMMV6E/1pbSsmlew==
X-YMail-OSG: ZcnO2AkVM1liitLb9d.7JkxEeOGA9r5fPiy7MJ0vu0OtqUPevXBhuOnywMMn.76
 LsdMFYBjxrBpc8dJ4ccmiXU0dquIvb8klcFmrxLy0A1oldUhF9GYC8ai1XsxjOWfj6M0Pe8R9Slt
 Tr7z6GXkDi1jxKXc6gadr6Q4odg.nti5JuuAKifOUr.za8gknU4T9HqWeZPiAeG9sTgYzcOo3hQ3
 r1cTXU7KsxIfyHF6immuYCbWPEtos7QKwUHNVIx9el98bT5Xp1TqZkgiVEzaBYsHTIB_vw9h54Ov
 woqrpf.IRR3KhFw7c6np8A6stmqE9xLkVZWAhhrIZZP1uFOHim7KCj2mB9EQFx77o4YgfZbgj7TE
 b4LbD5mRLHPV6M7KvHKKpC_NpSCKtAvzEHYS53ih6jfEl_VenRoJe5RzF_IyK.cJGHkM701ebJ0n
 J_xpnQW1avgbAfdAtnO0xGs.3xVH_rSg6U71Zkgp5j95IhNiKURvp_M0cgbAy53cgITTWNxPpb_7
 kUfb12vohKtXvv8EZ_6ZGUy9OFtwG6_SK2_6R2dRtByx1rXueSpe6BcOdHwy65gYBzcSS6Px32Hz
 k3NqEcB0Xhb9rZURFFvLIFjgnlgkhGMXLGFUH59naWXTTiAeCqUw3iXJ4A.Zpq96cYhJV7qioncN
 r1xBQ_cVZQGu_vFQBn4mb7KjWhC_Azv4OW8JeIxKcRW6xmN3hhxbWgETvR0DItbyUbb2sOW6MCpx
 Opc73zNkvyb_Gdv0QxnZPcxwwfxgPaPAjyVF80HbYnve8kv48J4wwBMqfLzJVOknlBBZF0kblbID
 uJjZ1Cd.wm1R0d4U3fg1xWtdK35whr4p40y8.xKGByHS2nvPkIJEgyNV31nAc7UghTvwOqRyvtWb
 _uwF8WRf6Pg1L8s0LHWaEO0EKRad.jhIl3BSfIeL8r5ERMuPCvVWbeQZ3epyGB2El.lSPUwUQ5Bb
 L.8slFDf.dgX0w4m7r8ULxb3kow9eyWtezXsIeefdxLQhdPiVUgpb.LWb9rIPS4KNNJ3Yq8zHE.Q
 NH9OpijgcaiZhlclzfOh13eNa.A5voKTnTCCkRaYFHFQdwkK1RCR0o9njfKOF2xXo_ZycqAYRKW2
 IBhWG87W1sd8EJzWgeqviKcUWfC9dWWURH6kCtOWAzwEOZfJK5C.PYJUpb0dTCxBP62b2w7SJNn.
 TLmMUDAPlZcIbv0WsgxXlMu8pSxaFGwWHoj1Nj9NB2Xie_09XfuFGgpjIw2VJS1q.vrNzE1eegRE
 2CL56BdkxHGf5xxO705CBKbiqXqaSQ4YN.wcmp2akRzFEWHHwGG8MMc9wc2.KbMbRQU239T7D4ES
 U0tA5LMeQvWUjKpS44DSpbDgyOl2iF9mKugTn_g5vgq0A7BkbmueALypAl0Drh2_VqOoEiDLKwhG
 WIneThRLdOQqh5QqcB4GmVIp8j4nbRW5io54V7GQ7sLqLlsC1UpoaHGXiFrzWB4jbSIsayWHuTNZ
 5CYdo9zitBWntgfAuascA5K7_7clCS4LRm37erSI1w4OnbaR0lFpZjVZtfV2D2u_vrxk4uITaMWv
 KD8XQYV5GSda6PnvHqfjiEtb7zWgC69CeGUa3K.mGZ3DtQ79vi69zfq7UMA384hYps1mvLt8Euui
 Y0TmKkyfGqvbaafixWqBAOIMZPqJ7.gKDc_Bq.3JkMywRDVxByYGIC3plYBZOr_DgjJiCJ8aMttz
 oEDDKKk0igIMASnd.JSjlCiR39GW.eYbQgsMm5XsM6CnQblYpY_GLlZj2YX.VEKIW.GAx1jlDswe
 6sYf0phvlbMJA1GO.gCn.ZQMQLDuBB6DFqiICyuWWbpeZrUujcFcWbOWiUd_zlPntEZFP3W4vKoV
 divDmCJdpT2vOdIgTqT80qnHfReivP6jhBT4D.tH4IS8UN3_UTwXilFYqVXZ7ftSFlfyPgli7rL5
 752GF.oQT0oBQs3HjmFEq0NR9ErnuiimfLlEkoqTMZHk5Oa1kIwOVZB1iaBRE9fnVit0Cfx9hV1e
 XlALCsK.OzE_HjF007IcwxpyIdom.UISXc73oM1wGC45Wf7CzPrZcRmFTYahE4LYGETiVOqc66YQ
 TfBvgn4alicC8WdDqB8g871zwsVYc8WK56bDFnP2VqhA03toTDHDZcCCZ0SvgQ40evfFyDcZyMB7
 6FOAPcx_BpMKf2AvfJb7C4ivU3t5YrKtB_i6wGUdfJPgfFXl7tktXYUkXT93NLW89ZtBKB0nEpYy
 4uZjUkfp5SMW3XzciJhWZZigO76dcYHbifrx0IoCu.IF96R3di2NbXUUruKY41csutovGF3jLpFt
 4FjB0wTMT8sxP02jTuBEIE3N63zDVWA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b7106443-eda9-45df-a9bd-a5edf83173ae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:39:16 +0000
Received: by hermes--production-bf1-5f9df5c5c4-wvm2h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7872f02abf9ba03acc5bf1902aa8c755;
          Fri, 28 Apr 2023 20:39:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: [PATCH v10 10/11] SELinux: Add selfattr hooks
Date:   Fri, 28 Apr 2023 13:34:16 -0700
Message-Id: <20230428203417.159874-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428203417.159874-1-casey@schaufler-ca.com>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
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

Add hooks for setselfattr and getselfattr. These hooks are not very
different from their setprocattr and getprocattr equivalents, and
much of the code is shared.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 154 +++++++++++++++++++++++++++++++--------
 1 file changed, 124 insertions(+), 30 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2ee92d3fb79d..e78b955e04f8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6348,8 +6348,8 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 		inode_doinit_with_dentry(inode, dentry);
 }
 
-static int selinux_getprocattr(struct task_struct *p,
-			       const char *name, char **value)
+static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
+			       char **value)
 {
 	const struct task_security_struct *__tsec;
 	u32 sid;
@@ -6367,20 +6367,27 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	switch (attr) {
+	case LSM_ATTR_CURRENT:
 		sid = __tsec->sid;
-	else if (!strcmp(name, "prev"))
+		break;
+	case LSM_ATTR_PREV:
 		sid = __tsec->osid;
-	else if (!strcmp(name, "exec"))
+		break;
+	case LSM_ATTR_EXEC:
 		sid = __tsec->exec_sid;
-	else if (!strcmp(name, "fscreate"))
+		break;
+	case LSM_ATTR_FSCREATE:
 		sid = __tsec->create_sid;
-	else if (!strcmp(name, "keycreate"))
+		break;
+	case LSM_ATTR_KEYCREATE:
 		sid = __tsec->keycreate_sid;
-	else if (!strcmp(name, "sockcreate"))
+		break;
+	case LSM_ATTR_SOCKCREATE:
 		sid = __tsec->sockcreate_sid;
-	else {
-		error = -EINVAL;
+		break;
+	default:
+		error = -EOPNOTSUPP;
 		goto bad;
 	}
 	rcu_read_unlock();
@@ -6398,7 +6405,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	return error;
 }
 
-static int selinux_setprocattr(const char *name, void *value, size_t size)
+static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
 	struct cred *new;
@@ -6409,28 +6416,36 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
-	if (!strcmp(name, "exec"))
+	switch (attr) {
+	case LSM_ATTR_CURRENT:
+		error = avc_has_perm(&selinux_state,
+				     mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETCURRENT, NULL);
+		break;
+	case LSM_ATTR_EXEC:
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETEXEC, NULL);
-	else if (!strcmp(name, "fscreate"))
+		break;
+	case LSM_ATTR_FSCREATE:
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETFSCREATE, NULL);
-	else if (!strcmp(name, "keycreate"))
+		break;
+	case LSM_ATTR_KEYCREATE:
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETKEYCREATE, NULL);
-	else if (!strcmp(name, "sockcreate"))
+		break;
+	case LSM_ATTR_SOCKCREATE:
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETSOCKCREATE, NULL);
-	else if (!strcmp(name, "current"))
-		error = avc_has_perm(&selinux_state,
-				     mysid, mysid, SECCLASS_PROCESS,
-				     PROCESS__SETCURRENT, NULL);
-	else
-		error = -EINVAL;
+		break;
+	default:
+		error = -EOPNOTSUPP;
+		break;
+	}
 	if (error)
 		return error;
 
@@ -6442,13 +6457,14 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 		}
 		error = security_context_to_sid(&selinux_state, value, size,
 						&sid, GFP_KERNEL);
-		if (error == -EINVAL && !strcmp(name, "fscreate")) {
+		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
 			if (!has_cap_mac_admin(true)) {
 				struct audit_buffer *ab;
 				size_t audit_size;
 
-				/* We strip a nul only if it is at the end, otherwise the
-				 * context contains a nul and we should audit that */
+				/* We strip a nul only if it is at the end,
+				 * otherwise the context contains a nul and
+				 * we should audit that */
 				if (str[size - 1] == '\0')
 					audit_size = size - 1;
 				else
@@ -6459,7 +6475,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				if (!ab)
 					return error;
 				audit_log_format(ab, "op=fscreate invalid_context=");
-				audit_log_n_untrustedstring(ab, value, audit_size);
+				audit_log_n_untrustedstring(ab, value,
+							    audit_size);
 				audit_log_end(ab);
 
 				return error;
@@ -6483,11 +6500,11 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
 	tsec = selinux_cred(new);
-	if (!strcmp(name, "exec")) {
+	if (attr == LSM_ATTR_EXEC) {
 		tsec->exec_sid = sid;
-	} else if (!strcmp(name, "fscreate")) {
+	} else if (attr == LSM_ATTR_FSCREATE) {
 		tsec->create_sid = sid;
-	} else if (!strcmp(name, "keycreate")) {
+	} else if (attr == LSM_ATTR_KEYCREATE) {
 		if (sid) {
 			error = avc_has_perm(&selinux_state, mysid, sid,
 					     SECCLASS_KEY, KEY__CREATE, NULL);
@@ -6495,9 +6512,9 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				goto abort_change;
 		}
 		tsec->keycreate_sid = sid;
-	} else if (!strcmp(name, "sockcreate")) {
+	} else if (attr == LSM_ATTR_SOCKCREATE) {
 		tsec->sockcreate_sid = sid;
-	} else if (!strcmp(name, "current")) {
+	} else if (attr == LSM_ATTR_CURRENT) {
 		error = -EINVAL;
 		if (sid == 0)
 			goto abort_change;
@@ -6542,6 +6559,81 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	return error;
 }
 
+static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
+			       size_t *size, u32 flags)
+{
+	char *value;
+	size_t total_len;
+	int len;
+	int rc;
+
+	len = selinux_lsm_getattr(attr, current, &value);
+	if (len < 0)
+		return len;
+
+	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
+
+	if (total_len > *size)
+		rc = -E2BIG;
+	else if (ctx)
+		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
+	else
+		rc = 1;
+
+	*size = total_len;
+	if (rc < 0)
+		return rc;
+	return 1;
+}
+
+static int selinux_setselfattr(unsigned int __user attr,
+			       struct lsm_ctx __user *ctx, size_t __user size,
+			       u32 __user flags)
+{
+	struct lsm_ctx *lctx;
+	int rc;
+
+	lctx = kmalloc(size, GFP_KERNEL);
+	if (lctx == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user(lctx, ctx, size))
+		rc = -EFAULT;
+	else if (lctx->ctx_len > size)
+		rc = -EINVAL;
+	else
+		rc = selinux_lsm_setattr(attr, lctx->ctx, lctx->ctx_len);
+
+	kfree(lctx);
+	if (rc > 0)
+		return 0;
+	return rc;
+}
+
+static int selinux_getprocattr(struct task_struct *p,
+			       const char *name, char **value)
+{
+	unsigned int attr = lsm_name_to_attr(name);
+	int rc;
+
+	if (attr) {
+		rc = selinux_lsm_getattr(attr, p, value);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+
+	return -EINVAL;
+}
+
+static int selinux_setprocattr(const char *name, void *value, size_t size)
+{
+	int attr = lsm_name_to_attr(name);
+
+	if (attr)
+		return selinux_lsm_setattr(attr, value, size);
+	return -EINVAL;
+}
+
 static int selinux_ismaclabel(const char *name)
 {
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
@@ -7183,6 +7275,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
 
+	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
+	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
 	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
 	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
 
-- 
2.39.2

