Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8267A969
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjAYDub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjAYDu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:50:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C72D4859B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:50:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94881B81897
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B45DC433A8;
        Wed, 25 Jan 2023 03:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674618619;
        bh=W49himB24WbXFY9PqkkVpWkwLeDmCXXyYZNXQsCimqU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DQBxlohxyD9EKJywFWIB5YJu5Dm1GsiWzY5DivbfB77DOSWMi+Z+By+ZJXsDXOLff
         tcHF3o3x82ddK7GkBfxacVAGDOF57yIeB35E43kdxmlk6ssxZNs0nL3Yeu2SChHpxF
         fLQt0ySRveCHQt/pol2br+Or9Lc4JR3HlHk+COhP6LFu13LCaDOU09OrDAPrbM3JqO
         u5nlmfEqh510gVXULgt0jm3AaZ3ZG8MmmmJp5iyAT2RzVvOLJdX8G/ss2ZEtSuA0+z
         Qx66wJ5JvlBdkZR2t0QhhCi1ujuKjSKOkflnzImLTLrjA7Y49I+1+TzKtmBjBq93yB
         e66n1a7vKiUzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBF22F83ED5;
        Wed, 25 Jan 2023 03:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: pgtable: Fixup comment for KERN_VIRT_SIZE
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167461861896.411.6044285262102729324.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Jan 2023 03:50:18 +0000
References: <20230110080419.931185-1-guoren@kernel.org>
In-Reply-To: <20230110080419.931185-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, alexandre.ghiti@canonical.com,
        palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com
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

On Tue, 10 Jan 2023 03:04:19 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> KERN_VIRT_SIZE is 1/4 of the entries of the page global directory,
> not half.
> 
> Fixes: f7ae02333d13 ("riscv: Move KASAN mapping next to the kernel mapping")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> 
> [...]

Here is the summary with links:
  - riscv: pgtable: Fixup comment for KERN_VIRT_SIZE
    https://git.kernel.org/riscv/c/6be1ff430dab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


