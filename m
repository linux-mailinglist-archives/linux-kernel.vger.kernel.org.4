Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EDB73AED9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjFWDA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjFWDAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC542681;
        Thu, 22 Jun 2023 20:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01E996195B;
        Fri, 23 Jun 2023 03:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 557DBC433C9;
        Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687489222;
        bh=o4vaiix31FGXLHehkhTx3OLu9WuRT75FIaWxmy6Kuow=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=i1zC6zZuUxAS7w6RwO5Xe+yiXCC4OlIxXjqPy82BmWiQfkPNt+aSJVE9BqmtvqfFm
         iXToBOzG3sQcWMTvqzmW70xp8/+IfLyqgUu6LqSJtR7EGG4tVqiDl4whTw5ImAffdj
         014on6tLxpTplBZq1caLG7fZFHEmByssiDz1RtVVAkdh3FXKG63FJZHyi0gPByIfd5
         KArqlGX3V8nB97oAxlKR3mmeAjF+oeTpG6BhORlnbqKun5PdOP4ARO5Dww5ljvfuaD
         cTquQFJub7At86Ps+DuwaXuBehskquinnFq/kfqpJznI73X9mB3ClI0la8LBzscqSz
         Oj09YKl8Zn+Mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 336B6C395F1;
        Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] docs: ABI: sysfs-class-led-trigger-netdev: add new
 modes and entry
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168748922220.4682.2842456110616074957.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 03:00:22 +0000
References: <20230621092653.23172-1-ansuelsmth@gmail.com>
In-Reply-To: <20230621092653.23172-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     andrew@lunn.ch, lee@kernel.org, linux-leds@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 21 Jun 2023 11:26:53 +0200 you wrote:
> Document newly introduced modes and entry for the LED netdev trigger.
> 
> Add documentation for new modes:
> - link_10
> - link_100
> - link_1000
> - half_duplex
> - full_duplex
> 
> [...]

Here is the summary with links:
  - [net-next] docs: ABI: sysfs-class-led-trigger-netdev: add new modes and entry
    https://git.kernel.org/netdev/net-next/c/2ffb8d02a9b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


