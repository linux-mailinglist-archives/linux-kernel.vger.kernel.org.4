Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026FF5EC8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiI0QCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI0QBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B0A2A9F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF3F61A95
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DC4C433B5;
        Tue, 27 Sep 2022 16:01:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2l-00G2tU-0y;
        Tue, 27 Sep 2022 12:02:47 -0400
Message-ID: <20220927160246.762009135@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <mhiramat@kernel.org>, <peterz@infradead.org>, <ast@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: [for-next][PATCH 11/20] x86/kprobes: Remove unused arch_kprobe_override_function()
 declaration
References: <20220927160216.349640304@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaosheng Cui <cuigaosheng1@huawei.com>

All uses of arch_kprobe_override_function() have been removed by
commit 540adea3809f ("error-injection: Separate error-injection
from kprobe"), so remove the declaration, too.

Link: https://lkml.kernel.org/r/20220914110437.1436353-3-cuigaosheng1@huawei.com

Cc: <mingo@redhat.com>
Cc: <tglx@linutronix.de>
Cc: <bp@alien8.de>
Cc: <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: <hpa@zytor.com>
Cc: <mhiramat@kernel.org>
Cc: <peterz@infradead.org>
Cc: <ast@kernel.org>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/include/asm/kprobes.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 71ea2eab43d5..a2e9317aad49 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -50,8 +50,6 @@ extern const int kretprobe_blacklist_size;
 
 void arch_remove_kprobe(struct kprobe *p);
 
-extern void arch_kprobe_override_function(struct pt_regs *regs);
-
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
 	/* copy of the original instruction */
-- 
2.35.1
