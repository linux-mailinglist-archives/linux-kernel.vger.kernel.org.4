Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D84465935C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiL2XjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiL2Xi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:38:29 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAA99FDC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672357107; bh=qDe7dJsVo2SzNvD/njTcHvmCWggB3sey+6Knm0SuJ/M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=BG+aSkEzkUgDAcAqLxI124SDRQiPfRaJ9xHMCJA6PWG9NRiUp6KgQBNN+sMVWpXvyfidlivH1ZQMViHRo214cWcqVfXYPaPQk1efYLC1DHs943XcvT2e6ERDzCsS2uKWWkGVvfFBQstVLSUTlGwCQm0fGq3WE6qr8xOp62n2H4s9H3TX0aGy3Ahg9BvPJfmfFeimVFQ3ZmoI15RZiwEo+raq6mU5Lp5jVACy2iwNDURZunOONHuaqx98ARPpvHjIMKABn2719fVkKPp69v4Hp3Gb++P6ZulduuOyWrc/aH9qVx89YUOh4gtv+DpJRGy4OgdUjDVCDbHO/vnEySlSEw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672357107; bh=JP8RdJaSlRdwEQld6o0kJYv7K/BnKJ8+Gj7PN1uNpQy=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PPe09Twrsgf4rua65JtZI4n4+zoNkXOz9xLalxHev1gi0u0ujtEmQexx5IysHGtAjEQ4bs3S/2hc9dinkByBTXAPdP/aqFDl0IxmujMS5X32EzyRMA6co/msthnh44ydHaloP5R8bVpR2grxRjxtGn/WL2yHKi8o+oAO47mhbBg2Hwg7h9Gak7HPN/HhloSg89JaqOLGRClsJHKhlN/O2qdfk5Ac3YPpBlSWESELXxB7XktJUQGpwjwlRzl5wrrxXAl+KQOtmf4NQy57rjEr0cyEqgvG+byDktFYWEfYpizVkqw2Bj0fhyf6upcbjfAl60NCRo8Omad35PVPb6LJXA==
X-YMail-OSG: wXm0mGkVM1kMm8VGgCpwQUrjfs.AO4tkamYnDTkQYwXbsJMVn9PlzYlNR3oTdga
 10RL29YnUVuzaQFjMOJ4LQQ3l0vlIh7oCDpPTXC58pK.GjLAt9Zu6d2HmgG6xgzN3Ze0urfLi9Sq
 yR_VdIXW0qIZ.Sq6QMyDhQogl9dBRBx4i3bNAHubgMNMNZaHEmhHMoNrkFMWzYqUm_shSnxI7VbF
 KpBOrS7S3ou3OFPlN.HJyTSVsQ2YcChaiYd3tEMUnpgXKJNmb8Kzk5guSWI._MFCiTBEnGLRCTSV
 Y.Tff5KYmAjiEqSirDkF79t.TbTydqjRMpRKaJeNNy5BSc33s43cB_UvdaVrprkXRQWJHStLsIgS
 8YY9v6ZKiZhvVRbj92cx9Si4fWs4hSp1CTu2HaiAfrD2h8i2ax_f818DdDnRgC5pwdlgXZ_SM7Tn
 hG86WZt0IG17H0C62KCTqUUvclJ6yu9j.6Bfn3qzPnxfBpJCDEA2RekqVoDM5xbvhXPYhCtkzvnl
 aJ5r78fKeC30VZ4WZge_ULD3xNIINTd.tSxNBTtTqmVS_UYsr_p3d18DH4E0LPvCjBmPvtcy3Cny
 2gIZBP95P_FSg3V26P3rux97XBzNJ05H9ozwxSfoTd.kl3hsSdoVMg8IGJHZlhR58oLVON3DvTeN
 dj1p4ZfFtC_W7wJl8e_JnJtXMveFubwfi4b7Z24LJK0rYxG4O8xJli0x72_Nmvm2sWVixfFVfCsF
 UtHtFv07ISc8o8BVvaojk6tVbpzU1xIYRQOTDb9Eye4IM5nsPn0SQnzQWW.o5Ax4JPrPYoYn6Vvm
 0OlbfcnJV6SJFB1CeK7m4Z.0x8WhSr.sSrZcdc_IQpbqNon3Omm6hZrf0aasz07C1bpHYcWqqPb0
 7CXKfo398jCmU_CbqRBFFw1IjJTjStzLzrJKIJEuaTJxsaeAT3Ivl66RJJyKLjUGt5.ipKUa_Y7G
 z8Zv53zV5z8LYbG1nNQZ5u9dKrTbjxHkTe3xOr407DUYzGiAxJ4kAuPU8uieyDaDeZy7LvlgsQeP
 2qEJtO.l6PjNaH3zhexFmcKbUIN4KHnyxsgEOuEk61QH0aa4xjYz_zW03rZ.djWakezKAc50jYDq
 Z1mvx5it33Y3Lfv.lKx9FEdWgvk2bhUInjn0mU7mNAlt9jvNMa9Hco9fsLab7dUr3Y_1zFz5OxsA
 Bz1jpsK.QBgzKAGGMQOOByKGi0tK8ASguY_yOfXOMycb7F5ElsUtlIxJVw.e719APRV4ki.HUn02
 DTSMJ44npTZjoIA_6vQ88.Wz10Qv.PrNltr5Sw4BnFAB.yWTEUVdILwnDMSiZvKZYiFAXdwTbYJ8
 tXZ2Ddr5C2l4H9fw9MleMv62_lfx.CC09t2emqM5kFGWiZzOG7KsdMg4.SByaI_mLrf4hstdA9GW
 BxIdW.bZ7WciwnTdMPlwz1KhtYHjKkeKiTSrSp8o6ske2N79F63N2bgQAjkeQVmyg8949KCk9oqb
 8fOuZqu9.KDg3_.ZTk2JPB9mnybOKEnr5uXotyA0MuwxUyc8Yy4iBDMPUdqUDVA9zwIU1keq10BW
 flvdDaEXKpGQHYWXj3mzEjxi.tovAH74f1ezUjt5fHiWlZBzTdrF57llUbrJgVgiiABtZdaeS3Kx
 NunAvi9.4_4WWeg3f0AEx5MIkcqjDuiYSbdXpU_L7GwpxdbPNma7lFkk.qCeIDdZL6C.78Pocf9p
 cCtNax_ER1t_F71rcrNpSUQxrE1862283vpC.JLgnE4877Kyz4o3fEYuiY8KZRVeqxP.LreQuYnp
 vsyr9jO8qKdXPUvO2Fq0.hblJJMmG7jrZNWp3ve5AZ2YBODRzfRqSt.RjINkC77ZIR34UwZa.QiD
 Y1gAe1S_CtFqrDoupWzJzPM0WvcmSyTAgTsOdCpO8wjaf7LJwCSw_wuoJ4HqApIHqvlyQRCRJkLL
 7Z61MKkayIQJATj9XI7YmJ2rWLf2KOPCuKjBrsQEVGCQSWlDzN9OjQnrZ2JkvfEsHeAoicz1LPaG
 PHVLibsALqy9IPu.AeOI4tu7czaUFn5ZIk3WNsrOnQ.0XfJzd5I5uDQ8__5ENqXJgOZAeqjGSkZU
 l114kdvPTuAfsfMWi1gnLyP_xlVwyMyYU5DFJOFrkhUhdoS3moDhJVrHktzUtGtJiMzigIMpoPi8
 48etdmb2KRdPtriMzL2Ak6vkT4QHsQ5kZJFB94_is4JO6f9V3g8WE.HyqM9jl34ZFrrRZVVJoPko
 irAK1R3ej0K2yhOHdXWu7hu5ptS7QKhjgEqtOg5Q-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Dec 2022 23:38:27 +0000
