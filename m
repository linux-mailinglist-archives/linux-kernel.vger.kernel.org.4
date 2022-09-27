Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4665EC8DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiI0QCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiI0QBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC01918B4BE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 493F961A85
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24407C433D6;
        Tue, 27 Sep 2022 16:01:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2k-00G2su-1n;
        Tue, 27 Sep 2022 12:02:46 -0400
Message-ID: <20220927160246.094153309@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <mhiramat@kernel.org>, <peterz@infradead.org>, <ast@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: [for-next][PATCH 10/20] x86/ftrace: Remove unused modifying_ftrace_code declaration
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

All uses of modifying_ftrace_code have been removed by
commit 768ae4406a5c ("x86/ftrace: Use text_poke()"),
so remove the declaration, too.

Link: https://lkml.kernel.org/r/20220914110437.1436353-2-cuigaosheng1@huawei.com

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
 arch/x86/include/asm/ftrace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index b5ef474be858..908d99b127d3 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -23,7 +23,6 @@
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
 #ifndef __ASSEMBLY__
-extern atomic_t modifying_ftrace_code;
 extern void __fentry__(void);
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
-- 
2.35.1
