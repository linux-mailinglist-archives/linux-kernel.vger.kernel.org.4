Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1916FB324
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjEHOmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjEHOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988CB76A9
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15E4064071
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69FA2C4331D;
        Mon,  8 May 2023 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683556916;
        bh=MrdCpjU5cKRZ+iOA16YP4qYRYpFPsfYgs180muKVh7I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=k4QlnF2U2dcoBqTj74KrZ25LExHhiKev2gieWJ+s7h2X/LrnG2/xSkOrpXosRsZlr
         JJaPbd63AE4Y2S4RWT5gHOcrMNopQUgzA6AtCyUYMD61FgfNYWMN8fvM2MPcBN8upb
         cMKuA3fiUopDvKwJReqNyqCIRLPEqNr7AKsEv6/2uvtVXx00V9g4oJPUZp1vrBgqob
         X8+VRIlpXktuamOlqb5e3MewEZGH3nqfdQvmWorhuq3DIgHKZHQRZJhisbhmlqY4TI
         V+XNzRVZ3xe8O87ji12B0SVm7EPl8FqtTduH7pfOUlnlE0VZAFqQtmm4idepEzmcP/
         O1bUK/fH/qYGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44A7BE4F0A0;
        Mon,  8 May 2023 14:41:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v18 0/7] RISC-V IPI Improvements
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168355691627.25692.3962222758677102007.git-patchwork-notify@kernel.org>
Date:   Mon, 08 May 2023 14:41:56 +0000
References: <20230328035223.1480939-1-apatel@ventanamicro.com>
In-Reply-To: <20230328035223.1480939-1-apatel@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de, maz@kernel.org,
        daniel.lezcano@linaro.org, atishp@atishpatra.org,
        Alistair.Francis@wdc.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Marc Zyngier <maz@kernel.org>:

On Tue, 28 Mar 2023 09:22:16 +0530 you wrote:
> This series aims to improve IPI support in Linux RISC-V in following ways:
>  1) Treat IPIs as normal per-CPU interrupts instead of having custom RISC-V
>     specific hooks. This also makes Linux RISC-V IPI support aligned with
>     other architectures.
>  2) Remote TLB flushes and icache flushes should prefer local IPIs instead
>     of SBI calls whenever we have specialized hardware (such as RISC-V AIA
>     IMSIC and RISC-V SWI) which allows S-mode software to directly inject
>     IPIs without any assistance from M-mode runtime firmware.
> 
> [...]

Here is the summary with links:
  - [v18,1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
    https://git.kernel.org/riscv/c/3ee92565b83e
  - [v18,2/7] irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
    https://git.kernel.org/riscv/c/0c60a31ce62c
  - [v18,3/7] RISC-V: Treat IPIs as normal Linux IRQs
    https://git.kernel.org/riscv/c/832f15f42646
  - [v18,4/7] RISC-V: Allow marking IPIs as suitable for remote FENCEs
    https://git.kernel.org/riscv/c/fb0f3d281b7f
  - [v18,5/7] RISC-V: Use IPIs for remote TLB flush when possible
    https://git.kernel.org/riscv/c/18d2199d8105
  - [v18,6/7] RISC-V: Use IPIs for remote icache flush when possible
    https://git.kernel.org/riscv/c/627922843235
  - [v18,7/7] irqchip/riscv-intc: Add empty irq_eoi() for chained irq handlers
    https://git.kernel.org/riscv/c/f8415f2def18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


