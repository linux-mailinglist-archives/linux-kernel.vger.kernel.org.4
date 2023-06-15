Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF9731A19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344174AbjFONfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344471AbjFONfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217E30DB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9BD660F85
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF3BC433C9;
        Thu, 15 Jun 2023 13:34:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n79-000TlJ-0A;
        Thu, 15 Jun 2023 09:34:15 -0400
Message-ID: <20230615133414.865893768@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 01/15] tracing/rv/rtla: Update MAINTAINERS file to point to proper mailing
 list
References: <20230615130531.200384328@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Link: https://lore.kernel.org/linux-trace-kernel/20230529044002.0481452b@rorschach.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..725d35b5d328 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17806,7 +17806,7 @@ F:	tools/testing/selftests/rtc/
 Real-time Linux Analysis (RTLA) tools
 M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
-L:	linux-trace-devel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/tools/rtla/
 F:	tools/tracing/rtla/
@@ -18368,7 +18368,7 @@ F:	drivers/infiniband/ulp/rtrs/
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
