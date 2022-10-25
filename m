Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586BC60D3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiJYSrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiJYSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:47:10 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A4AA3CF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723622; bh=KH1GpeT2uoLHjcAGzKdKYk33AV7vMyMYHNZNvsCxlAw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=k8a1/iHx0h2eF0IGrvljpJ50HgIwIvSV3fS4u8W9svfGta8fFRb7PhQ7p3FJWGVLQLNv/a4Cs9nvzGXueZnSVSgKl+ajcxvPxL8e2KREHRRWzAUYvCvEIVSnn9D3ix9qJDExLWz9DPy39XD36G5DGcA95xv703NKQRXq1SjZB2D4STijy214uxq1R1QnV5Ljq4r/bEz8PLnHHdBc0TDioUrLM4p5iekByEiVH93vtvfyqcOC0WYywHU7Oau0IoD/ygHcd/NMQefWgZIpYwfhRKPuFsBLaJ3BHD72Nn1vngCbM/3xER6kz84saO+upbSm295D59WeG8SLoMDrEzraCQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723622; bh=HVMP6nxZVtzQ4eGSt/O7itFBpLng2k80j9xiJo4Nn1t=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tpPWoBo/wPrXvtR1A5Vj9LLl58R70fNpT+nlWDEFyRuzFmDkOwxjhj05HVm1I/Kv5MepvS/8scGpUMd2jAg+ttTfPt1JU343BVxhujfrpvILN7dADO5nkOVguICoLnlYR5Yxex24SAgCCRmEG9Qm7tdJQe9jwEJvkd5ZNGpMnQ/6ra6xDyOvRb6dnU8+Ol67NcdaK0VrtxfATsUBVRolz6Ud10EyrB1ERyqhJuHWAY6vmQsh2+TeMhyJx+D8muIyKzjoYbdoP8qJ775wNsARUKrKTys3sca4VcI+gtos4rbJMcZpanEuanlToNVQ1XJOMGzbtZEe/F9KM0Bo2o9jPg==
X-YMail-OSG: cHlVjpwVM1mf3DhtM20mV9r7hncK6UaW6sVxlkSyThcPUFDNxBi.bz7PLhtya2C
 _T5ljnyj1Je0bhh8Fk7hyHef7293ZeUE3S170LcPtzPdNOmuTBlIO_zszyxuJ7ITOKmUa1Id1tIk
 k7xW5bXWM_SyZgGfZdnMhuHFLMu5empsWbUDLvtK3rJTAJQ.Xgzqim9tOa3OATSHLfj6gmBSge3.
 UlEW0hSvpyXBHz..WfJuB7G5It674Ax0h3ggj5hCZhyUKnzlfG51NuvHgyMdkX3y1DCMDXMT52wf
 qOWwHWYwWQrNBjF0SU3IzJjL3Z.DljmpcRvTEzQFhvGactVrMtJ91dBpzHuUzPoqdwq8SsQEam6D
 8Axz8A3_d5s0CAHNVRjdaGiiu7i3rkYkp23QUREQvnIGjSsaPxTHuy02AnNazeAtB5fzIQwwvRLm
 .UHIrFh9.Kbj6dOeplY1fWoqwt0DdlKXD.Zm3AxJH0VXebfVyKQYNBAza6dElpdVT1aYIlSwvTL1
 nBei6mq_rHefvsIU7TVJIMMwjGJOL4J_bt_vGtrmJQwD4zZuuPTEt4JimAaLQI3sQk5Y7ic9pkPe
 SZY.m41w_.5mA4M7XrnOwflSVef7taTDB.LZvChRoW70bILNTdDpAqWI.dMgGacnwRexjk7SmTz7
 Ymt9n1z106VusMU6pgMoZ56jMlBr0V2Qw79qpzzCAOyoojAbkVW8WPGEiKH5LcBtVs31lBSa1xqB
 Fj5NOTFOIptHzjWESmZcptkCtZNDdrI0ofn48JVbb_kzol33avpnJA.ihYGUFoD7.t8Ayx4Pv4jq
 7o653a0FMQgTfn76Ul4o.bowvs0g5QlL0nkBwC9mWWKo.hS.JejCJ5isxz49ck929W5C43FdNmVK
 IVr9fXGTqZviwNHm7FF.C9lTNhslBo_MxoHkUUvdXXmvCemPm048LqvKYy_p5gZgoixQ2eROi2BA
 PLyi0LIEerZ0qVirjQC7ppP.ig.DKkiZcdySRiFWBxTW9AatBwnjTVtn7GSdykSZWSEZ2Y70B5Sb
 DOQvYhyMEmmx3ghTpsjWDFldGeanrLHrP5DPtJ.HkZ.2WjkAUff9tPLh4uMNbYz3PuNCHEk32tVz
 1HlW7hQXPi.8N9msTZGf67x.1NBHzG0LaZhmOB0pKnCbjFWAQApd_5xFVQkPMCPsKKaEMJ_ewO4g
 DHxnO0XboxrWMfrCFM0n2tFxmrF_0Ov.3UzL0Ky.trdOohMzjfq8nBxqeyp2aVQ9rdwDMzkY44pk
 6U2briI9P73Kgdqyeq1cBhBCShSwyLWvZb7VeJHxgb92eL7nsF9OumbjiXQEd77T5nrjhS5quWv1
 0luU.GB3DWyjyPIXYQHvkp2ZnP7ziXHvTOJ9zrLY1Y6J_Q1ZHqFVbUh1y4KYt78xfLTYEFN4rz7m
 acLvio_B5LF_x0V2A.saMRBIznFdeTHFkpKM0PCA8xMiiuqaOdGS3ctzpwBGaHr8Vi4dQTssHLCO
 rqEr_gXiCar3OWPuscBiUINaWMWVt72eULN2g9pSC8PjMFhvU_xsUwXrknRkJpJGlHXt6.3Z.FbB
 eklyiN2E2Q5AvXbLZnBxLQelIh8RVkAdrmbNY9qG4UMh.dBkTukUoz54P4At8jmLxOWxpcdzJo10
 rO2EyifbfyDkU6SxAhxzOSFu2KxkR8DXk1GhaeI7Iz23JAF6AqFpgFUnLT2lo2eb8lX_JFyd9eg3
 W0aVLrLsPuW.clzhnkVtBEwYKE6DfszJEf2pK4I3KVqAXPoWvYlnLVDOq_KK7uXfyw_jcLaedERL
 MVeYcwy9CbUwgsXMGVbK9XpFcaB7JVrUeRFOPF9.Zc.pq1Bw1oRhKvVydO9qHjFzn11g6obR5QJS
 KsexUCqnJI4HRVfpRkOQU7qiOShFTorRDXdsv.LBVVPhff4xk1PV2ZJTFo4wZ_Sm75D2NdjXPJv3
 QxbMClVEw.lwr8doRYkYS.HzPSazQoSLwWcJQat_A1Oqb_E_7.LtLpL6M7b.jKTmOpSEKE3IUhNi
 ktGjZM2zfZyp8fM58yNiKjkJBmt40bmsz0wjzaDJYpQGLraaDQUwBTAhudWBB_7IxaZs.u7tJIiF
 h2_3YclU3kwqm1uXVYntv72dZmjEfG4b.0uk6PzGW3JWgxC0XdUOlf48msNkVhzx3mYLiv4Tgb1j
 WHHNeWZszF4.H7HAz_mJnpit721LAPP02Cp5eHQlCDU8TydOaP_UeoVllJLSazDO6uYgqMVe4OEv
 gzhAHleRYBjx8JB.5UT5CPiEy__JJAMBucNCyf9mg1CAHml68XvygTo5pfAJiB3Tn6YTyGmg8dUK
 N_OWq_zjGmL.J6DA8.McwhRo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 18:47:02 +0000
