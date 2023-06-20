Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682DF7374EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjFTTK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFTTKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA22810A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E56361403
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7EB3C433C9;
        Tue, 20 Jun 2023 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687288221;
        bh=bAG0iRvuyDGrA5ue3CDODowB+oGZsOWqL4rn8pf0hR8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Sl9Ntx+QeT9grEA+dsN9wfthlhTDnUIgLZwJs5e9aB5oNfA0/Q/Y/jQkSVSXOAivO
         USRGT8gD+poMva9B70eO4WIOPri1ci4Zuq65eY9CrjbB/jy3v9eqpJ1ZlXzvgQ6sSG
         fiu/cQ7WcTi15oBF46r/UDvgZoTe4KLKnpHFIQxQ6iqMlFx57pBDhqlmwbCldFKV59
         RRNcyffeQ9MOMEOi0MXPLHrE6oda3WpylIf4qumau0ECwCm//pMoh86gfR+ShvQa5E
         3ZCJlvl8kvM8fK404/WtmqaPN9f3fuWqZ3NAHB36+hDKD9bYxQs/wLuyW7B2XJ3xwj
         BY3TobRhUhucA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92A78C395D9;
        Tue, 20 Jun 2023 19:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: mediatek: fix compile-test dependencies
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168728822159.4938.14447454868774866597.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 19:10:21 +0000
References: <20230616093009.3511692-1-arnd@kernel.org>
In-Reply-To: <20230616093009.3511692-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, arnd@arndb.de,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        ramon.nordin.rodriguez@ferroamp.se,
        Parthiban.Veerasooran@microchip.com, Frank.Sae@motor-comm.com,
        michael@walle.cc, daniel@makrotopia.org,
        piergiorgio.beruto@gmail.com, vladimir.oltean@nxp.com,
        jonathan.lemon@gmail.com, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jun 2023 11:29:54 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new phy driver attempts to select a driver from another subsystem,
> but that fails when the NVMEM subsystem is disabled:
> 
> WARNING: unmet direct dependencies detected for NVMEM_MTK_EFUSE
>   Depends on [n]: NVMEM [=n] && (ARCH_MEDIATEK [=n] || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
>   Selected by [y]:
>   - MEDIATEK_GE_SOC_PHY [=y] && NETDEVICES [=y] && PHYLIB [=y] && (ARM64 && ARCH_MEDIATEK [=n] || COMPILE_TEST [=y])
> 
> [...]

Here is the summary with links:
  - net: phy: mediatek: fix compile-test dependencies
    https://git.kernel.org/netdev/net-next/c/462a3daad679

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


