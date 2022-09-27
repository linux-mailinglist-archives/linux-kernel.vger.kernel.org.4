Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651AD5ECD4C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiI0T4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiI0T4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:56:16 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966005FAC2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308574; bh=BuNRSsCGrbA/UtzmRUVacZovuKuYHjMYbRUrNC6cO70=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=J/r20bkQ34m1GJsZHWTlbRuRca9ntvhflMSXKb3JHjtF8/c2cPlv7IAzpJ1w5VwCrtS5Z69wGlp2AiDqSK3a7AEgz+NMry6LpGnOSbSGFIVLFYhQKLqm7zae+KGa1IC5+6BUHsqmJGDCLj6qcOiX1dSqyhTMXVCUZtzCpQQWqjA3guol77tTRMwJ5id6IVmMvpW7PJyDNTtXnKxiK4rxOMYL5otH4ofg2MDGWkC2a7ZY+HjeILR01QHIRX02jKZNzZDovv2leB+0yioVcJFG+ZRR3UChARP8X6HQMQQgIzLjgqchS8Jl8Vz0Ck2q+FjQ7WhMoR/9EsfFW4kuxMZT5A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308574; bh=B/ieQminLxTcoHmUAJMSPdE8JWTyso5pSfQ2x/DlpZJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rFZ49N47rHN9wsLM2qzsF7XJUXXshlq1GvcQRg6610GR9kKjDYGRUN9jBZx/gJIeZ6KazxmALDvQsJTwIFWdb/kDdqsq+UFisoLgBvjQjsDIvlQ1TLSGZN8Y9wege6rAO6nickXGESlvI5pwEIaZ0J7IfhvCQS5t0KR96pv6pmA7h5BF7GR20IaJJwGMareEZHF1YJ6eGdzKlwS18Rouz+kSkVry1dD8itlCkl2SH5O26Xl6ilRAPZC6fK9IVgJ7jbtuerYaPCpEoIU5u8hGiBwf3jrwkrD4TX8An2iPheEQNFiIovG10jw8V2+dElxfklnxD0yCu0ThhIGA9w8r0A==
X-YMail-OSG: ESlA3B8VM1mr0qNm2qLD0BcfUndp6PEiJJBpLXoYLiYqxKfpQuw2IfLLJdK1Ig9
 ZGOAKhTlGO_TzdDl8eMdkFrcZXlNSzyMNv87eIl8LyhbNCvcy8XOYXzkG4ThQUb3H3PNkpzh10nq
 T2XrbPXXZKK1aZEcDR5xpYUpe3DsTd2RMDuEk4gza3bK22jiwjVopgGEN9TgkaTWSd7grLjbe8X_
 D4sNasvXE.kh6sYwJ9yg0YSnveXg_hvZSzyGYFVfJufs4eGISD1i2lVcOGgAyVuMAWMSZfPJqOz6
 H0iPZ4eMCSeQtePyl1t2QlXsAvXZ2RBGX71hxFvwQssmpNE5tQAXdH0Z935TLZpolHCX5W4Exzcr
 dC1czazqGlsJslqaULBkdJ.oZco8Ymg6fU4oSj7GB0UOA1nQ7U3zd6WlrDEYmbW_xV7yYjGr1lmv
 2dF_B.ob0UPsB8ckTIsfcw0sCfBHhbR1cbi7Of5Cezert5BLGYLQgEDbwgnId1mC.VEA7MUMnpKv
 m1jLuzGqbIWg8OaG.tyb7ON3I9HRM8NqNAVfh5k_ygxLCet29ckTsW668QZu4PrDRGM.gIiPAqHQ
 8ou2hhAWB0dQU6cmluN2VR4SVINsywE6g8nSkOlHBpQCycJYQqqIrfZc0EBKHzYuN2.g6TR6XuJf
 LwD83vEFD0y5QcrE21glBhqHwcTfh8V0Zivlq5Pd9Wyx.P5vG5cVGbrRWv2ehFJtzPGMVivzhbge
 tPJtG8zXtRQZV4JzBK7oOhPnB6zmCsCAJ2HmywRrxFG_K0yHviK6edVp5FCf2oHfwa4MJojMyRE3
 31lDcbeNH9Yb1uDmllq6Cr19MwOrqTVdl0VUlTNbiU2eLn6u0tAiY_hPOukqVrMzmrVAwufnQkGC
 X7puYjxMgphZ0bHcmjXjb80fpk2vqT77_Mmzdck3kif_o2KiT82cKFNcVmiHtNbPYWVSpACwfLsh
 RCoNApJsbUHJbixdn7WV.PNdQJzAnuUy9JYHmy__QcwxcslkQTvxjlA6PifkXdswRGJwW_NhV1AP
 SKil0FErsW7D7aV9EI70phsLD9tZWWVg13HZXKIsfkDreIByXotpsO2BS4toXny8oSe.g2aFZvBu
 6dWfLpYxkgFH8IHwPDG.IfJXFg2iFLQzoUpUele2.pdkB_rQO9KZYHaeYXT8zc9KM_t6QrEha7VH
 nPxe4ii14IVo2GTLRYftGj30fRG4hslDDTTzeMAPJuwtyUJEwARMwImc9zTGHbFCYRWEuABZjW52
 Uz6NX5JPyxrYB30KoiV5t1l3PTgI7P0SLWwXBFb4rvLbpAh1EOu2D0khUkmPT84m5vOugMEGTHdY
 ZyLd_RFqUH3OeHqQqCiZ9U7zl8jrDPqQBD1GaeO3kDhP6V8cQien9PJBtZNlghBStmUwHNGff1_B
 jiX5nCyl3XBhi5iVXkYIqPmBEMHjauE2bk7AYI_7FBZhZMGvVcuRh2wngFHoNcDPQ7uAtXwwgeDE
 1mLee8FcP5s8nZjcvXw6lv6PHaP8QIymZTwLFLxVYNmFhnsyxXj2v9Gkjfu4wEA2jB5Ed6lxUn5e
 OucfAkGk_w.iuG1Kppl6tFu1LY0LijesjoMSk.RU6qZaZJiniGstaCa0oN6mntnLb.C.i5NUHVMB
 oJroHosBa2eiEgYQPFjznLxfsKClt_7lccF0MuMoEm73mOnbIi6goXJCOEYttWfaWyDIs3rgJ01R
 fOK4GHxUBbckQYF0riGsahYe4PS9o9CxFYqnAENt6f4cACDfOxBx0NxIevr8YSQhuS0w0LrznHTs
 hov1jLHXw9GNjGysvXlPBgvR4OHFpRfjK7BCrZPtMtpChd1__D3BT9hunNAgfrLaLXPrWb686Ddn
 y1ANKhDR4YJTU9S3.IfL011SlzjbiHqusr6ndtAg6Tv4V4CCs5sPzyciSAajxNlgXa0lSTSCg93O
 2aR_ARpOcCRXaXu..QCiWD801s.1CkgHyy6iwBXAwZUMwHFx6FZLPgdRVS1ftF8kHcc7yuY.4zr.
 OtCssd.VDHnz5VHskQbam2V1VxkV4NxeODfIJjPAUz719KXRL0BkFxt0gIZQonDM1r7iBYvQcsx3
 xfp5Ke8RvaXEd1D9Tnp3UCSWBpjw7s5vVpj7lxqusAS24Aolhmma6UkqyprinPYXlUOY_i4iOMcn
 uDeXIVgbe3diqVimsyNZIGUlu608KKno8VkGlCxW_6M0F22pOqqesm0fO_Voma8hMzfJKOzXHIft
 1h1SxUuDHdrJd4ioK9XAcOWTAJ5xhL.60d1xrTrMewglnurbknZJxzr72u9bWVdV7y6oIlyjxIBG
 CUMuzsfw5YXTi6LTay0qCTjYZap5i3UG5
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 19:56:14 +0000
Received: by hermes--production-ne1-6dd4f99767-h2xxw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ed20d3b3c3bee07b1518207f2172ebcb;
          Tue, 27 Sep 2022 19:56:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 03/39] LSM: Identify the process attributes for each module
