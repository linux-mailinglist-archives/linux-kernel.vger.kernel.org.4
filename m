Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D830267B6CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbjAYQUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbjAYQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:20:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FEE561B2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7CF9B81A90
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C72AC433A4;
        Wed, 25 Jan 2023 16:20:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKiVO-004Mrw-1y;
        Wed, 25 Jan 2023 11:20:10 -0500
Message-ID: <20230125162010.423848948@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 11:18:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [for-linus][PATCH 04/11] tracing: Kconfig: Fix spelling/grammar/punctuation
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

Fix some editorial nits in trace Kconfig.

Link: https://lkml.kernel.org/r/20230124181647.15902-1-rdunlap@infradead.org

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 197545241ab8..d7043043f59c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -933,8 +933,8 @@ config RING_BUFFER_RECORD_RECURSION
 	default y
 	help
 	  The ring buffer has its own internal recursion. Although when
-	  recursion happens it wont cause harm because of the protection,
-	  but it does cause an unwanted overhead. Enabling this option will
+	  recursion happens it won't cause harm because of the protection,
+	  but it does cause unwanted overhead. Enabling this option will
 	  place where recursion was detected into the ftrace "recursed_functions"
 	  file.
 
@@ -1017,8 +1017,8 @@ config RING_BUFFER_STARTUP_TEST
 	 The test runs for 10 seconds. This will slow your boot time
 	 by at least 10 more seconds.
 
-	 At the end of the test, statics and more checks are done.
-	 It will output the stats of each per cpu buffer. What
+	 At the end of the test, statistics and more checks are done.
+	 It will output the stats of each per cpu buffer: What
 	 was written, the sizes, what was read, what was lost, and
 	 other similar details.
 
-- 
2.39.0
