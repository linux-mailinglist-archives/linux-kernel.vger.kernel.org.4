Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C006F4F27
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjECDaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjECDaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBBC30FD;
        Tue,  2 May 2023 20:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 604CC622DA;
        Wed,  3 May 2023 03:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3392C433EF;
        Wed,  3 May 2023 03:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683084619;
        bh=WLePMFTzjehr9UevzId0j2OA0wYMyFASCHTHGYPPt2w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=M32UpwLrF0haRxJJu4+N6DyK2waPH0u80DX/t6PsuBzKMfQdHl5U1+guDJAaWr+pJ
         P40yjI8fyWwShSe28I1r5pqFwtVnSk14s722dNoho9UE/iKltSn8ytt89ZTFO79OZZ
         HQtcjEOzDtBVaZxnXiPlEp7MtOHtQIlTUWBwNAnf3YyyEWnP8PYYU/Qjb6xiGtzxJm
         k0yYwbacdxQwvUuXfYD4ZqRKqOOk2LCTWpy1kT1QDB/hVCngOQ1XSx9HKFhscVbjWI
         MaWoFnDUAETaE3yfec2NR2xAGfqFqze1Eher+sSLPDwORJJjvg/IFwOjm0GFMb8mkU
         XjGC+rEVRZ6BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E1BEC3959E;
        Wed,  3 May 2023 03:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v2] net: ethernet: mtk_eth_soc: drop generic vlan rx offload,
 only use DSA untagging
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168308461957.6433.6971778251909204791.git-patchwork-notify@kernel.org>
Date:   Wed, 03 May 2023 03:30:19 +0000
References: <20230426172153.8352-1-linux@fw-web.de>
In-Reply-To: <20230426172153.8352-1-linux@fw-web.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org, nbd@nbd.name, john@phrozen.org,
        sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
        lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        frank-w@public-files.de, arinc.unal@arinc9.com
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Apr 2023 19:21:53 +0200 you wrote:
> From: Felix Fietkau <nbd@nbd.name>
> 
> Through testing I found out that hardware vlan rx offload support seems to
> have some hardware issues. At least when using multiple MACs and when
> receiving tagged packets on the secondary MAC, the hardware can sometimes
> start to emit wrong tags on the first MAC as well.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: mtk_eth_soc: drop generic vlan rx offload, only use DSA untagging
    https://git.kernel.org/netdev/net/c/c6d96df9fa2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


