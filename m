Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356126015EA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJQSE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiJQSEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:04:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5F22B09;
        Mon, 17 Oct 2022 11:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79DD8B819D9;
        Mon, 17 Oct 2022 18:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA75C433D6;
        Mon, 17 Oct 2022 18:04:49 +0000 (UTC)
Date:   Mon, 17 Oct 2022 14:05:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing: Update MAINTAINERS file for new patchwork and
 mailing list
Message-ID: <20221017140513.14b9ce2e@gandalf.local.home>
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

The tracing subsystem now has its own mailing list (although patches
should also be sent to LKML) as well as a new patchwork entry for kernel
related tracing patches.

Update the MAINTAINERS file to reflect the changes.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d95f5d3b4d37..6293cb4e46a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8415,6 +8415,9 @@ FUNCTION HOOKS (FTRACE)
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 R:	Mark Rutland <mark.rutland@arm.com>
+L:	linux-kernel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/trace/ftrace*
@@ -11392,6 +11395,9 @@ M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/trace/kprobes.rst
@@ -20628,6 +20634,9 @@ F:	drivers/char/tpm/
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/trace/*
-- 
2.35.1

