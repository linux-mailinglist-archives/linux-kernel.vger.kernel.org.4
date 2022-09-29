Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306E05F0112
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiI2Wzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiI2Wz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C370EC55A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC4A2621E1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A83C433C1;
        Thu, 29 Sep 2022 22:55:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oe2SM-000cpw-2W;
        Thu, 29 Sep 2022 18:56:38 -0400
Message-ID: <20220929225638.299125775@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 29 Sep 2022 18:55:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: [for-next][PATCH 09/15] tracing: Fix spelling mistake "preapre" -> "prepare"
References: <20220929225542.784716766@goodmis.org>
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

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in the trace text. Fix it.

Link: https://lkml.kernel.org/r/20220928215828.66325-1-colin.i.king@gmail.com

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb5597c6bfc1..def721de68a0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10157,7 +10157,7 @@ __init static int tracer_alloc_buffers(void)
 	 * buffer. The memory will be removed once the "instance" is removed.
 	 */
 	ret = cpuhp_setup_state_multi(CPUHP_TRACE_RB_PREPARE,
-				      "trace/RB:preapre", trace_rb_cpu_prepare,
+				      "trace/RB:prepare", trace_rb_cpu_prepare,
 				      NULL);
 	if (ret < 0)
 		goto out_free_cpumask;
-- 
2.35.1
