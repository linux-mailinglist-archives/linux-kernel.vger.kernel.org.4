Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AC163163A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKTUIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiKTUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:07:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF49B1E3C9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1BAE60D36
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF6FC43141;
        Sun, 20 Nov 2022 20:07:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1owqbH-00Di8k-1u;
        Sun, 20 Nov 2022 15:07:35 -0500
Message-ID: <20221120200735.429898312@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 20 Nov 2022 15:07:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-linus][PATCH 11/13] tracing: Remove unused __bad_type_size() method
References: <20221120200700.725968899@goodmis.org>
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

From: Qiujun Huang <hqjagain@gmail.com>

__bad_type_size() is unused after
commit 04ae87a52074("ftrace: Rework event_create_dir()").
So, remove it.

Link: https://lkml.kernel.org/r/D062EC2E-7DB7-4402-A67E-33C3577F551E@gmail.com

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index b69e207012c9..942ddbdace4a 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -201,8 +201,6 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
 	return trace_handle_return(s);
 }
 
-extern char *__bad_type_size(void);
-
 #define SYSCALL_FIELD(_type, _name) {					\
 	.type = #_type, .name = #_name,					\
 	.size = sizeof(_type), .align = __alignof__(_type),		\
-- 
2.35.1


