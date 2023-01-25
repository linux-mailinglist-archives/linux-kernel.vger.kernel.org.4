Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51DA67B6C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjAYQU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbjAYQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:20:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C585619C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEC3A61509
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49755C433B0;
        Wed, 25 Jan 2023 16:20:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKiVP-004Mtc-0i;
        Wed, 25 Jan 2023 11:20:11 -0500
Message-ID: <20230125162011.031705664@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 11:18:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [for-linus][PATCH 07/11] lib: Kconfig: fix spellos
References: <20230125161824.332648375@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix spelling in lib/ Kconfig files.
(reported by codespell)

Link: https://lkml.kernel.org/r/20230124181655.16269-1-rdunlap@infradead.org

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 lib/Kconfig.debug | 2 +-
 lib/Kconfig.kcsan | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 881c3f84e88a..6426dbf99c12 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1917,7 +1917,7 @@ config FUNCTION_ERROR_INJECTION
 	help
 	  Add fault injections into various functions that are annotated with
 	  ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
-	  value of theses functions. This is useful to test error paths of code.
+	  value of these functions. This is useful to test error paths of code.
 
 	  If unsure, say N
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 375575a5a0e3..4dedd61e5192 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -194,7 +194,7 @@ config KCSAN_WEAK_MEMORY
 	  Enable support for modeling a subset of weak memory, which allows
 	  detecting a subset of data races due to missing memory barriers.
 
-	  Depends on KCSAN_STRICT, because the options strenghtening certain
+	  Depends on KCSAN_STRICT, because the options strengthening certain
 	  plain accesses by default (depending on !KCSAN_STRICT) reduce the
 	  ability to detect any data races invoving reordered accesses, in
 	  particular reordered writes.
-- 
2.39.0
