Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A404F6627E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbjAIN7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjAIN65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:58:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9090DF6F;
        Mon,  9 Jan 2023 05:58:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5558C1A25;
        Mon,  9 Jan 2023 05:59:38 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7FEEF3F23F;
        Mon,  9 Jan 2023 05:58:54 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org, ndesaulniers@google.com,
        ojeda@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, rostedt@goodmis.org,
        will@kernel.org
Subject: [PATCH 7/8] arm64: ftrace: Update stale comment
Date:   Mon,  9 Jan 2023 13:58:27 +0000
Message-Id: <20230109135828.879136-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230109135828.879136-1-mark.rutland@arm.com>
References: <20230109135828.879136-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit:

  26299b3f6ba26bfc ("ftrace: arm64: move from REGS to ARGS")

... we folded ftrace_regs_entry into ftrace_caller, and
ftrace_regs_entry no longer exists.

Update the comment accordingly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index b30b955a89211..38ebdf063255b 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -209,7 +209,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
  * | NOP      | MOV X9, LR | MOV X9, LR |
  * | NOP      | NOP        | BL <entry> |
  *
- * The LR value will be recovered by ftrace_regs_entry, and restored into LR
+ * The LR value will be recovered by ftrace_caller, and restored into LR
  * before returning to the regular function prologue. When a function is not
  * being traced, the MOV is not harmful given x9 is not live per the AAPCS.
  *
-- 
2.30.2

