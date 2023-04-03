Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341E56D4A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjDCOro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjDCOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:47:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CBE29BE2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:42 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F6233F57D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533150;
        bh=CML0MX+E6RHRMEZDuKLkjuHXCZn0KNZeg1m8eYp9u4Q=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=b7OYEYkG1Xf77jtOGLCV/1MDNd/skiChtKPzO0+m/hc2hjPKjb64I7fmXOg7UtNGX
         GXBuuFIo4Rj6BVIt1IhYkCkFY4n6SeTwLiJmyn+zxtw5rEkZJ5mlwrxGTQkjRnFO74
         4Jrz/BQWKXE9eI7PfvEBT9ZMM3IO1vG1FcD8sXyUIcG4z85Zr8FmB4rtB/10d9vgzg
         DivbyFHxmG6bn4DlGHX/qHV/yrm4aOMpYfj5IPIkvnjFQQ/x+b8uvsnByF0SKpr6MC
         eNym/Ed/5dWC2zl94otk5Y2LM67Khy7MiT0yMxdQp5Z/484f7Ccajgtpvehr4mmgfu
         qFIvWYpvyXWSQ==
Received: by mail-ed1-f71.google.com with SMTP id v1-20020a50d581000000b0050291cda08aso7957470edi.15
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CML0MX+E6RHRMEZDuKLkjuHXCZn0KNZeg1m8eYp9u4Q=;
        b=QK9sN9hTUIeEt/clzcntwWd/aFPekw5v8FQrk05d9el8MEQn6+Pr/7ZllNKNvUKYbx
         FQwuZRJTieaoZw/aD1R/BwnZe/I57/nrf5oR4hXExVf/flqHAbSSK47fDI+rWRSoyo5n
         Yxfk3dOirC9myscJ0awjTpt7cHdLwq00uU5NdEAs2VKd8uRMoOwRy5rO40COcmikSeGX
         9yN7PbI08PQTSjWvHTro7eRTlVWTbiSXr3Sxl3wJzStsfIxm+ChOCN5dh7if2MBIaHD8
         PWlT8v27q5gi0LI/FCtLZZoUDMyXHH2xS9uUhKRA+GM0bRV0m1cLT0EfNPs3GH1WuNS1
         yyZQ==
X-Gm-Message-State: AAQBX9f4A2fiPxkTFe0zJdhOmH6hWfzKYxkcTYv27ONAhmmLb594GDy/
        vpJvX3L68clXMKBJdcwiYonp9wkX8L77Cs+Cmy00PCBh63v7KI1cPE8n1d/WoNaOZMdy457l2yP
        GoNDFC1rPhrilg0UYdQ+huiLpfMmslMzLZWEKZA6sJA==
X-Received: by 2002:a05:6402:215:b0:502:9c52:447f with SMTP id t21-20020a056402021500b005029c52447fmr4105688edv.17.1680533148976;
        Mon, 03 Apr 2023 07:45:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350btyKXZRMoX7/M0+6dUdIKd3K9ydJ1W9baKVdPNFK7DJGhr7naoKrIONWiKDmdxp0+zXVLfPg==
X-Received: by 2002:a05:6402:215:b0:502:9c52:447f with SMTP id t21-20020a056402021500b005029c52447fmr4105680edv.17.1680533148816;
        Mon, 03 Apr 2023 07:45:48 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm4735804edj.79.2023.04.03.07.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:48 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     flyingpeng@tencent.com,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH v2 8/9] namespace: add sb_revalidate_bindmounts helper
Date:   Mon,  3 Apr 2023 16:45:16 +0200
Message-Id: <20230403144517.347517-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/namespace.c                | 90 +++++++++++++++++++++++++++++++++++
 include/linux/mnt_namespace.h |  3 ++
 2 files changed, 93 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index bc0f15257b49..b74d00d6abb0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -568,6 +568,96 @@ static int mnt_make_readonly(struct mount *mnt)
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

