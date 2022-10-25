Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22E360D3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiJYSrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiJYSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:47:10 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F277DE5ED7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723622; bh=Df7bQuU86RtfRmA6zmLEew+17FaTUT67EczNgrIKLuU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Marrr2wwAhXAjdt1DKtepS/1MIuYV+fAxWJpPp+4EuyFRkTia9dWWfGWtHSvt1BRtz1AE39fS4HLFTjUwn2S8wmLQd1e8SCLm6yWwjEPBLiagWN7XziaqYr9UOt3xjb1PL7thyPNQc533305goGqB2ty4ejXxbQ7riNBfYDi0DsUr9yl/2Tr/VIq52ze0dJV8LNLgliC9fKzo0SP5gX8mSGUVaPd4cG0v8i2uHtbVD7plXmozyErq6pdtIqEPkEp4rBDhaClgMWcg9Y9CYWZEYMOSoc5uP+bqUyxh0VEcqbuX/AW+Q+zsPUZ2rxh1us+Far6bf9cAMeN2TrOaUcXLw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723622; bh=2+qxWdlvbDrXZH4AZuQxgBlCvBcOsyXmDdIdkkqYg8T=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RkTunHKN3ZTpKpuV9WN/0eN2p6Cjp8vfFKtr7Sjnm6XWcYZKp86jtQ2GCfkSptzb3wp7js6yEDDbd/L0tWM2Iswh8b1mN8TTk+OEIK9OSDgcFhEYAmHT/l87F+Al/eFlXykQmRvpAJSAiqVY7nkhDpeX3b2gaYUNzS1wdA4IsM7OnBp8FhcfKR95huMBpkdpWkpxvs1qiALbfVzjBUNdptXbUu4OPp7bM5OpebjHnbjy/JrXrs5xQ6G1Sqjo3pUZK8PANo/fZW1lNb+zfVGWct+s5Ni+Fl/w/11dgO6KKK2wLQOchXDPS6N/QEhAROfvRThasbknbF9bI3mW3ECYrQ==
X-YMail-OSG: Qae11hcVM1l7mtaIMdkZNBuhFEqNOMGmC3vof1l.q25LV0RTuo0a1qzR8Ldlpzq
 IM8oWysWCXDpXLFk7iO8ttoGqVBVOlvUFsCvwmafwywmafAB6n6Gv.BcI3S63nkaAC5u38C9THxA
 _g.VfecuosWTs7HuDj6SThvAt_whUlGGa_zOf7N2qCJ4WP_xP2ZBWHop6MzRMSI6HWL2WkYAPjzl
 zlhTgr0_HraNibXgmhLbCZBeljVEE7AuKJGM1fdFL9XsQI.rPgHVzncRvln.PXzRQ8J_BH7ji0mG
 Ff8GogrV.4.rrhURevmZvOc6eb99a48iqkW.nyCQEFzl3kDUEScWaqJ..4ipc5YACZly1ORagw6I
 CcmDCx5Oe_Iv05Ct1gGtNS9V.iwDTMhyymeffwJ.RfJ0dpzmjhXo4g_JQOatbg2UTHuFQ8XhTIY.
 tuhzHvpCcY9udpAtbTzimu.64lU_4RQ6ddNhqGQtMBtYqtQg0ug.VIogr.RtOVhanGZ3LMMoW5RH
 75Y.BWwmgSH0TtwffEzF1UkMdw9Si.cs3jbLOO9S5zGNu3WmWlkhUphQZf9xg.BqYTx8M8YOETsk
 GpGqr3FcJ.64_xEDGJn6Klom95uiZ.HdreV9MVZyHLglYAzwZaPQtPiTmzCRxMm8ITeVuqxrixs0
 5iUq2_wzRCngbN9F.7EJkQ6fattPkG98KQMLSUdDYtUXupgPJ3H3nRqeMzchvWnIywAT0RaPcAil
 O7fxUCUBtax32EVQ7N21CcvPU2YeH0xf0QihD8xEttIMmeAkYN5edAa0JInELQZIhIkcA2fa2qX4
 720jI9V7I6ND1sOqTWDm9128qWDAYaz6vyFbv0qjNY_e9A26gDdV0tPyC52pbFPzqJOfCXrfSpeX
 t5XRTgALq01juw7xJPJqYh39eoXWtew7t_UlkG_QDaMr0wKOWhkdSBh50ClyCmwAzgCKr.YG5aKh
 hdndUwHF4Mk047wLcQtqRMhb0pr2Y7tntnwBnG1aojPqEG.LcsW3G2wV2aBBA611oDjW4hHAMrxK
 tOWGUVPXdw9QlcRqK9loQt9KluqEEl2zMXFwZqvVq2FIJ6D_cPuhOmvXo_GByC2LNumZBWrB2tc6
 5_iabRkydANTDXzS2Q__ZIbSKNMYWWNymSCSW3w9I63sYh69W.1bm.8cq9gOjLrYFx4AKCj3iUTH
 QEvGlh9EqariDn5e1ACIzVXbLV9DDwf3CY374U0w8Fy.o4Myz7uYeC.Vm1pwLlgTTsVfVOipCJqD
 cH2ei1ux8Py19A5_XwUUAmuTX2I_2Cpaepw_OyGHG.6RpcUu0zSfrqQ89dm7tI3mRmNGQPlXX3fm
 fdxcC1V8tk4MOBL0hWFVtEiSNNAsXLB7BqSG3pq1DFLbIefdPrCCIBJlfvNMDAFPI_fGhglHt8lz
 Z99G9YYkRvNpp6cWikQkcsNSmHHZtUESZTQbbJ4jkrGtFSUGXi7bFHDzTppaKWdiQMoyt4Zp6rvw
 4oHL_z78rShY45WHoyElhGX0bGPygXOoRJ.w8k1mDtevayrQQEWkQobBWxSH_89sNX82JuEZiFdA
 k10a.I.cE._qVV50dkgLv6ThPU9tCXRv9tNdyJSfPxvnk7b_tmjrT_gudh_liAZUNS25KZOYIH8i
 c0pdh9IoCgyWpGCHrcx9dJwCynBYwNJ_mIjwPAikIdRZ2JJo70Y126C.V9K4FqDX1NFVFPOt4p74
 xz54wG3WGRkH61WBEvLBTGdf4_DC3C5LnknueAKnMEwVnU5vdiLbwRLHbTSX2kD3hB46iaT5wseK
 TGqpmh0AeDygIdVO5QesIDdZgUBJvLlhP2YPNTuo03WFjNqeiQYDCdZNuKjCNyif4DAVfcSnF1_5
 Dpb7e6NAt.9UzN_Pph5IeZSVIkii2JwNxQN7z0zO.LxnDxDMhS2LueY3hvmuEh.fWBHOumVp5MY2
 VWKnFvnIY1HkyU7bGNBMeVQrQ9XfhSw5OL07A4T8.uJQmjh_BvQxNIZJNmG0TLOrt8F12dz5czk.
 Y4HsNWcn1cL5VX9kjGFC69ShwfPtLI0uDbpdvl2PbTBM4d06hIMG18dawFY.kL8qZjB4FfSkFOZq
 Qn28HuBtLlZ_g5juCuG24CX9P4pwfovw6VZwMigxn.qrLnIVS1vPbfMw8sTD4HJxxvb4soDzmUUP
 .YSVabc5TW7JanMn9KXPKGgGCmFKYdoRy.F67CtnVmHM6VXRsX4zEXeRDOBL9MgLfsUFsxbF6Y2B
 2kQGEEH_PavyW34hJCmX9Kagb1uefA.Ojgo463RGOKn6P
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 18:47:02 +0000
Received: by hermes--production-ne1-c47ffd5f5-mfswp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ff43769a0d5883148e3027385165ea8;
          Tue, 25 Oct 2022 18:47:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 4/8] LSM: Maintain a table of LSM attribute data
Date:   Tue, 25 Oct 2022 11:45:15 -0700
Message-Id: <20221025184519.13231-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221025184519.13231-1-casey@schaufler-ca.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
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

As LSMs are registered add their lsm_id pointers to a table.
This will be used later for attribute reporting.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 17 +++++++++++++++++
 security/security.c      | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index ca1b7109c0db..e1678594d983 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -138,6 +138,23 @@ enum lockdown_reason {
 
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
index b2eb0ccd954b..bf206996a2af 100644
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
+int lsm_id __lsm_ro_after_init;
+struct lsm_id *lsm_idlist[LSMID_ENTRIES] __lsm_ro_after_init;
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -364,6 +371,7 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
 
+	init_debug("lsm count            = %d\n", lsm_id);
 	kfree(ordered_lsms);
 }
 
@@ -485,6 +493,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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

