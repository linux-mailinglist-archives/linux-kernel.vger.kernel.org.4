Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF76EDA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjDYDER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjDYDED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:04:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D6D1FC8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 20:03:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a5197f00e9so42403425ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 20:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1682391838; x=1684983838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/o2UHS4ZJJmags83cdXDEg5I6zpz205KtvMH6IPDII=;
        b=WSUJFCR+jo5h4Hv4GEnI8VHn6zGj26vnQxlLD0gNeXolXyEHVNF2HUDrZsD1CHT//Z
         52S2hGzyv3bG3dhoKh00Tj72XyHO0O4SlqweeBThqtc32loSgj5S7SeIzs7oHOB42Jjt
         QOsU5RJOvwMcqmOSp1CvkBkDuBZ1UT484jlaw/Jmi6zfTIEiwbVX3VtSSyZamQm8VhtS
         d9dHdgyGsCkHkbkudyJFynO46H1J58tu7CgwTZLlHi9vBG2HO9duFEBFiqfsCWZU6Eja
         2qIb9/KPn4dWO84bPxpnsBYgMgUSnktTO18h7B3N1VUo0hD0Ln/L3J6Njpv1kW8TGUZZ
         pN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682391838; x=1684983838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/o2UHS4ZJJmags83cdXDEg5I6zpz205KtvMH6IPDII=;
        b=DAplB6TxCdXXdNOf9DJnENeUdJk6bNt6iZHD/HMO09YvxDP4lNVnCcyBjTKoL5P0V+
         PAnkrcLvbxF30/j35kCITxJxKQA6tF6aHZMdG3ZsW+D6N77dfdL1jcSRvL6ieF9jfFF+
         DBeKb/yyIDtC3j6ngqb1topCrEX7BRd8xPEYL0+UTe1Sw1+LjfFe2syUigQg+Wf803Ro
         hIDKhbqhwY8Etv+EDISoZnUUYBZTqTLF69hhg6N1KgimgXAVKbUeBD6HdVBFPK16fGW8
         QFmxsMIkF6hVXd0yjPxRhuBEKbKMswPHL87tNQt9infvpp62fAgX5U9lmKs5bf8sRtCz
         YafA==
X-Gm-Message-State: AC+VfDyREbuyV3E8c0uem4xthB50JifD2x2CAROiqVlArvzvnx4j7qBZ
        m9hqDxUHUiKLhUCHxgwNGlE0XYSBPF9SX7G4rwF22Q==
X-Google-Smtp-Source: ACHHUZ6dx/DNtVI0cSfD075q6tK0TV4bznCOeBnmmvoWahoG3qmVl6dLEyDEjVCTNglMCkqlFc0z9w==
X-Received: by 2002:a17:902:d507:b0:1a9:8769:36bd with SMTP id b7-20020a170902d50700b001a9876936bdmr2646125plg.36.1682391837358;
        Mon, 24 Apr 2023 20:03:57 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b00199203a4fa3sm7171508pld.203.2023.04.24.20.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 20:03:57 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     torvalds@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, mszeredi@redhat.com,
        bigeasy@linutronix.de, mcgrof@kernel.org, xiubli@redhat.com,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/2] vfs: replace d_backing_inode() with d_inode() globally
Date:   Tue, 25 Apr 2023 03:01:18 +0000
Message-Id: <20230425030118.4982-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d_backing_inode() does the same thing with d_inode(), so using
d_inode() to get the inode of dentry instead of d_backing_inode().

Following are the steps to complete search-and-replace:

1) replacing the definition and comment of d_backing_inode() with
   #define d_backing_inode d_inode

2) sed -i -e "s/\<d_backing_inode\>/d_inode/g" $(git grep -l -w "d_backing_inode")
   sed -i -e "/#define d_inode d_inode/d" include/linux/dcache.h

Al Viro hopes to do the search-and-replace just prior to -rc1.

More details about this discussion can refer to:
	https://lore.kernel.org/all/20230419104704.243950-1-haifeng.xu@shopee.com/

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c                          |  2 +-
 drivers/block/ublk_drv.c              |  2 +-
 fs/cachefiles/cache.c                 |  8 ++--
 fs/cachefiles/namei.c                 | 38 +++++++++---------
 fs/cachefiles/security.c              |  6 +--
 fs/cachefiles/xattr.c                 |  2 +-
 fs/exfat/file.c                       |  2 +-
 fs/fs_parser.c                        |  2 +-
 fs/namei.c                            |  4 +-
 fs/open.c                             |  6 +--
 fs/posix_acl.c                        |  2 +-
 fs/stat.c                             |  6 +--
 fs/udf/symlink.c                      |  2 +-
 include/linux/dcache.h                | 19 +--------
 include/trace/events/cachefiles.h     | 10 ++---
 kernel/audit_tree.c                   |  4 +-
 kernel/audit_watch.c                  |  8 ++--
 kernel/auditsc.c                      |  6 +--
 kernel/bpf/inode.c                    |  4 +-
 net/unix/af_unix.c                    |  6 +--
 net/unix/diag.c                       |  2 +-
 security/apparmor/file.c              |  4 +-
 security/apparmor/lsm.c               | 14 +++----
 security/commoncap.c                  |  8 ++--
 security/integrity/evm/evm_crypto.c   |  4 +-
 security/integrity/evm/evm_main.c     | 24 +++++------
 security/integrity/ima/ima_appraise.c | 10 ++---
 security/landlock/fs.c                | 10 ++---
 security/landlock/syscalls.c          |  2 +-
 security/lsm_audit.c                  |  4 +-
 security/security.c                   | 54 ++++++++++++-------------
 security/selinux/hooks.c              | 20 ++++-----
 security/smack/smack_lsm.c            | 58 +++++++++++++--------------
 security/tomoyo/condition.c           |  2 +-
 security/tomoyo/realpath.c            |  8 ++--
 35 files changed, 173 insertions(+), 190 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 1795c7d4b99e..7081e6e99f0b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -904,7 +904,7 @@ int lookup_bdev(const char *pathname, dev_t *dev)
 	if (error)
 		return error;
 
-	inode = d_backing_inode(path.dentry);
+	inode = d_inode(path.dentry);
 	error = -ENOTBLK;
 	if (!S_ISBLK(inode->i_mode))
 		goto out_path_put;
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 604c1a13c76e..08a9a3fcb92f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2103,7 +2103,7 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
 		goto exit;
 
 	err = inode_permission(&nop_mnt_idmap,
-			d_backing_inode(path.dentry), mask);
+			d_inode(path.dentry), mask);
 exit:
 	path_put(&path);
 	return err;
diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 7077f72e6f47..86078ba0e637 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -59,10 +59,10 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
 	 */
 	ret = -EOPNOTSUPP;
 	if (d_is_negative(root) ||
-	    !d_backing_inode(root)->i_op->lookup ||
-	    !d_backing_inode(root)->i_op->mkdir ||
-	    !d_backing_inode(root)->i_op->tmpfile ||
-	    !(d_backing_inode(root)->i_opflags & IOP_XATTR) ||
+	    !d_inode(root)->i_op->lookup ||
+	    !d_inode(root)->i_op->mkdir ||
+	    !d_inode(root)->i_op->tmpfile ||
+	    !(d_inode(root)->i_opflags & IOP_XATTR) ||
 	    !root->d_sb->s_op->statfs ||
 	    !root->d_sb->s_op->sync_fs ||
 	    root->d_sb->s_blocksize > PAGE_SIZE)
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 82219a8f6084..2fc095af6156 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -103,7 +103,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		subdir = ERR_PTR(ret);
 	trace_cachefiles_lookup(NULL, dir, subdir);
 	if (IS_ERR(subdir)) {
-		trace_cachefiles_vfs_error(NULL, d_backing_inode(dir),
+		trace_cachefiles_vfs_error(NULL, d_inode(dir),
 					   PTR_ERR(subdir),
 					   cachefiles_trace_lookup_error);
 		if (PTR_ERR(subdir) == -ENOMEM)
@@ -112,7 +112,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	}
 
 	_debug("subdir -> %pd %s",
-	       subdir, d_backing_inode(subdir) ? "positive" : "negative");
+	       subdir, d_inode(subdir) ? "positive" : "negative");
 
 	/* we need to create the subdir if it doesn't exist yet */
 	if (d_is_negative(subdir)) {
@@ -142,10 +142,10 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 			cachefiles_put_directory(subdir);
 			goto retry;
 		}
-		ASSERT(d_backing_inode(subdir));
+		ASSERT(d_inode(subdir));
 
 		_debug("mkdir -> %pd{ino=%lu}",
-		       subdir, d_backing_inode(subdir)->i_ino);
+		       subdir, d_inode(subdir)->i_ino);
 		if (_is_new)
 			*_is_new = true;
 	}
@@ -163,7 +163,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	inode_unlock(d_inode(subdir));
 
 	/* we need to make sure the subdir is a directory */
-	ASSERT(d_backing_inode(subdir));
+	ASSERT(d_inode(subdir));
 
 	if (!d_can_lookup(subdir)) {
 		pr_err("%s is not a directory\n", dirname);
@@ -172,15 +172,15 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	}
 
 	ret = -EPERM;
-	if (!(d_backing_inode(subdir)->i_opflags & IOP_XATTR) ||
-	    !d_backing_inode(subdir)->i_op->lookup ||
-	    !d_backing_inode(subdir)->i_op->mkdir ||
-	    !d_backing_inode(subdir)->i_op->rename ||
-	    !d_backing_inode(subdir)->i_op->rmdir ||
-	    !d_backing_inode(subdir)->i_op->unlink)
+	if (!(d_inode(subdir)->i_opflags & IOP_XATTR) ||
+	    !d_inode(subdir)->i_op->lookup ||
+	    !d_inode(subdir)->i_op->mkdir ||
+	    !d_inode(subdir)->i_op->rename ||
+	    !d_inode(subdir)->i_op->rmdir ||
+	    !d_inode(subdir)->i_op->unlink)
 		goto check_error;
 
-	_leave(" = [%lu]", d_backing_inode(subdir)->i_ino);
+	_leave(" = [%lu]", d_inode(subdir)->i_ino);
 	return subdir;
 
 check_error:
@@ -245,12 +245,12 @@ static int cachefiles_unlink(struct cachefiles_cache *cache,
 
 	ret = cachefiles_inject_remove_error();
 	if (ret == 0) {
-		ret = vfs_unlink(&nop_mnt_idmap, d_backing_inode(dir), dentry, NULL);
+		ret = vfs_unlink(&nop_mnt_idmap, d_inode(dir), dentry, NULL);
 		if (ret == -EIO)
 			cachefiles_io_error(cache, "Unlink failed");
 	}
 	if (ret != 0)
-		trace_cachefiles_vfs_error(object, d_backing_inode(dir), ret,
+		trace_cachefiles_vfs_error(object, d_inode(dir), ret,
 					   cachefiles_trace_unlink_error);
 	return ret;
 }
@@ -424,9 +424,9 @@ int cachefiles_delete_object(struct cachefiles_object *object,
 	/* Stop the dentry being negated if it's only pinned by a file struct. */
 	dget(dentry);
 
-	inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
+	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
 	ret = cachefiles_unlink(volume->cache, object, fan, dentry, why);
-	inode_unlock(d_backing_inode(fan));
+	inode_unlock(d_inode(fan));
 	dput(dentry);
 	return ret;
 }
@@ -561,9 +561,9 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	path.mnt = cache->mnt;
 	path.dentry = dentry;
 	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				   d_backing_inode(dentry), cache->cache_cred);
