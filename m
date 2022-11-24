Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22820637BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKXOs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:48:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6214E0685
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:48:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410D662187
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D421C433D7;
        Thu, 24 Nov 2022 14:48:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDWZ-001Wqz-2M;
        Thu, 24 Nov 2022 09:48:23 -0500
Message-ID: <20221124144823.607266108@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:47:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: [for-linus][PATCH 1/6] tracing/hist: add in missing * in comment blocks
References: <20221124144752.427194398@goodmis.org>
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

There are a couple of missing * in comment blocks. Fix these.
Cleans up two clang warnings:

kernel/trace/trace_events_hist.c:986: warning: bad line:
kernel/trace/trace_events_hist.c:3229: warning: bad line:

Link: https://lkml.kernel.org/r/20221020133019.1547587-1-colin.i.king@gmail.com

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 48465f7e97b4..087c19548049 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -983,7 +983,7 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
  * A trigger can define one or more variables.  If any one of them is
  * currently referenced by any other trigger, this function will
  * determine that.
-
+ *
  * Typically used to determine whether or not a trigger can be removed
  * - if there are any references to a trigger's variables, it cannot.
  *
@@ -3226,7 +3226,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
  * events.  However, for convenience, users are allowed to directly
  * specify an event field in an action, which will be automatically
  * converted into a variable on their behalf.
-
+ *
  * This function creates a field variable with the name var_name on
  * the hist trigger currently being defined on the target event.  If
  * subsys_name and event_name are specified, this function simply
-- 
2.35.1


