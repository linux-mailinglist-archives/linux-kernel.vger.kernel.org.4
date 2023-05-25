Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B5710546
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbjEYFXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbjEYFXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:23:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A289613A
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 22:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C00E642FA
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73122C433EF;
        Thu, 25 May 2023 05:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684992021;
        bh=73OiVQvxUbIdVc5Wugu04RHIw1HLsow4HQOXyejZWhI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dihAniOKLfrXXY6JMFVOsFZ/YVbBdBUBNzCJT18jscx12ocCwDpp6uM0zt8MaPhN+
         p9J+va1TfF93iZQUnmVgeMwUl1ob6GIuZdJ52aui49m4WgmSjCpPJp8MvaKFV8Dqo6
         SXXD+RaqmVW/SkiVWV60Q6RxxHSgfxWMxnoIjSbGMbtpTO/haeBAYeewQiOQTDOIAm
         98kPJaBFgzaW+gj2mHCVDvDZx8oY9q6+a1zeihVaFRS3Jpqpe2/2QZZQfJJcHFogkq
         4IBoG0UIELzUi1/L3Sq+i3UzkzDRid+d33jN9Rl1tLhq8xJVEgQtATOOh0ohhly6hf
         SVhYWajqEfF7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C92EC395DF;
        Thu, 25 May 2023 05:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] net: phy: mscc: support VSC8501
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168499202131.9034.18213059919292167495.git-patchwork-notify@kernel.org>
Date:   Thu, 25 May 2023 05:20:21 +0000
References: <20230523153108.18548-1-david.epping@missinglinkelectronics.com>
In-Reply-To: <20230523153108.18548-1-david.epping@missinglinkelectronics.com>
To:     David Epping <david.epping@missinglinkelectronics.com>
Cc:     olteanv@gmail.com, andrew@lunn.ch, linux@armlinux.org.uk,
        hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
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

On Tue, 23 May 2023 17:31:04 +0200 you wrote:
> Hello,
> 
> this updated series of patches adds support for the VSC8501 Ethernet
> PHY and fixes support for the VSC8502 PHY in cases where no other
> software (like U-Boot) has initialized the PHY after power up.
> 
> The first patch simply adds the VSC8502 to the MODULE_DEVICE_TABLE,
> where I guess it was unintentionally missing. I have no hardware to
> test my change.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] net: phy: mscc: add VSC8502 to MODULE_DEVICE_TABLE
    https://git.kernel.org/netdev/net/c/57fb54ab9f69
  - [net,v3,2/4] net: phy: mscc: add support for VSC8501
    https://git.kernel.org/netdev/net/c/fb055ce4a9e3
  - [net,v3,3/4] net: phy: mscc: remove unnecessary phydev locking
    https://git.kernel.org/netdev/net/c/7df0b33d7993
  - [net,v3,4/4] net: phy: mscc: enable VSC8501/2 RGMII RX clock
    https://git.kernel.org/netdev/net/c/71460c9ec5c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


