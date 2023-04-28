Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FABC6F1F76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346612AbjD1Uep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346615AbjD1Uel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:34:41 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FCC3A88
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714066; bh=DTgxbazKa+xgTYBEP6cv64ozuJBWjZnUzEFzm5ov1Hk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LVitpcrf78vDl611SRonORCfBZUOPpIMS3JmZ6Wl78w0N/lDMCK4rvlJpT1fxIu6BqIZ988v2JKOrzX4HWk7zSUVRKu0S2lKNPhWodGeYuaG8ZiSOBIqz708BS+Eo+SbxoV7FFC51zeR4paoV0Z7S/6gCOOMRqbn73MUYEKfHO5ys30Zjc/kItmhXEaSEompGEKgXNhzv8vMXEcBr0zQ6TKug3ymFyPmiXiap9r1jVYXlg7oBhDFX5jx3Gy5jrqNTxkfT9sUHnjOW1831+i6Y6WS8KSL6ri4WQ7oc1ykDxMk0IaTKQ/iu3B4I4pPqamsBiCU7u9NqWsswtAwMjYPwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714066; bh=7gh+WYkftXRpDy5bIT2L1xMfVbzeT+5a05mBpDGfoJw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=g554fwuMQZD4Gqu7a5C/lDuMoO03Os1U2WFXSFbXNb07E7HnwcuL95HoBnlqMfPLMaBZvxQ/6on7U2nxunvxYszQFq8WfMkIJJe61nDYBykN+SIqMAZFjZbEtvD4w0khLoHdCf4Om2RpO0vTxvBeebZvJdN9S/882un+PBooVeKCNweqOjddo7RmmsrJPTcRHpblXbZB4Vy4XNClqTH6jaFH0XStMa/kQkVv6Fr3uVob8p+CfY+2xkqUIhVWEncBca07Q4Ov1bOgz9MBbvHcauCH/EIsyIrfqVN7qeTq3ZVz63TWujKmF8VC+wZ+hl5aJxR+VbaVOF3dk+0GBIXkEw==
X-YMail-OSG: pTbcNfgVM1miuLB5r9aToJR.y9KtNAavwOeiED7NKDXgmoYL4eX8TeveV6OE8ma
 wFFYhSwdAn.54rSZPtcAFX4kMQ3f9Va2bcUNr6wD9AQ9hb2oyqs97QMhAiHrfAD65TdObaj_T7QN
 _lDatKfUF7ScADnNvEudVm_hGDSipFjDqz9CpUaz9yyUpgsVnqLx7wtSzvm_YUMtFdxfZfrbFXk0
 0sBmc1KUmub3l2P513KT4M9WBw9OScgxQfS8BuXj4LnFYxryxvv5HtD7M5cswdzA.C7Sllvib41x
 2M2Uvt4OrTPOYqlPV2pJmTocj1t9deNTWbmAaOx1y_PqvRoOqExmhBc.TtWsC9jwEUWLr5sofb1T
 TIqQhUxlandxGcaSGH0wcN0HmsEufLAdg7y9z.XsT346CG5Ivgc1DV4BPwaoh3mvo9h7FkByIC41
 tg6Xkg_5z.TwAVuPwRiiBRxhkwrTVVFiVlgQoP._C0JM0OfADfIm8sJ97afDtSI0uwJW.OjKD_Cc
 Z42ByAHY9eKdyaUJVOmdqDAOICcgHWn2IoLcAmmaa0H4DcRlrPwn0JpM5UcEZssCiE2iMLFPBtBd
 e_pNTosNUR8VZXd8OZS3tpn0klQnInft1VoPnq2xYvRKots4YdSUzB13z5w_TIQhNcELXQGX0W5T
 b.Pvz5b7msuq3sudYpk1MuqodCZoUHERgXqlRzmJlYyLxmUB6VXPITBejfLFQgw..V57Pz0Gq3.Y
 v2fEWnsQ5Hu1yc_DeuHjmESXU3sHron_5vjypuTe0bd_JDtGk5jEVO08WCZPlEEG0YXCeeFAS6CO
 Bj.hKaKGpbUEPHKsTstk7UEoLl8TZZiGKlXToEOCHmeCKGHgHavRMz1cy1mHRYXYRghSXNurI7e0
 nf9alGXNB4i7D1nPIEKbje9yCE0V.bbnZM4mxjriwxgpCM2N2GmjjgWLrbTqiTxbhGs5ksU8HfDP
 g9gd7yvgWaSLekOvQPGTWPW4xlfkwGAmh.RK2KZHhqXnf9rAGPcyUZPdbMVD4H.qMl.hRZRY2od2
 KrkZxAh2X28qbz9tLD6oOuMVnz6vVKReikjTt9ub4ta5hZW68XaiBUdeTaX9IBUWgPQpfB0LswLY
 faChfhyEWWCu1BLYvzT5Wlvc4HMdEezz7jY_flywMYtVCWGcW7YRXNNIa9eHYy_CmjUmjcKU5wOO
 65sAsDt98ukgiq2ElINvo4d4MC_eHxmcSpCpaXV3Uh55qmyKSZaenzbMcxzdT4BL6ptvEIws_1S8
 fwbU0Zd9ejYKldBMAvWn3DKCl5A1F_D2MnPnHTSGGNHTEqDkaIu_605Qs9bs7zJQuvkV27yB12af
 l5YNSiMyFsDXA8eZcCZVsvqxx9vL33S_QC5glf8uucWg3DUhG0sZC6iWdEHZ6eGrM.I_dVc520VD
 ouYFg76vQNwqNpR8IBXY1fyr5gUaWcD2jyG4dkf8VMgI0upbxn6RGVfKrv_2Uix.QDitQAy2geLv
 7gjip.EZZN109SxkPcKdcXQAPIyKs20Cb4IgC4hE9.3uYgQN4fqobaVSiKnvevENZ6swCDb3_GHe
 dyTBrKvR6Anv_k2NWGWNanVsyQ7UIvZ9mAxb2adM9DByg0YWkIc6nFhB6ggpb.ZyyhpX2cpLNvy.
 aJKPoB1ZI65HbLlxDxf8OmESMBUR6GiQA2mgHkLWP1VUQGVbsHjKI9hFFgshkIwdCwQH.rQ.ZJf7
 XLTu1Lb.gEoGOj_.tcSTsVkmdlzh4fZ18bE19XS.0K4WXKmpDvc7.hlCVdcBQNMTVxvy5Gxgp6Mj
 NeGqiAH6VMrrsSB.gvJZ3iDXFsx8OOOhnwsVhvSvYXmMCuo.a6ZQAltCPOft.OGL.aN1jmdFnRCI
 EHnxLntRlMTHCSLG48ulzYGKqNRqXhQ2S_lur0Rn0GTX_iCmqAdU_jI8hkPGapBV6vRzXrXNCU_i
 78pW4V6AVdDNIsmxJ8LE.pKhge1Cm3Ix1zZIRrWOHfPb5RYF9kD312jo1RKgWyAN1M16Hic3dO.G
 bkfBo7bKIjRPf9.TuqlPwILxgDcffsC7HWZX2P7lWBBKSbiykFzcbAeCS7QuwvjCmMKxnmSKxej3
 O.B_AQLwrkaZpr2w022fIAbsKceoy2gxE.0mDBs9LNNlbTT0Mkl9KEsMZ4GvFJoBwqVDUX0Hc1TD
 9Ovb2vOdjdc3a_0Htbvg.CnPq_aL9aMS5I0StXugUpz41hcemj.AU6qJ9UmlaXvwmUh6hZqHF.MU
 viWo5i2i7qP4sYFEaLePtLGMfnQlXjva4zg8k61HS2eOlaJ4iZCJT_h1JDCNGF1o3iEYDQqApVrt
 5Cxf8jY5PPV49g48BbnQjcbKJR.guAw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 09290273-147a-4164-a614-04dff17895a5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:34:26 +0000
