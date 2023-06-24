Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1732773C631
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 04:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjFXCAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 22:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFXCAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 22:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729DC273D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 19:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0203A61B9A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FFFCC433C9;
        Sat, 24 Jun 2023 02:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687572020;
        bh=/5hqAVUutsRdQlN6XP75PJGI6jtQkVvsi2aP/zYXs1c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rRflR4GoNsD9eqByr39w+S7+rvjJxsTuG4gNKP0JNYCleY1wtXV2inSGHq62YV/vU
         SFbynhaNUHaA9bCeq3JvaRQZ0bgGO6wKmPJhJpZY+v6lFvYT3Pp/kEMHjrehZN8+BX
         JJcpnc6GCnIJ6pFuMqM5qy5it39iRMT+XEnVJJ3zBgRwpkySS9qmsLx6+EgsCMXMQg
         P0XppmiIvUCk4E0nvmSQhoSK6ynftvixY3LZcyNeerpHzSuSrgqzEdYMaZ1kxpzToN
         cJOrpucSYZOZGc0vFo3EuyoIigUr661Wrk3PlvdzoAsrWcmEjuEDxJ45S0ArwDUPJA
         O2P3gwUQxT89g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2492CC395D9;
        Sat, 24 Jun 2023 02:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmgenet: Ensure MDIO unregistration has clocks
 enabled
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168757202014.19315.5128795746838257029.git-patchwork-notify@kernel.org>
Date:   Sat, 24 Jun 2023 02:00:20 +0000
References: <20230622103107.1760280-1-florian.fainelli@broadcom.com>
In-Reply-To: <20230622103107.1760280-1-florian.fainelli@broadcom.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        ansuelsmth@gmail.com, rmk+kernel@armlinux.org.uk,
        opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
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

On Thu, 22 Jun 2023 03:31:07 -0700 you wrote:
> With support for Ethernet PHY LEDs having been added, while
> unregistering a MDIO bus and its child device liks PHYs there may be
> "late" accesses to the MDIO bus. One typical use case is setting the PHY
> LEDs brightness to OFF for instance.
> 
> We need to ensure that the MDIO bus controller remains entirely
> functional since it runs off the main GENET adapter clock.
> 
> [...]

Here is the summary with links:
  - [net] net: bcmgenet: Ensure MDIO unregistration has clocks enabled
    https://git.kernel.org/netdev/net/c/1b5ea7ffb7a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


