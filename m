Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75BE7360F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFTBAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFTBAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16668187
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E18A60F38
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE71FC433C0;
        Tue, 20 Jun 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687222823;
        bh=d1EVAIuUCkQo8k/ULkkFYkAV6A3t5sHL69vz5H1Z1a8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dVywihqGfCS3dskFd6RjHIXYmAsUMhLaLN30lwloXCa9Up8R1yHKpBGaPZxyWzbL5
         3NzveDV4CJK7bcJhceRXCRjUagX6eD1HXk8PV5PFrBZkGdI2PCDpp2dHbuYAeA9gby
         ys+YG9PqEZS/pdNU4cIA+9mYTXM6hspfw/0uKcIwpRo8h94xSvQePdwI30u6xCzUjQ
         mXqZZJ0QyxGKA15M56Y0I4mM5TPLOd/L54N8hgeuMh+uZh9orUr9mcJX4rFfpg5iUh
         S4Y+zza0Bhh3oB0g5PnolNorNEN0DF/ojAuMfC+aORERzLG4BtiHelSr7BK7llrJy+
         h3r2QjqUUOvfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE7EDE301F8;
        Tue, 20 Jun 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 -next 0/2] RISC-V ACPI: Assorted fixes
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168722282377.22807.11943189274896706189.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 01:00:23 +0000
References: <20230607112417.782085-1-sunilvl@ventanamicro.com>
In-Reply-To: <20230607112417.782085-1-sunilvl@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        atishp@atishpatra.org, will@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  7 Jun 2023 16:54:15 +0530 you wrote:
> This series fixes couple of issues required to complete the previously
> merged basic ACPI support series.
> 
> 1) Kernel test bot has found a new warning using the sparse tool. Though
> I believe this warning exists for other architectures also,
> I don't see an issue fixing this for RISC-V.
> 
> [...]

Here is the summary with links:
  - [v2,-next,1/2] RISC-V: ACPI : Fix for usage of pointers in different address space
    https://git.kernel.org/riscv/c/3b426d4b5b14
  - [v2,-next,2/2] RISC-V/perf: Use standard interface to get INTC domain
    https://git.kernel.org/riscv/c/ca7473cb8312

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


