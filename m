Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E499B725931
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbjFGJCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbjFGJB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:01:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A61FE0;
        Wed,  7 Jun 2023 02:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762AF63090;
        Wed,  7 Jun 2023 09:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDF71C4339C;
        Wed,  7 Jun 2023 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686128421;
        bh=F5+N75Zg/ewS0cV/xECJGMYPsMqht0e4NrsDhr0XjP8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AjcGkpYAI0O1/OHrmPdmhO8Sb3CmVRjmE1lVgGz0lQGffqHwgxDwzlsSDcygN91gB
         XjLNZ4AFdkZOQCo1nNREtUavVyKPwR8zUlYfMqbIrCGDVZGF4OZp4p14Fu6SFKUtD4
         c2m+1T0fBPmtY2lp9nZFJUMCDNbwht7RlmFcuCboIDfSYe7LOavvRmlUsmaOEVin9V
         779yk1ashNkfWVUMVTRPleemh68x6Po9Dx7+Xa4c7XvOd7yDCMVFHxfunh/vx7mPJ8
         bKJA7yvcz1CJ90gzlgHmAYmgmT/QBDfuBXEJhnf6npZyqRotAHo8szBQfsL3ifo6cE
         WAImxORBhu/MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B598FE4D016;
        Wed,  7 Jun 2023 09:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] net: phy: realtek: Support external PHY clock
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168612842173.26370.13026780994764936762.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 09:00:21 +0000
References: <20230605154010.49611-1-detlev.casanova@collabora.com>
In-Reply-To: <20230605154010.49611-1-detlev.casanova@collabora.com>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  5 Jun 2023 11:40:07 -0400 you wrote:
> Some PHYs can use an external clock that must be enabled before
> communicating with them.
> 
> Changes since v3:
>  * Do not call genphy_suspend if WoL is enabled.
> Changes since v2:
>  * Reword documentation commit message
> Changes since v1:
>  * Remove the clock name as it is not guaranteed to be identical across
>    different PHYs
>  * Disable/Enable the clock when suspending/resuming

Here is the summary with links:
  - [v4,1/3] net: phy: realtek: Add optional external PHY clock
    https://git.kernel.org/netdev/net-next/c/7300c9b574cc
  - [v4,2/3] dt-bindings: net: phy: Document support for external PHY clk
    https://git.kernel.org/netdev/net-next/c/350b7a258f20
  - [v4,3/3] net: phy: realtek: Disable clock on suspend
    https://git.kernel.org/netdev/net-next/c/59e227e2894b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


