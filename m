Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1F972C291
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjFLLMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbjFLLLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:11:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E385127FB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 136DF62713
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 531CEC4339E;
        Mon, 12 Jun 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686567624;
        bh=r0X2TAr+gPr7pslkAM2tRZzvN32ycrAosMvOE3Fh/DI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c8M/fqBxiGljMN2u9oJUllZd7ax8GxPDKJuMgPiK/Tid96cTXXhd4SNyk6vzuctK8
         ZbQsmfp1IM2htXrAxlVvoQcGurwd+l8S8ArW6NNvou9Ip9KD4HORnzo/eAeZ54q2MK
         p7lX/hXfubLljOerOSMvjJ8HMrXpomCpo7B3M0swjhNk7tXBLpdLeMLolq7jG+Wd+I
         mSOiUZe/4ResLmQVm3Q2UnFB5OzT1BqMb5R6Dju1CK42baJDEADVfW9KSprKEe/ZMs
         AfxAHJoz/PyHl7osgEZinoXdzlMZGDllZ4cgBqf/bLGyipH14YvpvkOxIR98EyDy1U
         Otpqfx2qwp+Cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EA2EE29F37;
        Mon, 12 Jun 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: phy: add driver for MediaTek SoC built-in
 GE PHYs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168656762418.2644.6683801463437104353.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Jun 2023 11:00:24 +0000
References: <ZIULuiQrdgV9cZbJ@makrotopia.org>
In-Reply-To: <ZIULuiQrdgV9cZbJ@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        SkyLake.Huang@mediatek.com, dqfext@gmail.com, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 11 Jun 2023 00:48:10 +0100 you wrote:
> Some of MediaTek's Filogic SoCs come with built-in gigabit Ethernet
> PHYs which require calibration data from the SoC's efuse.
> Despite the similar design the driver doesn't share any code with the
> existing mediatek-ge.c.
> Add support for such PHYs by introducing a new driver with basic
> support for MediaTek SoCs MT7981 and MT7988 built-in 1GE PHYs.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: phy: add driver for MediaTek SoC built-in GE PHYs
    https://git.kernel.org/netdev/net-next/c/98c485eaf509

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


