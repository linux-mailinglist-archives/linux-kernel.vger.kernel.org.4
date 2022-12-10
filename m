Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0F648F07
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLJN67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiLJN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597301839E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00D45B8282B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA85C433F2;
        Sat, 10 Dec 2022 13:58:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40Mx-000klQ-2A;
        Sat, 10 Dec 2022 08:58:23 -0500
Message-ID: <20221210135823.536214084@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:57:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 02/25] tracing: Update MAINTAINERS file for new patchwork and mailing list
References: <20221210135750.425719934@goodmis.org>
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

The tracing subsystem now has its own mailing list (although patches
should also be sent to LKML) as well as a new patchwork entry for kernel
related tracing patches.

Update the MAINTAINERS file to reflect the changes.

Link: https://lore.kernel.org/linux-trace-kernel/20221017140513.14b9ce2e@gandalf.local.home

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2585e7edc335..d12576150a70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8461,6 +8461,9 @@ FUNCTION HOOKS (FTRACE)
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 R:	Mark Rutland <mark.rutland@arm.com>
+L:	linux-kernel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/trace/ftrace*
@@ -11483,6 +11486,9 @@ M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/trace/kprobes.rst
@@ -20862,6 +20868,9 @@ F:	drivers/hwmon/pmbus/tps546d24.c
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