+				   d_inode(dentry), cache->cache_cred);
 	if (IS_ERR(file)) {
-		trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
+		trace_cachefiles_vfs_error(object, d_inode(dentry),
 					   PTR_ERR(file),
 					   cachefiles_trace_open_error);
 		goto error;
@@ -688,7 +688,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	}
 
 	if (!d_is_negative(dentry)) {
-		if (d_backing_inode(dentry) == file_inode(object->file)) {
+		if (d_inode(dentry) == file_inode(object->file)) {
 			success = true;
 			goto out_dput;
 		}
diff --git a/fs/cachefiles/security.c b/fs/cachefiles/security.c
index fe777164f1d8..f3c1f4900d3e 100644
--- a/fs/cachefiles/security.c
+++ b/fs/cachefiles/security.c
@@ -51,14 +51,14 @@ static int cachefiles_check_cache_dir(struct cachefiles_cache *cache,
 {
 	int ret;
 
-	ret = security_inode_mkdir(d_backing_inode(root), root, 0);
+	ret = security_inode_mkdir(d_inode(root), root, 0);
 	if (ret < 0) {
 		pr_err("Security denies permission to make dirs: error %d",
 		       ret);
 		return ret;
 	}
 
-	ret = security_inode_create(d_backing_inode(root), root, 0);
+	ret = security_inode_create(d_inode(root), root, 0);
 	if (ret < 0)
 		pr_err("Security denies permission to create files: error %d",
 		       ret);
@@ -91,7 +91,7 @@ int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
 
 	/* use the cache root dir's security context as the basis with
 	 * which create files */
-	ret = set_create_files_as(new, d_backing_inode(root));
+	ret = set_create_files_as(new, d_inode(root));
 	if (ret < 0) {
 		abort_creds(new);
 		cachefiles_begin_secure(cache, _saved_cred);
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index bcb6173943ee..05b9ccbc2e85 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -160,7 +160,7 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 			cachefiles_io_error(cache,
 					    "Can't remove xattr from %lu"
 					    " (error %d)",
-					    d_backing_inode(dentry)->i_ino, -ret);
+					    d_inode(dentry)->i_ino, -ret);
 	}
 
 	_leave(" = %d", ret);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index e99183a74611..e9eddd3f70f8 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -229,7 +229,7 @@ int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, unsigned int request_mask,
 		  unsigned int query_flags)
 {
-	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *inode = d_inode(path->dentry);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 
 	generic_fillattr(&nop_mnt_idmap, inode, stat);
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index edb3712dcfa5..62ab7d06de46 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -173,7 +173,7 @@ int fs_lookup_param(struct fs_context *fc,
 	}
 
 	if (want_bdev &&
-	    !S_ISBLK(d_backing_inode(_path->dentry)->i_mode)) {
+	    !S_ISBLK(d_inode(_path->dentry)->i_mode)) {
 		path_put(_path);
 		_path->dentry = NULL;
 		_path->mnt = NULL;
diff --git a/fs/namei.c b/fs/namei.c
index edfedfbccaef..f93c42124b27 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2917,7 +2917,7 @@ EXPORT_SYMBOL(__check_sticky);
 static int may_delete(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *victim, bool isdir)
 {
-	struct inode *inode = d_backing_inode(victim);
+	struct inode *inode = d_inode(victim);
 	int error;
 
 	if (d_is_negative(victim))
@@ -3536,7 +3536,7 @@ static int do_open(struct nameidata *nd,
 		if (d_is_dir(nd->path.dentry))
 			return -EISDIR;
 		error = may_create_in_sticky(idmap, nd,
-					     d_backing_inode(nd->path.dentry));
+					     d_inode(nd->path.dentry));
 		if (unlikely(error))
 			return error;
 	}
diff --git a/fs/open.c b/fs/open.c
index 4401a73d4032..05854c7f994f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -484,7 +484,7 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 	if (res)
 		goto out;
 
-	inode = d_backing_inode(path.dentry);
+	inode = d_inode(path.dentry);
 
 	if ((mode & MAY_EXEC) && S_ISREG(inode->i_mode)) {
 		/*
@@ -1008,7 +1008,7 @@ int finish_open(struct file *file, struct dentry *dentry,
 	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 
 	file->f_path.dentry = dentry;
-	return do_dentry_open(file, d_backing_inode(dentry), open);
+	return do_dentry_open(file, d_inode(dentry), open);
 }
 EXPORT_SYMBOL(finish_open);
 
@@ -1048,7 +1048,7 @@ EXPORT_SYMBOL(file_path);
 int vfs_open(const struct path *path, struct file *file)
 {
 	file->f_path = *path;
-	return do_dentry_open(file, d_backing_inode(path->dentry), NULL);
+	return do_dentry_open(file, d_inode(path->dentry), NULL);
 }
 
 struct file *dentry_open(const struct path *path, int flags,
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 5a76fb35923a..305fa1f01d27 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -960,7 +960,7 @@ EXPORT_SYMBOL(set_posix_acl);
 static bool
 posix_acl_xattr_list(struct dentry *dentry)
 {
-	return IS_POSIXACL(d_backing_inode(dentry));
+	return IS_POSIXACL(d_inode(dentry));
 }
 
 const struct xattr_handler posix_acl_access_xattr_handler = {
diff --git a/fs/stat.c b/fs/stat.c
index 7c238da22ef0..98e9e3eb096e 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -99,7 +99,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 		      u32 request_mask, unsigned int query_flags)
 {
 	struct mnt_idmap *idmap;
-	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *inode = d_inode(path->dentry);
 
 	memset(stat, 0, sizeof(*stat));
 	stat->result_mask |= STATX_BASIC_STATS;
@@ -250,7 +250,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 
 	/* Handle STATX_DIOALIGN for block devices. */
 	if (request_mask & STATX_DIOALIGN) {
-		struct inode *inode = d_backing_inode(path.dentry);
+		struct inode *inode = d_inode(path.dentry);
 
 		if (S_ISBLK(inode->i_mode))
 			bdev_statx_dioalign(inode, stat);
@@ -476,7 +476,7 @@ static int do_readlinkat(int dfd, const char __user *pathname,
 retry:
 	error = user_path_at_empty(dfd, pathname, lookup_flags, &path, &empty);
 	if (!error) {
-		struct inode *inode = d_backing_inode(path.dentry);
+		struct inode *inode = d_inode(path.dentry);
 
 		error = empty ? -ENOENT : -EINVAL;
 		/*
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index a34c8c4e6d21..2e87b8419903 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -150,7 +150,7 @@ static int udf_symlink_getattr(struct mnt_idmap *idmap,
 			       u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct page *page;
 
 	generic_fillattr(&nop_mnt_idmap, inode, stat);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..601397faa7b3 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -528,23 +528,6 @@ static inline struct inode *d_inode_rcu(const struct dentry *dentry)
 	return READ_ONCE(dentry->d_inode);
 }
 
-/**
- * d_backing_inode - Get upper or lower inode we should be using
- * @upper: The upper layer
- *
- * This is the helper that should be used to get at the inode that will be used
- * if this dentry were to be opened as a file.  The inode may be on the upper
- * dentry or it may be on a lower dentry pinned by the upper.
- *
- * Normal filesystems should not use this to access their own inodes.
- */
-static inline struct inode *d_backing_inode(const struct dentry *upper)
-{
-	struct inode *inode = upper->d_inode;
-
-	return inode;
-}
-
 /**
  * d_backing_dentry - Get upper or lower dentry we should be using
  * @upper: The upper layer
@@ -589,7 +572,7 @@ static inline struct dentry *d_real(struct dentry *dentry,
 static inline struct inode *d_real_inode(const struct dentry *dentry)
 {
 	/* This usage of d_real() results in const dentry */
-	return d_backing_inode(d_real((struct dentry *) dentry, NULL));
+	return d_inode(d_real((struct dentry *) dentry, NULL));
 }
 
 struct name_snapshot {
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index cf4b98b9a9ed..e866d6ee1092 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -251,9 +251,9 @@ TRACE_EVENT(cachefiles_lookup,
 
 	    TP_fast_assign(
 		    __entry->obj	= obj ? obj->debug_id : 0;
-		    __entry->dino	= d_backing_inode(dir)->i_ino;
-		    __entry->ino	= (!IS_ERR(de) && d_backing_inode(de) ?
-					   d_backing_inode(de)->i_ino : 0);
+		    __entry->dino	= d_inode(dir)->i_ino;
+		    __entry->ino	= (!IS_ERR(de) && d_inode(de) ?
+					   d_inode(de)->i_ino : 0);
 		    __entry->error	= IS_ERR(de) ? PTR_ERR(de) : 0;
 			   ),
 
@@ -272,8 +272,8 @@ TRACE_EVENT(cachefiles_mkdir,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->dir	= d_backing_inode(dir)->i_ino;
-		    __entry->subdir	= d_backing_inode(subdir)->i_ino;
+		    __entry->dir	= d_inode(dir)->i_ino;
+		    __entry->subdir	= d_inode(subdir)->i_ino;
 			   ),
 
 	    TP_printk("dB=%x sB=%x",
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index e867c17d3f84..67451ab3f3da 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -670,7 +670,7 @@ int audit_remove_tree_rule(struct audit_krule *rule)
 
 static int compare_root(struct vfsmount *mnt, void *arg)
 {
-	return inode_to_key(d_backing_inode(mnt->mnt_root)) ==
+	return inode_to_key(d_inode(mnt->mnt_root)) ==
 	       (unsigned long)arg;
 }
 
@@ -744,7 +744,7 @@ void audit_put_tree(struct audit_tree *tree)
 
 static int tag_mount(struct vfsmount *mnt, void *arg)
 {
-	return tag_chunk(d_backing_inode(mnt->mnt_root), arg);
+	return tag_chunk(d_inode(mnt->mnt_root), arg);
 }
 
 /*
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 65075f1e4ac8..68c581662067 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -135,7 +135,7 @@ int audit_watch_compare(struct audit_watch *watch, unsigned long ino, dev_t dev)
 /* Initialize a parent watch entry. */
 static struct audit_parent *audit_init_parent(const struct path *path)
 {
-	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *inode = d_inode(path->dentry);
 	struct audit_parent *parent;
 	int ret;
 
@@ -353,9 +353,9 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 	if (d_is_positive(d)) {
 		/* update watch filter fields */
 		watch->dev = d->d_sb->s_dev;
-		watch->ino = d_backing_inode(d)->i_ino;
+		watch->ino = d_inode(d)->i_ino;
 	}
-	inode_unlock(d_backing_inode(parent->dentry));
+	inode_unlock(d_inode(parent->dentry));
 	dput(d);
 	return 0;
 }
@@ -425,7 +425,7 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
 	}
 
 	/* either find an old parent or attach a new one */
-	parent = audit_find_parent(d_backing_inode(parent_path.dentry));
+	parent = audit_find_parent(d_inode(parent_path.dentry));
 	if (!parent) {
 		parent = audit_init_parent(&parent_path);
 		if (IS_ERR(parent)) {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index addeed3df15d..383b35d7f78b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2125,7 +2125,7 @@ static void handle_path(const struct dentry *dentry)
 	rcu_read_lock();
 	seq = read_seqbegin(&rename_lock);
 	for(;;) {
-		struct inode *inode = d_backing_inode(d);
+		struct inode *inode = d_inode(d);
 
 		if (inode && unlikely(inode->i_fsnotify_marks)) {
 			struct audit_chunk *chunk;
@@ -2292,7 +2292,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 		   unsigned int flags)
 {
 	struct audit_context *context = audit_context();
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct audit_names *n;
 	bool parent = flags & AUDIT_INODE_PARENT;
 	struct audit_entry *e;
@@ -2410,7 +2410,7 @@ void __audit_inode_child(struct inode *parent,
 			 const unsigned char type)
 {
 	struct audit_context *context = audit_context();
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	const struct qstr *dname = &dentry->d_name;
 	struct audit_names *n, *found_parent = NULL, *found_child = NULL;
 	struct audit_entry *e;
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9948b542a470..7bd7ab54a794 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -507,7 +507,7 @@ static void *bpf_obj_do_get(const char __user *pathname,
 	if (ret)
 		return ERR_PTR(ret);
 
-	inode = d_backing_inode(path.dentry);
+	inode = d_inode(path.dentry);
 	ret = path_permission(&path, ACC_MODE(flags));
 	if (ret)
 		goto out;
@@ -590,7 +590,7 @@ struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type typ
 	int ret = kern_path(name, LOOKUP_FOLLOW, &path);
 	if (ret)
 		return ERR_PTR(ret);
-	prog = __get_prog_inode(d_backing_inode(path.dentry), type);
+	prog = __get_prog_inode(d_inode(path.dentry), type);
 	if (!IS_ERR(prog))
 		touch_atime(&path);
 	path_put(&path);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0b0f18ecce44..38fe6efb2644 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -394,7 +394,7 @@ static struct sock *unix_find_socket_byinode(struct inode *i)
 	sk_for_each_bound(s, &bsd_socket_buckets[hash]) {
 		struct dentry *dentry = unix_sk(s)->path.dentry;
 
-		if (dentry && d_backing_inode(dentry) == i) {
+		if (dentry && d_inode(dentry) == i) {
 			sock_hold(s);
 			spin_unlock(&bsd_socket_locks[hash]);
 			return s;
@@ -1063,7 +1063,7 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 		goto path_put;
 
 	err = -ECONNREFUSED;
-	inode = d_backing_inode(path.dentry);
+	inode = d_inode(path.dentry);
 	if (!S_ISSOCK(inode->i_mode))
 		goto path_put;
 
@@ -1230,7 +1230,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	if (u->addr)
 		goto out_unlock;
 
-	new_hash = unix_bsd_hash(d_backing_inode(dentry));
+	new_hash = unix_bsd_hash(d_inode(dentry));
 	unix_table_double_lock(net, old_hash, new_hash);
 	u->path.mnt = mntget(parent.mnt);
 	u->path.dentry = dget(dentry);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 616b55c5b890..88e2e64a6829 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -30,7 +30,7 @@ static int sk_diag_dump_vfs(struct sock *sk, struct sk_buff *nlskb)
 
 	if (dentry) {
 		struct unix_diag_vfs uv = {
-			.udiag_vfs_ino = d_backing_inode(dentry)->i_ino,
+			.udiag_vfs_ino = d_inode(dentry)->i_ino,
 			.udiag_vfs_dev = dentry->d_sb->s_dev,
 		};
 
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 9119ddda6217..2ae87503ad6f 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -409,8 +409,8 @@ int aa_path_link(struct aa_label *label, struct dentry *old_dentry,
 	struct path link = { .mnt = new_dir->mnt, .dentry = new_dentry };
 	struct path target = { .mnt = new_dir->mnt, .dentry = old_dentry };
 	struct path_cond cond = {
-		d_backing_inode(old_dentry)->i_uid,
-		d_backing_inode(old_dentry)->i_mode
+		d_inode(old_dentry)->i_uid,
+		d_inode(old_dentry)->i_mode
 	};
 	char *buffer = NULL, *buffer2 = NULL;
 	struct aa_profile *profile;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d6cc4812ca53..6c6a3560603a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -228,10 +228,10 @@ static int common_perm(const char *op, const struct path *path, u32 mask,
 static int common_perm_cond(const char *op, const struct path *path, u32 mask)
 {
 	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_idmap(path->mnt),
-					    d_backing_inode(path->dentry));
+					    d_inode(path->dentry));
 	struct path_cond cond = {
 		vfsuid_into_kuid(vfsuid),
-		d_backing_inode(path->dentry)->i_mode
+		d_inode(path->dentry)->i_mode
 	};
 
 	if (!path_mediated_fs(path->dentry))
@@ -271,7 +271,7 @@ static int common_perm_dir_dentry(const char *op, const struct path *dir,
 static int common_perm_rm(const char *op, const struct path *dir,
 			  struct dentry *dentry, u32 mask)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct path_cond cond = { };
 	vfsuid_t vfsuid;
 
@@ -384,16 +384,16 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 		struct path new_path = { .mnt = new_dir->mnt,
 					 .dentry = new_dentry };
 		struct path_cond cond = {
-			.mode = d_backing_inode(old_dentry)->i_mode
+			.mode = d_inode(old_dentry)->i_mode
 		};
-		vfsuid = i_uid_into_vfsuid(idmap, d_backing_inode(old_dentry));
+		vfsuid = i_uid_into_vfsuid(idmap, d_inode(old_dentry));
 		cond.uid = vfsuid_into_kuid(vfsuid);
 
 		if (flags & RENAME_EXCHANGE) {
 			struct path_cond cond_exchange = {
-				.mode = d_backing_inode(new_dentry)->i_mode,
+				.mode = d_inode(new_dentry)->i_mode,
 			};
-			vfsuid = i_uid_into_vfsuid(idmap, d_backing_inode(old_dentry));
+			vfsuid = i_uid_into_vfsuid(idmap, d_inode(old_dentry));
 			cond_exchange.uid = vfsuid_into_kuid(vfsuid);
 
 			error = aa_path_perm(OP_RENAME_SRC, label, &new_path, 0,
diff --git a/security/commoncap.c b/security/commoncap.c
index 5bb7d1e96277..1f5753673608 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -295,7 +295,7 @@ int cap_capset(struct cred *new,
  */
 int cap_inode_need_killpriv(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	int error;
 
 	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
@@ -533,7 +533,7 @@ int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
 	uid_t nsrootid;
 	const struct vfs_cap_data *cap = *ivalue;
 	__u32 magic, nsmagic;
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct user_namespace *task_ns = current_user_ns(),
 		*fs_ns = inode->i_sb->s_user_ns;
 	kuid_t rootid;
@@ -636,7 +636,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
 			   struct cpu_vfs_cap_data *cpu_caps)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	__u32 magic_etc;
 	int size;
 	struct vfs_ns_cap_data data, *nscaps = &data;
@@ -1039,7 +1039,7 @@ int cap_inode_removexattr(struct mnt_idmap *idmap,
 
 	if (strcmp(name, XATTR_NAME_CAPS) == 0) {
 		/* security.capability gets namespaced */
-		struct inode *inode = d_backing_inode(dentry);
+		struct inode *inode = d_inode(dentry);
 		if (!inode)
 			return -EINVAL;
 		if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 033804f5a5f2..754ccba4c1dd 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				 size_t req_xattr_value_len,
 				 uint8_t type, struct evm_digest *data)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct xattr_list *xattr;
 	struct shash_desc *desc;
 	size_t xattr_size = 0;
@@ -356,7 +356,7 @@ static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
 int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 			const char *xattr_value, size_t xattr_value_len)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct evm_digest data;
 	int rc = 0;
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index cf24c5255583..3d1b5b7cc9aa 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -130,7 +130,7 @@ static bool evm_hmac_disabled(void)
 
 static int evm_find_protected_xattrs(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct xattr_list *xattr;
 	int error;
 	int count = 0;
@@ -240,7 +240,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					(const char *)xattr_data, xattr_len,
 					digest.digest, digest.hdr.length);
 		if (!rc) {
-			inode = d_backing_inode(dentry);
+			inode = d_inode(dentry);
 
 			if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG) {
 				if (iint)
@@ -337,7 +337,7 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 	int rc, size, total_size = 0;
 
 	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
-		rc = __vfs_getxattr(dentry, d_backing_inode(dentry),
+		rc = __vfs_getxattr(dentry, d_inode(dentry),
 				    xattr->name, NULL, 0);
 		if (rc < 0 && rc == -ENODATA)
 			continue;
@@ -367,7 +367,7 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 			size = rc;
 			if (buffer) {
 				rc = __vfs_getxattr(dentry,
-					d_backing_inode(dentry), xattr->name,
+					d_inode(dentry), xattr->name,
 					buffer + total_size,
 					buffer_size - total_size);
 				if (rc < 0)
@@ -409,7 +409,7 @@ enum integrity_status evm_verifyxattr(struct dentry *dentry,
 		return INTEGRITY_UNKNOWN;
 
 	if (!iint) {
-		iint = integrity_iint_find(d_backing_inode(dentry));
+		iint = integrity_iint_find(d_inode(dentry));
 		if (!iint)
 			return INTEGRITY_UNKNOWN;
 	}
@@ -427,7 +427,7 @@ EXPORT_SYMBOL_GPL(evm_verifyxattr);
  */
 static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 
 	if (!evm_key_loaded() || !S_ISREG(inode->i_mode) || evm_fixmode)
 		return INTEGRITY_PASS;
@@ -509,7 +509,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 		if (evm_hmac_disabled())
 			return 0;
 
-		iint = integrity_iint_find(d_backing_inode(dentry));
+		iint = integrity_iint_find(d_inode(dentry));
 		if (iint && (iint->flags & IMA_NEW_FILE))
 			return 0;
 
@@ -544,7 +544,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 
 	if (evm_status != INTEGRITY_PASS &&
 	    evm_status != INTEGRITY_PASS_IMMUTABLE)
-		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
+		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
 				    integrity_status_msg[evm_status],
 				    -EPERM, 0);
@@ -617,7 +617,7 @@ static int evm_inode_set_acl_change(struct mnt_idmap *idmap,
 	int rc;
 
 	umode_t mode;
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 
 	if (!kacl)
 		return 1;
@@ -682,7 +682,7 @@ int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		return 0;
 
 	if (evm_status != INTEGRITY_PASS_IMMUTABLE)
-		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
+		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
 				    integrity_status_msg[evm_status],
 				    -EPERM, 0);
@@ -782,7 +782,7 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 static int evm_attr_change(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
 
 	if (!i_uid_needs_update(idmap, attr, inode) &&
@@ -830,7 +830,7 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	    !evm_attr_change(idmap, dentry, attr))
 		return 0;
 
-	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
+	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
 			    integrity_status_msg[evm_status], -EPERM, 0);
 	return -EPERM;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 491c1aca0b1c..a056a1b90070 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -484,7 +484,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	static const char op[] = "appraise_data";
 	const char *cause = "unknown";
 	struct dentry *dentry = file_dentry(file);
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
@@ -636,7 +636,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 void ima_inode_post_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct integrity_iint_cache *iint;
 	int action;
 
@@ -770,7 +770,7 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
 	}
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
-		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
+		ima_reset_appraise_flags(d_inode(dentry), digsig);
 		if (result == 1)
 			result = 0;
 	}
@@ -781,7 +781,7 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const char *acl_name, struct posix_acl *kacl)
 {
 	if (evm_revalidate_status(acl_name))
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		ima_reset_appraise_flags(d_inode(dentry), 0);
 
 	return 0;
 }
@@ -792,7 +792,7 @@ int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		ima_reset_appraise_flags(d_inode(dentry), 0);
 		if (result == 1)
 			result = 0;
 	}
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index adcea0fe7e68..2287aa58ead0 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -181,7 +181,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	access_rights |=
 		LANDLOCK_MASK_ACCESS_FS &
 		~(ruleset->fs_access_masks[0] | ACCESS_INITIALLY_DENIED);
-	object = get_inode_object(d_backing_inode(path->dentry));
+	object = get_inode_object(d_inode(path->dentry));
 	if (IS_ERR(object))
 		return PTR_ERR(object);
 	mutex_lock(&ruleset->lock);
@@ -213,7 +213,7 @@ find_rule(const struct landlock_ruleset *const domain,
 	if (d_is_negative(dentry))
 		return NULL;
 
-	inode = d_backing_inode(dentry);
+	inode = d_inode(dentry);
 	rcu_read_lock();
 	rule = landlock_find_rule(
 		domain, rcu_dereference(landlock_inode(inode)->object));
@@ -284,7 +284,7 @@ static inline bool is_nouser_or_private(const struct dentry *dentry)
 {
 	return (dentry->d_sb->s_flags & SB_NOUSER) ||
 	       (d_is_positive(dentry) &&
-		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
+		unlikely(IS_PRIVATE(d_inode(dentry))));
 }
 
 static inline access_mask_t
@@ -833,12 +833,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		if (unlikely(d_is_negative(new_dentry)))
 			return -ENOENT;
 		access_request_parent1 =
-			get_mode_access(d_backing_inode(new_dentry)->i_mode);
+			get_mode_access(d_inode(new_dentry)->i_mode);
 	} else {
 		access_request_parent1 = 0;
 	}
 	access_request_parent2 =
-		get_mode_access(d_backing_inode(old_dentry)->i_mode);
+		get_mode_access(d_inode(old_dentry)->i_mode);
 	if (removable) {
 		access_request_parent1 |= maybe_remove(old_dentry);
 		access_request_parent2 |= maybe_remove(new_dentry);
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 245cc650a4dc..3fd22ee41e31 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -262,7 +262,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 	    (f.file->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
 	    (f.file->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
 	    d_is_negative(f.file->f_path.dentry) ||
-	    IS_PRIVATE(d_backing_inode(f.file->f_path.dentry))) {
+	    IS_PRIVATE(d_inode(f.file->f_path.dentry))) {
 		err = -EBADFD;
 		goto out_fdput;
 	}
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index a7355b4b9bb8..7b3e9937d4ad 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -223,7 +223,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 
 		audit_log_d_path(ab, " path=", &a->u.path);
 
-		inode = d_backing_inode(a->u.path.dentry);
+		inode = d_inode(a->u.path.dentry);
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
@@ -267,7 +267,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
 		spin_unlock(&a->u.dentry->d_lock);
 
-		inode = d_backing_inode(a->u.dentry);
+		inode = d_inode(a->u.dentry);
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
diff --git a/security/security.c b/security/security.c
index af83d4eb4f1e..2fe3edd64512 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1175,7 +1175,7 @@ EXPORT_SYMBOL(security_old_inode_init_security);
 int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
 			unsigned int dev)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dir->dentry))))
 		return 0;
 	return call_int_hook(path_mknod, 0, dir, dentry, mode, dev);
 }
@@ -1183,7 +1183,7 @@ EXPORT_SYMBOL(security_path_mknod);
 
 int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t mode)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dir->dentry))))
 		return 0;
 	return call_int_hook(path_mkdir, 0, dir, dentry, mode);
 }
@@ -1191,14 +1191,14 @@ EXPORT_SYMBOL(security_path_mkdir);
 
 int security_path_rmdir(const struct path *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dir->dentry))))
 		return 0;
 	return call_int_hook(path_rmdir, 0, dir, dentry);
 }
 
 int security_path_unlink(const struct path *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dir->dentry))))
 		return 0;
 	return call_int_hook(path_unlink, 0, dir, dentry);
 }
@@ -1207,7 +1207,7 @@ EXPORT_SYMBOL(security_path_unlink);
 int security_path_symlink(const struct path *dir, struct dentry *dentry,
 			  const char *old_name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dir->dentry))))
 		return 0;
 	return call_int_hook(path_symlink, 0, dir, dentry, old_name);
 }
@@ -1215,7 +1215,7 @@ int security_path_symlink(const struct path *dir, struct dentry *dentry,
 int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
 		       struct dentry *new_dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(old_dentry))))
 		return 0;
 	return call_int_hook(path_link, 0, old_dentry, new_dir, new_dentry);
 }