Received: by hermes--production-ne1-c47ffd5f5-mfswp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ff43769a0d5883148e3027385165ea8;
          Tue, 25 Oct 2022 18:46:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 3/8] LSM: Identify the process attributes for each module
Date:   Tue, 25 Oct 2022 11:45:14 -0700
Message-Id: <20221025184519.13231-4-casey@schaufler-ca.com>
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
index dd4b4d95a172..46b2aa6a677e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1608,6 +1608,7 @@ struct security_hook_heads {
 struct lsm_id {
 	const char	*lsm;		/* Name of the LSM */
 	int		id;		/* LSM ID */
+	int		features;	/* Set of LSM features */
 };
 
 /*
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index d5bcbb9375df..61e13b1b9ece 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -29,4 +29,18 @@
 #define LSM_ID_BPF		42
 #define LSM_ID_LANDLOCK		43
 
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
index b859b1af6c75..77260026fda0 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1206,6 +1206,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
 	.lsm = "apparmor",
 	.id = LSM_ID_APPARMOR,
+	.features = LSM_ATTR_CURRENT | LSM_ATTR_PREV | LSM_ATTR_EXEC,
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5fcce36267bd..107b944e5d45 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7018,6 +7018,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
 	.lsm = "selinux",
 	.id = LSM_ID_SELINUX,
+	.features = LSM_ATTR_CURRENT | LSM_ATTR_EXEC | LSM_ATTR_FSCREATE |
+		    LSM_ATTR_KEYCREATE | LSM_ATTR_PREV | LSM_ATTR_SOCKCREATE,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c7ba80e20b8d..12ff27c00fe6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4791,6 +4791,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 static struct lsm_id smack_lsmid __lsm_ro_after_init = {
 	.lsm = "smack",
 	.id = LSM_ID_SMACK,
+	.features = LSM_ATTR_CURRENT,
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
-- 
2.37.3

