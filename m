Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CCB6FC3BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjEIKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjEIKUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CEAD2D4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F15D64565
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EC39C433D2;
        Tue,  9 May 2023 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683627620;
        bh=b17Dty99xu5pN5a7OJGcHypwcsCAXQpaPhA5ELZjDjE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pAYwgO3MddVQ0CBSHdPjXnL6i+pAevXRU9kEpBZDucoVhwUZXU9bFfhXN0mrpmiM5
         bK8BpkWZxQI/995aSX/8AEAnffNxyIW/hxFow1oQoFyQSKlwHQkHFtWRFbPo3E6IkR
         ki3UNYMclziZv9OHX3VDQmBwpttATzOvbvpMg9AtUhuYHI1DQEoFjxUBjGANNyIgVW
         oV5VhH0JwYgyfgBGUbIkCGCq+UxrbdytMsyp3W3atSdFXAbtIGcjw3Bb4+VBS9aTvd
         eD3KomgqEdcqO2P5/hbZF+1YQZyCOUQdNxbXjMWMgSMu+/wUGQCxI85icWkokkRf72
         M9O8rOtVZWi3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73B0BC39562;
        Tue,  9 May 2023 10:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: dp83869: support mii mode when rgmii strap
 cfg is used
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168362762046.5548.8289105927534896732.git-patchwork-notify@kernel.org>
Date:   Tue, 09 May 2023 10:20:20 +0000
References: <20230508070359.357474-1-s-vadapalli@ti.com>
In-Reply-To: <20230508070359.357474-1-s-vadapalli@ti.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 8 May 2023 12:33:59 +0530 you wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> The DP83869 PHY on TI's k3-am642-evm supports both MII and RGMII
> interfaces and is configured by default to use RGMII interface (strap).
> However, the board design allows switching dynamically to MII interface
> for testing purposes by applying different set of pinmuxes.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: dp83869: support mii mode when rgmii strap cfg is used
    https://git.kernel.org/netdev/net-next/c/94e86ef1b801

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


