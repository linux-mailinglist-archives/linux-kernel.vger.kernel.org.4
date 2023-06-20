Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3C737531
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFTTk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFTTkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFF4E7D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F279960EC4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52D32C433C9;
        Tue, 20 Jun 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687290023;
        bh=mM9yZzRc1EvsVBVrsYVux7+dW6hdoDW/V0q9LAFw450=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=K4rKjZVg4wMrZnfe/taLR8c5BRD7xwffa4W8FuheDFdqZAdg+EFC2cyd04uSx1DbX
         KD2zGS5HXV0pE4uedkw6BXCNYMNOt42BWWN8sA3fKSRP+MI4ld7SiAfBR9+2DWmVzp
         xPHslnDdfB+GqZZrg3bRCr2de9dTrwMMcgemFyykKpDvELCoOoqQ9YiJLmfDzwb8FY
         qkS5yrTsRI6ECcHTduj+SUwG2/k0IDq9YapEE8otQJeobXi8EZwvdCuRVKvX/uAPoJ
         ntzf85bkWUJjTKjAWnfTxxyYZ6nhEvEeLDC+8E2YDWnyN0uF6MUcMYSNsKDHsgfhMM
         qWdSSQUjjHAfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38EDEC395D9;
        Tue, 20 Jun 2023 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: replace deprecated scall with ecall
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168729002322.20607.3530889477319155290.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 19:40:23 +0000
References: <20230423223210.126948-1-maskray@google.com>
In-Reply-To: <20230423223210.126948-1-maskray@google.com>
To:     Fangrui Song <maskray@google.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
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

On Sun, 23 Apr 2023 22:32:10 +0000 you wrote:
> scall is a deprecated alias for ecall. ecall is used in several places,
> so there is no assembler compatibility concern.
> 
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  arch/riscv/kernel/entry.S             | 4 ++--
>  arch/riscv/kernel/vdso/rt_sigreturn.S | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - riscv: replace deprecated scall with ecall
    https://git.kernel.org/riscv/c/4681dacadeef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


