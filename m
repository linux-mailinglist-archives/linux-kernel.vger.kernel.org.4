Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C90F624DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiKJWua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKJWuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:50:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE18A51C1F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A977BB823D0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54F7DC433C1;
        Thu, 10 Nov 2022 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668120616;
        bh=84QsudrNH/f0EHhVDmxqZ8qDJLJ+1IYEmL5AKFvoKtk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pCPWkmqNcfsMJl4O1gkVQ8F6luJk89T2Lbc7uJoT2r6rTUQRwP7asUngfqx+ISBdJ
         0IP5feNKDjjBgFoOjNBiUfQGEUFGzdJFaTePr00xfMU7h03EZem/GaviLLmnO+Pcwb
         5L0aavwxh6+MriXMoH9n8nKK1yv/z2A5cUvdxS6M7d4eZ04AGYdAqGfXUqH3nOEDKQ
         GPK0S3SGy1o56N3aoO+N6IXo7v723pluqZYzUPPyDlCd1fGtxQOKJON2hHSYUQqHIc
         RkOKbzjPsCqW3h5heV/sxXTOKg7HFd3WQPSxqthsdLnXvVawyhH/ezEQ6aW3yog126
         KW0LXDKmeyZAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D33CC395FD;
        Thu, 10 Nov 2022 22:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: process: fix kernel info leakage
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <166812061618.32242.11997902319930265840.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Nov 2022 22:50:16 +0000
References: <20221029113450.4027-1-jszhang@kernel.org>
In-Reply-To: <20221029113450.4027-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 29 Oct 2022 19:34:50 +0800 you wrote:
> thread_struct's s[12] may contain random kernel memory content, which
> may be finally leaked to userspace. This is a security hole. Fix it
> by clearing the s[12] array in thread_struct when fork.
> 
> As for kthread case, it's better to clear the s[12] array as well.
> 
> Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> [...]

Here is the summary with links:
  - riscv: process: fix kernel info leakage
    https://git.kernel.org/riscv/c/6510c78490c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


