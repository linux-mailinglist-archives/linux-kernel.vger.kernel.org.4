Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E5364CBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbiLNOCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiLNOCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:02:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F098275ED
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:02:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF427B818CB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9739BC433D2;
        Wed, 14 Dec 2022 14:02:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p5SKm-000gsL-1l;
        Wed, 14 Dec 2022 09:02:08 -0500
Message-ID: <20221214140133.608431204@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Dec 2022 09:01:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/8] tracing: Last minute fixes for 6.2
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 9a2179ff02e179a866375bd6916f761381749b5b


Guilherme G. Piccoli (1):
      tracing: Improve panic/die notifiers

Steven Rostedt (Google) (5):
      x86/mm/kmmio: Remove redundant preempt_disable()
      tracing: Have trigger filter parsing errors show up in error_log
      tracing: Remove pointer (asterisk) and brackets from cpumask_t field
      tracing: Do not synchronize freeing of trigger filter on boot up
      tracing: Fix cpumask() example typo

Yang Jihong (1):
      tracing: Fix infinite loop in tracing_read_pipe on overflowed print_trace_line

gpiccoli@igalia.com (1):
      ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels

----
 arch/x86/mm/kmmio.c                        | 13 +++---
 include/trace/stages/stage4_event_fields.h | 10 ++++-
 kernel/trace/ftrace.c                      |  1 +
 kernel/trace/trace.c                       | 70 +++++++++++++++++-------------
 kernel/trace/trace_events_trigger.c        | 19 ++++++--
 samples/trace_events/trace-events-sample.h |  2 +-
 6 files changed, 72 insertions(+), 43 deletions(-)
