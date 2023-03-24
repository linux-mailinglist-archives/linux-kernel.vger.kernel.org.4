Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2816E6C746F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCXATs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCXATq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001DC2D177;
        Thu, 23 Mar 2023 17:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7679D628E3;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE52C433EF;
        Fri, 24 Mar 2023 00:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617180;
        bh=Dy5gUgxa2Ux36xNFueJhEIxHE/YNXOYB6Npc4f9H5Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeG19BfYL7hBWzqROTU8ovzKbWMk1QCSR90fZ6CwvpocH07kIFC/amEUmPqIs8WkP
         JojEDVWNOLdSFnDOmq24IrBeFqr8UXorLQHSkCzLwR6lO18gdZI9E4VJSHjRwJwuoL
         +hNxwZVtbV+IujcutqCpgXwHBEDt2/uHpSaNCXnIEHDsLY6yTYIJgSxK5ZgnqcLM9Y
         /P+2dQXTb2dzgSzk4AOBjGAcTbC+9x+lk6qWmGpu2Mrgj5m2aCmaVxZfra/oHBAJdS
         LKqF5yztJokJdJSKVfctop1Xk3Zvlu6JjGJCQltdD7chkmCiInzVc0Qz2FRqdAVBQs
         Cqmf5lt3s7yRg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 891E21540379; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 01/19] srcu: Add whitespace to __SRCU_STRUCT_INIT() & __DEFINE_SRCU()
Date:   Thu, 23 Mar 2023 17:19:20 -0700
Message-Id: <20230324001938.3443499-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a whitespace-only commit with no change in functionality.
Its purpose is to prepare for later commits that: (1) Cause statically
allocated srcu_struct structures to rely on compile-time initialization
and (2) Move fields from the srcu_struct structure to a new srcu_usage
structure.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 include/linux/srcutree.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index a6910805f9c5..ac8af12f93b3 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -121,13 +121,13 @@ struct srcu_struct {
 #define SRCU_STATE_SCAN1	1
 #define SRCU_STATE_SCAN2	2
 
-#define __SRCU_STRUCT_INIT(name, pcpu_name)				\
-{									\
-	.sda = &pcpu_name,						\
-	.lock = __SPIN_LOCK_UNLOCKED(name.lock),			\
-	.srcu_gp_seq_needed = -1UL,					\
-	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),		\
-	__SRCU_DEP_MAP_INIT(name)					\
+#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
+{												\
+	.sda = &pcpu_name,									\
+	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
+	.srcu_gp_seq_needed = -1UL,								\
+	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
+	__SRCU_DEP_MAP_INIT(name)								\
 }
 
 /*
@@ -150,15 +150,15 @@ struct srcu_struct {
  * See include/linux/percpu-defs.h for the rules on per-CPU variables.
  */
 #ifdef MODULE
-# define __DEFINE_SRCU(name, is_static)					\
-	is_static struct srcu_struct name;				\
-	extern struct srcu_struct * const __srcu_struct_##name;		\
-	struct srcu_struct * const __srcu_struct_##name			\
+# define __DEFINE_SRCU(name, is_static)								\
+	is_static struct srcu_struct name;							\
+	extern struct srcu_struct * const __srcu_struct_##name;					\
+	struct srcu_struct * const __srcu_struct_##name						\
 		__section("___srcu_struct_ptrs") = &name
 #else
-# define __DEFINE_SRCU(name, is_static)					\
-	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
-	is_static struct srcu_struct name =				\
+# define __DEFINE_SRCU(name, is_static)								\
+	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
+	is_static struct srcu_struct name =							\
 		__SRCU_STRUCT_INIT(name, name##_srcu_data)
 #endif
 #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
-- 
2.40.0.rc2

