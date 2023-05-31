Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F9717790
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjEaHK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjEaHKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDF6113;
        Wed, 31 May 2023 00:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F167F63756;
        Wed, 31 May 2023 07:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55059C433A1;
        Wed, 31 May 2023 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685517021;
        bh=vgDLZgUxG3NRbr05w1i59jHhY447JvUfX7GZcVLgbPQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MIRYwLFGov3yMA2Mag3fr1wLeY2n4QKx+N8F5V2W/elKpoZZGlzfWsbjTBdzep+Db
         zBOW9c1Jy14ufWe3Txfv7EkOJe9RBghqCs22nGg9e4g5xiBXP2Zb388b/hsPht3s/S
         cOeHtt1ghZdDbv+HPRPcTG/uPiZ4PxMb5LIrJbEi9sWNXn5939wNMnThMnDZsvdpei
         oN8zUDqbxTVnpH4UXrAwk7bSldsmor9kbCD2WmKffE0P+SoEffdx+9wt5yDQSOwBj4
         HzShIw5siET5Bm8zY+ewP6U1aZh/fwv6XKMdmdwLPMdqVoCs8JynAUL6NAWH9y3Q5y
         7vatIQxVRRW4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D0AAE52C0F;
        Wed, 31 May 2023 07:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] net: dsa: mv88e6xxx: add 88E6361 support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168551702124.26195.3362960081498362670.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 07:10:21 +0000
References: <20230529080246.82953-1-alexis.lothore@bootlin.com>
In-Reply-To: <20230529080246.82953-1-alexis.lothore@bootlin.com>
To:     =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@ci.codeaurora.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, paul.arola@telus.com,
        scott.roberts@telus.com, kabel@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 29 May 2023 10:02:39 +0200 you wrote:
> This series brings initial support for Marvell 88E6361 switch.
> 
> MV88E6361 is a 8 ports switch with 5 integrated Gigabit PHYs and 3
> 2.5Gigabit SerDes interfaces. It is in fact a new variant in the
> 88E639X/88E6193X/88E6191X family with a subset of existing features:
> - port 0: MII, RMII, RGMII, 1000BaseX, 2500BaseX
> - port 3 to 7: triple speed internal phys
> - port 9 and 10: 1000BaseX, 25000BaseX
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] dt-bindings: net: dsa: marvell: add MV88E6361 switch to compatibility list
    https://git.kernel.org/netdev/net-next/c/9229a9483d80
  - [net-next,v4,2/7] net: dsa: mv88e6xxx: pass directly chip structure to mv88e6xxx_phy_is_internal
    https://git.kernel.org/netdev/net-next/c/ca345931907f
  - [net-next,v4,3/7] net: dsa: mv88e6xxx: use mv88e6xxx_phy_is_internal in mv88e6xxx_port_ppu_updates
    https://git.kernel.org/netdev/net-next/c/7a2dd00be869
  - [net-next,v4,4/7] net: dsa: mv88e6xxx: add field to specify internal phys layout
    https://git.kernel.org/netdev/net-next/c/3ba89b28adb2
  - [net-next,v4,5/7] net: dsa: mv88e6xxx: fix 88E6393X family internal phys layout
    https://git.kernel.org/netdev/net-next/c/2f93493970df
  - [net-next,v4,6/7] net: dsa: mv88e6xxx: pass mv88e6xxx_chip structure to port_max_speed_mode
    https://git.kernel.org/netdev/net-next/c/18e1b7422dff
  - [net-next,v4,7/7] net: dsa: mv88e6xxx: enable support for 88E6361 switch
    https://git.kernel.org/netdev/net-next/c/12899f299803

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


