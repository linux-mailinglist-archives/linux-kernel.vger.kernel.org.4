Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C3C72D54C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjFMAAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFMAA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4FA1713
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D05D06253B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24E87C433D2;
        Tue, 13 Jun 2023 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686614424;
        bh=kliTCodd6wYpHfGlKYtf/FCCXeowUCACVsZ/qFZvUmM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LT7JGewdeY18HwKhJom7lXUFLTWQxxqwW87Ev4oAnyxqhaYnx9TYTC1tK6KIG+esQ
         nRMp4Tg/N2R19V7SS5UHWQ9xrayEgl2PUJrBuD83HX6s1YDYddhsFCxnwfUrzjmezN
         JE0RjjwjuNBcsl0a7IODy0M+9AAWVPKky5bVxB8pb4e0GWaCWQLCLjowBX9ju7knGl
         uW44kSnjfImSneXD14HpMaZXs3URq60ihBgDy5eRwF38GSntvD637RPKO4fP0DhSY2
         0hQd6kkRMqGbfe0zwr/cy1D6Vu/VjbDfEVBj5aEXNltzJh/53AXSW5oOj8wE2b9qdU
         RbrlIFQoL/k3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0103EE29F37;
        Tue, 13 Jun 2023 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] fixes for Q-USGMII speeds and autoneg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168661442399.10094.15517056785323276063.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Jun 2023 00:00:23 +0000
References: <20230609080305.546028-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20230609080305.546028-1-maxime.chevallier@bootlin.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        Horatiu.Vultur@microchip.com, Allan.Nielsen@microchip.com,
        UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com,
        simon.horman@corigine.com
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

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Jun 2023 10:03:03 +0200 you wrote:
> This is the second version of a small changeset for QUSGMII support,
> fixing inconsistencies in reported max speed and control word parsing.
> 
> As reported here [1], there are some inconsistencies for the Q-USGMII
> mode speeds and configuration. The first patch in this fixup series
> makes so that we correctly report the max speed of 1Gbps for this mode.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: phylink: report correct max speed for QUSGMII
    https://git.kernel.org/netdev/net/c/b9dc1046edfe
  - [net,v2,2/2] net: phylink: use a dedicated helper to parse usgmii control word
    https://git.kernel.org/netdev/net/c/923454c0368b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


