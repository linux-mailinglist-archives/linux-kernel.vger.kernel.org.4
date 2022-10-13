Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E165FCE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJLWDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJLWC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:02:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6B012571D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F3B7B81C1F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129B4C433C1;
        Wed, 12 Oct 2022 22:00:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oijmV-0049AN-17;
        Wed, 12 Oct 2022 18:00:51 -0400
Message-ID: <20221012215911.735621065@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Oct 2022 17:59:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: Fixes for 6.1
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jiapeng Chong (1):
      ring-buffer: Fix kernel-doc

Steven Rostedt (Google) (3):
      tracing: Move duplicate code of trace_kprobe/eprobe.c into header
      tracing: Add "(fault)" name injection to kernel probes
      tracing: Fix reading strings from synthetic events

Zheng Yejian (1):
      ftrace: Fix char print issue in print_ip_ins()

----
 kernel/trace/ftrace.c             |   5 +-
 kernel/trace/ring_buffer.c        |   6 +-
 kernel/trace/trace_eprobe.c       |  60 ++------------------
 kernel/trace/trace_events_synth.c |  23 ++++++--
 kernel/trace/trace_kprobe.c       |  60 ++------------------
 kernel/trace/trace_probe_kernel.h | 115 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 146 insertions(+), 123 deletions(-)
 create mode 100644 kernel/trace/trace_probe_kernel.h
