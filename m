Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AE469F742
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjBVPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjBVPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:00:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6E3345F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:00:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82C73CE1DE0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A438C43444;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078022;
        bh=//0EBuofToROe4aHx0Fig7UklG17tIZf4rPh6uYWYYA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bp1WJT9+8TdJIp4pxW+sPJBmJ55lT8100WwM5ZxC+gAf7r3EurN/X2Zehztmit/j5
         t8oa5P3QZd595iAym+M3wW4eC6DAQ7TNWAgL9//+LwHja5miR+O7yvXxoUiu/tFWDN
         K/zJstFnZ/C0jRO9TztJ2mYGWMOm0KzhR+aK2woFIHWI5ken3A6BGmFkk5ELMTzOWS
         zd4rj1PSq7ATxoWgN/JH1sAWgJk7pbiDV3OtKTYPTmxEViJGBu4nPh9YRSO//JYubD
         Om6KLuww+DwTXpMAfoKbrX8VKQCIqZrCMLdac8rQW8M/YB4uJRPZ27Oe8dEn1r+Kfo
         Vd25wOcK2CWCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3888BC73FF5;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] riscv: improve link and support
 ARCH_WANT_LD_ORPHAN_WARN
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167707802222.24438.1548732675746244127.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 15:00:22 +0000
References: <20230119155417.2600-1-jszhang@kernel.org>
In-Reply-To: <20230119155417.2600-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, masahiroy@kernel.org,
        keescook@chromium.org, nathan@kernel.org, conor@kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, 19 Jan 2023 23:54:12 +0800 you wrote:
> This series tries to improve link time handling of riscv:
> patch1 adds the missing RUNTIME_DISCARD_EXIT as suggested by Masahiro.
> 
> Similar as other architectures such as x86, arm64 and so on, enable
> ARCH_WANT_LD_ORPHAN_WARN to enable linker orphan warnings to prevent
> from missing any new sections in future. So the following two patches
> are preparation ones, and the last patch finally selects
> ARCH_WANT_LD_ORPHAN_WARN
> 
> [...]

Here is the summary with links:
  - [v2,1/5] riscv: lds: define RUNTIME_DISCARD_EXIT
    https://git.kernel.org/riscv/c/7e92586c28a5
  - [v2,2/5] riscv: vmlinux.lds.S: explicitly catch .rela.dyn symbols
    https://git.kernel.org/riscv/c/e5973191a8e3
  - [v2,3/5] riscv: vmlinux.lds.S: explicitly catch .riscv.attributes sections
    https://git.kernel.org/riscv/c/b13e64d94149
  - [v2,4/5] riscv: vmlinux.lds.S: explicitly catch .init.bss sections from EFI stub
    https://git.kernel.org/riscv/c/0ed0031b093b
  - [v2,5/5] riscv: select ARCH_WANT_LD_ORPHAN_WARN for !XIP_KERNEL
    https://git.kernel.org/riscv/c/f4b71bff8d85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


