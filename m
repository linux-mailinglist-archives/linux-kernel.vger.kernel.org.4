Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1374B3C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjGGPKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGGPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AEDAA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 183E2619EC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F88DC433C8;
        Fri,  7 Jul 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688742623;
        bh=2dh4tnVkPfE/NzvB3pEYoTiSBYTXVvMwmr877tZQ0Ic=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ICetrvfi1hW/2srHYb3SFLoBmdGXeN5OsIDMJHSm7oDNexAzcIRUnbRve1jaCYT6M
         j7BZS3+Z4K6wRa7m2po5Y0fx/skuAb50FYoG1D61eERZGZwMYKNBPH0o4xXTX2xzPZ
         K9Nr2jgtht0cLyDmrdNttVDDtmJe9AM9OGlQ66FKdoblaGCeHYjiiKEspvxdwOvUej
         AExCh0HzCPPTx1tWbglABOZLaXN3YF9CJcjsuXfvQddXIpeF3uk4ZnGHJHKEH2OIsu
         mVJ/9a0b5yy32cjgjgvFsMNwvj17mgM5MNRWhMLxXGCvJ5SIa7vHRVGoJ6JL6YZ8x3
         ELVgEIlQ4pwKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54507E53801;
        Fri,  7 Jul 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] riscv: some CMO alternative related clean up
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168874262334.15275.18352096242766499021.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Jul 2023 15:10:23 +0000
References: <20230614165504.532-1-jszhang@kernel.org>
In-Reply-To: <20230614165504.532-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
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

On Thu, 15 Jun 2023 00:55:01 +0800 you wrote:
> This series consists of clean up patches of the "riscv: Reduce
> ARCH_KMALLOC_MINALIGN to 8" series[1]. Per Catalin suggestion, I will
> submit the enabling of riscv ARCH_KMALLOC_MINALIGN 8 in next
> development window. However, the cleanups are good for submitting
> now.
> 
> PS: Conor's reviewed-by tag is included.
> 
> [...]

Here is the summary with links:
  - [1/3] riscv: errata: thead: only set cbom size & noncoherent during boot
    https://git.kernel.org/riscv/c/31ca5d49264b
  - [2/3] riscv: mm: mark CBO relate initialization funcs as __init
    https://git.kernel.org/riscv/c/3b472f860c5c
  - [3/3] riscv: mm: mark noncoherent_supported as __ro_after_init
    https://git.kernel.org/riscv/c/8500808a991f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


