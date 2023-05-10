Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C36FD617
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjEJFU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEJFUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B382683
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B650163995
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAD79C4339B;
        Wed, 10 May 2023 05:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683696022;
        bh=Bi3GyuHId+ec7J9NjOJf3MZv/MmdYCZCwvjP0Jdaeok=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n4fkcaVvfP0zUJlrEr+bQ6PeIYSufcTvOWAwXAdQpAvveuFh2n9hIQaGmrKIzGa2q
         /qXVsSlIz4PYMY5TiefImHeCGL8wadnU0fmsMvFe4neX0rrPHXxvnJG7qog8ePn0W0
         ETO7c/FpBaDL1dyTggKIwpx87RpvDyyqm9xcJ95xk4Pwr8vOaZPofLjVkCxM7XiE4W
         IZmtcs0Ndbeal+eogG6ZTj2O5DDjnQmtketpqavT4+b6ccIAnV0KfysX/44b7m5LYj
         zKfErfAW6UIKz+nfwBaQwlIRXHPNhgbISpBBVl++GyqeCAzZFVNPnrZrBrrcybaVyR
         hYY3sRuVo3xSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8CDDE26D21;
        Wed, 10 May 2023 05:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: bcm7xx: Correct read from expansion register
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168369602268.9775.867364427097647378.git-patchwork-notify@kernel.org>
Date:   Wed, 10 May 2023 05:20:22 +0000
References: <20230508231749.1681169-1-f.fainelli@gmail.com>
In-Reply-To: <20230508231749.1681169-1-f.fainelli@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 May 2023 16:17:49 -0700 you wrote:
> Since the driver works in the "legacy" addressing mode, we need to write
> to the expansion register (0x17) with bits 11:8 set to 0xf to properly
> select the expansion register passed as argument.
> 
> Fixes: f68d08c437f9 ("net: phy: bcm7xxx: Add EPHY entry for 72165")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: phy: bcm7xx: Correct read from expansion register
    https://git.kernel.org/netdev/net/c/582dbb2cc1a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


