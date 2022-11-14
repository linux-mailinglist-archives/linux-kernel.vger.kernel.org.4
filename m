Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89218628145
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiKNN3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiKNN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:29:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9C020BDB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:29:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CCF3B80EBB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4DCC433C1;
        Mon, 14 Nov 2022 13:29:00 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] arm64: ftrace: Define ftrace_stub_graph only with FUNCTION_GRAPH_TRACER
Date:   Mon, 14 Nov 2022 13:28:58 +0000
Message-Id: <166843253456.1481799.5153520671489594909.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109192831.3057131-1-samitolvanen@google.com>
References: <20221109192831.3057131-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 19:28:31 +0000, Sami Tolvanen wrote:
> The 0-day bot reports that arm64 builds with CONFIG_CFI_CLANG +
> CONFIG_FTRACE are broken when CONFIG_FUNCTION_GRAPH_TRACER is not
> enabled:
> 
>  ld.lld: error: undefined symbol: __kcfi_typeid_ftrace_stub_graph
>  >>> referenced by entry-ftrace.S:299 (arch/arm64/kernel/entry-ftrace.S:299)
>  >>>               arch/arm64/kernel/entry-ftrace.o:(.text+0x48) in archive vmlinux.a
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: ftrace: Define ftrace_stub_graph only with FUNCTION_GRAPH_TRACER
      https://git.kernel.org/arm64/c/2598ac6ec493

-- 
Catalin

