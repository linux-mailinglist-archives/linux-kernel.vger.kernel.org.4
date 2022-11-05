Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E407761DE16
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 21:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKEUvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 16:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKEUvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 16:51:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B2EE29
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 13:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE49AB808C6
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 20:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A301C433C1;
        Sat,  5 Nov 2022 20:51:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1orQ8f-007k6Y-16;
        Sat, 05 Nov 2022 16:51:37 -0400
Message-ID: <20221105205049.462806482@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 05 Nov 2022 16:50:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/6] tracing: Fixes for 6.1
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Li Huafei (1):
      ftrace: Fix use-after-free for dynamic ftrace_ops

Li Qiang (1):
      kprobe: reverse kp->flags when arm_kprobe failed

Masami Hiramatsu (Google) (1):
      tracing/fprobe: Fix to check whether fprobe is registered correctly

Rafael Mendonca (1):
      fprobe: Check rethook_alloc() return in rethook initialization

Shang XiaoJing (1):
      tracing: kprobe: Fix memory leak in test_gen_kprobe/kretprobe_cmd()

Steven Rostedt (Google) (1):
      ring-buffer: Check for NULL cpu_buffer in ring_buffer_wake_waiters()

----
 kernel/kprobes.c                     |  5 ++++-
 kernel/trace/fprobe.c                |  5 ++++-
 kernel/trace/ftrace.c                | 16 +++-------------
 kernel/trace/kprobe_event_gen_test.c | 18 +++++++-----------
 kernel/trace/ring_buffer.c           | 11 +++++++++++
 5 files changed, 29 insertions(+), 26 deletions(-)
