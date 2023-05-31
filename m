Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9707185C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjEaPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjEaPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB11698
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FC8763D18
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9527C433EF;
        Wed, 31 May 2023 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685545821;
        bh=ZWD2zkUqIfn7LVLDVSME3AoFlWVrJDLG/awdINUug6s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AkbS2cuGbFB2C3gWF8PvQhTWG1afWkfQafSs+uoCH9LBJonNloSyQ6Qz8XT0CBquP
         XLRkw3/R42Bd6QHHUkosQxG0WwGggVPKaFCygeCpb/ew6G0GdVW9dfbceOSmXm74wX
         IqhP2xG6JsOuCdISRmlusxFL0nH+G+ocTlA5pWnuGUrNQ1p00duwHb1FgcAg3n4FF5
         IXm5itCrhltNNA67Tew/cf9uZkZ3gcd+QOx2OhXKKoUVXRUsdLyXmFgveqeEceLRr5
         Txpix/zFFubRHiul7SVdRp+8+6vEcIf7C/0/8qEZ/gZojCwfFPKIFN2Y0Pih0Moiqe
         vlYewTAxCAnNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C00A5E52BF3;
        Wed, 31 May 2023 15:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early alternatives
 using -fno-pie
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168554582178.8247.10623595249995347296.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 15:10:21 +0000
References: <20230526154630.289374-1-alexghiti@rivosinc.com>
In-Reply-To: <20230526154630.289374-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, schwab@linux-m68k.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 26 May 2023 17:46:30 +0200 you wrote:
> Early alternatives are called with the mmu disabled, and then should not
> access any global symbols through the GOT since it requires relocations,
> relocations that we do before but *virtually*. So only use medany code
> model for this early code.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Fix relocatable kernels with early alternatives using -fno-pie
    https://git.kernel.org/riscv/c/8dc2a7e8027f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


