Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B358714664
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjE2IkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjE2IkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006BB5;
        Mon, 29 May 2023 01:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ABCC61260;
        Mon, 29 May 2023 08:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39476C433EF;
        Mon, 29 May 2023 08:40:06 +0000 (UTC)
Date:   Mon, 29 May 2023 04:40:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] tracing/rv/rtla: Update MAINTAINERS file to point to proper
 mailing list
Message-ID: <20230529044002.0481452b@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The mailing list that goes to linux-trace-devel is for the tracing
libraries, and the patchwork associated to the tracing libraries keys
off of that mailing list.

For anything that lives in the Linux kernel proper (including the tools
directory) must go through linux-trace-kernel, as the patchwork to that
list keys off of the Linux kernel proper.

Update the MAINTAINERS file to reflect the proper mailing lists.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..5bb6dccd6ea3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17808,7 +17808,7 @@ F:	tools/testing/selftests/rtc/
 Real-time Linux Analysis (RTLA) tools
 M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
-L:	linux-trace-devel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/tools/rtla/
 F:	tools/tracing/rtla/
@@ -18370,7 +18370,7 @@ F:	drivers/infiniband/ulp/rtrs/
 RUNTIME VERIFICATION (RV)
 M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
-L:	linux-trace-devel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/trace/rv/
 F:	include/linux/rv.h
-- 
2.39.2

