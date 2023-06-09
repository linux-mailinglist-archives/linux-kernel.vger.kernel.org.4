Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152647295E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbjFIJv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjFIJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:51:16 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108EC7AA5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:44:24 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 437293F7F6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303188;
        bh=NTRbvFaxBJiBjzqaGA2aiDfNbGvJPFM8L4tecTGSATY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=c81609pkRXrliN6J5+Wk08J9hlXSHMh/dHTCxQpCjJKCfgDAXMkq860l1M77DEYS+
         cHMCcIr6znlMT647dDztb2Tdaqzv2MiXJ/XRN7KCMza1+n+h0rgKKLaz3N9tTb11gw
         XLUFcULb+uFSYARLC0mJXzhf8lvMtl7eBFphdlcYAnpCuLCCuegM/5U9siOH8Iancw
         Si4Qng4q211NFijfYEUm0JpfFhA4JrugY8UzlctkyofBZ92Q+3m5xQaUIZVcpOv9gc
         BWOsg2N5Idr8hsvMyyX0U5lpS5qKcV9htOxI34SK32aHI/jBvSQ7ndEPknzuo1beUt
         MalpqFXNSqoZQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a341efd9aso188696866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303188; x=1688895188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTRbvFaxBJiBjzqaGA2aiDfNbGvJPFM8L4tecTGSATY=;
        b=Yx1luc++t4TbgtVbRLVexbBYMCNconxSJwcIY2r4n9vNfaPIAp8Lpb78JzYKeSe61m
         u/oigaL6ZL1ZUMQTY4Ry6iJZXy2MXf2C5vluG2Z0/HnIjbMzuMKQ2uHtzfAMNxrsK4iX
         i0NgNdnon5O3kDWHclkdcyfSwx14HDXWzYsozwPDTM3Vam8EhBrTK4dIk3vdq1nS/usU
         u6f06gwWB2g7y8iB96R8CQ2zcNLEcIwRcQqfQxFaRnN142HKKzhhtwdEZivh1ChGdYH4
         lK0FcwthEWZKTYaiKcTKPFuiLZNq9O2S0piUUI0olit1k3+/JoKzw5vlpFdTeTDafWtv
         xDJQ==
X-Gm-Message-State: AC+VfDyp9x09qNivJb6Wi9dLckoOqvpSOVVKTqBGnOfRYhRCJojG1tcZ
        I2LP7lw5hSes3yebqTdnQILizo4nC7Eau8fePrpdvExFVjIrIZroc+YenxPrm4fnhNDwFN5e7C+
        HGP9C/vJzdLNaMWp9tLBc2/hE9iVimQuunYTa1G+c2w==
X-Received: by 2002:a17:907:2d86:b0:96a:ee54:9f19 with SMTP id gt6-20020a1709072d8600b0096aee549f19mr1483419ejc.48.1686303187976;
        Fri, 09 Jun 2023 02:33:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Z2fKxESvTokZxAA6jO95MDJ55kXGYQIvSjdgXaLQkL7P4nGYdW+Kjdz5sh7oS5H5q3aYmyA==
X-Received: by 2002:a17:907:2d86:b0:96a:ee54:9f19 with SMTP id gt6-20020a1709072d8600b0096aee549f19mr1483409ejc.48.1686303187841;
        Fri, 09 Jun 2023 02:33:07 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:33:07 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/15] ceph: pass idmap to ceph_open/ioctl_set_layout/readdir
Date:   Fri,  9 Jun 2023 11:31:24 +0200
Message-Id: <20230609093125.252186-14-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass an idmapping to:
- ceph_open
- ceph_ioctl_set_layout
- ceph_readdir

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: brauner@kernel.org
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v6:
	- pass idmap to ceph_readdir
---
 fs/ceph/caps.c  | 2 +-
 fs/ceph/dir.c   | 2 ++
 fs/ceph/file.c  | 9 +++++++--
 fs/ceph/ioctl.c | 3 +++
 fs/ceph/super.h | 2 +-
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b432f29e80dd..13c231258153 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3042,7 +3042,7 @@ int __ceph_get_caps(struct mnt_idmap *idmap, struct inode *inode,
 			}
 			if (ret == -EUCLEAN) {
 				/* session was killed, try renew caps */
-				ret = ceph_renew_caps(inode, flags);
+				ret = ceph_renew_caps(idmap, inode, flags);
 				if (ret == 0)
 					continue;
 			}
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 2c0c2c98085b..26335c025f50 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -308,6 +308,7 @@ static bool need_send_readdir(struct ceph_dir_file_info *dfi, loff_t pos)
 static int ceph_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct ceph_dir_file_info *dfi = file->private_data;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
@@ -440,6 +441,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		req->r_inode = inode;
 		ihold(inode);
 		req->r_dentry = dget(file->f_path.dentry);
+		req->r_mnt_idmap = mnt_idmap_get(idmap);
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 		if (err < 0) {
 			ceph_mdsc_put_request(req);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c2bb8f5fd345..9671b0e77faf 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -175,7 +175,8 @@ static void put_bvecs(struct bio_vec *bvecs, int num_bvecs, bool should_dirty)
  * inopportune ENOMEM later.
  */
 static struct ceph_mds_request *
-prepare_open_request(struct super_block *sb, int flags, int create_mode)
+prepare_open_request(struct super_block *sb,
+		     int flags, int create_mode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(sb);
 	struct ceph_mds_request *req;
@@ -293,7 +294,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 /*
  * try renew caps after session gets killed.
  */
-int ceph_renew_caps(struct inode *inode, int fmode)
+int ceph_renew_caps(struct mnt_idmap *idmap, struct inode *inode, int fmode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -336,6 +337,8 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	ihold(inode);
 	req->r_num_caps = 1;
 
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
+
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	ceph_mdsc_put_request(req);
 out:
@@ -356,6 +359,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_file_info *fi = file->private_data;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	int err;
 	int flags, fmode, wanted;
 
@@ -431,6 +435,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	ihold(inode);
 
 	req->r_num_caps = 1;
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	if (!err)
 		err = ceph_init_file(inode, file, req->r_fmode);
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 6fa021b973e5..69efd446a9e1 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -114,6 +114,7 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 	req->r_inode = inode;
 	ihold(inode);
 	req->r_num_caps = 1;
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 
 	req->r_inode_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_FILE_EXCL;
 
@@ -139,6 +140,7 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
 	int err;
@@ -160,6 +162,7 @@ static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 	req->r_inode = inode;
 	ihold(inode);
 	req->r_num_caps = 1;
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 
 	req->r_args.setlayout.layout.fl_stripe_unit =
 			cpu_to_le32(l.stripe_unit);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 05dbae76087c..d89e7b99ac5f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1308,7 +1308,7 @@ static inline bool ceph_has_inline_data(struct ceph_inode_info *ci)
 /* file.c */
 extern const struct file_operations ceph_file_fops;
 
-extern int ceph_renew_caps(struct inode *inode, int fmode);
+extern int ceph_renew_caps(struct mnt_idmap *idmap, struct inode *inode, int fmode);
 extern int ceph_open(struct inode *inode, struct file *file);
 extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			    struct file *file, unsigned flags, umode_t mode);
-- 
2.34.1

