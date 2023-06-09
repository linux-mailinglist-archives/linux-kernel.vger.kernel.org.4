Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6813D728E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjFICk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjFICkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F452D52
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 623356530B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97963C4339B;
        Fri,  9 Jun 2023 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686278423;
        bh=ktOKcgJcF42n3ju25sxNzNdwoMPdtvE4MEbMAQ1sHZc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BRu2EluiE4XIsmXnqAhO+yMK6YmnTPrfUSpZGiVZBxWvMsPPg3/DQTGk76phbtv24
         Ze9SlcZP06+/tZ+xk+mhvq93UeQjRUWFGZ7CDegayayKbea5Aa+PURTeXpiNLTKq/P
         xr2Vx8crx+6LjxGXCTKmCXK1W3dM1Qqa+muGic5wyf1DkGORvZ3fuf+hO1e3++2MTJ
         S+i4UzSDacI9yoyww31ZrDW5qSNm85bwhu+Y9F6ehmVmDt2FCghgDsTEUkM3+ihPnS
         /WbAZF1tP2uSqpeNxoKndK6tpLkQnCfDHuc7fCd2axvct4s7822ghB2XpNM2ylUei4
         /nHk3wA5hPJZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AD11E87232;
        Fri,  9 Jun 2023 02:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ethtool: ioctl: improve error checking for
 set_wol
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168627842349.12774.1205929814216417059.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Jun 2023 02:40:23 +0000
References: <1686179653-29750-1-git-send-email-justin.chen@broadcom.com>
In-Reply-To: <1686179653-29750-1-git-send-email-justin.chen@broadcom.com>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew@lunn.ch, d-tatianin@yandex-team.ru, idosch@nvidia.com,
        marco@mebeim.net, wsa+renesas@sang-engineering.com,
        jiri@resnulli.us, gal@nvidia.com, mailhol.vincent@wanadoo.fr,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Jun 2023 16:14:11 -0700 you wrote:
> The netlink version of set_wol checks for not supported wolopts and avoids
> setting wol when the correct wolopt is already set. If we do the same with
> the ioctl version then we can remove these checks from the driver layer.
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ethtool: ioctl: improve error checking for set_wol
    https://git.kernel.org/netdev/net-next/c/55b24334c0f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


