Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51005668E58
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbjAMGxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbjAMGwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:52:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC0B6E427
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fTqn+551gOme2g9n3gOJc95mD7RbhGDR59qs9l+mVwo=; b=j4gOOiX/BjD5FPPSirxHSGXYq/
        6oTjI8y9ps5qgPdskjsmgNuyQT4J1nniUjIVor0q/JaWsUx7945xvcIiTi/sPFyxrmdgUmWFriYiL
        ueRgTPok78z+4DAw6LDzyn5gOITZ/7/eOpfFddq30tKtyF65JHz+uK3tZaeyxxZjqR2kNhS2/ITAW
        KAGOUVoKYxLlG1brILvzLXazoFiitKq9fiNs5kZpXHcMVdjVTcuy1NTRykgkbcxkKX2yRoJ1uql9/
        Omegv1uDDUMGTISNlduMr4U+7WM8Um503kWnFdrdCBW5uO0Ep1Psd2g87eCcXuMLJeaBFyW6ip2T+
        ZVlsl/LQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDfo-000q9Z-7D; Fri, 13 Jan 2023 06:36:20 +0000
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
Subject: [PATCH] android: fix W=1 kernel-doc warnings
Date:   Thu, 12 Jan 2023 22:36:17 -0800
Message-Id: <20230113063617.4129-1-rdunlap@infradead.org>
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
---
 drivers/android/binder.c   |   16 ++++++++--------
 drivers/android/binderfs.c |    4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff -- a/drivers/android/binder.c b/drivers/android/binder.c
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -277,7 +277,7 @@ _binder_proc_lock(struct binder_proc *pr
 
 /**
  * binder_proc_unlock() - Release spinlock for given binder_proc
- * @proc:         struct binder_proc to acquire
+ * @_proc:                struct binder_proc to acquire
  *
  * Release lock acquired via binder_proc_lock()
  */
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
