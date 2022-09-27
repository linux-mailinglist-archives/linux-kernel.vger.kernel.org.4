Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92E15ECDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiI0UI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiI0UIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:08:36 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2021E458B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309255; bh=dXKb6wGxnKftlZ7RCVLysJedKqOWzeYSSwCIwkDbd8E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fBDarV9RSnYTCRnGMJA4pM/IHQBHJTVv5CxdaKBvY2+yC8hRWfLTH/xFHHups4DwARoXpEpXvWaSwc0LeF5/UATiU6HmME8K/nadEm9pKPdEyPeB7Le3D7uTn1Hc7fw1guNfKRVn6MhWovt5SXAN5/dk6U84cRakaUasvVnpeRESCShtSC7yVKGVYI+2f4MbwKT0y49YFIPye77e49J2k43790dR/WMpqA/hxrZ2QGiqW/ixTH7rYr431mHikV/A4PqGLQJ0swcp+4uXf2gh5M7Ds5vrG8JxPiGmYHYuYVOWJNQCFE0IWtIMqfsa+wjao8ry+ERTXYcFP98eLQ7GFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309255; bh=/nQM1xuhKTxxxQ/ntL9ptC8qCPL9ONBHnTOFT+H0JyJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rYB1D5umqs1CJkeUzbtPebohaZtpqMUlllBamKRWqjGtY49mPqhgwJYA4Aig/PzmVQbybK4itf8M805Xc8iuigSBscYdtHIU75XJza5Vq0iY0C0Y6GbtIQvhffUbOxq7mkd+csyRfOIsUd/pdxCIC6sSUZRD1Cq4kr/gWqfFutIyAkZLX62O2dDGKQ67sULQb5hGQx7IwQkwnk+VvcQZSsf5NF2EcfVkBbp3Bjtdtfevc5JYAEoeZmZTrxAqv3WAzILJGlsq7ZzK0biiSFziR71N6CYq4rcyajUR20QLZJX7zX4S7wBISmR55fkj+g/kVGV5XByBwwezNwk3QEbr0w==
X-YMail-OSG: WISzTEoVM1lNB34SCTq6Hb0WLdNbdJ_KcNNvCPn6_tUB1hSNr8sndgftiPLox0O
 6s.JDI54Wa8bCKzuwX9anEfOB6Qto76UmFT8NjNnMlAVIBr1PNrsL.FTUnNuLl2AtywKRKVq2Bva
 _12EgUvBXgnNrVhZHcY1ejaTyYdis7qQ2EXLo3V2JhZN.cBOB1bDtfrP9AxylspioKUOCrM7x.C1
 bG34s3Pw4qfbolmSTSVO4XI5QTmR_bnZ.CPEDHFi52E3z9q3WtvhAW3FBgt_Hrf95t6YavOXfTy3
 rVjiEzw_3JY3BpuRgUY6jYT8deE989OnQJ47Tesrh_rpDiVvHCE6G.oWjW40Nt5ilFT4ho7xkMlu
 .wkXxHl1Pi9bkePOFA_QLi73nlD3H6pfxhLIEbubQ_KmKwJgrk3iSMPpkjZETnCTFeVbdqrv5lr0
 KDddNY9NEub97qiFQZ7fMf9WRirtluxQAOYjTnIcG4SaI1oO0kt6Rc6IyH3lYWWKADrhiOtXkhPG
 AGbQGdbnRYH2z_ZaScsfYceFgr5bDDNqVT2sxNfk.4GvCLxM6Top_Tr4TFVOMt4YKcAnzZW65p0p
 QlTB1HmY8Lq6iL.gjitwvEw2V1.PDgUmkmIj_gAXa1CqZ2.q05d8i0hNp_G5RY56SdUj3KU7oGLd
 ih_E1SpQBv7kLG8spaqF98WChF7v3gotwTkx.DIkfcWtGdwNyCbMC6mLU5VIxb5.JPSjcdI4pnIE
 y68NugJS1hIzaz5yVwHuI5V7XntDlDkslGxC3X3rXRWNXW_GTVwnYmCN5tKBhSCFSh8ImNdxdNNY
 E8EMGtF29jBDf4YTMWjVdgizHlpk7mOxvcbfDmZzg05JIAwWk4SN_cDpTcO.XYEbOj0P2uaAeHDY
 7QsTbmcviSvoCFOSc9mUGMldrN6B.HjD6HcOMU7QRWpSNr4blc_U5U_AJBGNIeigi2KCi5zDEY3Z
 7n3bQh2zrYO5d4oRXgL4RAE0FyBKTKMksA7VwcYprIvbgb4dtC8ZodDopP2ap_jkfN1GNeensh_q
 KL77dcrIx0_wXDKXp5lGtfyUg3PRYP1ekxrpwNMh4Jd7gESUNjHAeL0QXP5b62Pkw6zC4..iV4L9
 cZhFXaHV2_rxu8c3QXK5m_XqOEsc8gQEM1uuW1rnOH7wgnM2aRlKSMsFzolYOf0MHKIZrvnvDhX8
 gG5vQ_3KEXqaPl5BHAoMmPng_jlJ_2UaTfNpUNJES4fGYwwbTZiBoEGujjHgESh6iPnrdvIpSVVP
 BpYqqfUhTPIZzqr48bxYHbhWGX._ufgcPU1Kv3IjkTSIYdmz7Y.74fcomEsNiqJLY6O4txwsJ065
 NVT.AijW0zKgm1mZsb0NY0Xqaabjm.XAyV4J7O0SBT_6CBdLihAA8K3ZyAlAqtso6VXn1hEAu6AG
 bIfc9abOCecgEJgKaGN49lruwaxOmlKedaicjiMSMyR3xv3Q6Z7U.lYwMdeEmF4C6RDhPKco3_ZG
 0WblMsEvNXJp9j2JCVsqaNcsEr.sdeCzy25kF73KTeNc3.rerPZoDNxc8tBY7xWz7N9SYQWm3.ek
 jfwCPcAlm1VR6EwObG.3gKyf_ZrH30rR8ZJ0vDLVxtSROdvRK6dbdaYsN78WcLtL4rDEUHCb0Mbl
 5_bE5vUkzzE8dioSS01HbA4azT2lrYtW38IBu3JRkDJiHx3Sii74AHXGdy41TEXw_HSdoxFcxwmG
 0WzFXoxxT5LIu1KaFyY5h588BQ8opSHyb4F8lIxn01eZfVz5B2D6NiiEXmhBCkcOwBpPQ8UefF99
 i3MWQ9hiI5Igf6S5Em1BFZINpSy7WJs9XAIQ.HgYkFM4krqvgwWY1HvPLk5wBXSIny1BMtK3B3NK
 tDQ0G6YX.Ocn.e6afUF_RiiTSBLdtDiYlCiauFHrGOJd6oqnGnGcVRo8udusnK5UVs6qGek7OJY5
 4Ymq_TQxCwSDH7dVbuiw7y2rnYWDjTM3DRXeTjh39pes9lZf2nKTGQLuPyvZqKEPmz2S3A7AfloF
 q7cZ6LCLLzUq6ybAaA.6jCctS_u8unfnT8SXBDzbHfuq_bkn4U1v1V2jv77.3Y6z6XV17mqQC2jY
 _.PesDdMCKBY_AkkyeZds0drwjQHPyVC6QzUeMxtHmTPPsQxHqBsJdZxcynaRwpWQq8axRKrTw.m
 4.1Qjq0EZ.zv4MiX.35yf9Yd6CTt1sToIxToduwbv4RpegdL1c9QaMoZaW4XRgy3xIIhVzgMjObS
 .p0sqvSQXMc1.eSA.b1BqEkk4SNoaSN4BddrYELqib.jO0ntHvuIklWQ1HROum34DraJmrAVc62f
 11jG2SxFl1QXJ24QjE1Jh8PumJ0LPktHyHZFIr60-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:07:35 +0000
