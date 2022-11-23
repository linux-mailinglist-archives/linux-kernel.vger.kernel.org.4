Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C651A636AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiKWUSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbiKWURo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:17:44 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A6A5DBA9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234661; bh=qn5dpYKouGdwygf/FqjybCs4Om0RnRLlJQiuetJGR6M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qTqW/eHWT8WjRCc8uRQmCBKS2i9SklVs3ONqvHqKD0iEbCwqLz1ITHfQTn3w3EgZh5lSfTQMR0KXY6VxbvQP8l9xCczij1d1ZEtlVc98Zlp6Pm4maF5xn7p/UDJRfB2Stp35YwrRoDkeomRbNeaNYF1nWztBkCoKTQecYHJAq/sU6RIlG5/PnAfThzHnbrMO3r5IkQcV/ElskTRG1KeKru0UgWk+R2vp+BbP7yZMF/+3S2hL2Pw9kTmsqccYFTvT8WA5yis9hBWQyHcJgTIzf8KiroafQkvDfpVaLKcqAApdyoSPXrVzf1rEzL21n0bPgaNwv4exJN0T7lC9hESKRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234661; bh=gzkH37PRs0s4Qmji36nS4+lgtVYWHth9/0RL2voc0F0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SfLei+D+XQ3w7LSAuj/6d1pEGcuMkp6ZdTtkqmZR4L0sI1T2HBbc0bKB1ATaPnUG4QGowIwTw5LONy+TiEKpNFtn3ZYg166090Ojh0Zg+GtsUZKdd0HabjLzq/zgFDB/jj3P4WcjMzllV5UoVCU/dRxDea5xeg3NhGv4T7ZaHbnt9obSa/7IV8D0tUQzxRLUGPL22oDbZNawk20DrBqwl1WUD685PQ5bCSL5OWmXoPiLY26Hhpz1hKLtFiI5w+eVpuUe/MPHMYKMZBk2LM0aNGE2qIl2x9JChz0weyb377YkdUHB5Zg7SkigPkhA5BtbF/6n2UQGD2AZHezX5BwrDg==
X-YMail-OSG: 0LvFKBwVM1mhMBcax1IiFEAdTUQL6mr2jouMibQZTzj76DHsnkXN4_g43RW.6Ou
 RWLq7Ig23X8FQcsqeMmSpGKO0pw7X3GOjMqaOqToo0kAbcFaeL9hwveMOvm2FSa_pwJHL.HHsg0j
 WV78uVoQWHmdjZZNKYwqcpysf47Yz_2kRAd9pLltXXpIO.HEeLx.E85p_MPI1E3hokTDYtHCk6VB
 M2UhIO65WiUiyvBxpm3YN2aXqqLC4RuF.wJZTT7yQtncHnEc0N_dq1RN3ij9seIZK9iVGN_cRnB1
 xgQzmmaLklrs7Io54.h0cTLD0.bq_Z6NF_zp47wSwt_s8clJ7nAPhxRANTW7Buh38W1UlHvl_n3h
 FenJe1lJZppsvg0PbWPDrJupJuguzPyz2WTeZRR8vCE0gwVdHhrPsRATERSHmgef674xi2cBAhcY
 WLk1mTY0xfdYU8CzOppkmcCcMe1EXLRbTU3yBXIEdp91eanBL2yLgoQnCO1_YybHRupztWso0u03
 ybhIGlHz.qAIbWoNItkyBvruXGme1cd8h64wTpXRlSspnZyeHl1BZE0x7Vdir9nmjBDVOO_UCEpQ
 VIlJptGMN8VCvslfzdyec5q.qHALzSquh7tu6Ln1qaeifAY81RPESWfuiyhMCUKEQkckrYKVmIYJ
 IfifaJATfc9uVvfxoBNcInUECCzOzXU60l_xTy9WVhj3UgsJ48cvEQOsOApBAo__iWw5JpvEbHif
 JpN1FvWxPk2MMKDiRyfJ0EaQdQbNmNLxhEZsVfe2q.AKZHdl3m9ph5pJ0ydeOzfiL5PG44Ocfqt0
 39srO6e.FasBf1f6J9x86hdlKmHyw4t14M6PmZA3oxh6Xu9sjUBogO4sQLO0JuTyNZoLpc4I4c16
 tFPrQMH00zLLdjTNFMtUZGgPUdLQvdpj1CHx_sGNk7Lisr5lA6BhvHokFqu7bO2v9INEKDHoRZ.o
 qO7rr6HS5dlg_NymwmQGS5aqncBqfouDPdi0DkEZLttoZMFi_bFXN3YnX.J3P_HDPkqtCM7.3.nP
 f9NeSEl.gXaiBblhhALks7ACtO7xlt4kxt8rubVEKIl9rzeOPweWGTuj9HFUmALzvpqqNTpDviN1
 P4aYqWbIzNmo0SI6RubYSB7QsKS02sM6w4WnpPMP762dUaP739K_Cj1Kv2O712i8XB8DX4OFABwy
 DhbPLZvEU5lafuo_PUU.nS6rRv4XlMk2wpsMThUo25clswKff4W9EB_5n_Jy6gcpTyEhrjsmSW__
 CxoMrjJczz9XPGBT4MVe53uUbLhstFipQ5g2T99NLb56TaGZVNqQVSBn1Q3qOtG3pXDZlBabbTRa
 fIWZaInIDMG2t49HfiNtR.qWl2DeIgJY0MRaJXEL5VDaJH.If6P8LmtVaA6PEgPLtgXXK4BZGRi9
 IbA8ZWG3CK9Yv8c1CRaeYSJPPARVR6sUq4HM9O.WO0Obd6OhqDoC326nnMBnq2jDMXFoorvCelPz
 I85OIUEvsJkbIpFetUc2VzdrkMUCuLaTPCk0jFURN7SHK7L1EGwhdUWH28g6GDRo4ceX1QxBhOdh
 ydHZnjdS8HIhatUgkotdfj1cMYhAIC_RUVKPwoVHpFDzRWgNiWkoZKjxkatcEgWdN7XVekPr_AOq
 kQOq6L.ie7vwRsjqZ2MLElvnD6FJmnfXF5ggUjxrXrt2Gij.rzL43u8UYGcDsK.Q0STyFfTvuVni
 7pFhjZVE6Rlr6Bvp6WhBk_OPcSpok2dfdJ8irg8kiBAfJbwdylHiqLN7LrJALCinDclAziMMoGZp
 swBZhJow7t2e9ZeUy69KpEzdKrq89vFJGHkJGMOh8BKPq3cavNRDtP0uuPYec7EAe_mlsXk04o0m
 FG5yp7fDRuJhot1CkL2h4bvOHlVZrgMCSbn_yp4mEsGDVxi0F0jAWQ9rP9d_b4LKiwpTBFF3HT9N
 zlQgQjrMIJdo28BjGWDegpLciY8rf2eZVixRQ5iblWWhACPWCyMH9PfiW.lKlPehetHeGVipKrhQ
 _CguN1a7nVG7Zmj1LGlg1yNhv4M4GO2x3TDYEK1PivB3Ght6WFWFmgXKkC67jZfi7pbeJ1n8YArR
 L0FHThs6MLoQDEA2GpUbVQBK5bj.f2wZIT_qPom9hRn8q2vdzp6.J4_mUR1ano5ztfmH0RC1RaEA
 _SRVObRqS31qkoH9NE2Ii80sx9i_m5x9jRDkXp8NYzQymgm5MOI2E_tF1JjXxPZIO8zExI6yy0rK
 9jicm9X_4IAYNr0PeUEVfVxSnPB7OZb36HexxvNfzabXmVw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:17:41 +0000
