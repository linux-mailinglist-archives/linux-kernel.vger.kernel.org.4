Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E271A5F5EB4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJFCWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJFCVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:21:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AFE4B48B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 19:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77994B81F2B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E125C433D6;
        Thu,  6 Oct 2022 02:21:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1ogGWI-002gOp-09;
        Wed, 05 Oct 2022 22:21:54 -0400
Message-ID: <20221006022126.894976366@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 05 Oct 2022 22:21:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] tracing: Last two fixes before pushing to 6.1
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

Head SHA1: a541a9559bb0a8ecc434de01d3e4826c32e8bb53


Steven Rostedt (Google) (2):
      ftrace: Still disable enabled records marked as disabled
      tracing: Do not free snapshot if tracer is on cmdline

----
 kernel/trace/ftrace.c | 20 ++++++++++++++++----
 kernel/trace/trace.c  | 10 ++++++----
 2 files changed, 22 insertions(+), 8 deletions(-)
