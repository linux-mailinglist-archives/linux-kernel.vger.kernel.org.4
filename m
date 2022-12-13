Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7031464B9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiLMQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbiLMQaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117251FCDE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FF3361610
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E746EC433D2;
        Tue, 13 Dec 2022 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670949016;
        bh=LloHy53SbXLXbE3aV7SnS0epf3d4eEaPG0nvPWm1AfQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ajLW80LQJ3VakJm1vjQtecugwbpUXmVGTeOltV/ruIhdblqugqrCiSNPTuS5u0KxQ
         +AoXgGKh9IXYpmjNSUbqWDDgfThQoOC0GzictRr7n1Y3EJ/nKg9G531pGCQw5RWrKH
         dWOi0nZoFHH9czhdqyO7QFd41RZuwKMSrdkx9W8saAaY1BikzPiZUQJyU+ie75EVYn
         hZe/in+IWMD2AOaeE2m072RgMAtHKWVwExE8N/7go2Cj77QhjyBLIMVV6G+zJklC72
         9fR5KNR9zkX2JFSRV3KvwfDe5flMLJKBqmFA63/NLhDstGpe3wRG0RVaYokLroUEUR
         CHGJy/GgMt/RQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C936CE50D97;
        Tue, 13 Dec 2022 16:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] riscv: Fix P4D_SHIFT definition for 3-level page table
 mode
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167094901682.29011.15971870673116736802.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Dec 2022 16:30:16 +0000
References: <20221201135128.1482189-1-alexghiti@rivosinc.com>
In-Reply-To: <20221201135128.1482189-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        panqinglin2020@iscas.ac.cn, linux-mm@kvack.org,
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  1 Dec 2022 14:51:27 +0100 you wrote:
> +cc linux-mm since I'm struggling to know how bad is this issue and
> if this should be picked for 6.1-rc8 or not.
> 
> I tested this fix on an Ubuntu kernel in sv39 mode without any issue
> but the version without the fix seems to work fine too, either this is
> not a real issue or I don't exercise the right thing to make it visible.
> 
> [...]

Here is the summary with links:
  - [1/1] riscv: Fix P4D_SHIFT definition for 3-level page table mode
    https://git.kernel.org/riscv/c/71fc3621efc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


