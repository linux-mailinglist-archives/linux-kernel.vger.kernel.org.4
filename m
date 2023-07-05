Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F0749210
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjGEXu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjGEXuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A9710F5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45E3B61804
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C4C8C433C7;
        Wed,  5 Jul 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688601022;
        bh=dgXQEhdOdm8Y9HQ7BRI3NqcsjIWDbxMCk69RUHbOSWk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dCFDTpVawFPZDWwMeLUlZl3+wm089lS5dcOC5grNJ+72BcuEaOa1oA9e4PpYqF1OC
         4cGQkMuzHX9Ni11AAaV5Iv9Iu13dfzBMwb1uC2s6/0nySsH0v0r0Dy7C3jdPNM8QtC
         Lp5AWa/WlE56DlwdZz9v1LDLFaqvuUf6QIU9c4Hz6Gxxm87wrIWGh7F0zosAlXfpTr
         SoFZRkGmZsbDT2txlI4pFS9tCboA2QScLF2SWbd1if/6ZU/Sv35k+FhF0VEuPldCsy
         nIzCFOrYbGZjsuMLHN4TrTP1ahTMFP0uN98OjTKwOD4e1tMzHNc/ZoyaxLLmOVeRGW
         WnAcI/yp+CeOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 840C5C64459;
        Wed,  5 Jul 2023 23:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Enable ARCH_SUSPEND_POSSIBLE for s2idle
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168860102253.23922.13316871741173468585.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 23:50:22 +0000
References: <20230529101524.322076-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230529101524.322076-1-songshuaishuai@tinylab.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org,
        suagrfillet@gmail.com, linux-kernel@vger.kernel.org
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 29 May 2023 18:15:24 +0800 you wrote:
> With this configuration opened, the basic platform-independent s2idle is
> provided by the sole "s2idle" string in `/sys/power/mem_sleep`.
> 
> At the end of s2idle, harts will hit the `wfi` instruction or enter the
> SUSPENDED state through the sbi_cpuidle driver. The interrupt of possible
> wakeup devices will be kept to wake the system up.
> 
> [...]

Here is the summary with links:
  - riscv: Enable ARCH_SUSPEND_POSSIBLE for s2idle
    https://git.kernel.org/riscv/c/c1f048a6bd7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


