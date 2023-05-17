Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F434706256
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjEQIKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjEQIKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D7171F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6736064367
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA2B8C4339B;
        Wed, 17 May 2023 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684311020;
        bh=iYboL9dX+41SulISH6YWXCP0H8wdk++oren2dVtLuTQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SHBSZSqjOST9D+Ja79MDsKNVarQrLmUZK+Qkpul1ZdeIsLZxuw36Ym7DsqUKPzNi3
         fGhEq9un9qpedKrZGNWBQkHBydCEMfmJYa45IHS8AmROPtAgo0pkqzaesJi7Z24PIq
         fScSHokoANzseruSnsObAvH9/THPjbPGI5WulfoUT9zd86DSbWxqV+DAs3keXhU/ZW
         adsFE5d4JKeK17Z938ou12gwzhJjl/RH9iJkQl0by7QBwcjyg5tsHM4lK2Gx6OUYAJ
         eysRvl6o2LWew925ecFQSBhQIqthIvB75Mga87fF//PkdgxXxB75T5Kvs9aeAGGyL1
         w6sx/LrD3scJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0CEFE21EEC;
        Wed, 17 May 2023 08:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix mv88e6393x EPC write command
 offset
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168431102065.18881.9563171509805168718.git-patchwork-notify@kernel.org>
Date:   Wed, 17 May 2023 08:10:20 +0000
References: <20230516073854.91742-1-m.migliore@tiesse.com>
In-Reply-To: <20230516073854.91742-1-m.migliore@tiesse.com>
To:     Marco Migliore <m.migliore@tiesse.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ashkan.boldaji@digi.com, pavana.sharma@digi.com,
        kabel@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, 16 May 2023 09:38:54 +0200 you wrote:
> According to datasheet, the command opcode must be specified
> into bits [14:12] of the Extended Port Control register (EPC).
> 
> Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
> Signed-off-by: Marco Migliore <m.migliore@tiesse.com>
> ---
>  drivers/net/dsa/mv88e6xxx/port.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] net: dsa: mv88e6xxx: Fix mv88e6393x EPC write command offset
    https://git.kernel.org/netdev/net/c/1323e0c6e1d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


