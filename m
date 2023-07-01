Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF911744A57
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGAPpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGAPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7AB2686
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 08:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1482460AE7
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 15:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B83BC433C7;
        Sat,  1 Jul 2023 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688226304;
        bh=5goMEgvQFh3eL2WcHllJEDQ78LTNrgS33kORtflyOxk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KpsoAvIRfgnJqLnaqX3b2h0p0uqQxZ+5zGKaYWJ0WjeCASghSnQoGm+t2wDRSsYYk
         Fx1/NVCkFFZG90oWiAFs7alb7llwYIYorfuEpkdOE3FGPWLADNYOi0aQJ4kFj5XBMq
         n/W9DvP4ia+kDP70eRa+6wJIITVLdIS3oAO4UKGYeJ3d04SGiQ2QRFBact59s7IDgd
         sRM0B/peII413QdO9JUngpDrG5aS8OUpyWBxiOEmCs5u/sPkOYoKXX5JGw502FRH50
         mT/1hkJG7iDIIbtZ6e+CUG3L3NX6faW6eGyx9VW7ux0KMzKsS93AkhWfm8Ct0iu5De
         gOnRKwnf6+1Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49E60E5381B;
        Sat,  1 Jul 2023 15:45:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.5 Merge Window, Part 1
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168822630429.22742.3829252189849990649.git-patchwork-notify@kernel.org>
Date:   Sat, 01 Jul 2023 15:45:04 +0000
References: <mhng-ebcc1b82-5dd0-4f2d-824e-8d9250374abf@palmer-ri-x1c9>
In-Reply-To: <mhng-ebcc1b82-5dd0-4f2d-824e-8d9250374abf@palmer-ri-x1c9>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
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

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 30 Jun 2023 08:40:50 -0700 (PDT) you wrote:
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> 
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-mw1
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.5 Merge Window, Part 1
    https://git.kernel.org/riscv/c/533925cb7604

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


