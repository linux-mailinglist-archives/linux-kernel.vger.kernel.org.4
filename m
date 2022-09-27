Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB74E5ECD53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiI0T43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiI0T4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:56:17 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3287CAA3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308574; bh=Kh8i16a0m8mq1Xnpun2zhyi3u0lPOUkXVFGhcP3AKJ8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CCOwpscu35lwxGLwZ2/v29YqcR42ocCfRtlyQ3OYy5YRLp/Ai8KjhjTBHI8lTpjoIej1T8XiIUSG0phGSYyf0x7ImtXiuuLQJHGjpTXheeJ6QR0ch0Y9Wjk3Ao0+LtJViSB2z0zQk0ToGdzT/7StpDLMVPVVPK1oZ8dWuNISgoDpRARhQPTpE6I7DBDKxvdmmYG/AILaAIDlUbbuBCNuhooIieis3m/vV4+1WMkxGBmE4yx9AWqLmLQ6g1Y1T7OqO2ekjRgpWbtgbfipcC77GUC7QmmEoPbBRB40NB4FVvsYUuEbYiBYFJx5jpf3J78dh7DUI+6RASoiPT9KmgO/dw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308574; bh=/mFV8nrKHKziknKHS+k/smuAaU9FD83Vp8CIDoIOUN4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bdKhOX5Bnc0LXZyfNW8G2jhIIpENO9ulI5txH6veCmV62xpvRfnNkTnMUPHiz/lyw0WSpgtkYjyGHxUehBHNYtjCFq+4sadyFoOx8TCQmEjPJu2XPjC/GbwpGArgdSYWgzA8ZwR5fLsQ7coAeEPtzXOzYJncKk++Pi4MG+HwzJyIXqdiEFnjgAbahOC0A564fZSZiQvsSmFsSwTptqh1koX1NrRbAWTLx5urIC60QYYrEQpvm8shXsqQmI61AlqAzV0ZgcVGJlRV3VTwTrNEbUxz6WZqFNqXkMNH3NYWdbEsLVBa9wXJYA4AIgV4oNHojraB3gAGggcdaVaTeSZwkQ==
X-YMail-OSG: _CwTIPUVM1kKMNXWVjVQXgYCmlIcGojkol9V_SpDI59Wiu_ZCWDPa1Pv3eP0PH9
 X5AsPvSQnlhkl3fmR6i6uRqBSxYw0STHwYkkRJUc5uuZxdffEbhL4ZY7CiXXwE5zzXu69q_kpB4W
 DXfVYUOhu6cf2RKLr0cRuQFBm4x71vVME6fywKNrz6jLpiP18n43Xwv7.B8dyUzcbO4EdXeKOJsp
 SdQ1ofGChnYMgkmtEns1k8411aKXqXd03v3AyQDRSz5s5K0HAbENYBynJg9rYK7YSyGTu3R5TzvV
 dnmKUREP4uo7L42LbOsM1gbfNOfuY9CxSaKo9Ta76cspvnafEfykVdI_7Vh8KQTGu7EjFV.hSJYt
 JD8EVxXvKF4cZUrxbu66JRrz1embXoQ7Ws15mO0sK6hLO.pX140ncrigyg_58x572Uv76_ysF1Nr
 jxF54aY01o9_zQLZjA6e._PAf321OUACxAb2jGShNLkpM1lpK9iMsfz348GbXpk8hoDe6_AHkW6C
 hDBZnGjUjOIUujeI0qiNgvtEbxDPt9o8svJw3l19Ekgzf7cy5FaZHo7X6iQDOtwqmZLSAtq0sxiV
 E.WT.usOXZgHNtRR_l2xu33CcEVOToYlOCNg8i_tFE.E55arQU05DN42.TN9D3A67vy8fg18cQmP
 rsNP34XF0DJ0fGsQjHUPpnViJRhip3b2.bDj7y8tMoV7UYHj4jNrH4u5JrQymccBMrAunAhMPCzX
 .oCy9qfm4g39uNkM8HAduVfi7f5HiPQdU5jO6vRpYg4teC858NBplRvbpwn_2R3c5blbowgQcBoo
 gu49Ln0l7lwJpv7QUySL2AenTS1DwAWjxRrEVxBUlbMj8gsbbTuLo87bS10eAs15eroU92WPdxRB
 b7jsYehSfqiePygLYrBaYzwNITdxD5pXeZIPeAdO6C1t8o5Szt.M1YNtazwkAM_nCxTaTsFUn48z
 gd0QM5ff7esW3BwF3JA8cE8phJvLRBRrbRn9Kb9hWP48dH7C.k55OiQCWzO5qOGxjv0SvONHKbZY
 63.DdEnT1rrPyixCdT1W8SCBsTT6ax8LAyGT.S02OLQaMGXpmh.TVAjQ_voIpxzuSuV3SZgL3WDB
 Ko4gdcdo.QrCFCSnFHrANycyFGzWgoqMdxuVn0GKHxWDLmHt7eetTpbj8GNDumtjSqO1pb8N8Yp0
 2ZH5Ukpmmz2QQS3uudfJhtkq5IAAJ8eHB_fdvsynw7kH.6dp5TVoJGj0l2y8ntKFW23DneEU8ami
 lMA6vTQLZb9i8KspuB1WJx7J_8NJcsYjMZCacB4RecejrLfNwjMSXeCb4tqn4h7U0UPJP3s_mSfe
 j197_XT9vtRL13IE9tdBcCgmlHday.9pKKxZgz63B7vV1jR2ps9vyqudy0EDkN9jhmmYlZEK_Ma.
 A6t.AzBit1SpvTEj1l_3drlpb5cugLVF0w9FsvXD5LhtcFJ9hhXU9ShA4kt.taIB9KJ2hr94NfhO
 Hehx7NfSIJw6yjN1CZ_DeSUDIiThPzGePmh0pCRS5CJltVRW0Hkcx_o8dG.63onmOWavDjYkh3Wx
 3C3VSeEprNmvsGIEmXgkMd_FF9gLFvlhryZghS6EUp8EkVKmAicpsSg_Uz3t_A8D1yU_1i8S5UZM
 ASuCCfxeGDvjVbtfqkA851Wfg8inxCBm_I7G3xY91.OnBdUcqds2D7NxJTVydzue4eJFehKSlOwQ
 805rZs7FIoNblk8jiPllrrjy4Zv5BLkq4cO6ySFRQOd9zwRbn5piUiMquCae3s1aRun32nemc2B0
 FOzmv_dPmqvUuCZSI5DRZMEVM0Yid01412hI5srtr_wk9mFG390eRqvgIwQsOuxLqavmbIOHxzqI
 0UybKpKh6bXUTf_CTiVP.cxRm.xIjD.vh4gF9ivDpB57vzR1cimWiUZz14ymFGgF8djoEcG70EfF
 JLn0vNH.GBczY3NgzgUZ29LQcCTcHcULiFcyYC2K7wQvoTV2LyzMQKxasnCovzuzOnO7ENMGFPQP
 wSXDjDqY_TLxsywShbgMpvftstxZGHNC1y6NbiYMab6W5QAuheFxMcubjsdgPGN3y8i9JDkWePRl
 1qiv33ZbSKipPEniSa4sD6Vuj4RKAhoTiKKry9VWEr7kdNZbsouHQDMpelTDXxrhuhXY82ScCNpM
 _uwZ7PnWD.xHLjnm_9GMfOy29jggbpoJLuw82b4xyiAdAQ8Q5R0WlwzIHEJUlPoRwCzyUt._1gbX
 MJGp7ZzMIo2pplaQTdDwIsWoTz.NkyVYNncmqHi.VH64Vq3nKjCWUxpQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 19:56:14 +0000