@@ -1224,8 +1224,8 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 			 const struct path *new_dir, struct dentry *new_dentry,
 			 unsigned int flags)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
-		     (d_is_positive(new_dentry) && IS_PRIVATE(d_backing_inode(new_dentry)))))
+	if (unlikely(IS_PRIVATE(d_inode(old_dentry)) ||
+		     (d_is_positive(new_dentry) && IS_PRIVATE(d_inode(new_dentry)))))
 		return 0;
 
 	return call_int_hook(path_rename, 0, old_dir, old_dentry, new_dir,
@@ -1235,21 +1235,21 @@ EXPORT_SYMBOL(security_path_rename);
 
 int security_path_truncate(const struct path *path)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(path->dentry))))
 		return 0;
 	return call_int_hook(path_truncate, 0, path);
 }
 
 int security_path_chmod(const struct path *path, umode_t mode)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(path->dentry))))
 		return 0;
 	return call_int_hook(path_chmod, 0, path, mode);
 }
 
 int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(path->dentry))))
 		return 0;
 	return call_int_hook(path_chown, 0, path, uid, gid);
 }
@@ -1271,14 +1271,14 @@ EXPORT_SYMBOL_GPL(security_inode_create);
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(old_dentry))))
 		return 0;
 	return call_int_hook(inode_link, 0, old_dentry, dir, new_dentry);
 }
 
 int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_unlink, 0, dir, dentry);
 }
