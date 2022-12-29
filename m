Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B9665934F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiL2XhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiL2Xgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:36:54 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4619511A2B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672357012; bh=nXuYCBxN4Zmh9IPWHGdwx157B1zGKh55272CrsdwG88=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cFmUyHHo4cSiSAhl84uzkmvW6nphZiHwW7+ZeQ9AdzKhZ3dFBkdMB9NoeUTR9qXZiwO7R/XcWIwfwY2TNXVZpXz0Q7h/T/RN5DSCNAsJSveB4Y0BTIH0LMLFswkeF3xD3j1Ol9RvuM1L6VeIPvUlAQVrnofvyeQzJPdq0+Pc401N+djhR8rHSzEvKpS2csPKIirlIWqkmwq8UihUo5kdtNwb59BmNosuMo7GaBKYcSYYzeEMd7WJXaL6wct7/RAUBY7x+SIiNLc4n8hFI+YtDAMlVDy+ikiuZrY6fUkwA+WKyRJ28+NkfuvSeX5G5JqMwr/V/1b6zrJdLBPqYNgsXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672357012; bh=ICwp+xM9QxAlmAG6BB6zrRN5SYpylzaRB47F+tKZfPp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gzYcRC2pLO1kIMGhc0rsItFCPon1mAqnswGUkRFCnQxD0vnBPpVM6on4kmTHQ6qPVPbMMuvvEDn2m1voKMemHt55viI8n+0O11LLevocj/98uEef8/CD9lyCbV7dffTko9SCx9HYt83wxQp1y2iYlxifCk50pvyZLoawpNZvft4Ubojpp49JX58QfvnTJw9yVBdPb7kkjusNj2321Fvckza3u4m34VS1BnH/V0CTbhCpjJEi6c3/GSz9XuwyCyI0k3dnhnsIhHwGXpNkC9Rsh6LVmV8Hg1p7fo0Ca9fmGYV3gQpTHMYhq92v55tDdxIRtnmWwnWSBUWIigyJcx/a1Q==
X-YMail-OSG: _sWu6zwVM1knPpwLX4.ZIAvnGh0VpVbKuQEWdSA.E6j.w8MlZZ.Hw_70TMRoXiq
 Unu_ZNxbaEAMtAOK5z1nfa9GMioWcjUCKWJFpngfLff2aDT6YjB9HtxjKaPtYnkWPB6KSGkq2TtZ
 BbeCXUP7FYchn0z5CF717JIM3rXcfk6ZMTYmEevHj35KKGEdiNNTany5OSN6EWBStg_g.BLWjTGq
 u9vYPx9oPQ2Awr99TeUkjcNdyZZ2skQyf5jsBiBuaF5ot.RFl4SCfwLUW.lH49qGufK2Of9Jg0SE
 jxUzUQ4jncSikHHtDcLMeJtEbuIwPMKRafAsrH.asLulZhahTDXQZpS5zYoHFzP4imMXSfUcl47v
 iREIZBpf2NxrmLxHlJlY_TprgvJB.Qo2SuuoX1Rar5NYxrhWUt1qpTxFWJ.hPWTPmPb_3jXcxFCH
 _gb5_untj1SxAZrwkuZCnJTav9q8INfvLvZT.isjKbBD7ZtEhKvn2zvytSjytd6HjqESeUpZ4PcC
 WfuWQ6VgeJNR16Qis5QubkElYYIoCRbLvdFURJeclR6wX6WXOmqkGMvQcziO.tiJcPErN.zrywpR
 zrn.9PerrWfrNrOifYtVkukzrvjyiKE4wsgw3nqmQUWyQHou2PjlQ0zJJyBp73SLx2D55mbruwfR
 EJmIJ3mxV8T0D_S4Zue0WvaEpbrcQzUdFWJVqWmMlL.xbXuVlBJEVtXV3sfeClMaUFcmIbbb8aBC
 2OVuOAIsnO0PaGVvt43VCWQ4rPgLv5EFtUiws.PQm8YF6EGpO9Hpn9Opc18fwuPEnIvmYSbKaQqR
 _msG0OnRNVCqGTPQUWbnRXHOHk.lyO2JggxclcvnJNvXOik.szanrZGJMeESTUD.GNfKBy8LLAOG
 MkE8sD6sbMK3NINaeMiCMP.4534SXWZPC.k4OGsfyg6dxURxB3l1suCBbB0k2S0PMbwnzfLdxOC8
 kukKUEmUMqMb.fOz.x7VJjZIiRCjbHP.b86EKLddlydunFEkT94U_pqsRLXMyWNRkYd9dXT6WFx2
 _HXYeaqWd2XgANsiCL7o_Vl8ncLxf.hlkYJ3Y07Y5OkRaGeU0zPVVIzua_aq9hkhxzNPKrnXm5yX
 3O.gssMUgb8YWnpQwHRpVT_8W0h15vyRXe3EArFxD5.CUnrSRTuU1lvGY_VZZy_gCz1wQjuCUj9C
 fDSRBU94UNumGSUtrkqZnXipj461kOj3hp8HjJSVKknqHiGlVWdTrM8Nr89LuPBaJiJ0PJzg9.9_
 K_AfelbEaFM3RJinOUN7gO.R3zrtbCPFU7CQ1kZ8Z6kaB1r.RWw2RwtWlbrwCpplpecaGPkIsfVm
 JaxkxrWcjL5FzFMnwoZeu5rzfTA4sr04R12kk6pnFgHZ.pzLSrMa2brHgfxeW.0h4PDgq17MEZzS
 vTq.UZlit8jK3vLuleyqGyF8FKcZDl4VW89ygrbZ5iC60.EmlyudkMcLmgCfXu50DuHjrIubShnZ
 T9hAYQYNAzjBJJZAhuRGEw91EV4JyLrMt4TKicVxx79ClQBH9COX6IQtgJcwpssE81rD3LoM2Srm
 BGSfiTYdh9zT_G6mJt130mvaSOThs1QetjVgCws7B4hGjF4m7TDdpS6o9HwH5cWUDThelar25_0W
 YmuOZVLtHgaT8_rH1isXx.hpDGKeO0TNpu2CKUivsUFs2mzIpokdtrb1PrNKx7rXFH8SjMDQQX91
 i6rHu5SGUI.xg1C9.yrnKmzatrzRaoZbNzTIuTnCqhEp6mP4TvAPGPODJDlIKfiKcXdN_OFcOgIv
 oSWQWARi2QsH6mURHqEtfFQ6G1C8mpnz1pADLT0rI4pF37huI2f6gRQ0V_s6wg2ZJkqKZcmYluLQ
 axEGmDKnyD3_.4gAQ6LO2iY3O5LNffu55jk_DepL.E0Gno2GxvKsN_iYA7QNGEHyiGhrKj0Tg8y1
 HYErJQAL5AGVXUKdIRSBQnONNmbBDf8tTJSlp_ZA.1kn8qs37JnlOSQa0LmSZ7gD1UAJpUrivwmh
 dLYaOYKgE9sW0BafhDdG6lGHhies5cnDCJdePZFBQGz.s2Y2vFYsWaB2e0tdEwOiTpl2c3SL3ILY
 ybPey5nxAJMErWpOlzjTTNQHaVSkvkGliZRBAak2_MolML8r9yXJdy3a5hbUuUTR2dk83BBjhjxe
 gt3U9HYLXKpqpaPtnm51qGEE3w00906Y_x6U1nOgWBoo.iSVKgAeQQOmFjjv3E1.e7incoR0b3x1
 7nN30zOD0YArwJV6JoGosN6RvgndbhLQC33nR2Zv8
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Dec 2022 23:36:52 +0000
Received: by hermes--production-bf1-5458f64d4-x4bxm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2c9ed6e23ac4176228a90f5214b07a1b;
          Thu, 29 Dec 2022 23:36:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v4 5/8] LSM: Create lsm_module_list system call