Received: by hermes--production-gq1-7dfd88c84d-mgq76 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3a50061892aa4d3f76ff4b42bdd2ab9e;
          Tue, 27 Sep 2022 20:07:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 24/39] Use lsmcontext in security_dentry_init_security
Date:   Tue, 27 Sep 2022 12:54:06 -0700
Message-Id: <20220927195421.14713-25-casey@schaufler-ca.com>
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

Replace the (secctx,seclen) pointer pair with a single
lsmcontext pointer to allow return of the LSM identifier
along with the context and context length. This allows
security_release_secctx() to know how to release the
context. Callers have been modified to use or save the
returned data from the new structure.

Special care is taken in the NFS code, which uses the
same data structure for its own copied labels as it does
for the data which comes from security_dentry_init_security().
In the case of copied labels the data has to be freed, not
released.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/ceph/super.h          |  3 +--
 fs/ceph/xattr.c          | 19 ++++++-------------
 fs/fuse/dir.c            | 35 ++++++++++++++++++-----------------
 fs/nfs/dir.c             |  2 +-
 fs/nfs/inode.c           | 17 ++++++++++-------
 fs/nfs/internal.h        |  8 +++++---
 fs/nfs/nfs4proc.c        | 20 ++++++++------------
 fs/nfs/nfs4xdr.c         | 22 ++++++++++++----------
 include/linux/nfs4.h     |  8 ++++----
 include/linux/nfs_fs.h   |  2 +-
 include/linux/security.h | 18 ++++++++++++++----
 security/security.c      | 17 +++++++++++++----
 12 files changed, 93 insertions(+), 78 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 40630e6f691c..60c560a842e7 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1072,8 +1072,7 @@ struct ceph_acl_sec_ctx {
 	void *acl;
 #endif
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	void *sec_ctx;
-	u32 sec_ctxlen;
+	struct lsmcontext lsmctx;
 #endif
 	struct ceph_pagelist *pagelist;
 };
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index d943be72dfff..c7f8c3a56be8 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1332,8 +1332,7 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 	int err;
 
 	err = security_dentry_init_security(dentry, mode, &dentry->d_name,
-					    &name, &as_ctx->sec_ctx,
-					    &as_ctx->sec_ctxlen);
+					    &name, &as_ctx->lsmctx);
 	if (err < 0) {
 		WARN_ON_ONCE(err != -EOPNOTSUPP);
 		err = 0; /* do nothing */
@@ -1358,7 +1357,7 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 	 */
 	name_len = strlen(name);
 	err = ceph_pagelist_reserve(pagelist,
-				    4 * 2 + name_len + as_ctx->sec_ctxlen);
+				    4 * 2 + name_len + as_ctx->lsmctx.len);
 	if (err)
 		goto out;
 
