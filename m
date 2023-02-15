Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C3697F02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBOPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBOPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:00:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703D16A73
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 190BDB82252
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95104C433EF;
        Wed, 15 Feb 2023 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676473220;
        bh=gAEa31AYEDjZmUvHEiW7JfL4UhgpHyb6OCumJEqk5qc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TXhyaYbcR7TMX1dgz3IBiT7xQLbEIruGiwe6KLHeq88PpMMjCr+wmjCzAfDvxxY8X
         0JcIQ/RhbeOumVr8u1LmiuPYsIrUwHIJjOFV/F8hvvu/7sE7+7AJwFgefHDQ/b63uX
         zgZHl3msu+StN2BiJjBvnsH0xNhfXMxhYI8tDZr33MGYqROjC1zXRLL4X1SGQhS+x3
         AfrPt2SWtZ6fWoKfxx4+G0fyxeoqhbpbPwc/XQif0BzFafl7kbAWbDQwVoE+E3Lphw
         PzlK5K6gj4/5b3r4CUo1our7qK7n7aqxGzJqLIXUznw1pN3I97oSWYjsx6B2mU7I3f
         diS/2ax4BfvIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AC20E21EC4;
        Wed, 15 Feb 2023 15:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv: Fix alternatives issues on for-next
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167647322042.11521.13482164945173632656.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Feb 2023 15:00:20 +0000
References: <20230212021534.59121-1-samuel@sholland.org>
In-Reply-To: <20230212021534.59121-1-samuel@sholland.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-riscv@lists.infradead.org, heiko@sntech.de,
        jszhang@kernel.org, palmer@dabbelt.com, ajones@ventanamicro.com,
        christoph.muellner@vrull.eu, conor.dooley@microchip.com,
        guoren@kernel.org, heiko.stuebner@vrull.eu, nathan@kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 11 Feb 2023 20:15:31 -0600 you wrote:
> Several people have reported that D1 fails to boot on linux-next.
> Patch 1 fixes a bug where early alternative patching used the wrong
> address. Patch 2 fixes a separate issue where the Zbb alternatives
> are incorrectly applied based on the 'C' extension instead of Zbb.
> 
> 
> Samuel Holland (2):
>   riscv: Fix early alternative patching
>   riscv: Fix Zbb alternative IDs
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: Fix early alternative patching
    https://git.kernel.org/riscv/c/bfd6fc5d8014
  - [2/2] riscv: Fix Zbb alternative IDs
    https://git.kernel.org/riscv/c/d5a7fab7859d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


