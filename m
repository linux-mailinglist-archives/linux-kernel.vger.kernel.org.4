Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46C6E9AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjDTRk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDTRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE9E93;
        Thu, 20 Apr 2023 10:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 987F364AFF;
        Thu, 20 Apr 2023 17:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F125BC433EF;
        Thu, 20 Apr 2023 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682012422;
        bh=xx+vnuJ8fbBXHjt5KUhqykE72X3YbB4D+HrbBLN/fp0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=swcqEAzzNfF4PbGtLC+Y1g8NIPrhqMOJudKRPHs5s2Csb72NKfNl3YFeGxGY/Zjug
         mgDaBG1UiPHXP5gDhO5hZyyePMOqFVTrVQVAZtyXaaTobM+RSFX9sZMGuEAZzBK3/v
         1jzJz7qSpleZTattS492X+EGgmP5uB7+UQs0GORMgqN2ZnP9tvicgu0W49TS9ELd5P
         2SVRXYj2Ocu9C0rFm5WXUA+bzPprIweNTq5un4A4W8wRDrlJ7n41p+gmAmClYNyHiN
         lPlV+xhImalzbHl1zYFi22w5s33BGoaaTU+sICbNfEDgu6SSxslrYCsLHK3zP0tG6F
         msYaLIlP1PKhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2810E270E2;
        Thu, 20 Apr 2023 17:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/6] Introduce 64b relocatable kernel
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168201242185.9373.5416270250289201005.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Apr 2023 17:40:21 +0000
References: <20230329045329.64565-1-alexghiti@rivosinc.com>
In-Reply-To: <20230329045329.64565-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, ndesaulniers@google.com,
        bjorn@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
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

On Wed, 29 Mar 2023 06:53:23 +0200 you wrote:
> After multiple attempts, this patchset is now based on the fact that the
> 64b kernel mapping was moved outside the linear mapping.
> 
> The first patch allows to build relocatable kernels but is not selected
> by default. That patch is a requirement for KASLR.
> The second and third patches take advantage of an already existing powerpc
> script that checks relocations at compile-time, and uses it for riscv.
> 
> [...]

Here is the summary with links:
  - [v9,1/6] riscv: Prepare EFI header for relocatable kernels
    https://git.kernel.org/riscv/c/55de1e4ad43b
  - [v9,2/6] riscv: Move .rela.dyn outside of init to avoid empty relocations
    https://git.kernel.org/riscv/c/69a90d2fe107
  - [v9,3/6] riscv: Introduce CONFIG_RELOCATABLE
    https://git.kernel.org/riscv/c/39b33072941f
  - [v9,4/6] powerpc: Move script to check relocations at compile time in scripts/
    https://git.kernel.org/riscv/c/47981b5cc687
  - [v9,5/6] riscv: Check relocations at compile time
    https://git.kernel.org/riscv/c/c2dea0bc5339
  - [v9,6/6] riscv: Use --emit-relocs in order to move .rela.dyn in init
    https://git.kernel.org/riscv/c/559d1e45a16d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


