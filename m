Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008AA662D24
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjAIRpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbjAIRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:45:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD72395CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:45:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A8396124B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB7FC433D2;
        Mon,  9 Jan 2023 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673286334;
        bh=N/mGC1JSaAE/Ch09Nd54a2F0u2gUgX6CiTHhcHbSQ1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2B9nZaiKwxOFnGCxW1UZllASxVtPY2UB+BNGkSihEBHz6fEgQdOtgomB7sELwuON
         bl/sx60FbrFOv2p/yre1OVm72cHaZg79zO1KvDMbBD1IhPR9u9/qbzyFkYAHHgIjMm
         m7nUaEbnJbrDfu4WdMn7SGz6Q6JqCyRUWuqsj+4zj5GYVKZZ88Ybx8BIReFTLILHG4
         myE2MnpoUYh1XoIUIgNPnnchx1lF3H08a59oa1UFm7eHkt9MaKUnvXmq6AxheCTE9g
         1TaRRwFwObNGNl+SPOZ2LwFopkiIKbv5owLU56d6she5DjDGUghyTf9+/ir2WIn3sl
         xhBrtnF8+Fl8w==
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Tom Rix <trix@redhat.com>,
        Florent Revest <revest@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] arm64: Fix build with CC=clang, CONFIG_FTRACE=y and CONFIG_STACK_TRACER=y
Date:   Mon,  9 Jan 2023 17:45:28 +0000
Message-Id: <167327998306.3113570.4853582275546519184.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230109122744.1904852-1-james.clark@arm.com>
References: <20230109122744.1904852-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 12:27:43 +0000, James Clark wrote:
> commit 45bd8951806e ("arm64: Improve HAVE_DYNAMIC_FTRACE_WITH_REGS
> selection for clang") fixed the build with the above combination by
> splitting HAVE_DYNAMIC_FTRACE_WITH_REGS into separate checks for
> Clang and GCC.
> 
> commit 26299b3f6ba2 ("ftrace: arm64: move from REGS to ARGS") added the
> GCC only check "-fpatchable-function-entry=2" back in unconditionally
> which breaks the build.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Fix build with CC=clang, CONFIG_FTRACE=y and CONFIG_STACK_TRACER=y
      https://git.kernel.org/arm64/c/68a63a412d18

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