@@ -1378,11 +1377,9 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 		as_ctx->pagelist = pagelist;
 	}
 
-	ceph_pagelist_encode_32(pagelist, name_len);
-	ceph_pagelist_append(pagelist, name, name_len);
-
-	ceph_pagelist_encode_32(pagelist, as_ctx->sec_ctxlen);
-	ceph_pagelist_append(pagelist, as_ctx->sec_ctx, as_ctx->sec_ctxlen);
+	ceph_pagelist_encode_32(pagelist, as_ctx->lsmctx.len);
+	ceph_pagelist_append(pagelist, as_ctx->lsmctx.context,
+			     as_ctx->lsmctx.len);
 
 	err = 0;
 out:
@@ -1395,16 +1392,12 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 
 void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 {
-#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	struct lsmcontext scaff; /* scaffolding */
-#endif
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 	posix_acl_release(as_ctx->acl);
 	posix_acl_release(as_ctx->default_acl);
 #endif
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	lsmcontext_init(&scaff, as_ctx->sec_ctx, as_ctx->sec_ctxlen, 0);
-	security_release_secctx(&scaff);
+	security_release_secctx(&as_ctx->lsmctx);
 #endif
 	if (as_ctx->pagelist)
 		ceph_pagelist_release(as_ctx->pagelist);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b585b04e815e..235f8039bb5b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -470,29 +470,29 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 {
 	struct fuse_secctx *fctx;
 	struct fuse_secctx_header *header;
-	void *ctx = NULL, *ptr;
-	u32 ctxlen, total_len = sizeof(*header);
+	struct lsmcontext lsmctx = { };
+	void *ptr;
+	u32 total_len = sizeof(*header);
 	int err, nr_ctx = 0;
-	const char *name;
+	const char *name = NULL;
 	size_t namelen;
 
 	err = security_dentry_init_security(entry, mode, &entry->d_name,
-					    &name, &ctx, &ctxlen);
-	if (err) {
-		if (err != -EOPNOTSUPP)
-			goto out_err;
-		/* No LSM is supporting this security hook. Ignore error */
-		ctxlen = 0;
-		ctx = NULL;
-	}
+					    &name, &lsmctx);
+
+	/* If no LSM is supporting this security hook ignore error */
+	if (err && err != -EOPNOTSUPP)
+		goto out_err;
 
-	if (ctxlen) {
+	if (lsmctx.len) {
 		nr_ctx = 1;
 		namelen = strlen(name) + 1;
 		err = -EIO;
-		if (WARN_ON(namelen > XATTR_NAME_MAX + 1 || ctxlen > S32_MAX))
+		if (WARN_ON(namelen > XATTR_NAME_MAX + 1 ||
+		    lsmctx.len > S32_MAX))
 			goto out_err;
-		total_len += FUSE_REC_ALIGN(sizeof(*fctx) + namelen + ctxlen);
+		total_len += FUSE_REC_ALIGN(sizeof(*fctx) + namelen +
+					    lsmctx.len);
 	}
 
 	err = -ENOMEM;
@@ -505,19 +505,20 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 	ptr += sizeof(*header);
 	if (nr_ctx) {
 		fctx = ptr;
-		fctx->size = ctxlen;
+		fctx->size = lsmctx.len;
 		ptr += sizeof(*fctx);
 
 		strcpy(ptr, name);
 		ptr += namelen;
 
-		memcpy(ptr, ctx, ctxlen);
+		memcpy(ptr, lsmctx.context, lsmctx.len);
 	}
 	*security_ctxlen = total_len;
 	*security_ctx = header;
 	err = 0;
 out_err:
-	kfree(ctx);
+	if (nr_ctx)
+		security_release_secctx(&lsmctx);
 	return err;
 }
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5d6c2ddc7ea6..a1979b3d311f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -810,7 +810,7 @@ static int nfs_readdir_entry_decode(struct nfs_readdir_descriptor *desc,
 	int ret;
 
 	if (entry->fattr->label)
-		entry->fattr->label->len = NFS4_MAXLABELLEN;
+		entry->fattr->label->lsmctx.len = NFS4_MAXLABELLEN;
 	ret = xdr_decode(desc, entry, stream);
 	if (ret || !desc->plus)
 		return ret;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index bea7c005119c..5bec6ead5407 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -361,14 +361,15 @@ void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr)
 		return;
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && inode->i_security) {
-		error = security_inode_notifysecctx(inode, fattr->label->label,
-				fattr->label->len);
+		error = security_inode_notifysecctx(inode,
+						fattr->label->lsmctx.context,
+						fattr->label->lsmctx.len);
 		if (error)
 			printk(KERN_ERR "%s() %s %d "
 					"security_inode_notifysecctx() %d\n",
 					__func__,
-					(char *)fattr->label->label,
-					fattr->label->len, error);
+					(char *)fattr->label->lsmctx.context,
+					fattr->label->lsmctx.len, error);
 		nfs_clear_label_invalid(inode);
 	}
 }