Date:   Tue, 27 Sep 2022 12:53:45 -0700
Message-Id: <20220927195421.14713-4-casey@schaufler-ca.com>
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

Add an integer member "features" to the struct lsm_id which
identifies the API related data associated with each security
module. The initial set of features maps to information that
has traditionaly been available in /proc/self/attr.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 include/uapi/linux/lsm.h   | 14 ++++++++++++++
 security/apparmor/lsm.c    |  1 +
 security/selinux/hooks.c   |  2 ++
 security/smack/smack_lsm.c |  1 +
 5 files changed, 19 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 407f57aaa6ef..ded76db3f523 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1604,6 +1604,7 @@ struct security_hook_heads {
 struct lsm_id {
 	const char	*lsm;		/* Name of the LSM */
 	int		id;		/* LSM ID */
+	int		features;	/* Set of LSM features */
 };
 
 /*
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 5647c3e220c0..4bb692b84a28 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -29,4 +29,18 @@
 #define LSM_ID_LANDLOCK		43
 #define LSM_ID_CAPABILITY	44
 
+/*
+ * LSM_ATTR_XXX values identify the /proc/.../attr entry that the
+ * context represents. Not all security modules provide all of these
+ * values. Some security modules provide none of them.
+ */
+/* clang-format off */
+#define LSM_ATTR_CURRENT	(1UL << 0)
+#define LSM_ATTR_EXEC		(1UL << 1)
+#define LSM_ATTR_FSCREATE	(1UL << 2)
+#define LSM_ATTR_KEYCREATE	(1UL << 3)
+#define LSM_ATTR_PREV		(1UL << 4)
+#define LSM_ATTR_SOCKCREATE	(1UL << 5)
+/* clang-format on */
+
 #endif /* _UAPI_LINUX_LSM_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index fb6c7edd5393..40266cc4866c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1206,6 +1206,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
 	.lsm      = "apparmor",
 	.id       = LSM_ID_APPARMOR,
+	.features = LSM_ATTR_CURRENT | LSM_ATTR_PREV | LSM_ATTR_EXEC,
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9803bbbc6747..625cc791c440 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7016,6 +7016,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
 	.lsm      = "selinux",
 	.id       = LSM_ID_SELINUX,
+	.features = LSM_ATTR_CURRENT | LSM_ATTR_EXEC | LSM_ATTR_FSCREATE |
+		    LSM_ATTR_KEYCREATE | LSM_ATTR_PREV | LSM_ATTR_SOCKCREATE,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2a88b4e7669e..e79640a6bfd7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4778,6 +4778,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 static struct lsm_id smack_lsmid __lsm_ro_after_init = {
 	.lsm      = "smack",
 	.id       = LSM_ID_SMACK,
+	.features = LSM_ATTR_CURRENT,
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
-- 
2.37.3

