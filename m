Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4349A6DA0C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbjDFTMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbjDFTMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7CA83D1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7100862CEC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81ECC433EF;
        Thu,  6 Apr 2023 19:12:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pkV28-001EXN-2S;
        Thu, 06 Apr 2023 15:12:32 -0400
Message-ID: <20230406191058.652785135@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 06 Apr 2023 15:10:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: A few more updates to 6.3
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some more tracing fixes for 6.3:

- Reset direct->addr back to its original value on error in updating
  the direct trampoline code.

- Make lastcmd_mutex static.


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 31c683967174b487939efaf65e41f5ff1404e141


Steven Rostedt (Google) (1):
      tracing/synthetic: Make lastcmd_mutex static

Zheng Yejian (1):
      ftrace: Fix issue that 'direct->addr' not restored in modify_ftrace_direct()

----
 kernel/trace/ftrace.c             | 15 +++++++++------
 kernel/trace/trace_events_synth.c |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)
