Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DFD5ECD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiI0UA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiI0T7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:59:32 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822FB1CE614
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308768; bh=VPzKlwpLKZOBzTB//B7tagQk/2MUAL21dCJ/O4/krZc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=V3+ShlJ+vqQ786/oViQKmFJZ7U9de1rePF5gK+toHJjN5yBHGOwF6SHdALX56YKWYQvPGLrB8QV4eWHCmRuluDchJl0v93MV1s7MRZYbff/0FH+0d+KX+t4p0RXv9VOXUK6uyIsw5eZDIhDcT6cTW6TGsUxJfJVfshS4WgiTidbQOeM19Y3iLeuEoqjcBKQAKJgMSXPdP/0UCzdl7UNBJC6KvgEzNZFHB4Zm86CwAjFO4jnGCzI/jxdNcnGkRK/dYJuBjqbFgdpx+YfCTW4nP7Ol5adFoNJ5ld6LF44Ys8MXZr7pIuYhElsQST9647FOcXXGBK7ZG81XY/N0iu6/7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308768; bh=q2wDraLE9wUf/JVZLUYk2ol1DZI+RDn+ZNZ7japat9o=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GPpsIXZ/gQHRk25pt4HzNAhavXnyNoYvo4cq5Drs60U84TPTSRoTyWyfblUlg/kHWQnfMBcpbu/it2UCqwl3ql9U6oMeEoaFXlB9xMiKyhsWXsbG0ntIgnHn8AgnlcGtf0CDmAgQhJ7LvGGwXHe7c7P6Cqw8raiN+7QPsOfJVVktMGkj1q+Fm1r2zwhFrUx4ijBGNNDFsUMLdNmIgygOF/UffE2XU0XueWMWyPgpCOR4Ca20gSqpNmLJsaPLmPzBWIr9xtq72590MEU36G/VRyh8gm9ePCSh97+cVOd6q8PDQlBCXQmGKbavzEPNKt/48ZlCwNxelV4xNa5GsYkSTg==
X-YMail-OSG: quY2aZYVM1lvozECIdOvLWEfgx5w29WOXAgHMS.NuV3ppO.ouymQPJb69pCaLdj
 gd8aufOQ0siP1.EDg0IKX1flZbMPQe09iA9Np6RnBX_cviLp3U2vyWzW1ejp.BFL15zauQy8aC.q
 8xUn98v0tysoAj4JhUglRQu5Mnv8uB8.RyQu927zq0fuDl5fGBGOfIGmHqTgVSd9llPkaTba1PXw
 rboRkM8LYHMGEIfJD42.TrUAq1W1bZ_VM9RUyjEw2y38dP7xdmq1Ga2DeJnfDUZvE9Oa1hR99JL_
 DWtR32_a1iG_Zocr4CqHLnpUID6cefxtvzRnQG0Md4fpDfQ6SXOCr9PepqyCMdL8xSa4ace4BF6i
 7pKjTkQXhuR2i6q.PAtvZWNvrUeCzrKqRFYRuBFVPnqfYRPoCcVM2aRQgHEE89CC4W9iZXmxn0bx
 likyrYuaQVEUHoN7MgnP4t22kS4HkyQM_9QVxZ7LqeuKMbZ627CV.DHsObW1_RQVbS.bArsnR3CT
 6Mn2lD6e.ngU6swcNhzu3_QkEHXu.PSLSBg5HR_qPehXG0hOovWX0A.C2zR0KKHW.MsC5AD7pdq6
 mbjZJQV5c3SfHbH1qraf043YXRh0SVX.iSsanu.1lVrToEtYnL.bmAbtRB5AcIcfRagFCnlYNpxu
 YwYKCHpgJPmmmd0uggMqwXWrJL96nydxw5P37D_jyjKM9DQjOq1DcrnC3q6vvOowo_SxjOR6oFu0
 gLriPyqvlvsbsz7AFhD0hBDfVdiII3N35fEG5sgzIa0uKr4EG6_DHHUIGyrOJVAcaFjUNIaxhMP8
 UGK8f2ku6yle8Ybg5Bi8SZOeoG0FQERob.fq_W9d2txBCQMnS0GbPSv4vcqXQptqMR4hesT_6ADW
 mIzcKQSV0ZuT95PV0qQ7Za5BDZbYV3U3GL8uKJsqK3lUYgIBplYQmAVZXLFMjt2z7jAcde5yNwvq
 TbYFQvMeBXIg5oMKEmyIV.8cwhQwKF6ypYRD0FNoViAmjncT4Oo3KVKvLtFMsHZzI8v6hvtC0MCT
 YdCEYmTIH6EzDWiAnP2nTFeubWh4gESkurtBPfS0OBQvl871gCIjK8Dr6p2gmDasozW5_95WdHzT
 06AjhL0..Q4VnTnDDIF9pWySeY_DFSTM6rpxb1Ihf.xJhfhHR3NyMXneak9_DhYbmNvSK.eDHXps
 L6QZRQQWl7Q9lGqWLHR4JthnE7WxDIM3Dh8N0L_7bk2BMZBXo0icoQQoRdf9W0TYMczwuvMsWm8e
 KoywHK.DF0Yp7dqrrob7mxgYwBVUnp5jkHVmk9BW7QMj4tgdPHG9Mnxr.yLKnAtlJlZfNyqbWQtR
 .NpBjuvIIBgX7khhrf8U9cOcT93_OhZuw_8Q5NQv6QroDadkVCE64xvt_rLiripw5b4cxp95FVkf
 vHPE0b52nhprO9916hMFKt3ZVB40xYEoZ5EF1gDYzItJA25i94rSu2b4ZxQWQd6gUCVghcZfqoGn
 hJ_Fmf22clC6VF9DtBn34dfC5P.2c8Xi4U9_jdABlf2b7aexc11cxz1S.0BmJnq3dPwnaHkXDaZ0
 qlj.xiaQvBviUnJghw7YPigdGsrj_J8ly39ybG8EELa1HeJylogMvsO4WIiaiS55DU26NCYuvecu
 lt98dPp7p4KFbmYghcVjFTCVNTlFJ7h0WuOehlLbPRgW5xpgdK9ztKTH_j_kMAsaEnaRbtM7PQ_f
 nWIa3DQuLoPY.xwzYIPKcYSUQZsN6VESj9PLwZLZM4s92QKqshHThYtmOPbYIXN1QnLq3Ea5Uy25
 r8L8ZUwOWyzwIgjhqcXsCZTOyPRIO_XwLmkxLY1OMLH81CN9wrkwkidWSUd4r2fHBEopRL8K_wi.
 Y4R1fe93NtqmLG3dV8FvsGfSnss_0W29rVtH_2x4Cx4k6arPPXT_Y.Q72ith_FTIicPXFcwyccRE
 hciRWRnQQ_C1DvpTCzu7TnecYlMyXPu8P0qx7MVRN9A6CASabqde2SbQ.N4tTN9qlbNyJN8Bxwsp
 DFwIlH9exnlXSpR1R5URK0Gsgu_LpoQbPwUEAN1gxSrTqTMl1zGXelTavKETtkEmGLEo2p42WZT7
 NgumOoQsXmL8jlPIF4zE9byJ8ASW4XoW_EQzP3S1O.J2wzrzRtupfW2hPXNhXOyPkbQesKEVXc.x
 g1Zf5pseCeWWJXxUb_oV6zi9.nocD5O8IGVghIr9AMhJYiVLwYGnz_c3i1TdigdIcvKzn2euHWC3
 gMTfntjzu6TVt6zzBNjeT84UwJsCildwXx_4dTjpmLVVhOPJ2qkEnTfwnEes-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 19:59:28 +0000
