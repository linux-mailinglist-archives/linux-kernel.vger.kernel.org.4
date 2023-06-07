Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41E7252CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjFGEZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjFGEYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAFC2D7E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:20:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ACA263A5E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F67DC4339E;
        Wed,  7 Jun 2023 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686111624;
        bh=/okTpzrYZ3axlnAeFoiKd20SlCZ5YE115q+7Nvfz4zs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PnhZPtJEyE4eDnuoFeSYL/lL49E0fEu25DarK+y8k57tFYROY3pBsKGE72VOOuJS9
         F3Xj74RxARffte8073Z/IPtmjRyPEM5W3BPr6Ct4iSWdaADSgbUhRFjxcAJJm5Jpxf
         n+niCfwtOz3DbBwK2TgJk1smYUNYLpwoePXLl2gy+l7B9x/CixM/0XGsUbgzyjDzst
         TJJP1O/DusgdcnpQfvm5K/Y+/0Y8AjiwnjZx79MZhkJi30NP6dN1Oib+6dUWrorecp
         bfyKyCM71OD4gThfizhR07NtGM/GTFp9D3Xkdrt4CmsG2jO48ZU1aX/CerEKxp0SW7
         1oOMMA8BghROA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79C2AE87231;
        Wed,  7 Jun 2023 04:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Move KSZ9477 errata handling to PHY driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168611162449.32150.16757073360050768075.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 04:20:24 +0000
References: <20230605153943.1060444-1-robert.hancock@calian.com>
In-Reply-To: <20230605153943.1060444-1-robert.hancock@calian.com>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jun 2023 09:39:41 -0600 you wrote:
> Patches to move handling for KSZ9477 PHY errata register fixes from
> the DSA switch driver into the corresponding PHY driver, for more
> proper layering and ordering.
> 
> Changed since v1: Rebased on top of correct net-next tree.
> 
> Robert Hancock (2):
>   net: phy: micrel: Move KSZ9477 errata fixes to PHY driver
>   net: dsa: microchip: remove KSZ9477 PHY errata handling
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: micrel: Move KSZ9477 errata fixes to PHY driver
    https://git.kernel.org/netdev/net-next/c/26dd2974c5b5
  - [net-next,v2,2/2] net: dsa: microchip: remove KSZ9477 PHY errata handling
    https://git.kernel.org/netdev/net-next/c/6068e6d7ba50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


