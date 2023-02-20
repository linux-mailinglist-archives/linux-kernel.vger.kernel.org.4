Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED2E69D436
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjBTTjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjBTTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:42 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2281C7C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:30 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B850B3F596
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921904;
        bh=TXvnYBcpsks2j9HUsorAhOJizmKzS+zfkd4wCIIYO2g=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=XYNp8m6qvmxD6Lm+DWbqEUlyF8PVxsJYXEK86l57UZnCev4zBHNcn1PFEuhB2yoA0
         LhyDgwTcxUhR1yfi/Zj3noVZ1Bb7gp70R1JK+jgM8PLiD8q6pa2OIPeKufBbZZBQ85
         pkLzFabmaH00GO5snIDaLRp+oIKUPB8zWhmAC0rQxIwvwk8Y0Lz9frucO0kZMXb5KZ
         Qrew6sZhp+vNdp02+6zs9E07qNIbQ50XNrBrRC9YnmTly+b10S74R7jpJ+aBAXPEct
         opHMyz4AFyTBCdbBqIfmdJVXHwgiYe+nEK4aIzN1rPH9W7qwhyqgwkGuHxpfOORz+h
         TRhhMmo6E7Ghg==
Received: by mail-ed1-f70.google.com with SMTP id fi8-20020a056402550800b004a26cc7f6cbso2737929edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXvnYBcpsks2j9HUsorAhOJizmKzS+zfkd4wCIIYO2g=;
        b=2N982dvW2bLIshN9VwGuGJhQ07ZNIASg/IDSlHZPTdpxpICCufzi24CCO/5+s2xxmO
         t5N2JLdkjtoRzMCoG18LNm+YbFuVOIm8dskEys+p8GZYqcp02FNssy5mzc2Iac/uSNKM
         4QPgMnxIJ6xS2Mp4FAUyeK1ZwNpdNQELTSyFt04NGz5iZzys2AoN+869L/QP3T9uCucW
         PXjuyxpAulaxjzrG6bhTQ06a8h9pYVH/8Dqqgx4celaq3GPx2QXPivfc2lNoIPzQV6y/
         QePtdNe3QhB71qykdpMUCeOirI0PmHZIloPDlzHf9CL2spW7R7bA41q5uXRG8WcyFgu+
         JMeA==
X-Gm-Message-State: AO0yUKXrXcPrRc4KTIv0S4cyyZKGDCoOhaua2yEla12acyFrcnTr1qG3
        yCJm6v0NsZON1zfDn0tzP5N6zVfsjpR2tFBE1GL8lqdcXMDZJJeorDnmFIKNpWe38Bdh0wtZ4sh
        pu10EUH50hrfzLWZOoKXX98oJWhALXkvVUFfMys8wkg==
X-Received: by 2002:a17:906:fcd5:b0:8b1:81eb:158f with SMTP id qx21-20020a170906fcd500b008b181eb158fmr13780364ejb.62.1676921904506;
        Mon, 20 Feb 2023 11:38:24 -0800 (PST)
X-Google-Smtp-Source: AK7set+zc9gLLqzwJi8cf9vJZoGnswWczh9rYsXB3je/ww+BatP9c9Egec/MMFNNrEczNQTJZ5/tGw==
X-Received: by 2002:a17:906:fcd5:b0:8b1:81eb:158f with SMTP id qx21-20020a170906fcd500b008b181eb158fmr13780341ejb.62.1676921904319;
        Mon, 20 Feb 2023 11:38:24 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:23 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH 8/9] namespace: add sb_revalidate_bindmounts helper
Date:   Mon, 20 Feb 2023 20:37:53 +0100
Message-Id: <20230220193754.470330-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful if for some reason bindmounts root dentries get invalidated
but it's needed to revalidate existing bindmounts without remounting.

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/namespace.c                | 90 +++++++++++++++++++++++++++++++++++
 include/linux/mnt_namespace.h |  3 ++
 2 files changed, 93 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab467ee58341..88491f9c8bbd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -682,6 +682,96 @@ static int mnt_make_readonly(struct mount *mnt)
 	return ret;
 }
 
