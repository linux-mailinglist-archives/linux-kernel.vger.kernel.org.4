Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E550F67DDE5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjA0Glb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjA0GkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939CC6ACB6;
        Thu, 26 Jan 2023 22:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DZse1eO7oh50AhzLCdDhk7R2KKKuFFm0FSMJlqDIjNo=; b=brWK6hJWj8jGh5PKGf8T+ZwmK6
        l//PRZevg3wQoXDUqv2uQEPhVcDQfZqnjmUlY1gZZKg2+3+TW06OV4lZ8O4K1JHxVORqGR/o6Z3Ll
        upVg5+KZwsK/lGMQm2qqwSDACF3ARH9dRsunCjme6ZsAUCosqXfjltNLcPcyl9GqwOJ1Nv+c188Qt
        dunEZ0sqTwui5RWr2+W9DnixaShDj592LXu5fNcLH5GSGP6ad+6WGLQxABM4N1cx5eM8a9aHBZE3G
        bJAp97zz2PacfY8yY1etBuFTou8hlpuPDBgpMAaVLDP8mznfBkchXSmQN7FndtlK8TH2zLgLPfwbZ
        Bnbj4iTw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPK-00DM0u-4p; Fri, 27 Jan 2023 06:40:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 17/35] Documentation: locking: correct spelling
Date:   Thu, 26 Jan 2023 22:39:47 -0800
Message-Id: <20230127064005.1558-18-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/locking/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/locking/lockdep-design.rst  |    4 ++--
 Documentation/locking/locktorture.rst     |    2 +-
 Documentation/locking/locktypes.rst       |    2 +-
 Documentation/locking/preempt-locking.rst |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff -- a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
--- a/Documentation/locking/lockdep-design.rst
+++ b/Documentation/locking/lockdep-design.rst
@@ -29,7 +29,7 @@ the validator will shoot a splat if inco
 A lock-class's behavior is constructed by its instances collectively:
 when the first instance of a lock-class is used after bootup the class
 gets registered, then all (subsequent) instances will be mapped to the
-class and hence their usages and dependecies will contribute to those of
+class and hence their usages and dependencies will contribute to those of
 the class. A lock-class does not go away when a lock instance does, but
 it can be removed if the memory space of the lock class (static or
 dynamic) is reclaimed, this happens for example when a module is
@@ -105,7 +105,7 @@ exact case is for the lock as of the rep
   +--------------+-------------+--------------+
 
 The character '-' suggests irq is disabled because if otherwise the
-charactor '?' would have been shown instead. Similar deduction can be
+character '?' would have been shown instead. Similar deduction can be
 applied for '+' too.
 
 Unused locks (e.g., mutexes) cannot be part of the cause of an error.
diff -- a/Documentation/locking/locktorture.rst b/Documentation/locking/locktorture.rst
--- a/Documentation/locking/locktorture.rst
+++ b/Documentation/locking/locktorture.rst
@@ -113,7 +113,7 @@ stutter
 		  without pausing.
 
 shuffle_interval
-		  The number of seconds to keep the test threads affinitied
+		  The number of seconds to keep the test threads affined
 		  to a particular subset of the CPUs, defaults to 3 seconds.
 		  Used in conjunction with test_no_idle_hz.
 
diff -- a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -500,7 +500,7 @@ caveats also apply to bit spinlocks.
 Some bit spinlocks are replaced with regular spinlock_t for PREEMPT_RT
 using conditional (#ifdef'ed) code changes at the usage site.  In contrast,
 usage-site changes are not needed for the spinlock_t substitution.
-Instead, conditionals in header files and the core locking implemementation
+Instead, conditionals in header files and the core locking implementation
 enable the compiler to do the substitution transparently.
 
 
diff -- a/Documentation/locking/preempt-locking.rst b/Documentation/locking/preempt-locking.rst
--- a/Documentation/locking/preempt-locking.rst
+++ b/Documentation/locking/preempt-locking.rst
@@ -114,7 +114,7 @@ critical variables.  Another example::
 
 	int buf[NR_CPUS];
 	set_cpu_val(buf);
-	if (buf[smp_processor_id()] == -1) printf(KERN_INFO "wee!\n");
+	if (buf[smp_processor_id()] == -1) printf(KERN_INFO "whee!\n");
 	spin_lock(&buf_lock);
 	/* ... */
 
