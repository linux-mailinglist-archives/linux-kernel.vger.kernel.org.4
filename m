Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4D637BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKXOsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKXOs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:48:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FD0E0685
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3CE2B82838
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A967C433C1;
        Thu, 24 Nov 2022 14:48:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDWZ-001WqT-1t;
        Thu, 24 Nov 2022 09:48:23 -0500
Message-ID: <20221124144752.427194398@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:47:52 -0500
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

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 4313e5a613049dfc1819a6dfb5f94cf2caff9452


Colin Ian King (1):
      tracing/hist: add in missing * in comment blocks

Daniel Bristot de Oliveira (1):
      tracing/osnoise: Fix duration type

Steven Rostedt (Google) (3):
      tracing: Fix race where histograms can be called before the event
      tracing: Add tracing_reset_all_online_cpus_unlocked() function
      tracing: Free buffers when a used dynamic event is removed

Xiu Jianfeng (1):
      tracing/user_events: Fix memory leak in user_event_create()

----
 kernel/trace/trace.c              | 11 ++++++++++-
 kernel/trace/trace.h              |  1 +
 kernel/trace/trace_dynevent.c     |  2 ++
 kernel/trace/trace_events.c       | 13 +++++++++++--
 kernel/trace/trace_events_hist.c  |  7 +++++--
 kernel/trace/trace_events_synth.c |  2 --
 kernel/trace/trace_events_user.c  |  4 +++-
 kernel/trace/trace_osnoise.c      |  6 +++---
 8 files changed, 35 insertions(+), 11 deletions(-)