Received: by hermes--production-gq1-7dfd88c84d-mgq76 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a8608bb7fdb0322afb9a5fe3db2c5570;
          Tue, 27 Sep 2022 19:59:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 10/39] LSM: provide lsm name and id slot mappings
Date:   Tue, 27 Sep 2022 12:53:52 -0700
Message-Id: <20220927195421.14713-11-casey@schaufler-ca.com>
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

Provide interfaces to map LSM slot numbers and LSM names.
Update the LSM registration code to save this information.

Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  4 ++++
 security/security.c      | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index c1f8b33e7c27..0f0fb2077f41 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -214,6 +214,10 @@ static inline bool lsmblob_equal(const struct lsmblob *bloba,
 	return !memcmp(bloba, blobb, sizeof(*bloba));
 }
 
+/* Map lsm names to blob slot numbers */
+extern int lsm_name_to_slot(char *name);
+extern const char *lsm_slot_to_name(int slot);
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index b837500cb3dc..2c197c25746c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -486,6 +486,50 @@ static int lsm_append(const char *new, char **result)
  * Current index to use while initializing the lsmblob secid list.
  */
 static int lsm_slot __lsm_ro_after_init;
+static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
+
+/**
+ * lsm_name_to_slot - Report the slot number for a security module
+ * @name: name of the security module
+ *
+ * Look up the slot number for the named security module.
+ * Returns the slot number or LSMBLOB_INVALID if @name is not
+ * a registered security module name.
+ */
+int lsm_name_to_slot(char *name)
+{
+	int i;
+
+	for (i = 0; i < lsm_slot; i++)
+		if (strcmp(lsm_slotlist[i]->lsm, name) == 0)
+			return i;
+
+	return LSMBLOB_INVALID;
+}
+
+/**
+ * lsm_slot_to_name - Get the name of the security module in a slot
+ * @slot: index into the interface LSM slot list.
+ *
+ * Provide the name of the security module associated with
+ * a interface LSM slot.
+ *
+ * If @slot is LSMBLOB_INVALID return the value
+ * for slot 0 if it has been set, otherwise NULL.
+ *
+ * Returns a pointer to the name string or NULL.
+ */
+const char *lsm_slot_to_name(int slot)
+{
+	if (slot == LSMBLOB_INVALID)
+		slot = 0;
+	else if (slot >= LSMBLOB_ENTRIES || slot < 0)
+		return NULL;
+
+	if (lsm_slotlist[slot] == NULL)
+		return NULL;
+	return lsm_slotlist[slot]->lsm;
+}
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -517,6 +561,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
-- 
2.37.3