Received: by hermes--production-ne1-6bcfb7fb87-5nqxg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c337f88fc64cf6889317bc459f114f1a;
          Wed, 23 Nov 2022 20:17:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v3 3/9] LSM: Maintain a table of LSM attribute data
Date:   Wed, 23 Nov 2022 12:15:46 -0800
Message-Id: <20221123201552.7865-4-casey@schaufler-ca.com>
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

As LSMs are registered add their lsm_id pointers to a table.
This will be used later for attribute reporting.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 18 ++++++++++++++++++
 security/security.c      | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index ca1b7109c0db..5b7d486ae1f3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -138,6 +138,24 @@ enum lockdown_reason {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 
+/* The capability module is accounted for by CONFIG_SECURITY */
+#define LSMID_ENTRIES ( \
+	(IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
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
+extern u32 lsm_active_cnt;
+extern struct lsm_id *lsm_idlist[];
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index b2eb0ccd954b..6e8ed58423d7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <uapi/linux/lsm.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
@@ -320,6 +321,12 @@ static void __init lsm_early_task(struct task_struct *task);
 
 static int lsm_append(const char *new, char **result);
 
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+u32 lsm_active_cnt __lsm_ro_after_init;
+struct lsm_id *lsm_idlist[LSMID_ENTRIES] __lsm_ro_after_init;
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -364,6 +371,7 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
 
+	init_debug("lsm count            = %d\n", lsm_active_cnt);
 	kfree(ordered_lsms);
 }
 
@@ -485,6 +493,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once. Landlock is one such case.
+	 */
+	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt -1] != lsmid)
+		lsm_idlist[lsm_active_cnt++] = lsmid;
+
+	if (lsm_active_cnt > LSMID_ENTRIES)
+		panic("%s Too many LSMs registered.\n", __func__);
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-- 
2.38.1

