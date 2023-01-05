Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3665E152
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjAEAKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjAEAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C9D43A1D;
        Wed,  4 Jan 2023 16:09:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F4D8618A8;
        Thu,  5 Jan 2023 00:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BC9C433B0;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=fcSC4bGknuyVNiSTBAA/pbbBIR+9W/cdpVsAscN6+Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWhA9VAJbsgRQBpx1Anbzy+QLG23qhY/U+SxRPbJwOLe8kAQQrqoOtX5cyJjEjAN+
         LfDYA+wZofCcoAg8JQDyKZypwMrlRvMI6WbEbmtlMipAInx9XLKzaUpgm7fxXzUYBq
         CfyuuFf4Nw98PbEDDIZ5epb401mhiFz4+v5/aDTsPuQ0ibrQSueRhfbDSh1cAhVoEq
         P2P7z5FFYySpcXA1Vo16kc+JWvUQr5bhV2P3DU9+mw47Bkv5AV2q5uMtO3sb8m0Yhh
         QJWc+RH0ybefuANKoQICZ/w2usva+7Z7jbg0TxKeEf1zhusWb068q8QbRAiiXPzE8y
         5OofSaoKy6+ow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DA0075C1C89; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Akira Yokosawa <akiyks@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/15] docs/RCU/rcubarrier: Adjust 'Answer' parts of QQs as definition-lists
Date:   Wed,  4 Jan 2023 16:09:53 -0800
Message-Id: <20230105000955.1767218-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

The "Answer" parts of QQs divert from proper format of definition-lists
as described at [1] and are not rendered as such.

Adjust them.

Link: [1] https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#definition-lists
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcubarrier.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index 5a643e5233d5f..9fb9ed7773552 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -296,7 +296,8 @@ Quick Quiz #1:
 	Is there any other situation where rcu_barrier() might
 	be required?
 
-Answer: Interestingly enough, rcu_barrier() was not originally
+Answer:
+	Interestingly enough, rcu_barrier() was not originally
 	implemented for module unloading. Nikita Danilov was using
 	RCU in a filesystem, which resulted in a similar situation at
 	filesystem-unmount time. Dipankar Sarma coded up rcu_barrier()
@@ -315,7 +316,8 @@ Quick Quiz #2:
 	Why doesn't line 8 initialize rcu_barrier_cpu_count to zero,
 	thereby avoiding the need for lines 9 and 10?
 
-Answer: Suppose that the on_each_cpu() function shown on line 8 was
+Answer:
+	Suppose that the on_each_cpu() function shown on line 8 was
 	delayed, so that CPU 0's rcu_barrier_func() executed and
 	the corresponding grace period elapsed, all before CPU 1's
 	rcu_barrier_func() started executing.  This would result in
@@ -351,7 +353,8 @@ Quick Quiz #3:
 	are delayed for a full grace period? Couldn't this result in
 	rcu_barrier() returning prematurely?
 
-Answer: This cannot happen. The reason is that on_each_cpu() has its last
+Answer:
+	This cannot happen. The reason is that on_each_cpu() has its last
 	argument, the wait flag, set to "1". This flag is passed through
 	to smp_call_function() and further to smp_call_function_on_cpu(),
 	causing this latter to spin until the cross-CPU invocation of
-- 
2.31.1.189.g2e36527f23

