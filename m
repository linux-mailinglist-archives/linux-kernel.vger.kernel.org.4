Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257C26B9F48
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCNTEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCNTEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA382B292
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F8EA61884
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E14C433EF;
        Tue, 14 Mar 2023 19:03:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pc9vR-009twy-1z;
        Tue, 14 Mar 2023 15:03:09 -0400
Message-ID: <20230314190236.203370742@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 14 Mar 2023 15:02:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: Fixes for v6.3
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann (1):
      ftrace,kcfi: Define ftrace_stub_graph conditionally

Chen Zhongjin (1):
      ftrace: Fix invalid address access in lookup_rec() when index is 0

Steven Rostedt (Google) (3):
      tracing: Do not let histogram values have some modifiers
      tracing: Check field value in hist_field_name()
      tracing: Make tracepoint lockdep check actually test something

----
 arch/x86/kernel/ftrace_64.S      |  2 ++
 include/linux/tracepoint.h       | 15 ++++++---------
 kernel/trace/ftrace.c            |  3 ++-
 kernel/trace/trace_events_hist.c | 12 ++++++++++++
 4 files changed, 22 insertions(+), 10 deletions(-)
