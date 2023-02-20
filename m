Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D8669D42C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjBTTig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjBTTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:24 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A01166E2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:22 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 596163F20F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921899;
        bh=beo/X2fz11pJ2bRdyUmq50n5LTyxWqPc40OR5Kr3NC8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=FmYvGHrRPjqJaf5sLMuKjjo8N0B1ctTJf7uWaxliHmTHoH9GI17DOFl3YSrkK+8dU
         YsiMmAU+ZlTT/UWelf7htVFc6yzXSGBrz1u0qEB4LXek9uDMsB0TM9LImet9nB+cEj
         C2WAYzH/nRCr5DFQHHk0sKuKPRXp8K7wHoI4PuxH65aaI67whJxraQnxK8df0bT+Dp
         UAfHxrmN5j+rJOlnLZCPAVpKeR0w020VcDCTBPcdCfFk7QIvSYbmHZfvzkrviTKio9
         44+P16OANVaWWmmnUjVlJB+jWjmpQscKfM97CzkQC0+LELEI00/ahHKu2YafVytBbG
         Rtst2tN79a0Ww==
Received: by mail-ed1-f70.google.com with SMTP id cy28-20020a0564021c9c00b004acc6cf6322so2975594edb.18
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beo/X2fz11pJ2bRdyUmq50n5LTyxWqPc40OR5Kr3NC8=;
        b=MbRSvfv+TAdqX/9BrMv7YR6qXovai5Z+cq1rH1sA8Rab7srNW0VZ7lykPeSZsHyOvT
         d8/0S0hLmZBBlhaTmrVRRCtHta8ZWBC/jCmzbTKNg2Zmyz6Q5fCZz2ecmzdaWk6N807S
         yGrnk5WuEphZ8iqdRg6YANx+RaEc1XzIDRaUre0XnzlYu4wlwPElw8APKEjZ4+W61YmU
         RwFaJ/42Al7w/yQeLly8otKsd5eVZjIMcIKlm01xsJgs/MFjTnI4KxZ0adevu8qJwlvX
         nsjqLa/VjMLwAGi6ORTAEgZX7EouIzeb4/Y+MR0vQA76eRQuAOS7kDHYfAIacR9keLa8
         NQHg==
X-Gm-Message-State: AO0yUKUPR/0B6GQ3mCK9/87kAA5KtU50Oxif4Mdrd7EC1ppF7AO8OZLX
        Ok5ojbrkdkNXxaovHe1VkuSbscJeBoC8jMsg6WgtK+ljtSKcWh/Ps9w/XulK6WAcF5/WFh4kPlC
        LK0qZhatYuJa2tdMd4y7t5PAZj6xvEZNlJPIxmtosWQ==
X-Received: by 2002:a17:907:7206:b0:8b2:e93:3f59 with SMTP id dr6-20020a170907720600b008b20e933f59mr14113994ejc.31.1676921898110;
        Mon, 20 Feb 2023 11:38:18 -0800 (PST)
X-Google-Smtp-Source: AK7set94lpetJCYjttymkUIDv5boEy6xjxLsVjKM1rFBCySB5S4ehDjioM0ZnWUTTowOPsR6vaw2pg==
X-Received: by 2002:a17:907:7206:b0:8b2:e93:3f59 with SMTP id dr6-20020a170907720600b008b20e933f59mr14113979ejc.31.1676921897964;
        Mon, 20 Feb 2023 11:38:17 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:17 -0800 (PST)
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
Subject: [RFC PATCH 4/9] fuse: handle stale inode connection in fuse_queue_forget
Date:   Mon, 20 Feb 2023 20:37:49 +0100
Message-Id: <20230220193754.470330-5-aleksandr.mikhalitsyn@canonical.com>
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

We don't want to send FUSE_FORGET request to the new
fuse daemon if inode was lookuped by the old fuse daemon
because it can confuse and break userspace (libfuse).

For now, just add a new argument to fuse_queue_forget and
handle it. Adjust all callers to match the old behaviour.

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
 fs/fuse/dev.c    | 4 ++--
 fs/fuse/dir.c    | 8 ++++----
 fs/fuse/fuse_i.h | 2 +-
 fs/fuse/inode.c  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index eb4f88e3dc97..85f69629f34d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -234,7 +234,7 @@ __releases(fiq->lock)
 }
 
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
-		       u64 nodeid, u64 nlookup)
+		       u64 nodeid, u64 nlookup, bool stale_inode_conn)
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
@@ -242,7 +242,7 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 	forget->forget_one.nlookup = nlookup;
 
 	spin_lock(&fiq->lock);
-	if (fiq->connected) {
+	if (fiq->connected && !stale_inode_conn) {
 		fiq->forget_list_tail->next = forget;
 		fiq->forget_list_tail = forget;
 		fiq->ops->wake_forget_and_unlock(fiq);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7f4b29aa7c79..49d91add08bc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -250,7 +250,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			if (outarg.nodeid != get_node_id(inode) ||
 			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
 				fuse_queue_forget(fm->fc, forget,
-						  outarg.nodeid, 1);
+						  outarg.nodeid, 1, false);
 				goto invalid;
 			}
 			spin_lock(&fi->lock);
@@ -405,7 +405,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 			   attr_version);
 	err = -ENOMEM;
 	if (!*inode) {
-		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1, false);
 		goto out;
 	}
 	err = 0;
@@ -692,7 +692,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
-		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1, false);
 		err = -ENOMEM;
 		goto out_err;
 	}
@@ -817,7 +817,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr, entry_attr_timeout(&outarg), 0);
 	if (!inode) {
-		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1, false);
 		return -ENOMEM;
 	}
 	kfree(forget);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ccd7c145de94..ce154e7ab715 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1008,7 +1008,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
  * Send FORGET command
  */
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
-		       u64 nodeid, u64 nlookup);
+		       u64 nodeid, u64 nlookup, bool stale_inode_conn);
 
 struct fuse_forget_link *fuse_alloc_forget(void);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c604434611d9..33a108cfcefe 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -124,7 +124,7 @@ static void fuse_evict_inode(struct inode *inode)
 			fuse_dax_inode_cleanup(inode);
 		if (fi->nlookup) {
 			fuse_queue_forget(fc, fi->forget, fi->nodeid,
-					  fi->nlookup);
+					  fi->nlookup, false);
 			fi->forget = NULL;
 		}
 	}
-- 
2.34.1

