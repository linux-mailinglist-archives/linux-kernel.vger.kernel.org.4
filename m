Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9751A5F57CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJEPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJEPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA52C669
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 08:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 101AD61750
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB4BC433C1;
        Wed,  5 Oct 2022 15:51:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1og6fz-0028G2-2S;
        Wed, 05 Oct 2022 11:51:15 -0400
Message-ID: <20221005155030.594135087@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 05 Oct 2022 11:50:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: Minor updates for 6.1
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: e5d271812e7a4d527e65b0228b4a16795c0e0c6c


Beau Belgrave (1):
      tracing/user_events: Move pages/locks into groups to prepare for namespaces

Chen Zhongjin (1):
      tracing: Remove unused variable 'dups'

Mark Rutland (1):
      MAINTAINERS: add myself as a tracing reviewer

Steven Rostedt (Google) (2):
      ring-buffer: Fix race between reset page and reading page
      tracing: Add Masami Hiramatsu as co-maintainer

----
 MAINTAINERS                      |   5 +-
 kernel/trace/ring_buffer.c       |  33 ++++
 kernel/trace/trace_events_user.c | 346 +++++++++++++++++++++++++++++++--------
 kernel/trace/tracing_map.c       |   5 +-
 4 files changed, 312 insertions(+), 77 deletions(-)
