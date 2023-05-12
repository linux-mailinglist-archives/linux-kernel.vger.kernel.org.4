Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156497001B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbjELHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbjELHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C597A84
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D648265386
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31CD4C433EF;
        Fri, 12 May 2023 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683877820;
        bh=UG2XymFt/LVYF7Maho6gjkXm2jm8jJSoTDi9Gbe5NTY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JOSjI6/Qu+MCybdWFaloBNwPj1gXiafb13MCxCzz1IxgmKvwkVCfEOELtXqAuvPzN
         YaCA+ispsBXidbphxiXt726mZil+bjh9tAcc0ZE8DUvlPDoV8YgfPBZzqNzBgyPKQr
         hPHbVKIRNBtDyV1aQRQoraPQkF8Tpcpc8/v/3gf7P96Pd2rGK5CJSDQ07kvf/S2zCr
         nxdRpp0sq/pxbiFJ2+hn36E/E+huN7adpZr0CLP9XOfidzvh/NZXbcXPU217IL+rVH
         FXqkJLiBLGhAIeNL4KykNJguB4ZYBiAvmUN4IcgJCqeA6kmJnSnGUJVrSlmb85GW+w
         XY6wChHxACoVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19799E26D20;
        Fri, 12 May 2023 07:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phy: dp83867: add w/a for packet errors seen with
 short cables
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168387782010.11165.2503364837163624260.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 07:50:20 +0000
References: <20230510125139.646222-1-s-vadapalli@ti.com>
In-Reply-To: <20230510125139.646222-1-s-vadapalli@ti.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 10 May 2023 18:21:39 +0530 you wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Introduce the W/A for packet errors seen with short cables (<1m) between
> two DP83867 PHYs.
> 
> The W/A recommended by DM requires FFE Equalizer Configuration tuning by
> writing value 0x0E81 to DSP_FFE_CFG register (0x012C), surrounded by hard
> and soft resets as follows:
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phy: dp83867: add w/a for packet errors seen with short cables
    https://git.kernel.org/netdev/net/c/0b01db274028

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


