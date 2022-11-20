Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB265631644
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKTUMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:12:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6CB1E1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:12:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B9A760B54
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CC7C433D6;
        Sun, 20 Nov 2022 20:12:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1owqft-00DiVb-2s;
        Sun, 20 Nov 2022 15:12:21 -0500
Message-ID: <20221120201156.868430827@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 20 Nov 2022 15:11:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/7] probes: Fixes for 6.1
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes/urgent

Head SHA1: 40adaf51cb318131073d1ba8233d473cc105ecbf


Li Huafei (1):
      kprobes: Skip clearing aggrprobe's post_handler in kprobe-on-ftrace case

Masami Hiramatsu (Google) (1):
      tracing/eprobe: Fix eprobe filter to make a filter correctly

Rafael Mendonca (2):
      tracing/eprobe: Fix memory leak of filter string
      tracing/eprobe: Fix warning in filter creation

Shang XiaoJing (2):
      tracing: kprobe: Fix potential null-ptr-deref on trace_event_file in kprobe_event_gen_test_exit()
      tracing: kprobe: Fix potential null-ptr-deref on trace_array in kprobe_event_gen_test_exit()

Yi Yang (1):
      rethook: fix a potential memleak in rethook_alloc()

----
 kernel/kprobes.c                     |  8 +++++-
 kernel/trace/kprobe_event_gen_test.c | 48 ++++++++++++++++++++++++------------
 kernel/trace/rethook.c               |  4 ++-
 kernel/trace/trace_eprobe.c          |  5 ++--
 4 files changed, 45 insertions(+), 20 deletions(-)
