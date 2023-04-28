Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102BE6F1F84
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346682AbjD1UgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjD1UgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:36:06 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC9D12D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714164; bh=3rrx2/4CPchvROU7XfPjU63ZFDXsxZuUk/9nazGCq3E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QarBwP1cqGeFWbaKZ2C71JNds/uzP0VoVOxSrxp7xUGsHjKyB6uWQS3zFf7rEtsAPLtV1e+K2+xg892OSV4Z3IbPYDa/KJ21ZbBMrlyhTY1AiNLHjzvmrcFpg6JGbQgDscaGzBMSNCqsuAl1Fthd9DhLprR4uf2ONCirleclNjgngzrJpl65uvbWTpkcIV5bUbE0mcSFA80ejPiWemAEz8ApXD4f9Zr+NHtzH27/x7BTBeI23Ai9n4CNHeZB8LRG+UIwB/9DNDMiFwDkJIiL9fuMv3/wyG32bZjzvW0I9UH2QLKvm4xXtTQtnC8omeNWVujAeZkm8YV2BQcRXqzSjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714164; bh=H37CGhumWx4FB7+rIMRkSjNGRaIDHEZs7VpSPRXrt6Y=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UEVXPGch/X8yc9DZhmVFWvgABQjAJrZfxlbcPnyUVfpvQ6a4bV6Dh95AHIGMyBD/xmD42KDCd9nY0+p7YENiSw7HeL9FNP5tcGOzTM/Um618UP4UOKJ0qM0SpzCcs1qsgijzZQXfR8cqaC8NNEuhbWEMSAEuynmHk+PA920wGsjOdkzvfrRQo4Y30OMufzaEANYejhOmcpvlftV9kQUHXcmrhDozVTdOjB0i5/6w0mPgcXiyp9WYVYwV5dYmMNXV2IJkrf3WI6ymLQs8zb/jyx2S3suRc8g44m61iyRrpscngkpSj1YPQ6/GCk7wWD7cOrfq/as894z5Z92M9qXheg==
X-YMail-OSG: heNZ4NsVM1mFG5yjiEhwstl562EkzWndqoodPUDm3pMTVFFYgRdMCN5inYmbGiG
 NTIXW2mH1TgDZMUcuc8VgZ592BRitseBsBxf7SCwniI_SlnMHp_pfG29W69tnlPjUEsPCtlaEUg4
 0zX1c.chXLTrOzu4eyvxgSLTjgJDTve.H5BvMegvdQaw7rdlejjescvMv.B.qHYYRoEw2LUQ37Dj
 iu8wl5PXC4HzvD0dBG7njB7LwKunIjtQ9FhVcwYPn1Yqy.fhVRJ_sxN9WDaY_0xi2apif7GOm4OD
 vtsEULfTyOlG6A1X8IHY5_N6OK7pfaxKTU3R1zQEhWQfuyEHbc5Esk2xrWwUcSSF9zHSdCNPhnEx
 .hnN9sBXAlXVXOtQD8ozl2V5l6tuaGBt8wyzixYZB1azzQF9Bq5cnrn1QBurO7rHuEL0Y1EdSulj
 YUwjgtOOXL3MQ5eyxpzP5VR0WddD0AChMukIog5a30X9K2UF6UlgfcINB3JXbcZPoyHhXDXWuduj
 qHNDTrXO5jWscgu54D6fgq2gQ3WzF7rh2Re7KaV7wO0WS4TF69vaUJWZNkaxeeZyIU5qoXqXdama
 UGo69SuiMTbqoppLjq7i4MBauL7KN5gLl9R0xoqkrBuTzd8hYkvNnoqYpDj24K3nXZ1EiVQ__3WZ
 ym3KBe6n6n3JPMXIsswzjPfYeJ2qdXsCIZjcLkGN7rpzHvEJVugga2zqP1QU.O1s2ph4oFRu7.sQ
 GBGZ7kYiRqQHjMKzVKlSFQA1nPV1rhUl2dPpW7AbhlOwb.wdCRoXBlSa3OGFpJaSjM7_VYP.37fZ
 2A3k87dpnEPs6TxoavxYlvFDsha6KYl0nUcV4gJ4DgyzBVc2guuzWniGREjjm_lYfkFJRBjOr57l
 6rXNapyaBG2o_90uWfNSiACvhVZ92rZwi4TAriOmNHc8PaUWBwyG5FexlODz9gbBrNv4GSfzMFEJ
 Xos5tLLOPSJUZ5rexEXZ83AocB5Dfim46nKCXfBi8TzYN3pTqe_nztvdTkUc_Y2I9179jeL1a8he
 _2uOCidLd_1qsRU8t3Xa049GPaZMcK_1cbvLrNoatAPAIUrH_V78HSv64hI1E40DtDUs.GQfW6ud
 H3l31HtskXOI__flAEuWtqhJF8cKKgqayREFNWj4lB5mAspLki1ZE7y0MT.P_1Rlad7uNvzgriW3
 e2CUnu6B99O6py6W63mApRxttlRwTdMFFHyipOYc618CrnenDLplKevF2JpL1eGSkzW_Zf3PpkS7
 DTIZs5zbnYi89ra_QbMrLgWFz0pQPiaS29X3v0ncWdWR7igH0P171bjXi9Eei.Gq.vQd0hxdssAj
 dw8HenEShT4yZiaHRDQWUtkdbc7FxGZRn.D8tkmvcZZ9TUaAtvfmCiQXFMqQELfe0hRP2MXl.Hrg
 ggktN4ptKcQnpB.xI3TP2ciE6zFSbnUTfjhvKO_4J2Jl2rHANKmjuzL02f56TuOXiljrRoHO_W.O
 AsDHIq0rcCoPGXpS3CkUtJeO4BZ9_VeR59be2p_2mLNqsNMe3fKgHB9G2eD6yzO2xsxZgkfKxJPQ
 ro3dP7UI58bZZMmayDOxizcr4sXAl_yGcd2FCUVWBWzWaAHWbnR9juxSRvfNcFBh0nuiqOtVbU73
 7l5jeFW4KkuQhwMADH_LFadabfdrpjT58pzdQ6n4XO6TeSSYahXUD9Nuh1_5RYWYnfsRIC0WuFGy
 eqz14zNglPdI0GxMdJ3zT4ec.4Uzo2JSjyk8bBwvMEMjAY3OMki2tw66r1qP7tDz5pmR_OAB3Uxe
 RiNaGltX3Xw6SJQKjbQ3NZyb0theMooglnmrimbyIY1FRgU9k_Jg9lNk5goOQg2Y1OZB3kOYt3ug
 hCZZ8jfbNjKEm65K82_VVBJqGulCCQJcburrrEoZ.xaWs0l0Xi4.c_k1BpC67l6YOiFLK2QfJDPl
 lulBHs3qJp7wahSz9bFuwbVEtKCjUwGN4GpGgJn233ek0XYQKiF58fIDyOoEwZrQhVcvf._IYL5s
 R7pnBN4Wb8CIyXr14tgSe1qhyXS73DOxfpa80TOsV7RXCqq9wPsATbEGoNTpTY1N5doR1hF6eLPK
 z4ip3Dop7_h0l_7XCUxMfG4D84HpeU6uGCDIBIaklzTdxtLhJMh7qcu5JOtya6ozxwMB8uuYchkJ
 .6E4vhj.rTViIew48rA2mJ5uy7A5jifXOFkLEnXlVzKRlxcrOCf_5RuepsASX.gv_CfqrVZjDOHG
 ygBHK5Jnh_RE.RvtdDCe1or5kPW4_Fn3GVWfZqHv7DHVp94zhvTmzHhT.H3c3GkIdV8kdBcrmjaT
 wwp1bQwVH_0CwbgiYwPs2aQLR6_SpVw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 04ee8b1f-8535-4f91-bcbb-ac5db4472d63
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:36:04 +0000
Received: by hermes--production-gq1-546798879c-mpgfb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ba26e713cb439f1ca91afc1b8b946229;
          Fri, 28 Apr 2023 20:35:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 05/11] LSM: Create lsm_list_modules system call
Date:   Fri, 28 Apr 2023 13:34:11 -0700
Message-Id: <20230428203417.159874-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428203417.159874-1-casey@schaufler-ca.com>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include choosing an
output format, determining required privilege or bypassing
security module specific behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Documentation/userspace-api/lsm.rst |  3 +++
 include/linux/syscalls.h            |  1 +
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index e6c3f262addc..9edae18a2688 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -63,6 +63,9 @@ Get the specified security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_list_modules
+
 Additional documentation
 ========================
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 9a94c31bf6b6..ddbcc333f3c3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      size_t *size, __u32 flags);
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 				      size_t size, __u32 flags);
+asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d03c78ef1562..ceb3d21a62d0 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
 /* security/lsm_syscalls.c */
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
+COND_SYSCALL(lsm_list_modules);
 
 /* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index ee3881159241..b89cccb2f123 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
 {
 	return security_getselfattr(attr, ctx, size, flags);
 }
+
+/**
+ * sys_lsm_list_modules - Return a list of the active security modules
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
+SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
+		u32, flags)
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
2.39.2

