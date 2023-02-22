Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26E169F73E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjBVPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjBVPAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:00:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A599A38B7D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6DE06149B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 466F5C433A8;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078022;
        bh=iRBat2u1+RmG1QEv7W26a47GotBKVLB8ntUrJI9i/oA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pz+qICuPlJ07C3m5mpGnqpXbgSV/sVvFWMg4ECZFxJIE8ngR7LvlpbAvkqP/xmiYA
         oKnf0xoPPThf1sw+LYcPnvg2Vl7I82I28wnB4e9c/iMInpeZH3xBMaMK9PoUVEcjv0
         iKrila+XO1MThyknhoCjxxu4OF1mfMWXwP84zA2CvySJ5F6OUh8eENcXYeXAn5sSnF
         n1xdALsNKpR8lWZQMN02YNxcM7pAj7McciQqO1EBc6QzegO6uuO1Gjd4a/fNnwp+CW
         3gaDB1rIIhhejYYEQd5NmhkxgIul8LiowJrjqUeZwJIMtMZOUgo3GiwEsHi5tE0SJf
         S6SlN0Rk6sAig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 218EDC73FE7;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: alternative: proceed one more instruction for
 auipc/jalr pair
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167707802213.24438.17946403277180818321.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 15:00:22 +0000
References: <20230115162811.3146-1-jszhang@kernel.org>
In-Reply-To: <20230115162811.3146-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        heiko.stuebner@vrull.eu, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 16 Jan 2023 00:28:11 +0800 you wrote:
> If we patched auipc + jalr pair, we'd better proceed one more
> instruction. Andrew pointed out "There's not a problem now, since
> we're only adding a fixup for jal, not jalr, but we should
> future-proof this and there's no reason to revisit an already fixed-up
> instruction anyway."
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> 
> [...]

Here is the summary with links:
  - riscv: alternative: proceed one more instruction for auipc/jalr pair
    https://git.kernel.org/riscv/c/91612cfb1736

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


