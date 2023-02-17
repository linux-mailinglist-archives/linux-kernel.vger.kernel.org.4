Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BEE69A323
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBQAvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBQAu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:50:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD556595A5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:50:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51435B82AC0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3ECC433D2;
        Fri, 17 Feb 2023 00:50:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pSoxS-000qM3-1M;
        Thu, 16 Feb 2023 19:50:38 -0500
Message-ID: <20230217004954.719324747@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 16 Feb 2023 19:49:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: Updates for 6.3
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

Head SHA1: d8f0ae3ebed416728077fe94698983c30d409241


Steven Rostedt (Google) (1):
      tracing: Add BUILD_BUG() to make sure stacktrace fits in strings

Tom Zanussi (4):
      tracing/histogram: Don't use strlen to find length of stacktrace variables
      tracing/histogram: Fix a few problems with stacktrace variable printing
      tracing/histogram: Fix stacktrace key
      tracing/histogram: Fix stacktrace histogram Documententation

----
 Documentation/trace/histogram.rst | 156 ++++++++++++++++++++++----------------
 kernel/trace/trace_events_hist.c  |  75 ++++++++++++++----
 kernel/trace/trace_events_synth.c |   7 +-
 3 files changed, 156 insertions(+), 82 deletions(-)
