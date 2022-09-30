Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA65F102A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiI3QkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiI3QkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:40:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0826BC93D;
        Fri, 30 Sep 2022 09:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 616A5B82961;
        Fri, 30 Sep 2022 16:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC83DC433D6;
        Fri, 30 Sep 2022 16:40:16 +0000 (UTC)
Date:   Fri, 30 Sep 2022 12:41:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] tracing: Add Masami Hiramatsu as co-maintainer
Message-ID: <20220930124131.7b6432dd@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Masami has been maintaining kprobes for a while now and that code has
been an integral part of tracing. He has also been an excellent reviewer
of all the tracing code and contributor as well.

The tracing subsystem needs another active maintainer to keep it running
smoothly, and I do not know anyone more qualified for the job than Masami.

Ingo has also told me that he has not been active in the tracing code for
some time and said he could be removed from the TRACING portion of the
MAINTAINERS file.

Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5ca4aefd184..6c7c9cdff05a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20614,7 +20614,7 @@ F:	drivers/char/tpm/
 
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
-M:	Ingo Molnar <mingo@redhat.com>
+M:	Masami Hiramatsu <mhiramat@kernel.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 F:	Documentation/trace/ftrace.rst
@@ -20630,7 +20630,7 @@ F:	tools/testing/selftests/ftrace/
 
 TRACING MMIO ACCESSES (MMIOTRACE)
 M:	Steven Rostedt <rostedt@goodmis.org>
-M:	Ingo Molnar <mingo@kernel.org>
+M:	Masami Hiramatsu <mhiramat@kernel.org>
 R:	Karol Herbst <karolherbst@gmail.com>
 R:	Pekka Paalanen <ppaalanen@gmail.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.35.1