Received: by hermes--production-gq1-d898c4779-kmgvg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c30ab77c0fba0515bdb50273bd82270d;
          Thu, 29 Dec 2022 23:38:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v4 6/8] LSM: lsm_set_self_attr syscall for LSM self attributes
Date:   Thu, 29 Dec 2022 15:34:52 -0800
Message-Id: <20221229233454.43880-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229233454.43880-1-casey@schaufler-ca.com>
References: <20221229233454.43880-1-casey@schaufler-ca.com>
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

Create a system call lsm_set_self_attr() to set a security
module maintained attribute of the current process. Historically
these attributes have been exposed to user space via entries in
procfs under /proc/self/attr.

The attribute value is provided in a lsm_ctx structure. The structure
identifys the size of the attribute, and the attribute value. The format
of the attribute value is defined by the security module, but will always
be \0 terminated if it is a string. The ctx_len value must always be
strlen(ctx)+1 if the value is a string. The flags field is reserved for
future security module specific use and must be 0.

        ---------------------------
        | __u32 id                |
        ---------------------------
        | __u64 flags             |
        ---------------------------
        | __kernel_size_t ctx_len |
        ---------------------------
        | __u8 ctx[ctx_len]       |
        ---------------------------

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/userspace-api/lsm.rst |  3 +++
 include/linux/syscalls.h            |  2 ++
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 41 +++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index e342d75b99ab..c7da13801305 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -57,6 +57,9 @@ Get the security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_set_self_attr
+
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_module_list
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 9eb4cb6bbeb1..a9f1ec9942af 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1062,6 +1062,8 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
 				      int flags);
 asmlinkage long sys_lsm_module_list(u32 *ids, size_t *size, int flags);
+asmlinkage long sys_lsm_set_self_attr(struct lsm_ctx *ctx, size_t size,
+				      int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index af1fd28c0420..c3884c1c7339 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_module_list);
+COND_SYSCALL(lsm_set_self_attr);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 3838cdf66310..b0dc11e7d3df 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -181,6 +181,47 @@ SYSCALL_DEFINE3(lsm_get_self_attr,
 	return rc;
 }
 
+/**
+ * sys_lsm_set_self_attr - Set current task's security module attribute
+ * @ctx: the LSM contexts
+ * @size: size of @ctx
+ * @flags: which attribute to set
+ *
+ * Sets the calling task's LSM context. On success this function
+ * returns 0. If the attribute specified cannot be set a negative
+ * value indicating the reason for the error is returned.
+ */
+SYSCALL_DEFINE3(lsm_set_self_attr,
+		struct lsm_ctx __user *, ctx,
+		__kernel_size_t, size,
+		__u32, flags)
+{
+	int rc = -EINVAL;
+	int attr;
+	void *page;
+	struct lsm_ctx *ip;
+
+	if (size > PAGE_SIZE)
+		return -E2BIG;
+	if (size <= sizeof(*ip))
+		return -EINVAL;
+
+	attr = attr_used_index(flags);
+	if (attr < 0)
+		return attr;
+
+	page = memdup_user(ctx, size);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	ip = page;
+	if (sizeof(*ip) + ip->ctx_len <= size)
+		rc = security_setprocattr(ip->id, lsm_attr_names[attr].name,
+					  ip->ctx, ip->ctx_len);
+	kfree(page);
+	return (rc > 0) ? 0 : rc;
+}
+
 /**
  * sys_lsm_module_list - Return a list of the active security modules
  * @ids: the LSM module ids
-- 
2.38.1

