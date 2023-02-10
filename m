Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF596917B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjBJEsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjBJEss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:48:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5285B74C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:48:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8D7861C14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5971C433A0;
        Fri, 10 Feb 2023 04:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676004526;
        bh=3ZPhytsG6MoiFI71uMGAzjRAm4p3c/2mkgqWantxo+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdilebEYHnliIo6ccsozIn8z310XX+J4YeoCbW7rHQ02/iln2iXxE9EPvQfBjxLax
         t3ysfYwi4WsuohmRqftPzIgku530OlwXFpf3XyzBHQjyXWftPiGot3pG6gJwcCoJK3
         NTluwuUy5cBGGi1P7UEcU1ZMFeY8ED+DIAgqZw4WjDJqwj+DJOuSP/4PUQmO8Uz265
         5KTyBUZzr1t7Oe9UxIM5csHGF8Q8jf6WQe7xmnzaI9a1Se2LloVN9qnQ1LJckDykx6
         x4HSp+SsZ6xYd8rw6ZiBjPcRKEaoRozmHkbJ8dttfY+EZtSAVlxs9CZAaveKCXb81/
         UzFACfqLtzIRg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mm/damon/Kconfig: add DAMON debugfs interface deprecation notice
Date:   Fri, 10 Feb 2023 04:48:37 +0000
Message-Id: <20230210044838.63723-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210044838.63723-1-sj@kernel.org>
References: <20230210044838.63723-1-sj@kernel.org>
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

DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
kernel is released.  And, v6.1.y has announced to be an LTS[1].

Though the announcement was there for a while, some people might not
noticed that so far.  Also, some users could depend on it and have
problems at  movng to the alternative (DAMON sysfs interface).

For such cases, note DAMON debugfs interface as deprecated, and contacts
to ask helps on the Kconfig.

[1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 7821fcb3f258..436c6b4cb5ec 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -60,7 +60,7 @@ config DAMON_SYSFS
 	  the interface for arbitrary data access monitoring.
 
 config DAMON_DBGFS
-	bool "DAMON debugfs interface"
+	bool "DAMON debugfs interface (DEPRECATED!)"
 	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
 	help
 	  This builds the debugfs interface for DAMON.  The user space admins
@@ -68,8 +68,9 @@ config DAMON_DBGFS
 
 	  If unsure, say N.
 
-	  This will be removed after >5.15.y LTS kernel is released, so users
-	  should move to the sysfs interface (DAMON_SYSFS).
+	  This is deprecated, so users should move to the sysfs interface
+	  (DAMON_SYSFS).  If you depend on this and cannot move, please report
+	  your usecase to damon@lists.linux.dev and linux-mm@kvack.org.
 
 config DAMON_DBGFS_KUNIT_TEST
 	bool "Test for damon debugfs interface" if !KUNIT_ALL_TESTS
-- 
2.25.1

