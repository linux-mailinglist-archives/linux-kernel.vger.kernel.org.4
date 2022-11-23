Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3CF636A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiKWUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbiKWUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:00:01 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3F892B78
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233565; bh=KH1GpeT2uoLHjcAGzKdKYk33AV7vMyMYHNZNvsCxlAw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QZfBjlDBn4ClW35/oUUJwEeAyiwvZb2IU+hkeB0ufYwvzESd3JcW/Q5BOJzM9lIdwIkmKlpU09jo1Nh37iMlg9KvnXfbvU3VIHbUWkNVc66IAsgAxSI6hx7OHRiC1awwP3Tnhz/QPuyThkLS+/NEio6gAnOeulyLivx3iOv+6DtdnbAdSqqZ5GYb9+yFilFv9Pg6vKhWVPiWPcGr6Xn/C/JdUf4PpS5Qw+MB8CGIkRzk6r50+GBhQt4TCaKXh8y85cnFdxje/OqHom9pvyjhZJQX58/KisOYz4GYjy8hEzu30rHWMK/6jpQzEwUBE+5s/Xa8rV3xVbVgVlCjTmJNSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233565; bh=ekc5hzg9DJ8bF1mBpHePzC4LYFpJxAuacb5vWS4vZbh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JSiclsTiLLLmwJS2EPjjNchDdA/6YihANcgA/QU8KcKGIuQxDNYb/32MUtcV4aYYL84r0fVsBVQBzYg2/u/yr/K0dQwpwPD5YjYwoJBHiFFFWcgcBTePWA+mDze9vIaLVB3wq9wi7EP5bBHXplgLdxTFGU9d1raqmf+D8eG6rThIhiMq1pNpe7IQAwR0y7DaZF85CnSYqg0VC9z/zVR/LX1TvGhk9a9hNLANS1aHlG4wjEYK7tp8Zm1CBQx1p6frFn8pHm/2dkiVzhJzMtZtjjgcmiSQMboyogWyEuDGwCi2VSqN99MknIGP+z7J6hzP0yY7R5BrOMVkIdKvZtlpeg==
X-YMail-OSG: RgO9YMEVM1nFlBF.EMgaDLPi5wpevnyPRyupPZCwzknous4qYugrXxRmpfic_en
 WMxEEzwDpucM9AanCZ7Fyb_gFUlgJv.VIJ_.DBlYj8ErykZrSi8nYI7zFeCwETyytAbiS7IxERI0
 ubg9BlLEGn9qHB.8FTQhuiRzYqNNwY7syDaqB.ONGZYiPXgjdsXNuxAUKYIP7v9XZch9LgfnVoGu
 LRDWPAC6vVwQWHfmsWEfwMolmT4ur9u38miq1PEgpjgFkJ5cc7pzmyIz2Y64eXjJ4KiCfh_ks6TG
 PPerfoVX_te6cpJEfdxuyBbH9lhfn_mCkUqdLOoQXuv61RHQbGhPiV3V.0fcuwaLCu8Qn7tlV1VY
 dVuqGpvo.CDzRHgfiudrC1ZbdzeA3JV_RheJx0ovco7D6CWdfIcB6JOnTTKKpWHJV2pr5aNzZ1_f
 4cj01W.hmV5j0UkzKUa4grer_DqP_IsF0K_wkfEidg3rvvUMO2Ldvj0PSwXyxc72CI4jXk3kMjZz
 9Et9pQ8USvpyxx5u.BNbH_8w03TU5GkxBZh35KRHUZLJn14pU89SCDKQXI20e5aDWulagJ9f9qdc
 CXnYhL2Mq_KI_t_uwlFYPuXQmNkIutR6tkLpFPUU2Loxr1L5zxNOZeq8NQS59Ho_OZQSt92lPZwK
 WsdV.BNFfNRC3Juxa3O2VTGgyHF_pChRneMfnbknsaZ2Qty7tZ9JWDxkV5wLg3W1JNqj3RnEmRfd
 yWfJD18Wlwq1Pr5fw_NnCYtJuKe64zUb2Sf8AO7DVR_j4jPc9udXoTqYbJ89ruavK3TX1X0yo96d
 dZP2cO6Ug_Z5Hcekj47bVblqblZrSZV7snKJnksHmEfOy5mkzXX7pEJNMeDjMeoVxcgqiG3l68Ln
 gtVVabdjqh6fqTYhej5ja4H5fENj3VPnPQx6usBCg0hZqPqLy4ELpXS_IhDroAoF3aU6ir_1jHYZ
 RBHkM5j3itVwR_9XpM.zGKXqCN0qLd7.nDLE3OGdtGklTNlfiknx0mP.iQHaLXRK9SXO5W0M2LEH
 xS18.DXTx4AYRFA9EhDrsT0NtRX7_YVCEHV_fxFZaT6vN2yiOALkhH4fCqPhZX3iEalz6A6ZxcgS
 fHsitMMoiSr688YEa4I43vr84LAlQE7iYthQgSMvQK7vKyVWSR4aC3.QtMS1fr0qPzyrowBYkvM5
 7bgctxnf9cBMdx9GoB6hengj961OKZT0ACoSLhn9WHk..jmGTUYRp4Mj4I9zCGNNZPYQQK9t.Qfn
 q7QnIIJqj7nz37YfL.83AjTz9O2kXP3wYIQyogxgB7xC.U4.SNPAbk0YRcZR5z80x3vD_GNYqFC6
 2DhipdgEk8rnFn1Ewyy_wasyomOJlFP4B.lXU.9ENHJRSe1CBXxvtk2WppjCHFbq5J86U5fH3aW.
 QPO.FGywYoUQkOoWmFIuJbFEMXxTR5tB.Skl9w28pXO5v.KDGkHBnPZ7CNwT77A.98.2A0dNC.Vj
 jyn9ZxJOWjLq9MMgJFEGpMJmTIT5GYChD7YWxFVNM5Ea_rBUCvngqdeM2KdW.QXuzIely9qJNxKD
 nXGv68WLyvMZqOWnoJTs51QqIsc00aKgEjUt3n.yrynjI3Ez5hFq1GXz3hYtOyO8B.2l2ki85myM
 0eqnMkyx.4yq5gahGZR3NsYgU2iew1KxuKVgBapXh1Z1T7VB9bIphyNYRGkYZamBoBCvy7dBDeQi
 yK83XkuyizogawdV_VA5YI419T82SRUIXDfSo2KONVvYHmAmHruPNT4Px7MUd2YBtjk1xnINrlix
 mXeCJndoCfAHqzufQ9CmmbpPlzzEkZz_UE1kyl8S2eqfnJirMrMXe7nVKMc7Ayw0b9TDWnMZkKIQ
 MUpFuIoz8odj3ZNrWOisLs_xy12nZIYObxrk2u6qWwNYhzn578TPNgn6VZ3cfHqnFdQNMsyCkRE5
 xDkfw3l4sSxppMC1x2IN8K5nOqseYLBZnDGx5PfrYEn.TMLQA1Z1HMkRXn0YK6wVD3gFqPKGsttb
 wZNN4aHjRjNXRdpXWhb4BB_TLjeOGtScHPo_Fyrh66wS5R8RIk9FozSsXYvyCbtiZ3KUv_baI4vH
 nplq9CejNP9od9x9LpKqRojWArPyhc8ZCd981YyzPRIv6qPLwTuGf.YwQTswOkonmP1wzWcj.c0a
 dh052.8wGxc7ttnm1moKDJq87yqgC.QUooJVDTICzcSyTbUXrYOphVnmqtpkvxs35PFpydBlUGfq
 0FHIaP73KL5TVc0GxsL1T7gOwcE8VadXQ18E-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 19:59:25 +0000
Received: by hermes--production-ne1-6bcfb7fb87-kkrkf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3db3b97863d7dcf681a7c4ed78d526dc;
          Wed, 23 Nov 2022 19:59:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 3/8] LSM: Identify the process attributes for each module
Date:   Wed, 23 Nov 2022 11:57:38 -0800
Message-Id: <20221123195744.7738-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123195744.7738-1-casey@schaufler-ca.com>
References: <20221123195744.7738-1-casey@schaufler-ca.com>
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

