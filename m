Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607DC69B26C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBQSjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQSjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:39:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DC73C2F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 10:39:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B89C561F22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 18:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C40C433A0;
        Fri, 17 Feb 2023 18:39:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pT5dy-000soD-0H;
        Fri, 17 Feb 2023 13:39:38 -0500
Message-ID: <20230217183937.902030316@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Feb 2023 13:39:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Subject: [for-next][PATCH 3/3] tracing: Remove unnecessary NULL assignment
References: <20230217183911.775065402@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang ShaoBo <bobo.shaobowang@huawei.com>

Remove unnecessary NULL assignment int create_new_subsystem().

Link: https://lkml.kernel.org/r/20221123065124.3982439-1-bobo.shaobowang@huawei.com

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index cf3fd74fa675..b52c4d79eb78 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2261,8 +2261,6 @@ create_new_subsystem(const char *name)
 	if (!system->name)
 		goto out_free;
 
-	system->filter = NULL;
-
 	system->filter = kzalloc(sizeof(struct event_filter), GFP_KERNEL);
 	if (!system->filter)
 		goto out_free;
-- 
2.39.1
