Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADD636B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiKWUXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbiKWUXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:23:20 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B91D1C2F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234758; bh=aGqemySTCLk8V0kEN4OiRHHiWHs3EyepJemiGCSQEPA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=s3ciXVOb7Sb0eo6yslbDwgHad70/mC9nSq9nKZ7hRj12Lm5ReR4zF00L99zXIK4THAwpfcVOGCdPBYpAe4uaEceUGNIibLeOwgovkuP0qYvgXlvvK4QzqG6my/jFsRfJ8kJ1dGZAW/pFlP9ezc5qU/3FuFqMbDF8xYR3wpW0I0f6L9Xm57+v+5AGPs4wgge+STWmCZiJnqtH3mFgqBJThJa0L3GxhgbXMdaII1fXOkQTVrlb2jqCQLUqA8dln8UMKY9QBeMYF2BAuS4JL76u23M6t3JtOFwvlwrsD0zLG3XXHfucrwjK+oIf1zp7V9s/ABYVVi9Ws/k/ztXUG0G7lg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234758; bh=LNqFWsspVnudvfFJ7CnOMeJvvy+mq+SWil1ONRSNN4q=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cqLDKY+MDjN43rip8ueuszoFsZ++yVPIPlXJ1LhYyyv4qMuxK5UX7CqCRdpjW7KZU5JkDCN1VrEkfL3r93G8z5WpBhh7LuSwydS55x29DA71DnpObKpla8YDrJ1fNSRPT0zHr076l0DhkVUxpxL8Pf/e5MYrrHtN7s4PDLslsH3wXRzQyo5BGOZRN6RohyUTRc7T6jT3yIsGv4mDOUIZ/c7c25kATDRGi2grbXBwrm8CMkQdzJBqWiMEbYO4MHm6J/7N/5/OxTSAFNR9z3L5N2VW9IcnvffUqVUvjVX31TG5kGsY8+x062yexZWYYhQGrFUp9O9SQqHIBxeN8KYrSg==
X-YMail-OSG: rINToh4VM1l_icvkcCoaKyitoXxXeAt7XKGyjvQ4weq.RGUiiHyhT_4ocpVlvpK
 vYug3rHlVdUyaMM6ZpeFENBUf1EnBhQyokK0hfEoYuLMD5nL__RA4kZ4TDm_euGzPox3BvzQ28Or
 PpgPt.7Fzmw3ZP_MIcqDvpXoa9ayzmezblp0UU6fOh1w.N3AcB6wrzxQ6olNFRq8J4IXyoTTVbkv
 8pbDzrSDy_7ftGXnunvSTisC6GsffW_d2VkJijf9tM7EtqiC8rZI3HKNWjFPqNBX1EsG.IHO6G7J
 NyniO26MjFpXpavG1MOQCO9DXsE0Yu9x8d9TvTSldmMXgul9tqSg_jUDNTenb9cSh1h0lB1RXPLZ
 BTNqz9jQ3IcnFhMpyY2flPw7K6PnJRl8QlZ4bX3vwGgcrVauKaOq2lnhN_lGCijmI9cp4qICoDP8
 Gr2xF4d4mvVcMUxjJBTcqzpFvMOkAQgD9jfodKTYGJFmhTkn1ub5voIV2psYEzfUE2ePDcEViWve
 5gFu6TNAAsrQLQnT3zamlBNgUuKnZ8xj12p6iNTxL5GXQG.o0CdGjNMDTbcHjuLiDddFAE6xgrN2
 Z3OZX6P8s7cInlX3PLBSFqYKmoAiG27wSwm4PlfG2LJQZem0hQmAsBSr1z5eq0thPASwKDY0Kg.4
 Kunx1Pff3jQQm_zY1PTvNuxb4vtfRc8TH2Ky2Wrib5d79GUcltU5T2NG3n1UP6_STpyIP8z9MCld
 Ub7zoyA51TMQkXJJYXqtcACRu70Zy0M_wzw132Qc7z5BWNz7uh99s9omcyTnRWhwzQUD8jBzRdpU
 e3dh.YlYn7V_7YaQm_yfQUCQCldd24szdgzW9JeRqGR7mwcnyF.cXmu50V_y9RUbJK_zguLdTst2
 QJRO7owhzVkjX2NUzrGM0HKQcywJllE_gRLFa_FyUEazbvCgE.lLPRbZrdg7M02y9NVr0DOAu2mU
 7i70yk_fVHh9jiJ873qwNbKKvbJ9LTQLGhrgh3h8xdZSBm9.DccXR0CG.LSr2TljW7fk4nJxqt04
 sZDXcccrWFh4bp7WcyDRKbWDm8EnmyMuEkLGcuISbRDmZktSseD9Eo.eGBUf3jYF8eU4eG.8B930
 BJKpPsMGjN.1KNrSu8Tm7ei3G0sHvMEIPyoW8_8fu7QYSmAI6awJ5o8mXqigbHbIWZ9D8nEJS5Yn
 UqnpSFDOXyI9BXM_fxlF0tWImCPpX56Lgdye24db9bl.Xnlo_ovyLTmKhuf0GjMXVRqZfcnqV.Ut
 2mWSYiREitDUM45m9yyf1Vn8Mb8aDodWI_mDPRHwW3.8ZYQkMEraZ1r1vvRcBDa0oMhhZ80nQsUN
 vujxA9ywuihPVtrxzBgXL22A1tgO_MzaHAUZ63dCpzifKipUwvARBySkDv61L7xu_l9bsgIT1iM9
 NUD7kh9VYwCVT8aD7P08GbouXWyh5e2dnkf38_MC.iAH3ewq3B7QfYbXMyC9uxUlP8V2KsSvk_hJ
 RLHsMFrM7_8L4oRy4t3BgJ.2rekuWBXcfBq8YforWGyxHIABiAeXv9aJuVsqAyKYCVjnZN62YTzp
 9i0PF0w9Azz5MTsN_JybXVuq1hMctVR5KTx56jeZpvLnLmidXagqzj_xtzJvJ6w4FNCSp5TyssMT
 iuw37z0NemeWZZYmTU.hLr4cCZg8oVryAug0GgLMLqD8iOQKaBTCSp3SPrH2Wu4q.OAUAQSUcuVw
 glaZ3AKAAp2oyzihRCCn1duh0Xn2sXA6US4x.JfMDDSRPCDZsTOpfTxtjgj3CzX9AAacF7_yatWP
 tw3gO7KkMbqSETVRjfC6s1JvkmLlDjoax493vuW1ode.DnH0r0w3Hi8glVuHeKgqAKFrChueUozb
 i4AkQyy_08WxVZYezfYQXp1KmW5sLfPFI3NP4k_ML3LRWqyMihewDh0weFlg499N9gsD8l5qUjHj
 M7TrM0k.b6ZhYjTIkwsLeuy0MeNNFnlrXwQ0cnSgan..W916P38IO66QEWwJ_1FoNk_0Tzt.npp1
 PG3WnwQmeDomnx0LBKBJevcHBEMV5v7Z9h_o6IQFjhFGE1TqIVsxIXGs8j2B0VytkOrQ.hLaH3sp
 P3UYyQXGHAypisiuEz1zL4kS8ZCy0cSids_Rn49wbJIp6NxHgnv_qTzNhQVRLt12OAOH89QnvwLB
 o57sX9WmJoXGhcFu0jz_.fwJK7FJNBcuVTUG9k7FatMDHzBNQKf1cCsuDs76puA2Uc_CUKTm2Ju5
 THUX_pDkKBsNhxiJcT4xryNIO8yICIovKGu70MOI2DYL17YwDlHg6mPj2a.UwoJ5rXUzDou6Wf9Z
 18BIUIs7CWq_WA8LzSGeDt.zR
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:19:18 +0000
Received: by hermes--production-gq1-579bc4bddd-b8ql8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38c80e614aa0809f99b59395af46cd39;
          Wed, 23 Nov 2022 20:19:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v3 7/9] LSM: lsm_set_self_attr syscall for LSM self attributes
Date:   Wed, 23 Nov 2022 12:15:50 -0800
Message-Id: <20221123201552.7865-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123201552.7865-1-casey@schaufler-ca.com>
References: <20221123201552.7865-1-casey@schaufler-ca.com>
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
index 2411b4043752..75123c13a55f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1060,6 +1060,8 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
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

