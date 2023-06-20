Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A197360EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjFTBA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjFTBA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3FA18C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9351A60F4E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEAC6C433C9;
        Tue, 20 Jun 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687222824;
        bh=m/bds2qI0I7nlVEDozWBkVc/6egEMeDsV/8HStsN4z4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rdW3s00rS+h79iJWRc2WnutP++TKWYBPoSbAqw+xSYnu5frnlgP7HrbKr++TSPbmr
         /ncvhGoxZJWV/yQhoUBui8QXQgJIeMonsBEiQZZ2d/XUkTjJK3KYGrxqHzEaVk4kmH
         PYj+vcofq9ZNWMBP58eyhL6cW7Wzs/bbnimAcoYtQpbHQFQSA8I6T/xTr2eWa8q2hI
         MgDBnVhFP1E/Cxh+1j1GqUUy8d6SQXDxbQ8gHNRYjayjefZsuYYeMbUjBUMVoffWfM
         fGsDobSxfJazK5Zd/STF0xdANPykqHGc5l/PiGZd9A17uUwXeYuOlU555VgDaJdTnH
         2D/HILve1t+Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBFE3C43168;
        Tue, 20 Jun 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: hibernation: Replace jalr with jr before
 suspend_restore_regs
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168722282382.22807.3982031186213234976.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 01:00:23 +0000
References: <20230519060854.214138-1-suagrfillet@gmail.com>
In-Reply-To: <20230519060854.214138-1-suagrfillet@gmail.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 19 May 2023 14:08:54 +0800 you wrote:
> No need to link the x1/ra reg via jalr before suspend_restore_regs
> So it's better to replace jalr with jr.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/kernel/hibernate-asm.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - riscv: hibernation: Replace jalr with jr before suspend_restore_regs
    https://git.kernel.org/riscv/c/650ea2a1dd96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