Received: by hermes--production-ne1-6dd4f99767-h2xxw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ed20d3b3c3bee07b1518207f2172ebcb;
          Tue, 27 Sep 2022 19:56:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 04/39] LSM: Maintain a table of LSM attribute data
Date:   Tue, 27 Sep 2022 12:53:46 -0700
Message-Id: <20220927195421.14713-5-casey@schaufler-ca.com>
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

As LSMs are registered add their lsm_id pointers to a table.
This will be used later for attribute reporting.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 17 +++++++++++++++++
 security/security.c      | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 7bd0c490703d..abdd151fc720 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -136,6 +136,23 @@ enum lockdown_reason {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 
+#define LSMID_ENTRIES ( \
+	1 + /* capabilities */ \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
+
+extern int lsm_id;
+extern struct lsm_id *lsm_idlist[];
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index ff7fda4ffa43..14f22d9c9d84 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <uapi/linux/lsm.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
@@ -318,6 +319,12 @@ static void __init lsm_early_task(struct task_struct *task);
 
 static int lsm_append(const char *new, char **result);
 
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+int lsm_id __lsm_ro_after_init;
+struct lsm_id *lsm_idlist[LSMID_ENTRIES] __lsm_ro_after_init;
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -362,6 +369,7 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
 
+	init_debug("lsm count            = %d\n", lsm_id);
 	kfree(ordered_lsms);
 }
 
@@ -483,6 +491,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once. Landlock is one such case.
+	 */
+	if (lsm_id == 0 || lsm_idlist[lsm_id - 1] != lsmid)
+		lsm_idlist[lsm_id++] = lsmid;
+
+	if (lsm_id > LSMID_ENTRIES)
+		panic("%s Too many LSMs registered.\n", __func__);
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-- 
2.37.3

