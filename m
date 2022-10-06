Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67D5F69E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiJFOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiJFOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:44:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DFFF3D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8EBBDCE13BE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 14:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF2AC433D6;
        Thu,  6 Oct 2022 14:44:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1ogS75-002jsO-1Q;
        Thu, 06 Oct 2022 10:44:39 -0400
Message-ID: <20221006144439.282193367@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 06 Oct 2022 10:43:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] tracing: Update MAINTAINERS to reflect new tracing git repo
References: <20221006144346.554825677@goodmis.org>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The tracing git repo will no longer be housed in my personal git repo,
but instead live in trace/linux-trace.git.

Update the MAINTAINERS file appropriately.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 749558b09464..86b8aa4c11cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11380,7 +11380,7 @@ M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/trace/kprobes.rst
 F:	include/asm-generic/kprobes.h
 F:	include/linux/kprobes.h
@@ -20617,7 +20617,7 @@ M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 R:	Mark Rutland <mark.rutland@arm.com>
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/trace/ftrace.rst
 F:	arch/*/*/*/*ftrace*
 F:	arch/*/*/*ftrace*
-- 
2.35.1
