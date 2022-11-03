Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E997E6185CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKCRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiKCRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:10:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 197F310F4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:09:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F4291FB;
        Thu,  3 Nov 2022 10:09:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3B6B3F5A1;
        Thu,  3 Nov 2022 10:09:15 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org
Subject: [PATCH 0/3] ftrace: add sample code with dynamic ftrace_ops
Date:   Thu,  3 Nov 2022 17:09:04 +0000
Message-Id: <20221103170907.931465-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds sample code to manipulate dynamic ftrace_ops, which
I've been using to benchmark/test some changes I've been making in this
area for arm64.

In the process of writing that I spotted a couple of minor issues,
addressed by the first two patches.

I'm not sure whether this should be a sample or something under lib/;
I'm happy to change that if folk have strong opinions.

Thanks;
Mark.

Mark Rutland (3):
  ftrace: maintain samples/ftrace
  ftrace: export ftrace_free_filter() to modules
  ftrace: add sample with custom ops

 MAINTAINERS                                 |   1 +
 kernel/trace/ftrace.c                       |  23 +-
 samples/Kconfig                             |   7 +
 samples/Makefile                            |   1 +
 samples/ftrace/Makefile                     |   1 +
 samples/ftrace/ftrace-direct-multi-modify.c |   1 +
 samples/ftrace/ftrace-direct-multi.c        |   1 +
 samples/ftrace/ftrace-ops.c                 | 252 ++++++++++++++++++++
 8 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100644 samples/ftrace/ftrace-ops.c

-- 
2.30.2

