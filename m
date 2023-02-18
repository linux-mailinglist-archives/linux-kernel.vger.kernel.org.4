Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B5B69BBC7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBRUTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBRUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:19:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B514990
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 12:19:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F22DDB80936
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 20:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69658C433EF;
        Sat, 18 Feb 2023 20:19:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pTTgB-000xre-36;
        Sat, 18 Feb 2023 15:19:31 -0500
Message-ID: <20230218201821.938318263@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 18 Feb 2023 15:18:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 0/8] tracing/tools: Updates for 6.3
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has actually been in for-next for some time. But because I never
sent out the "for-next" emails, it's still set to "New" in my internal
patchwork.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: 5dc3750e747f93f9bb7987da3d47a8ab4a5a181e


Andreas Ziegler (2):
      tools/tracing/rtla: osnoise_hist: use total duration for average calculation
      tools/tracing/rtla: osnoise_hist: display average with two-digit precision

Daniel Bristot de Oliveira (5):
      rtla/timerlat: Add auto-analysis core
      rtla/timerlat: Add auto-analysis support to timerlat top
      Documentation/rtla: Add timerlat-top auto-analysis options
      rtla: Add hwnoise tool
      Documentation/rtla: Add hwnoise man page

zhang songyi (1):
      tools/rv: Remove unneeded semicolon

----
 Documentation/tools/rtla/common_timerlat_aa.rst |   7 +
 Documentation/tools/rtla/index.rst              |   1 +
 Documentation/tools/rtla/rtla-hwnoise.rst       | 107 +++
 Documentation/tools/rtla/rtla-timerlat-top.rst  | 164 ++--
 tools/tracing/rtla/Makefile                     |   2 +
 tools/tracing/rtla/src/osnoise.c                | 117 +++
 tools/tracing/rtla/src/osnoise.h                |   7 +
 tools/tracing/rtla/src/osnoise_hist.c           |   9 +-
 tools/tracing/rtla/src/osnoise_top.c            |  84 +-
 tools/tracing/rtla/src/rtla.c                   |   4 +
 tools/tracing/rtla/src/timerlat_aa.c            | 990 ++++++++++++++++++++++++
 tools/tracing/rtla/src/timerlat_aa.h            |  12 +
 tools/tracing/rtla/src/timerlat_top.c           |  46 +-
 tools/tracing/rtla/src/utils.h                  |   3 +
 tools/verification/rv/src/in_kernel.c           |   2 +-
 15 files changed, 1442 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/tools/rtla/common_timerlat_aa.rst
 create mode 100644 Documentation/tools/rtla/rtla-hwnoise.rst
 create mode 100644 tools/tracing/rtla/src/timerlat_aa.c
 create mode 100644 tools/tracing/rtla/src/timerlat_aa.h
