Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F1A6900FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBIHPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBIHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DDC402CD;
        Wed,  8 Feb 2023 23:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DZse1eO7oh50AhzLCdDhk7R2KKKuFFm0FSMJlqDIjNo=; b=FaLQ42M4IGdTWYvmzCAOHEBE0e
        5tyzmf6E21PNOPHpBkjqbMp4BmpOWb3KOD1rZ8KAqER/qjChwOhC7ZTer/0iBQ38ARTBurG8qom8E
        O3o/CEtui+sK03MrZhODX2mhyGgsc+gFn/8WbeHERXqxPxJD03GieKTFPBMTsFO7DARyin17xcfoO
        E9XYjFTFpgQ570uO6uEB3weO34Yt0p67jb2elAskDyGMc1y2f19CnuuuMPF8UVh+jEBaM0eaa70vO
        apIKYb5MMaGDJdEPgOei4Xc8gTqR86I+37ldXcZuk2xDCRgCPtYfzqRQPshMBt1YSPxipTGshxGnP
        eKR1f1xQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18C-000LPt-QP; Thu, 09 Feb 2023 07:14:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 10/24] Documentation: locking: correct spelling
Date:   Wed,  8 Feb 2023 23:13:46 -0800
Message-Id: <20230209071400.31476-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
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
 
