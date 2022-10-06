Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1DD5F69E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiJFOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiJFOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24ECC29
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CCD6619F1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 14:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B18BC433B5;
        Thu,  6 Oct 2022 14:44:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1ogS75-002jsv-21;
        Thu, 06 Oct 2022 10:44:39 -0400
Message-ID: <20221006144439.459272364@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 06 Oct 2022 10:43:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] ftrace: Create separate entry in MAINTAINERS for function hooks
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

The function hooks (ftrace) is a completely different subsystem from the
general tracing. It manages how to attach callbacks to most functions in
the kernel. It is also used by live kernel patching. It really is not part
of tracing, although tracing uses it.

Create a separate entry for FUNCTION HOOKS (FTRACE) to be separate from
tracing itself in the MAINTAINERS file.

Perhaps it shouldbe moved out of the kernel/trace directory, but that's
for another time.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86b8aa4c11cb..d95f5d3b4d37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8411,6 +8411,19 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/fujitsu-tablet.c
 
+FUNCTION HOOKS (FTRACE)
+M:	Steven Rostedt <rostedt@goodmis.org>
+M:	Masami Hiramatsu <mhiramat@kernel.org>
+R:	Mark Rutland <mark.rutland@arm.com>
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
+F:	Documentation/trace/ftrace*
+F:	kernel/trace/ftrace*
+F:	kernel/trace/fgraph.c
+F:	arch/*/*/*/*ftrace*
+F:	arch/*/*/*ftrace*
+F:	include/*/ftrace.h
+
 FUNGIBLE ETHERNET DRIVERS
 M:	Dimitris Michailidis <dmichail@fungible.com>
 L:	netdev@vger.kernel.org
@@ -20615,14 +20628,10 @@ F:	drivers/char/tpm/
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
-R:	Mark Rutland <mark.rutland@arm.com>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
-F:	Documentation/trace/ftrace.rst
-F:	arch/*/*/*/*ftrace*
-F:	arch/*/*/*ftrace*
+F:	Documentation/trace/*
 F:	fs/tracefs/
-F:	include/*/ftrace.h
 F:	include/linux/trace*.h
 F:	include/trace/
 F:	kernel/trace/
-- 
2.35.1
