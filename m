Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48EC6F1F45
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbjD1U1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjD1U1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:27:09 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA8844B2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713625; bh=DTgxbazKa+xgTYBEP6cv64ozuJBWjZnUzEFzm5ov1Hk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EezdhczHqbyKK8WjlxQasNu2CwfaZLS3v38cyGpFknoJY6wlCstys9o9/LaEAfEJhxj3vbn+xhrk9qIean8rKipTlPl1MpJr+xJcVBiUctvXdxWqX8z07WVFAJdxJ2VX2ciQuJ/PHRFRjNyOGZg82UOYVIT3VYBwTMXdJtQ4FTTlGm5TB+ICwpnY3jVfmws14Sww3akKvfE/hTpRa5TEwU5+6BaDgqjuNR0B6uqBHTnMszdixjk0m8DBCRvxFqKa0/NIeK+B5IPR5zkcwLSrmdVrgpRPRQ52cGmWGULzf8SXTBHN8hcYp33UPtncAR81EqT9TLrOls5pQCt4b9aScA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713625; bh=C2N5HklwAo63BOVbLhVQzY1OycONFP+xBTh4LbtJ8gi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tQDmcjij2ocRGGITXgfkTIxcPzqcQZcE9TmThTPdCQ3k/jYA9H93WadcQknohVlmKtvL6ZjhM9PPCVc/fk6ej9ueLjh61RcqGkVQcWEcM4C5G14efE/aII/i8bd7PTZxQSm6Tw559ukGTbHWxserzGLk0510hOILORAPKz+O+13anAvzE2ni4r0WgXvEzrDU2oU/KCOMlXgpIAwp34+AjcXpA++zHqaBgyvCOp067tDM+NeLn9nv+62GgJ8VnqylUeHlu18ixHvPMNnHlIsDtO47jUrIpt3jHqTJwtmfQN6QN26EoXKKViidNLqUFQgn8pLMPnR/iflTyo2nLa0yqw==
X-YMail-OSG: eOh4iTMVM1npYDKRLyvI.kQmBEUEAhaoeTtBQiKlhf3ITDJI4KvzeOJnYAnHwmJ
 qztELHbZG.slJTQKe933Yc1nav4x9nJ5TNQNpx34DcJokApZWX8Qg.kyOqjHZQJCNVzp36Z_dyk2
 5Wm4xv31U2MVMWWxshwgoHnS0TXGhk6hfU4Onark793BK4Zx3PB.2XaoI9i8VSAHfR7S8mVy1B3q
 UWdI1Iu5E7mNLUUKdyXAhzTJmqUwjTbDvwF4kVxXsJumahDwx0D.400V1dyzXcx2xGt7h7t_LtNm
 tRygf4CFbRCyTkVliMyNtAhy3lixqROhn1rIBx4Kiy90YmrhmUUZ3_E51uQ5ATWayHolVid9MVp4
 276Yv5b7uklUkEOZBb_.pj3jrFW2wPkXcPfzf7PweQsQPMPR87uNFuxjnc6wEXx.8j2hHuNVDfIT
 RyZBfDN3QQtOjief716f01zibeDDEaECIALvisbs2F46MyL5tsPgAy24jX5BaitUN7I_GbopBnFp
 ZMykdFvHkIqhUegXB2939SykiMWIoXQFahTKEUaAXRLqTymXYmCvy_fQMb.zhFFn0bqfHGkC.vv0
 KpezPoTw2yfGlWfVuwOgncxr1bmz9wObV_fCskvXn4vkBLStqfdwT5j6iRMkA4zLiDpbF_4ej4UH
 G2osowAPRrkJqYK4_aN6P6PUSSMxLSzzM2z2HxzUfQge8S_80eyU_KvSwQoB2HaY9eHIch8D_nyW
 acuo_JwRgc6C4ie.KPlUfu0Z.D0qEyNIYFy5V_hhdJDwmiEr3iqSssz1jvvoMFohRS5t8aS46Vrc
 bBVHc3_niJvuK.rT3J3PDLxdjpTauuoNzSTPw2Nn5pVYriiShy6XLiJg.nXJLBH8Ha3wheDpPuj0
 O1bhnqx8fqujwFv5YCZ7QbbGh5Jpq7FKjlczWxOeJUfg4nyTyhAaV.gLDxSxW.hjZN7RkigbfmrE
 1roebAbJ8FNUUhIC1H5rnwa4NlPipKNhI6FJe3dC.QhKiYB.e9onBf9Xr6Dyu1y_03dIhqcu6ZON
 xHXoeshIUeGj.E87DI3yDL5SZ.EHcNlfh40K1ZUmjyI3o2PrE8C6vHt4Fw8IHZWbPozHua_CZQbg
 ULKfU6LwNilKXeiJ9PpxNn_bF_jZy0OgnR8I_GMhRUb6NGcEvi40z83PlJQgB55AUBM_0EzmmoHF
 eK46s0deM.kGkwlyKtwI7KFp7FGhtPv.3o8QIasBSB56ft4Q17svl31ehDvUHvhCUMOO_PiOScw9
 n1zuoXvi8bvUFX1QbjXDpoiIH9aJHKNmmlTpm676X8p66DJT97v_BmF9c8P2.p03L8uXsF1146HX
 gl7brNLDqZb6IVwkUsOYpLzmJIF7y0qEKACT5cLjQbKahOyY5Ok7p69KrZAe846qcp0S.Tn8oMW4
 FQ4f1I5OJMLmTPvJ_LZzoXBIioL5pZmp.ROR1uL4D0J0s5bvJ9q4bg._eAkrVoOV8HChMRLnEDO4
 LvtOsfklvY.941kIauLVPWR12FNEoWGvVsg2Kg2WQNMr3mbJqjAPwHl3Pg7UGg8FdZqenE8IwKHl
 8ghb2_GZOneCaBXAoYDotZE4DCAGIyxY3_P0B9oqIwH.BPMQL6oXk_2WrTY4K48B8B1719eaUZyR
 eJMLkEU2kpYoGqzOl2OhU8uIunP9y0VhYINgEY02jfUjwl9G7jTrPY9oiN6AStYGJiLUr9EGWkT8
 mCHqwwkRuAvsf_oTVR7Q6KN6rpROiK4GpYWeHgIqmLEBiRJtp6gZz.BalwLErrDzqTDbLpaM307T
 byjhDqmrdtJTSRAvl.veIbMMo7pta5d_XUL46FOPH3wTCnAitGqK2wn8nS04nuuKI6CIxqsAr8OP
 U9T9CK4nfE66G.haQKE5irwfJVO6is8XL5Sql24K0zpKLuOifDQ6q5dSLWpoQiPAjyFvcfCOYKPL
 WWPRRSxqz1QpYWn207VyLBmOVGbonc0sA3elUQOwheh8zElXESzbsuHAL3xU608FGkKizMelfxRu
 Eqb9P.ElOFSiz3F2XwoiU0U56KqmpwUG9v04LH1i2eufX4YALeppLMLTyEGWmOOeYFNr91JYFMUo
 HWZETe2ksoTN5CyaTGd9UEDNIMxSZCiws1X06kSvYEs4jB3nTVeL6ca5JIvxK7UWxlsYJNCcx_Or
 5NADxyhHQwYku7b6ai3iTS9SdMrx2JiOLq7D6GOYQTik6WyIFZAPPA_kEa7u6wCrHtWgph3i4y1E
 j_IHrb11py_ZEAjR9ZBBfFzFezmIO.onYlGJlPTQHJpBis8.aLdIdVk5HiWdfrp3wNV.Qo3HwzEC
 qaPsQQjaaBS6BHN5F
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c8852a73-527e-4025-bb13-a78451204c2f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:27:05 +0000
Received: by hermes--production-gq1-546798879c-dcj2l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a31e9fc13eb2c1a30c94ee11b9cd508a;
          Fri, 28 Apr 2023 20:26:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 02/11] LSM: Maintain a table of LSM attribute data
Date:   Fri, 28 Apr 2023 13:26:42 -0700
Message-Id: <20230428202651.159828-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428202651.159828-1-casey@schaufler-ca.com>
References: <20230428202651.159828-1-casey@schaufler-ca.com>
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

