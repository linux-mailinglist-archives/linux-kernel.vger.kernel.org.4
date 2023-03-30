Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2F6D1283
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjC3WsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjC3Wry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:47:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731F21205E;
        Thu, 30 Mar 2023 15:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2C8EB82A5C;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFEFC433EF;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216448;
        bh=K70gMvYhGvFQm2RTfPHGhx5QhVRNYr3RZRGehe7G6d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gzb039to+vuZqj9zxtsNtJiv/Jsjbh/tlLhFhdaz59TRzIlvnTMqtwQGi/cv4d3j7
         0SQqRgI/QC5DGAS8eL9CqG1G/0ZkA0Z/5DyaT4BEeZ6Omc2c1c0f6dvhtc3hexdSYX
         Shh4vZ4G8t4XAfhkml9ADN8A0FfnmfHYhEud1kVYTnxxU67OkHHkb50KtcydTpOhY+
         fieZ49gHssFXVWCaHV0gPIr1ZjxUckCAto0HF0kYlUDcgcWi9y0p8ygakBLs7ME4qM
         1cOS+jQ4nAUJcSuBCN19LJH9rz/b8ZL8FnIticHqKXgBbmOMi4C50YUbfz1nO4qJpz
         UCGsj7+uYdgwQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F1057154047E; Thu, 30 Mar 2023 15:47:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 02/20] srcu: Add whitespace to __SRCU_STRUCT_INIT() & __DEFINE_SRCU()
Date:   Thu, 30 Mar 2023 15:47:08 -0700
Message-Id: <20230330224726.662344-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
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

Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 558057b517b7..488d0e5d1ba3 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -108,13 +108,13 @@ struct srcu_struct {
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
@@ -137,15 +137,15 @@ struct srcu_struct {
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

