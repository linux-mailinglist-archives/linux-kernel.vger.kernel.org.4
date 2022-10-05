Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5615F57D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJEPvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJEPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:51:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA5B3FA29
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 08:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF5C7B81E6E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF60C433B5;
        Wed,  5 Oct 2022 15:51:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1og6g0-0028HB-0S;
        Wed, 05 Oct 2022 11:51:16 -0400
Message-ID: <20221005155115.975728236@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 05 Oct 2022 11:50:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [for-next][PATCH 2/5] MAINTAINERS: add myself as a tracing reviewer
References: <20221005155030.594135087@goodmis.org>
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

From: Mark Rutland <mark.rutland@arm.com>

Since I'm actively involved in a number of arch bits that intersect
ftrace (e.g. the actual arch implementation on arm64, stacktracing,
entry management, and general instrumentation safety), add myself as a
reviewer of the core ftrace code so that I have the change to catch any
potential problems early.

I spoke with Steven about this at LPC, and it seemed to make sense to
add me as a reviewer.

Link: https://lkml.kernel.org/r/20220928114621.248038-1-mark.rutland@arm.com

Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5ca4aefd184..ef2fc5e581b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20615,6 +20615,7 @@ F:	drivers/char/tpm/
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Ingo Molnar <mingo@redhat.com>
+R:	Mark Rutland <mark.rutland@arm.com>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 F:	Documentation/trace/ftrace.rst
-- 
2.35.1
