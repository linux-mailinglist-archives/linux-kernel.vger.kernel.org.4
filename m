Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1968E65C038
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbjACMt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbjACMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:49:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D612D4A;
        Tue,  3 Jan 2023 04:49:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83CA01516;
        Tue,  3 Jan 2023 04:50:04 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2C383F587;
        Tue,  3 Jan 2023 04:49:21 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ftrace: Add sample code with dynamic ftrace_ops
Date:   Tue,  3 Jan 2023 12:49:09 +0000
Message-Id: <20230103124912.2948963-1-mark.rutland@arm.com>
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

Since v1 [1]:
* Rebase to v6.2-rc2 (trivial)
* Fix typos
* Fix commit title style
* Apply Steve's Reviewed-by to patch 2
* Fix "save_regs" module parameter name
* Add example output from sample module

[1] https://lore.kernel.org/lkml/20221103170907.931465-1-mark.rutland@arm.com/

Thanks,
Mark.

Mark Rutland (3):
  ftrace: Maintain samples/ftrace
  ftrace: Export ftrace_free_filter() to modules
  ftrace: Add sample with custom ops

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

