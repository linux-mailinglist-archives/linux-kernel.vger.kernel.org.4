Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF4E647A57
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiLHXuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLHXuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77301C405
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D571620DA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 23:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9481C433F0;
        Thu,  8 Dec 2022 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670543415;
        bh=YEg/kqUiMcU5Qvfb4M+IRYn0TXWZlyRJBxtS+d/nXXc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fGdZtnqFz6beBEyysnoTt2npctzN43nHJUoyg9RiMsBxoL3VnR275JwPW3xYazSG5
         LxcUi+oqKGq+M+vCnwElDn67aCOzQTOJNUDOBSXUksEl4EsTh9Y+fOQZJ71NdAaiM3
         qd6tzDoKvhfk5KlcbF6WJjS8G7EeDbJuPd6DZAO8/FpyPMm81TN0ZZerFS10X+0N6M
         JcI+wc0hHK+5u0ubY3oc8hWQuiglqbi67ogiAnm6UG6ZYFA1PsW1qJk4jjO+hmalQ9
         Hrisdhhh40rF/kdMuzn3MQmdjQETHqwp0yDte8F1F4eWWQYFOp+EM8eE8jpU7DlHON
         CAQ+OM0XbGFRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96397E1B4D8;
        Thu,  8 Dec 2022 23:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: Fix unannoted hardirqs-on in return to userspace
 slow-path
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167054341561.16966.16448595920168997874.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Dec 2022 23:50:15 +0000
References: <20221111223108.1976562-1-abrestic@rivosinc.com>
In-Reply-To: <20221111223108.1976562-1-abrestic@rivosinc.com>
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        atishp@rivosinc.com, guoren@kernel.org,
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

On Fri, 11 Nov 2022 17:31:08 -0500 you wrote:
> The return to userspace path in entry.S may enable interrupts without the
> corresponding lockdep annotation, producing a splat[0] when DEBUG_LOCKDEP
> is enabled. Simply calling __trace_hardirqs_on() here gets a bit messy
> due to the use of RA to point back to ret_from_exception, so just move
> the whole slow-path loop into C. It's more readable and it lets us use
> local_irq_{enable,disable}(), avoiding the need for manual annotations
> altogether.
> 
> [...]

Here is the summary with links:
  - RISC-V: Fix unannoted hardirqs-on in return to userspace slow-path
    https://git.kernel.org/riscv/c/b0f4c74eadbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