Date:   Thu, 29 Dec 2022 15:34:51 -0800
Message-Id: <20221229233454.43880-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229233454.43880-1-casey@schaufler-ca.com>
References: <20221229233454.43880-1-casey@schaufler-ca.com>
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

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include chosing an
output format, determining required privilege or bypassing
security module specific behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/userspace-api/lsm.rst |  3 +++
 include/linux/syscalls.h            |  1 +
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 41 +++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index 98a0c191b499..e342d75b99ab 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -57,6 +57,9 @@ Get the security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_module_list
+
 Additional documentation
 ========================
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a89205c70ffa..9eb4cb6bbeb1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1061,6 +1061,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 					    unsigned long flags);
 asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
 				      int flags);
+asmlinkage long sys_lsm_module_list(u32 *ids, size_t *size, int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 7b2513d5605d..af1fd28c0420 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -264,6 +264,7 @@ COND_SYSCALL(mremap);
 
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_get_self_attr);
+COND_SYSCALL(lsm_module_list);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index c109a0dc18fe..3838cdf66310 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -180,3 +180,44 @@ SYSCALL_DEFINE3(lsm_get_self_attr,
 	kfree(final);
 	return rc;
 }
+
+/**
+ * sys_lsm_module_list - Return a list of the active security modules
+ * @ids: the LSM module ids
+ * @size: size of @ids, updated on return
+ * @flags: reserved for future use, must be zero
+ *
+ * Returns a list of the active LSM ids. On success this function
+ * returns the number of @ids array elements. This value may be zero
+ * if there are no LSMs active. If @size is insufficient to contain
+ * the return data -E2BIG is returned and @size is set to the minimum
+ * required size. In all other cases a negative value indicating the
+ * error is returned.
+ */
+SYSCALL_DEFINE3(lsm_module_list,
+		__u32 __user *, ids,
+		size_t __user *, size,
+		__u64, flags)
+{
+	size_t total_size = lsm_active_cnt * sizeof(*ids);
+	size_t usize;
+	int i;
+
+	if (flags)
+		return -EINVAL;
+
+	if (get_user(usize, size))
+		return -EFAULT;
+
+	if (put_user(total_size, size) != 0)
+		return -EFAULT;
+
+	if (usize < total_size)
+		return -E2BIG;
+
+	for (i = 0; i < lsm_active_cnt; i++)
+		if (put_user(lsm_idlist[i]->id, ids++))
+			return -EFAULT;
+
+	return lsm_active_cnt;
+}
-- 
2.38.1

