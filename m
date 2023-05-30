Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C736E715AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjE3KA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjE3KA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B08F0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1454862CE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72849C433D2;
        Tue, 30 May 2023 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685440822;
        bh=tQ/3SHl9vr/ygwjx98i9ivbpl4z1ZQWHPcwGVuT0ah0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a0iMSepltDmWPKjHik13kO2U9mT1k+DR3NqgfDJeF7p2PbOKlZ3nQ7eG+NPpcoj0p
         kQO2UuhQGxUH4cqkA6glbBLUsSSDK69I/nwRvRqnpKKITJsUl4UbqtDwQA08w3qc63
         rrkVcd6MIxx88teq50SdZwHbZL3cPk5FZdY0KBn/9XC2wFo2NyCF1yMle086nihzGe
         6bXotejSZCMEIO/r23QBmyQBQKO3Z8secKO6l896Qcf1WZqBUA6+SV1KcGLRLixrCd
         tFJ54SYlN1xCcS9lzSIusssiVvw4dh1tPq3tbwn5fzZeEWnP/0/M39OJNt32lmjPBp
         XAQOzcv0oBsFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CCC3E52BFB;
        Tue, 30 May 2023 10:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] microchip_t1s: Update on Microchip 10BASE-T1S
 PHY driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168544082230.7583.8570017963154848959.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 10:00:22 +0000
References: <20230526152348.70781-1-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20230526152348.70781-1-Parthiban.Veerasooran@microchip.com>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ramon.nordin.rodriguez@ferroamp.se,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, Thorsten.Kummermehr@microchip.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 May 2023 20:53:42 +0530 you wrote:
> This patch series contain the below updates,
> - Fixes on the Microchip LAN8670/1/2 10BASE-T1S PHYs support in the
>   net/phy/microchip_t1s.c driver.
> - Adds support for the Microchip LAN8650/1 Rev.B0 10BASE-T1S Internal
>   PHYs in the net/phy/microchip_t1s.c driver.
> 
> Changes:
> v2:
> - Updated cover letter contents.
> - Modified driver description is more generic as it is common for all the
>   Microchip 10BASE-T1S PHYs.
> - Replaced read-modify-write code with phy_modify_mmd function.
> - Moved */ to the same line for the single line comments.
> - Changed the type int to u16 for LAN865X Rev.B0 fixup registers
>   declaration.
> - Changed all the comments starting letter to upper case for the
>   consistency.
> - Removed return value check of phy_read_mmd and returned directly in the
>   last line of the function lan865x_revb0_indirect_read.
> - Used reverse christmas notation wherever is possible.
> - Used FIELD_PREP instead of << in all the places.
> - Used 4 byte representation for all the register addresses and values
>   for consistency.
> - Comment for indirect read is modified.
> - Implemented "Reset Complete" status polling in config_init.
> - Function lan865x_setup_cfgparam is split into multiple functions for
>   readability.
> - Reference to AN1760 document is added in the comment.
> - Removed interrupt disabling code as it is not needed.
> - Provided meaningful macros for the LAN865X Rev.B0 indirect read
>   registers and control.
> - Replaced 0x10 with BIT(4).
> - Removed collision detection disable/enable code as it can be done with
>   a separate patch later.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] net: phy: microchip_t1s: modify driver description to be more generic
    https://git.kernel.org/netdev/net-next/c/ca33db4a8602
  - [net-next,v4,2/6] net: phy: microchip_t1s: replace read-modify-write code with phy_modify_mmd
    https://git.kernel.org/netdev/net-next/c/221a5344806c
  - [net-next,v4,3/6] net: phy: microchip_t1s: update LAN867x PHY supported revision number
    https://git.kernel.org/netdev/net-next/c/6f12765ecad3
  - [net-next,v4,4/6] net: phy: microchip_t1s: fix reset complete status handling
    https://git.kernel.org/netdev/net-next/c/1d7650b8ce60
  - [net-next,v4,5/6] net: phy: microchip_t1s: remove unnecessary interrupts disabling code
    https://git.kernel.org/netdev/net-next/c/b4010beb347d
  - [net-next,v4,6/6] net: phy: microchip_t1s: add support for Microchip LAN865x Rev.B0 PHYs
    https://git.kernel.org/netdev/net-next/c/972c6d834633

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


