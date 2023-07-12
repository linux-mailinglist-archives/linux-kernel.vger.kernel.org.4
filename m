Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31D5750D55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjGLQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGLQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E951518E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DF661873
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2903C433CA;
        Wed, 12 Jul 2023 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689177621;
        bh=NdMXVOOo+vMWBtkROJHL2faZFyhzZddyI2xLmLOz4YQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aoOsOqQnnaAye7ZDa+X7xi6olX9cqLD/258LDjXjpxi2RzZPBhvRU5uIS6AAy4jRn
         hdGHYzpIQxACfn2/GBbJXq9z/Kj9mp9QbapiNoswquNYEL1uErennKQJFrYpobYLyi
         BH2LsAQCxNxO2SX5zF38uzxLLpogWl0xD4bD5OZvW3r/z92vQ0Vbo8kj257B1LSmpx
         iSP29OAGGsEjw5MDk5vHayccrrZVg5pRmg5wOhl0ewKrH66f0gBB6TmPbOV7mkQzGG
         knTaUI+r8INBdSXnxS1BU4lyO+AIm73rcxPZ9CwhUD2BnOEKJ9E4uhVsN3RL3+uFEe
         sXBbzaMo5/P9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2B1CC04E32;
        Wed, 12 Jul 2023 16:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: mm: fix truncates issue on RV32
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168917762166.26837.18011111020285782236.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 16:00:21 +0000
References: <20230709171036.1906-1-jszhang@kernel.org>
In-Reply-To: <20230709171036.1906-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org, lkp@intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 10 Jul 2023 01:10:36 +0800 you wrote:
> lkp reports below sparse warning when building for RV32:
> arch/riscv/mm/init.c:1204:48: sparse: warning: cast truncates bits from
> constant value (100000000 becomes 0)
> 
> IMO, the reason we didn't see this truncates bug in real world is "0"
> means MEMBLOCK_ALLOC_ACCESSIBLE in memblock and there's no RV32 HW
> with more than 4GB memory.
> 
> [...]

Here is the summary with links:
  - riscv: mm: fix truncates issue on RV32
    https://git.kernel.org/riscv/c/b690e266dae2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


