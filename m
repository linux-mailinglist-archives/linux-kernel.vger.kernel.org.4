Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F3974AC87
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjGGIK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGGIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E9219BD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C936C617F7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 234D0C433C9;
        Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688717422;
        bh=g5lsoS1kcycjXztjR1PJ/Oy1gkd8iXLWN9aRuubkuOE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=osop7ms9amrh3cjHNWpekVSmBG+3PeOZ024h5TKwSziY82hrS1JjyDdvG3ptOoC1X
         glvUqDY0q+PoMrcU/iJTNFwHeR38YiVgiC7hxAiHIwe0pfE6YvbYVafKpCCLrVA9SW
         tlObNagE7fK7dFfSDWMVt6WzoY5KEjcKzb1CRLXj9RHcixTmXqn4tavydDXJ+zISie
         QgV3gtd83mtFNGc8mAhW+YiahApQREWa0NvsmVpX5Qq5rz6BYKsO5VwVIpTy0R4dVf
         PwOIzgZ5KVMiQoyfqhXKemeasxU5c+CxFoY/TsFL1ksJADKRhzoBhv5XOYbM3qrKlj
         xwjGwrKFBdpKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 087B1E53801;
        Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v3] octeontx2-af: Move validation of ptp pointer before
 its usage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168871742203.16578.3372513027335067632.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Jul 2023 08:10:22 +0000
References: <20230706082936.1945653-1-saikrishnag@marvell.com>
In-Reply-To: <20230706082936.1945653-1-saikrishnag@marvell.com>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        dan.carpenter@linaro.org, maciej.fijalkowski@intel.com,
        naveenm@marvell.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 6 Jul 2023 13:59:36 +0530 you wrote:
> Moved PTP pointer validation before its use to avoid smatch warning.
> Also used kzalloc/kfree instead of devm_kzalloc/devm_kfree.
> 
> Fixes: 2ef4e45d99b1 ("octeontx2-af: Add PTP PPS Errata workaround on CN10K silicon")
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-af: Move validation of ptp pointer before its usage
    https://git.kernel.org/netdev/net/c/7709fbd4922c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


