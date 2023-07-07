Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D5F74AC88
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjGGIKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636EC172B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2AEC617F5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B0E3C433CA;
        Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688717422;
        bh=aohNnOH0wvs9TSAr0wvY7il4dGP5lxM3YQ3nxa4VZHU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CfPkHreF+wDoTOjvr9MeEFEnnKukicbTbSU4fAi8w3sufLdxsXi9CgrJ7p1VQSKrx
         oyus0qcrXPl+HKEIo7ZxjMG4b6LAz8Zx0wmQ91hCoBIdU2/kHyRTCepVw7T6dtN/7x
         0QZSbhiKRGDD5ohifyXuZHlCSaYpLXRyct4fF7H7G3Mq5gN6R7LnRbHv8yVJySLvrx
         GzJfWw1YEmuch8yyem/T9MfafYe02Splv3BXkK0UCd980+erBQQT00i4vg0OhTAkk1
         tfAojHF3EThAGRoIMmTFEDLh3AgQd1PPJXiH9aMaB4MhGocXRx0oPylC2P/Lbs2t9N
         vgSaloznttwhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 109BFC73FEB;
        Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] octeontx2-af: Promisc enable/disable through mbox
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168871742206.16578.3681415561880198567.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Jul 2023 08:10:22 +0000
References: <20230706042705.3235990-1-rkannoth@marvell.com>
In-Reply-To: <20230706042705.3235990-1-rkannoth@marvell.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.kubiak@intel.com, sgoutham@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sbhatta@marvell.com, gakula@marvell.com, schalla@marvell.com,
        hkelam@marvell.com
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

On Thu, 6 Jul 2023 09:57:05 +0530 you wrote:
> In legacy silicon, promiscuous mode is only modified
> through CGX mbox messages. In CN10KB silicon, it is modified
> from CGX mbox and NIX. This breaks legacy application
> behaviour. Fix this by removing call from NIX.
> 
> Fixes: d6c9784baf59 ("octeontx2-af: Invoke exact match functions if supported")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v1] octeontx2-af: Promisc enable/disable through mbox
    https://git.kernel.org/netdev/net/c/af42088bdaf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


