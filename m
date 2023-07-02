Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863A4744E33
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGBOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGBOuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF28E6A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 07:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E19BF60C32
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50279C433C7;
        Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688309422;
        bh=X23+jQiYYimq1cCzLMx+0wCOHKPJuBYY/r5BZRqa9tc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fzUvKfG3GjFzQ8/ZjjBMFiXOCPLkot+soJ2jBUcBZc5wSYJMu1+xWeWXkrNzenfa+
         Smnpj2x54ybHGJP4ZD9ecEznFEdLAGAVe6SzjZCb0LX6o2QAE7lE0JL33jme4Pf3I1
         G2LmuxSfbingTQktscFjnqwStBXGm4VjA5mTTbPIu3AS7brisYZkKnl7u1Rw6/UyfU
         lsUKARnpITZ6onLWBTpmOb9rslQ5da1olJYl8SZK0EVpX04ZZrnElVkG3KylWmpvqf
         dFacIi1UX6GarQ5cwn+SSawzTOGmb9U1utjE+lmAxN3P9Dyipdc6kGs2ZD20BHauD3
         LhEYltLGgA+Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20B17C0C40E;
        Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch 0/4] octeontx2-af: MAC block fixes for CN10KB
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168830942212.27441.10283621538831195797.git-patchwork-notify@kernel.org>
Date:   Sun, 02 Jul 2023 14:50:22 +0000
References: <20230630062845.26606-1-hkelam@marvell.com>
In-Reply-To: <20230630062845.26606-1-hkelam@marvell.com>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, sgoutham@marvell.com, lcherian@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, sbhatta@marvell.com
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 30 Jun 2023 11:58:41 +0530 you wrote:
> This patch set contains fixes for the issues encountered in testing
> CN10KB MAC block RPM_USX.
> 
> Patch1: firmware to kernel communication is not working due to wrong
>         interrupt configuration. CSR addresses are corrected.
> 
> Patch2: NIX to RVU PF mapping errors encountered due to wrong firmware
>         config. Corrects this mapping error.
> 
> [...]

Here is the summary with links:
  - [net,1/4] octeontx2-af: cn10kb: fix interrupt csr addresses
    https://git.kernel.org/netdev/net/c/4c5a331cacda
  - [net,2/4] octeontx2-af: Fix mapping for NIX block from CGX connection
    https://git.kernel.org/netdev/net/c/2e7bc57b976b
  - [net,3/4] octeontx2-af: Add validation before accessing cgx and lmac
    https://git.kernel.org/netdev/net/c/79ebb53772c9
  - [net,4/4] octeontx2-af: Reset MAC features in FLR
    https://git.kernel.org/netdev/net/c/2e3e94c2f5dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