@@ -384,12 +385,14 @@ struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags)
 	if (label == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	label->label = kzalloc(NFS4_MAXLABELLEN, flags);
-	if (label->label == NULL) {
+	label->lsmctx.context = kzalloc(NFS4_MAXLABELLEN, flags);
+	if (label->lsmctx.context == NULL) {
 		kfree(label);
 		return ERR_PTR(-ENOMEM);
 	}
-	label->len = NFS4_MAXLABELLEN;
+	label->lsmctx.len = NFS4_MAXLABELLEN;
+	/* Use an invalid LSM slot as this should never be "released". */
+	label->lsmctx.slot = -1;
 
 	return label;
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 898dd95bc7a7..b02297d9b5ae 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -342,13 +342,15 @@ nfs4_label_copy(struct nfs4_label *dst, struct nfs4_label *src)
 	if (!dst || !src)
 		return NULL;
 
-	if (src->len > NFS4_MAXLABELLEN)
+	if (src->lsmctx.len > NFS4_MAXLABELLEN)
 		return NULL;
 
 	dst->lfs = src->lfs;
 	dst->pi = src->pi;
-	dst->len = src->len;
-	memcpy(dst->label, src->label, src->len);
+	/* Use an invalid LSM slot as lsmctx should never be "released" */
+	dst->lsmctx.slot = -1;
+	dst->lsmctx.len = src->lsmctx.len;
+	memcpy(dst->lsmctx.context, src->lsmctx.context, src->lsmctx.len);
 
 	return dst;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 47259990fae1..7ff49d4b7e97 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -123,8 +123,7 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, NULL,
-				(void **)&label->label, &label->len);
+				&dentry->d_name, NULL, &label->lsmctx);
 	if (err == 0)
 		return label;
 
