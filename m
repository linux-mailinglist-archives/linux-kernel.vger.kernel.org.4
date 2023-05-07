Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9856F98C5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEGOAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560761156A;
        Sun,  7 May 2023 07:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF84C60E95;
        Sun,  7 May 2023 14:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41E80C433D2;
        Sun,  7 May 2023 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683468019;
        bh=OuidcnJd5hMJxH1EcvWcJkNvgPAxboXRAstzxaj582k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a23XcLD7+JtGWM0ThOHnn8TSxtjN6gX42ZWtKK2curydB8F5TiuC5miECS1AKUY++
         JMuC+Fqjucw19QZrKAyfc/DAqRZSs15x6ihr6WkqkHbSfZ+yHkiKTGZK2IBCCe/ZYA
         YSfbizxfNG6x0E8gJnme0HhESQr8Olb0VowE3QPbSZK2ADHBCEy9vgqn2uMGESuR2l
         BztgKRND7G5lhb+o0AWXorK7Ybw9tzykjWNQqhtDULaSx4DG4BlXfTQeJalpTMvxzm
         vgSBAI8ycK3driyeUrjH9J9SPApV2nAyZndjjbXKc8RZ150A1m9qcmLgOSItlT7nlZ
         hSF3H1GBdfB5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 207CBC395FD;
        Sun,  7 May 2023 14:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: mvusb: Fix an error handling path in
 mvusb_mdio_probe()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168346801912.32578.9019263062117258004.git-patchwork-notify@kernel.org>
Date:   Sun, 07 May 2023 14:00:19 +0000
References: <bd2244d44b914dec1aeccee4eba2e7e8135b585b.1683311885.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <bd2244d44b914dec1aeccee4eba2e7e8135b585b.1683311885.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     tobias@waldekranz.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Fri,  5 May 2023 20:39:33 +0200 you wrote:
> Should of_mdiobus_register() fail, a previous usb_get_dev() call should be
> undone as in the .disconnect function.
> 
> Fixes: 04e37d92fbed ("net: phy: add marvell usb to mdio controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/mdio/mdio-mvusb.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] net: mdio: mvusb: Fix an error handling path in mvusb_mdio_probe()
    https://git.kernel.org/netdev/net/c/27c1eaa07283

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


