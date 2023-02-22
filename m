Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5EA69F73C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjBVPAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjBVPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:00:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440FC38B74
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9BD36149A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CCC4C4339C;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078022;
        bh=0/hM32z/5MnMiEUWQJhkGpZLjabYOUrD9dJBCTHVHTM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uAwRy1qAVcfjITCYBE8umJfNQ1GRMlMscOEacIzUO+BxNjAOViiEc9dI9BitV0oTh
         I2bY9m6QpIQQbdHYEvStxGO5Drxs7NWEUUVu0ZgnPWzA9loTZGMxm6Che9Pvnm71gP
         nEUPg9RG+9G14/Q4O9+WLv9OuB4eZW+DR3LH57yWPfnoWpfqJhILmNWgBjsyZqX2Dt
         oJrgyYr4DljW3XOC40C6Gl3sKIkTU0Zz7a3Z3YgbWtptGLQg05vEIcg3YzEqWEnDyE
         JNpke7HdKD+PWRtN17kv1QhYlCzvYUD/3srnnsBYsuqdCee8pfGUtkMNw9X69bP74C
         gAzfD4oSHc+aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F261CC43157;
        Wed, 22 Feb 2023 15:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next V3 0/2] riscv: jump_label: Fixup & Optimization
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167707802198.24438.1425894131434754650.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 15:00:21 +0000
References: <20230126170607.1489141-1-guoren@kernel.org>
In-Reply-To: <20230126170607.1489141-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, jrtc27@jrtc27.com, andy.chiu@sifive.com,
        zong.li@sifive.com, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 26 Jan 2023 12:06:05 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Patch 1 is the fixup patch should be merged into stable-tree.
> Patch 2 is a continuous optimization for jump_label patch_text
> atomicity.
> 
> Changes in V3:
>  - Correct the typo C.JAL -> C.J (Thx Jessica)
>  - Fixup compile error when CONFIG_RISCV_ISA_C=n
>  - Rebase on riscv for-next (20230127)
> 
> [...]

Here is the summary with links:
  - [-next,V3,1/2] riscv: jump_label: Fixup unaligned arch_static_branch function
    https://git.kernel.org/riscv/c/9ddfc3cd8060
  - [-next,V3,2/2] riscv: jump_label: Optimize the code size with compressed instruction
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


