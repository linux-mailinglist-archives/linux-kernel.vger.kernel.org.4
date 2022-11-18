Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5C962FE21
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242222AbiKRTlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiKRTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:41:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F11903A2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:41:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D73462739
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBBCC433D6;
        Fri, 18 Nov 2022 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668800476;
        bh=5Wd/yRIqV5ScFszUFr9I0FslL2CMEGpPWqImfvNoXcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BhhEUbUQq0ggnWPPWl218MoSyJivvPRa4A09SyXx7VmAb2lZSFJ7/s+cg3keAMghw
         HcunNVDNYzU8xfZ6kWY7mTsLY8g1ThwhtLlwGMcyQvHZdlm7wpKCTRRMJuMdTRoo4U
         2kbMR9lHCvCrxaFVbPFPMvr6JHD614PQ8u9hdcNMqNgUUJg/057nLS9qDlVP6vr653
         ZgE4kXnDwkC89OuPeWSNNajForUIRyuFGx235x5oX8zWrGwdpNei5soA/bVTDdZVsW
         xk/PoxYrC98oNP9Hlfx/VHiko20CLDfPhnOyPOjU49eMMDgLC1saHAhZd58El4EWsL
         Nwd6WsyZPxVlA==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        revest@chromium.org, mhiramat@kernel.org
Subject: Re: [PATCH v2 0/4] arm64/ftrace: move to DYNAMIC_FTRACE_WITH_ARGS
Date:   Fri, 18 Nov 2022 19:40:47 +0000
Message-Id: <166877980236.3587415.12262525621041241675.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221103170520.931305-1-mark.rutland@arm.com>
References: <20221103170520.931305-1-mark.rutland@arm.com>
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

On Thu, 3 Nov 2022 17:05:16 +0000, Mark Rutland wrote:
> This series replaces arm64's support for FTRACE_WITH_REGS with support
> for FTRACE_WITH_ARGS. This removes some overhead and complexity, and
> removes some latent issues with inconsistent presentation of struct
> pt_regs (which can only be reliably saved/restored at exception
> boundaries).
> 
> The existing FTRACE_WITH_REGS support was added for two major reasons:
> 
> [...]

Applied to arm64 (for-next/ftrace), thanks!

[1/4] ftrace: pass fregs to arch_ftrace_set_direct_caller()
      https://git.kernel.org/arm64/c/9705bc709604
[2/4] ftrace: rename ftrace_instruction_pointer_set() -> ftrace_regs_set_instruction_pointer()
      https://git.kernel.org/arm64/c/0ef86097f127
[3/4] ftrace: abstract DYNAMIC_FTRACE_WITH_ARGS accesses
      https://git.kernel.org/arm64/c/94d095ffa0e1
[4/4] ftrace: arm64: move from REGS to ARGS
      https://git.kernel.org/arm64/c/26299b3f6ba2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