+struct bind_mount_list_item {
+	struct list_head list;
+	struct vfsmount *mnt;
+};
+
+/*
+ * sb_revalidate_bindmounts - Relookup/reset bindmounts root dentries
+ *
+ * Useful if for some reason bindmount root dentries get invalidated
+ * but it's needed to revalidate existing bindmounts without remounting.
+ */
+int sb_revalidate_bindmounts(struct super_block *sb)
+{
+	struct mount *mnt;
+	struct bind_mount_list_item *bmnt, *next;
+	int err = 0;
+	struct vfsmount *root_mnt = NULL;
+	LIST_HEAD(mnt_to_update);
+	char *buf;
+
+	buf = (char *) __get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	lock_mount_hash();
+	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
+		/* we only want to touch bindmounts */
+		if (mnt->mnt.mnt_root == sb->s_root) {
+			if (!root_mnt)
+				root_mnt = mntget(&mnt->mnt);
+
+			continue;
+		}
+
+		bmnt = kzalloc(sizeof(struct bind_mount_list_item), GFP_NOWAIT | __GFP_NOWARN);
+		if (!bmnt) {
+			err = -ENOMEM;
+			goto exit;
+		}
+
+		bmnt->mnt = mntget(&mnt->mnt);
+		list_add_tail(&bmnt->list, &mnt_to_update);
+	}
+	unlock_mount_hash();
+
+	/* TODO: get rid of this limitation */
+	if (!root_mnt) {
+		err = -ENOENT;
+		goto exit;
+	}
+
+	list_for_each_entry_safe(bmnt, next, &mnt_to_update, list) {
+		struct vfsmount *cur_mnt = bmnt->mnt;
+		struct path path;
+		struct dentry *old_root;
+		char *p;
+
+		p = dentry_path(cur_mnt->mnt_root, buf, PAGE_SIZE);
+		if (IS_ERR(p))
+			goto exit;
+
+		/* TODO: are these lookup flags fully safe and correct? */
+		err = vfs_path_lookup(root_mnt->mnt_root, root_mnt,
+				p, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT|LOOKUP_REVAL, &path);
+		if (err)
+			goto exit;
+
+		/* replace bindmount root dentry */
+		lock_mount_hash();
+		old_root = cur_mnt->mnt_root;
+		cur_mnt->mnt_root = dget(path.dentry);
+		dput(old_root);
+		unlock_mount_hash();
+
+		path_put(&path);
+	}
+
+exit:
+	free_page((unsigned long) buf);
+	mntput(root_mnt);
+	list_for_each_entry_safe(bmnt, next, &mnt_to_update, list) {
+		list_del(&bmnt->list);
+		mntput(bmnt->mnt);
+		kfree(bmnt);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(sb_revalidate_bindmounts);
+
 int sb_prepare_remount_readonly(struct super_block *sb)
 {
 	struct mount *mnt;
diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
index 8f882f5881e8..20ac29e702f5 100644
--- a/include/linux/mnt_namespace.h
+++ b/include/linux/mnt_namespace.h
@@ -3,6 +3,7 @@
 #define _NAMESPACE_H_
 #ifdef __KERNEL__
 
+struct super_block;
 struct mnt_namespace;
 struct fs_struct;
 struct user_namespace;
@@ -13,6 +14,8 @@ extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
 extern void put_mnt_ns(struct mnt_namespace *ns);
 extern struct ns_common *from_mnt_ns(struct mnt_namespace *);
 
+extern int sb_revalidate_bindmounts(struct super_block *sb);
+
 extern const struct file_operations proc_mounts_operations;
 extern const struct file_operations proc_mountinfo_operations;
 extern const struct file_operations proc_mountstats_operations;
-- 
2.34.1

