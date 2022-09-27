Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DFD5ECD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiI0UCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiI0UBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:01:53 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564AA1DADE1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308870; bh=wBzyHs9tejfA0qxxNDjBYDLno8s882n9Tgt1y1TP8Gs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DwDOUt5A0pAHLs+wTW8DGYafNx4s3Yh3nqlUxaU90dFHOMh6jURGxrRvtGPH3w6FPcwm1WvRLPdXEqAdnpm3S/Tz2hMxKx0LkC61gD/N/riDEm2zq4pnyWwUr50hdgK3f/NrovmJSP9Dr5mtKamV0vkkHtN4uNt3JBInmEHVONaMUgjXRmkjaXGbX5wbb9Koaly5Ms7ZjbAkqIjVPApHizDOyv1kBMJyTrRcraxpzIy1r7tGIB8r8PTd9GWv1BivPLjYGdL2ZZv78VXEZCj89Mh8O406LxCLnlud2wOtDRlvKVb4rerDsglaiUticYT1gNpfRbZ466jxygpqZ0sOhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664308870; bh=b0kkQGRcqZzAI2cy/yIjIi4OsKri3RnphQYZVWEKMRH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=M9xR3LD1sC3pdbtmFgcJ1NDvAve+hcXiBCeaELPKw9/wVi7GjD9vWuGHV7emOwHNMllF5qXAuDTonXtSJ3YsxPp2pMOdUkL6T4l+sk4nOWWjXajbuHV4MJVC81f8arepcT13OQOjxD6OPXdZkDkvMH18uSk7L1XWfDIqJ65wJiw6PuRBjlJskM7Xsj/aTrDF3KrHYRc5fzx9ftcx2W2jNUB7keMoiF35RU9mZIN9JKzPLxehNkoCbWv4kZEWiRHsuk+jxcMz/F35YEOVjbvjPZ6wYceFKNR+V96xp3S34fO1frHhDPiItgRduc92ABaiCbpaD+T/Lqsy1o648Sc0fQ==
X-YMail-OSG: EBMMIXIVM1lDzY1r4EZkGziG3ndO.bhZGYAnkwcgZ8_m7dO0IlglEg9FzQhusxL
 A6Nca5PQzb8__eXjrE7kRTMhYNGWwS5EuBq8pF8t.2w98CbsI2LB0DBFbXJ5e2jRviEx1XdM3_kk
 g27Q1.._zJPnkWarQMubmdAGFPgbvd4uGFDv4pY5397n60JJ7S766mpwSc1xol1r3FH0ZH9cuuo7
 Slsp38i7sgqbqlAiLdPt8g412OSXhwe.Ts1tZ1aKfws2Ib9bNbSvG7hkcNikDa7mzd60LmHAnHcN
 ZJogaz02cCtl_TVIKaMNRkY2RNvdd.ykHNm1iwsEVCpmWlFuVBMYDflA0pTcC9l8Xt_3FV3j2w3x
 DFcQtk87bb19TA0hHUgtcebZaNhDLfJ5nt.0XRJ8sZFAIVinu1hD55TGFsx2afJxVkaydoplehmb
 46.jipnkIiw9dcptshcD_oC3jADHjMVb4LAhnVip03mR.G8JU023XCuLeFAJV.K5OsKx4cJNGzR0
 _zS3OaptAgyKkv0FLH57TIyoEET0gtSZ5g7oJYjWDpQTUnj93RIJczrgwZ5yNZARn3igqKQ9x_G0
 WHC_8Y8K7I_qkFzpA45khoxPB51zOweNQM1dTgyvsBjYmYIKyRAm7HuDRsnxCHCt9Bd1bAjFZpYl
 xd_ay3AJuacJAwf1WyF2nVZ4LWNC4.kEczWneSTP6Xivwigg.RhN4wCq_2PvWnYTfHSkUMlikDSD
 SIcjf_t3mtzIM__t12nmS5gf9LocL9L45.b2X12cRuQKbQ9wUOU8U786IRIVCGzJaJ_Aaq_fEP5N
 Yl7TGc20gYvwGk88fC5DfnvHGP5._K5Wf97Wv.rzJqEUUVff7fYqJRaTVS9uypSRMBge98L._gSL
 ITfKZbmliCl64Oq31IS88WwdIhEOdTKwiPiaeGaQSLDqf9iZbNHbACn2D5kT7aJZoaa9ee7DPCNP
 0yCbBkSBCs4FBWqVv3G8yJj0Pt0IUNJGbyIYzxZ_E1.Lm2R7Volchs9IW9VI2Q82xyPwOIIh9i2T
 zFXsOLcBjaDW2RcQhaxDHgShCzYozynjx1wHak6o.QoxElUOQCmmhR88V62AdfxcyBnfmV8kv3ig
 0DgsSNn8TMc_gh9UwnPwmHnxMlx4.DoNkvCcaXwT.uYWPnJHJKbnkR7185pYz5xBe0poxU...n5O
 PVr4jd4JDAINz1omWneP6CJ8D0Bww5cpN0ZELnE19xc4Q4cFxbUO9KMD2pEkh5YhLKRTfSnF9MgW
 p0wM98Lnyf1l9wnWqMKbGabBHc8pydyMUP0zlFWA77UlQCGa1lXEAQ5qf8MPFzmDDNzU8F75SxiT
 q6k3Ye5AOqfiiml1X0WjTVdhc49RDRhJotqd5Qz04prycuFSGP2UZpmmpAKL37tnb0Ydso8QIISY
 J29jBPI_Wu.YxiZrVDCSRGiZquWdm41ryFSjTmDZWRnyAN7FqkS_jwenVf3j9mH7DExc8w8qPh_v
 OFEyKSxTvU4aQMh5k3Rm78sUl3llGbU0iDga_DgwHkuJG7iWfgdUbuw8UipxYclJ0qGWHOQFSLiJ
 eOFohetzSw3Xbw0b704wfF1NkjqpWG7WCXAZmeczBVikhMGIhGS2SdsFPhcJ9Ev7bxwGFzlU4n2h
 UrpcV7h8av_Pm8UcXhkKyCKPDT32jxOk9sGjSLuUait4tVEbpa7wZdPzgpVSJkzB0Z2sl0el2Sja
 tqoAfoZvr0AYW2Qft5aJSfarAqYsqLmRtmGB6qfxl2A5ZAVtRdibFrfkam7R0xWBfRqdrG2kxrS1
 yFdZv.gVpeXHklG9ePP0wWYPullB0vEsPo4LQjEI6OTt5Wow70xjxJ.eH919QxXSzz21.nWp4D7G
 Jm4wVEG0qNEVhrw0yOsCZ1Xpr4kbgngZa.SX6T9aysnl3fEjo5LIAubHhHdYUjEs7JTcQB4Mjosq
 VF7OqYYbxLgTujk5yc4GrFJam9N0hXrQbFtup5eNFl2rWvrxFuXRVskPnf.SpL1GD6ve_t3syLLB
 ruV2z7B_GBLls_EWYUodiamx5oY8m9oknQa4poZl1Yy94f5n5HEAgV.C0J8_lWCPEu1JK5ppGNYi
 utnk0STq5crIgpKrUEYUiuEy7NFtyJ1bnI7qQmeM5ree7kP9doCk5cRDF1vA1.LjbNHCwR6hyDXN
 GkAaNnbC_vQP2aLfXHFy9BQbCrSR4jN5cLEyGtsUrNbzKAYEhuFJRcbuwJhQPk7wSM01hXjY4Mrf
 R0PuBQs70eNZy8Pggum3DWTwbo6x9V6OUtQraJ4HJCtApUdvKx4GpNgrFz8rRVeYLpEhUSfYVu_X
 sZTSfDqUX3Q2YF9Etv59_hiWejy7_ghx9T9xHRu0-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:01:10 +0000
Received: by hermes--production-bf1-759bcdd488-mc79z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6e213c213e954b1fa721ede3259fc3d6;
          Tue, 27 Sep 2022 20:01:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 13/39] LSM: Use lsmblob in security_kernel_act_as
Date:   Tue, 27 Sep 2022 12:53:55 -0700
Message-Id: <20220927195421.14713-14-casey@schaufler-ca.com>
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

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change its only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

The security module hook is unchanged, still taking a secid.
The infrastructure passes the correct entry from the lsmblob.
lsmblob_init() is used to fill the lsmblob structure, however
this will be removed later in the series when security_secctx_to_secid()
is updated to provide a lsmblob instead of a secid.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: David Howells <dhowells@redhat.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 9ed9232af934..610f70a99f60 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index 3fe04958f7fb..e95801437328 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -483,7 +483,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1126,7 +1126,8 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
 	*secid = 0;
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index e10c15f51c1f..3925d38f49f4 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -767,14 +767,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @blob: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *blob)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, blob);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -790,6 +790,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -797,7 +798,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 96faeff2c73b..ca749a8f36b8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1829,9 +1829,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.37.3