@@ -1301,7 +1301,7 @@ EXPORT_SYMBOL_GPL(security_inode_mkdir);
 
 int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_rmdir, 0, dir, dentry);
 }
@@ -1317,8 +1317,8 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
-	    (d_is_positive(new_dentry) && IS_PRIVATE(d_backing_inode(new_dentry)))))
+	if (unlikely(IS_PRIVATE(d_inode(old_dentry)) ||
+	    (d_is_positive(new_dentry) && IS_PRIVATE(d_inode(new_dentry)))))
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
@@ -1334,7 +1334,7 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 int security_inode_readlink(struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_readlink, 0, dentry);
 }
@@ -1359,7 +1359,7 @@ int security_inode_setattr(struct mnt_idmap *idmap,
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	ret = call_int_hook(inode_setattr, 0, dentry, attr);
 	if (ret)
@@ -1370,7 +1370,7 @@ EXPORT_SYMBOL_GPL(security_inode_setattr);
 
 int security_inode_getattr(const struct path *path)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(path->dentry))))
 		return 0;
 	return call_int_hook(inode_getattr, 0, path);
 }
@@ -1381,7 +1381,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	/*
 	 * SELinux and Smack integrate the cap call,
@@ -1406,7 +1406,7 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
 			    kacl);
@@ -1421,7 +1421,7 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 int security_inode_get_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_get_acl, 0, idmap, dentry, acl_name);
 }
@@ -1431,7 +1431,7 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
 	if (ret)
@@ -1445,7 +1445,7 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return;
 	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
 	evm_inode_post_setxattr(dentry, name, value, size);
@@ -1453,14 +1453,14 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 
 int security_inode_getxattr(struct dentry *dentry, const char *name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_getxattr, 0, dentry, name);
 }
 
 int security_inode_listxattr(struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_listxattr, 0, dentry);
 }
@@ -1470,7 +1470,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	/*
 	 * SELinux and Smack integrate the cap call,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9a5bdfc21314..734f64e83b48 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -298,7 +298,7 @@ static struct inode_security_struct *inode_security(struct inode *inode)
 
 static struct inode_security_struct *backing_inode_security_novalidate(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 
 	return selinux_inode(inode);
 }
@@ -308,7 +308,7 @@ static struct inode_security_struct *backing_inode_security_novalidate(struct de
  */
 static struct inode_security_struct *backing_inode_security(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 
 	__inode_security_revalidate(inode, dentry, true);
 	return selinux_inode(inode);
@@ -478,7 +478,7 @@ static int sb_check_xattr_support(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
-	struct inode *root_inode = d_backing_inode(root);
+	struct inode *root_inode = d_inode(root);
 	u32 sid;
 	int rc;
 
@@ -527,7 +527,7 @@ static int sb_finish_set_opts(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
-	struct inode *root_inode = d_backing_inode(root);
+	struct inode *root_inode = d_inode(root);
 	int rc = 0;
 
 	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
@@ -1640,7 +1640,7 @@ static inline int dentry_has_perm(const struct cred *cred,
 				  struct dentry *dentry,
 				  u32 av)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct common_audit_data ad;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
@@ -1656,7 +1656,7 @@ static inline int path_has_perm(const struct cred *cred,
 				const struct path *path,
 				u32 av)
 {
-	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *inode = d_inode(path->dentry);
 	struct common_audit_data ad;
 
 	ad.type = LSM_AUDIT_DATA_PATH;
@@ -2057,7 +2057,7 @@ static int selinux_binder_transfer_file(const struct cred *from,
 		return rc;
 #endif
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 
 	isec = backing_inode_security(dentry);
@@ -3103,7 +3103,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
 	const struct cred *cred = current_cred();
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = iattr->ia_valid;
 	__u32 av = FILE__WRITE;
 
@@ -3149,7 +3149,7 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 				  struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct inode_security_struct *isec;
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
@@ -3263,7 +3263,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 					const void *value, size_t size,
 					int flags)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct inode_security_struct *isec;
 	u32 newsid;
 	int rc;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index cfcbb748da25..b5c4a2b0830e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -755,7 +755,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 		unsigned long *set_kern_flags)
 {
 	struct dentry *root = sb->s_root;
-	struct inode *inode = d_backing_inode(root);
+	struct inode *inode = d_inode(root);
 	struct superblock_smack *sp = smack_superblock(sb);
 	struct inode_smack *isp;
 	struct smack_known *skp;
@@ -1004,15 +1004,15 @@ static int smack_inode_link(struct dentry *old_dentry, struct inode *dir,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, old_dentry);
 
-	isp = smk_of_inode(d_backing_inode(old_dentry));
+	isp = smk_of_inode(d_inode(old_dentry));
 	rc = smk_curacc(isp, MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(old_dentry), MAY_WRITE, rc);
+	rc = smk_bu_inode(d_inode(old_dentry), MAY_WRITE, rc);
 
 	if (rc == 0 && d_is_positive(new_dentry)) {
-		isp = smk_of_inode(d_backing_inode(new_dentry));
+		isp = smk_of_inode(d_inode(new_dentry));
 		smk_ad_setfield_u_fs_path_dentry(&ad, new_dentry);
 		rc = smk_curacc(isp, MAY_WRITE, &ad);
-		rc = smk_bu_inode(d_backing_inode(new_dentry), MAY_WRITE, rc);
+		rc = smk_bu_inode(d_inode(new_dentry), MAY_WRITE, rc);
 	}
 
 	return rc;
@@ -1028,7 +1028,7 @@ static int smack_inode_link(struct dentry *old_dentry, struct inode *dir,
  */
 static int smack_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct inode *ip = d_backing_inode(dentry);
+	struct inode *ip = d_inode(dentry);
 	struct smk_audit_info ad;
 	int rc;
 
@@ -1071,8 +1071,8 @@ static int smack_inode_rmdir(struct inode *dir, struct dentry *dentry)
 	/*
 	 * You need write access to the thing you're removing
 	 */
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	if (rc == 0) {
 		/*
 		 * You also need write access to the containing directory
@@ -1110,15 +1110,15 @@ static int smack_inode_rename(struct inode *old_inode,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, old_dentry);
 
-	isp = smk_of_inode(d_backing_inode(old_dentry));
+	isp = smk_of_inode(d_inode(old_dentry));
 	rc = smk_curacc(isp, MAY_READWRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(old_dentry), MAY_READWRITE, rc);
+	rc = smk_bu_inode(d_inode(old_dentry), MAY_READWRITE, rc);
 
 	if (rc == 0 && d_is_positive(new_dentry)) {
-		isp = smk_of_inode(d_backing_inode(new_dentry));
+		isp = smk_of_inode(d_inode(new_dentry));
 		smk_ad_setfield_u_fs_path_dentry(&ad, new_dentry);
 		rc = smk_curacc(isp, MAY_READWRITE, &ad);
-		rc = smk_bu_inode(d_backing_inode(new_dentry), MAY_READWRITE, rc);
+		rc = smk_bu_inode(d_inode(new_dentry), MAY_READWRITE, rc);
 	}
 	return rc;
 }
@@ -1181,8 +1181,8 @@ static int smack_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	return rc;
 }
 
@@ -1195,7 +1195,7 @@ static int smack_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 static int smack_inode_getattr(const struct path *path)
 {
 	struct smk_audit_info ad;
-	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *inode = d_inode(path->dentry);
 	int rc;
 
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
@@ -1266,8 +1266,8 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
 	if (rc == 0) {
-		rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-		rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+		rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+		rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	}
 
 	return rc;
@@ -1288,7 +1288,7 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 				      const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *isp = smack_inode(d_backing_inode(dentry));
+	struct inode_smack *isp = smack_inode(d_inode(dentry));
 
 	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
@@ -1327,8 +1327,8 @@ static int smack_inode_getxattr(struct dentry *dentry, const char *name)
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_READ, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_READ, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_READ, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_READ, rc);
 	return rc;
 }
 
@@ -1366,12 +1366,12 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	if (rc != 0)
 		return rc;
 
-	isp = smack_inode(d_backing_inode(dentry));
+	isp = smack_inode(d_inode(dentry));
 	/*
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
@@ -1411,8 +1411,8 @@ static int smack_inode_set_acl(struct mnt_idmap *idmap,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	return rc;
 }
 
@@ -1433,8 +1433,8 @@ static int smack_inode_get_acl(struct mnt_idmap *idmap,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_READ, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_READ, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_READ, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_READ, rc);
 	return rc;
 }
 
@@ -1455,8 +1455,8 @@ static int smack_inode_remove_acl(struct mnt_idmap *idmap,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	return rc;
 }
 
diff --git a/security/tomoyo/condition.c b/security/tomoyo/condition.c
index f8bcc083bb0d..c7e1bfd3ef72 100644
--- a/security/tomoyo/condition.c
+++ b/security/tomoyo/condition.c
@@ -735,7 +735,7 @@ void tomoyo_get_attributes(struct tomoyo_obj_info *obj)
 			dentry = dget_parent(dentry);
 			break;
 		}
-		inode = d_backing_inode(dentry);
+		inode = d_inode(dentry);
 		if (inode) {
 			struct tomoyo_mini_stat *stat = &obj->stat[i];
 
diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
index 1c483ee7f93d..e4eda5a4df4f 100644
--- a/security/tomoyo/realpath.c
+++ b/security/tomoyo/realpath.c
@@ -100,7 +100,7 @@ static char *tomoyo_get_absolute_path(const struct path *path, char * const buff
 		/* go to whatever namespace root we are under */
 		pos = d_absolute_path(path, buffer, buflen - 1);
 		if (!IS_ERR(pos) && *pos == '/' && pos[1]) {
-			struct inode *inode = d_backing_inode(path->dentry);
+			struct inode *inode = d_inode(path->dentry);
 
 			if (inode && S_ISDIR(inode->i_mode)) {
 				buffer[buflen - 2] = '/';
@@ -130,7 +130,7 @@ static char *tomoyo_get_dentry_path(struct dentry *dentry, char * const buffer,
 	if (buflen >= 256) {
 		pos = dentry_path_raw(dentry, buffer, buflen - 1);
 		if (!IS_ERR(pos) && *pos == '/' && pos[1]) {
-			struct inode *inode = d_backing_inode(dentry);
+			struct inode *inode = d_inode(dentry);
 
 			if (inode && S_ISDIR(inode->i_mode)) {
 				buffer[buflen - 2] = '/';
@@ -177,7 +177,7 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
 	if (!MAJOR(sb->s_dev))
 		goto prepend_filesystem_name;
 	{
-		struct inode *inode = d_backing_inode(sb->s_root);
+		struct inode *inode = d_inode(sb->s_root);
 
 		/*
 		 * Use filesystem name if filesystem does not support rename()
@@ -258,7 +258,7 @@ char *tomoyo_realpath_from_path(const struct path *path)
 			pos = dentry->d_op->d_dname(dentry, buf, buf_len - 1);
 			goto encode;
 		}
-		inode = d_backing_inode(sb->s_root);
+		inode = d_inode(sb->s_root);
 		/*
 		 * Get local name for filesystems without rename() operation
 		 */
-- 
2.25.1