Received: by hermes--production-ne1-7dbd98dd99-84p8v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1804015e38ebd45733da2d1b7adda460;
          Fri, 28 Apr 2023 20:34:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 02/11] LSM: Maintain a table of LSM attribute data
Date:   Fri, 28 Apr 2023 13:34:08 -0700
Message-Id: <20230428203417.159874-3-casey@schaufler-ca.com>
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

As LSMs are registered add their lsm_id pointers to a table.
This will be used later for attribute reporting.

Determine the number of possible security modules based on
their respective CONFIG options. This allows the number to be
known at build time. This allows data structures and tables
to use the constant.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/security.h |  2 ++
 security/security.c      | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5984d0d550b4..e70fc863b04a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -138,6 +138,8 @@ enum lockdown_reason {
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
+extern u32 lsm_active_cnt;
+extern struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
diff --git a/security/security.c b/security/security.c
index a482c6048df9..e390001a32c9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -35,6 +35,25 @@
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
+/*
+ * How many LSMs are built into the kernel as determined at
+ * build time. Used to determine fixed array sizes.
+ * The capability module is accounted for by CONFIG_SECURITY
+ */
+#define LSM_CONFIG_COUNT ( \
+	(IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
+
 /*
  * These are descriptions of the reasons that can be passed to the
  * security_locked_down() LSM hook. Placing this array here allows
@@ -244,6 +263,12 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+u32 lsm_active_cnt __lsm_ro_after_init;
+struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT] __lsm_ro_after_init;
+
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
@@ -513,6 +538,17 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
+	if (lsm_active_cnt >= LSM_CONFIG_COUNT)
+		panic("%s Too many LSMs registered.\n", __func__);
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once during initialization, and LSM initialization
+	 * is serialized. Landlock is one such case.
+	 * Look at the previous entry, if there is one, for duplication.
+	 */
+	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid)
+		lsm_idlist[lsm_active_cnt++] = lsmid;
+
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-- 
2.39.2

