Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D3F66E71C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjAQThW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjAQTer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:34:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07552568B2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=EUivZcn4D/k2WbaC0xKpnhpvHTq2BXzMWX/6Qz6IVBg=; b=eAk6ZFdxvsu2f3/hF4wOdKy8N7
        S9pr9fPTnxKLD1gOKuBKwEnZlmj9F2FJTnnIipQJPe7ULewCY0tpI5B477mdDKJQujSuH0I/PMlip
        4/f850yWSUvMuqUfoljHi4zCsgCIpG8gSnsNh0ZBeYJPIxjr4HKmIIJE7ImblgLtQBnGtRItmh1Ko
        oIWLXEC2X1pF+Bjj+oplH3lAU8G3RD5vXOUO3NR1/j7b3qrQZ4FN2+v6YwvVwyPUxEiSQnbZCaA7E
        3+wrJFjBbZDb80pGXHPil6icyBjREU4OqX5+7sSz1/FF/TD7rv7rZ9Znjq5uk8mwV9YW5idGfjmlq
        Pt+EvKKQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHqqA-00FTmC-Dp; Tue, 17 Jan 2023 18:37:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2] android: fix W=1 kernel-doc warnings
Date:   Tue, 17 Jan 2023 10:37:45 -0800
Message-Id: <20230117183745.20842-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up kernel-doc notation, use correct function and parameter
names.

drivers/android/binderfs.c:236: warning: expecting prototype for binderfs_ctl_ioctl(). Prototype was for binder_ctl_ioctl() instead
drivers/android/binder.c:386: warning: expecting prototype for binder_node_unlock(). Prototype was for binder_node_inner_unlock() instead
drivers/android/binder.c:1206: warning: expecting prototype for binder_dec_ref(). Prototype was for binder_dec_ref_olocked() instead
drivers/andrond/binder.c:284: warning: Excess function parameter 'proc' description in 'binder_proc_unlock'
drivers/andrond/binder.c:387: warning: expecting prototype for binder_node_unlock(). Prototype was for binder_node_inner_unlock() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Christian Brauner <christian@brauner.io>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
---
v2: change one function's param from _proc to proc; (Carlos)
    add Acked-by: Carlos.

 drivers/android/binder.c   |   18 +++++++++---------
 drivers/android/binderfs.c |    4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff -- a/drivers/android/binder.c b/drivers/android/binder.c
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -277,11 +277,11 @@ _binder_proc_lock(struct binder_proc *pr
 
 /**
  * binder_proc_unlock() - Release spinlock for given binder_proc
- * @proc:         struct binder_proc to acquire
+ * @proc:                struct binder_proc to acquire
  *
  * Release lock acquired via binder_proc_lock()
  */
-#define binder_proc_unlock(_proc) _binder_proc_unlock(_proc, __LINE__)
+#define binder_proc_unlock(proc) _binder_proc_unlock(proc, __LINE__)
 static void
 _binder_proc_unlock(struct binder_proc *proc, int line)
 	__releases(&proc->outer_lock)
@@ -378,7 +378,7 @@ _binder_node_inner_lock(struct binder_no
 }
 
 /**
- * binder_node_unlock() - Release node and inner locks
+ * binder_node_inner_unlock() - Release node and inner locks
  * @node:         struct binder_node to acquire
  *
  * Release lock acquired via binder_node_lock()
@@ -1194,13 +1194,13 @@ static int binder_inc_ref_olocked(struct
 }
 
 /**
- * binder_dec_ref() - dec the ref for given handle
+ * binder_dec_ref_olocked() - dec the ref for given handle
  * @ref:	ref to be decremented
  * @strong:	if true, strong decrement, else weak
  *
  * Decrement the ref.
  *
- * Return: true if ref is cleaned up and ready to be freed
+ * Return: %true if ref is cleaned up and ready to be freed.
  */
 static bool binder_dec_ref_olocked(struct binder_ref *ref, int strong)
 {
@@ -2813,8 +2813,8 @@ static int binder_proc_transaction(struc
 /**
  * binder_get_node_refs_for_txn() - Get required refs on node for txn
  * @node:         struct binder_node for which to get refs
- * @proc:         returns @node->proc if valid
- * @error:        if no @proc then returns BR_DEAD_REPLY
+ * @procp:        returns @node->proc if valid
+ * @error:        if no @procp then returns BR_DEAD_REPLY
  *
  * User-space normally keeps the node alive when creating a transaction
  * since it has a reference to the target. The local strong ref keeps it
@@ -2828,8 +2828,8 @@ static int binder_proc_transaction(struc
  * constructing the transaction, so we take that here as well.
  *
  * Return: The target_node with refs taken or NULL if no @node->proc is NULL.
- * Also sets @proc if valid. If the @node->proc is NULL indicating that the
- * target proc has died, @error is set to BR_DEAD_REPLY
+ * Also sets @procp if valid. If the @node->proc is NULL indicating that the
+ * target proc has died, @error is set to BR_DEAD_REPLY.
  */
 static struct binder_node *binder_get_node_refs_for_txn(
 		struct binder_node *node,
diff -- a/drivers/android/binderfs.c b/drivers/android/binderfs.c
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -222,14 +222,14 @@ err:
 }
 
 /**
- * binderfs_ctl_ioctl - handle binder device node allocation requests
+ * binder_ctl_ioctl - handle binder device node allocation requests
  *
  * The request handler for the binder-control device. All requests operate on
  * the binderfs mount the binder-control device resides in:
  * - BINDER_CTL_ADD
  *   Allocate a new binder device.
  *
- * Return: 0 on success, negative errno on failure
+ * Return: %0 on success, negative errno on failure.
  */
 static long binder_ctl_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