@@ -133,12 +132,8 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	struct lsmcontext scaff; /* scaffolding */
-
-	if (label) {
-		lsmcontext_init(&scaff, label->label, label->len, 0);
-		security_release_secctx(&scaff);
-	}
+	if (label)
+		security_release_secctx(&label->lsmctx);
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
@@ -3799,7 +3794,7 @@ nfs4_atomic_open(struct inode *dir, struct nfs_open_context *ctx,
 		int open_flags, struct iattr *attr, int *opened)
 {
 	struct nfs4_state *state;
-	struct nfs4_label l = {0, 0, 0, NULL}, *label = NULL;
+	struct nfs4_label l = { }, *label = NULL;
 
 	label = nfs4_label_init_security(dir, ctx->dentry, attr, &l);
 
@@ -6114,7 +6109,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 					size_t buflen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs4_label label = {0, 0, buflen, buf};
+	struct nfs4_label label = {0, 0, {buf, buflen, -1} };
 
 	u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
 	struct nfs_fattr fattr = {
@@ -6142,7 +6137,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 		return ret;
 	if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
 		return -ENOENT;
-	return label.len;
+	return label.lsmctx.len;
 }
 
 static int nfs4_get_security_label(struct inode *inode, void *buf,
@@ -6219,7 +6214,8 @@ static int nfs4_do_set_security_label(struct inode *inode,
 static int
 nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 {
-	struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
+	struct nfs4_label ilabel = {0, 0,
+				    {(char *)buf, buflen, -1}};
 	struct nfs_fattr *fattr;
 	int status;
 
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index acfe5f4bda48..9f1a376fb92c 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1154,7 +1154,7 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	}
 
 	if (label && (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL)) {
-		len += 4 + 4 + 4 + (XDR_QUADLEN(label->len) << 2);
+		len += 4 + 4 + 4 + (XDR_QUADLEN(label->lsmctx.len) << 2);
 		bmval[2] |= FATTR4_WORD2_SECURITY_LABEL;
 	}
 
@@ -1186,8 +1186,9 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	if (label && (bmval[2] & FATTR4_WORD2_SECURITY_LABEL)) {
 		*p++ = cpu_to_be32(label->lfs);
 		*p++ = cpu_to_be32(label->pi);
-		*p++ = cpu_to_be32(label->len);
-		p = xdr_encode_opaque_fixed(p, label->label, label->len);
+		*p++ = cpu_to_be32(label->lsmctx.len);
+		p = xdr_encode_opaque_fixed(p, label->lsmctx.context,
+					    label->lsmctx.len);
 	}
 	if (bmval[2] & FATTR4_WORD2_MODE_UMASK) {
 		*p++ = cpu_to_be32(iap->ia_mode & S_IALLUGO);
@@ -4236,12 +4237,12 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 			return -EIO;
 		if (len < NFS4_MAXLABELLEN) {
 			if (label) {
-				if (label->len) {
-					if (label->len < len)
+				if (label->lsmctx.len) {
+					if (label->lsmctx.len < len)
 						return -ERANGE;
-					memcpy(label->label, p, len);
+					memcpy(label->lsmctx.context, p, len);
 				}
-				label->len = len;
+				label->lsmctx.len = len;
 				label->pi = pi;
 				label->lfs = lfs;
 				status = NFS_ATTR_FATTR_V4_SECURITY_LABEL;
@@ -4250,10 +4251,11 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 		} else
 			printk(KERN_WARNING "%s: label too long (%u)!\n",
 					__func__, len);
-		if (label && label->label)
+		if (label && label->lsmctx.context)
 			dprintk("%s: label=%.*s, len=%d, PI=%d, LFS=%d\n",
-				__func__, label->len, (char *)label->label,
-				label->len, label->pi, label->lfs);
+				__func__, label->lsmctx.len,
+				(char *)label->lsmctx.context,
+				label->lsmctx.len, label->pi, label->lfs);
 	}
 	return status;
 }
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 8d04b6a5964c..5c2d69cf609a 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -15,6 +15,7 @@
 
 #include <linux/list.h>
 #include <linux/uidgid.h>
+#include <linux/security.h>
 #include <uapi/linux/nfs4.h>
 #include <linux/sunrpc/msg_prot.h>
 
@@ -44,10 +45,9 @@ struct nfs4_acl {
 #define NFS4_MAXLABELLEN	2048
 
 struct nfs4_label {
-	uint32_t	lfs;
-	uint32_t	pi;
-	u32		len;
-	char	*label;
+	uint32_t		lfs;
+	uint32_t		pi;
+	struct lsmcontext	lsmctx;
 };
 
 typedef struct { char data[NFS4_VERIFIER_SIZE]; } nfs4_verifier;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 7931fa472561..d4f30861c656 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -428,7 +428,7 @@ static inline void nfs4_label_free(struct nfs4_label *label)
 {
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	if (label) {
-		kfree(label->label);
+		kfree(label->lsmctx.context);
 		kfree(label);
 	}
 #endif
diff --git a/include/linux/security.h b/include/linux/security.h
index be935b8d7df5..4f2c1bb857be 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -246,8 +246,19 @@ static inline bool lsmblob_equal(const struct lsmblob *bloba,
 }
 
 /* Map lsm names to blob slot numbers */
+#if LSMBLOB_ENTRIES > 0
 extern int lsm_name_to_slot(char *name);
 extern const char *lsm_slot_to_name(int slot);
+#else
+static inline int lsm_name_to_slot(char *name)
+{
+	return LSMBLOB_INVALID;
+}
+static inline const char *lsm_slot_to_name(int slot)
+{
+	return NULL;
+}
+#endif
 
 /**
  * lsmblob_value - find the first non-zero value in an lsmblob structure.
@@ -487,8 +498,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
-				  const char **xattr_name, void **ctx,
-				  u32 *ctxlen);
+				  const char **xattr_name,
+				  struct lsmcontext *lsmcxt);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -906,8 +917,7 @@ static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
 						 const char **xattr_name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsmcontext *lsmcxt)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index d57554ce386a..d31989e4bc25 100644
--- a/security/security.c
+++ b/security/security.c
@@ -496,6 +496,8 @@ static int lsm_append(const char *new, char **result)
  * Current index to use while initializing the lsmblob secid list.
  */
 static int lsm_slot __lsm_ro_after_init;
+
+#if LSMBLOB_ENTRIES > 0
 static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
 
 /**
@@ -540,6 +542,7 @@ const char *lsm_slot_to_name(int slot)
 		return NULL;
 	return lsm_slotlist[slot]->lsm;
 }
+#endif /* LSMBLOB_ENTRIES > 0 */
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -568,6 +571,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 	WARN_ON(!lsmid->slot || !lsmid->id);
 
+#if LSMBLOB_ENTRIES > 0
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
@@ -576,6 +580,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
 	}
+#endif /* LSMBLOB_ENTRIES > 0 */
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
@@ -1186,8 +1191,8 @@ void security_inode_free(struct inode *inode)
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
-				  const char **xattr_name, void **ctx,
-				  u32 *ctxlen)
+				  const char **xattr_name,
+				  struct lsmcontext *lsmctx)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -1195,9 +1200,13 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 	/*
 	 * Only one module will provide a security context.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security, list) {
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list) {
 		rc = hp->hook.dentry_init_security(dentry, mode, name,
-						   xattr_name, ctx, ctxlen);
+						   xattr_name,
+						   (void **)&lsmctx->context,
+						   &lsmctx->len);
+		lsmctx->slot = hp->lsmid->slot;
 		if (rc != LSM_RET_DEFAULT(dentry_init_security))
 			return rc;
 	}
-- 
2.37.3

