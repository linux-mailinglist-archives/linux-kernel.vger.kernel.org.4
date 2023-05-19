Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0D7709194
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjESIUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjESIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB834E4D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EEA9654E8
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8B32C433D2;
        Fri, 19 May 2023 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684484421;
        bh=cYNsUqwT6Czd7CihswXIkDGRkFsuSYQWgVboqu1K6jA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iLAe1xuM9zRLHRQs2u9Yh2Ep0+uBSKH7J+3J1B2F1aOH/s14yG/hy7DV7QZd10HBG
         pdNZabSLeGwefTNzy84a+Yv+uGJKhYPiMHT4KbmczYxRkfYQNBu01pqguQ4nS/Rhwu
         vZrWgxo8N+KwQzJxopYrT+qGKvQvJnGmbi6DvQi7Tbp0aVk42j9RNBjNEz+lXaIYBF
         VchEXOtwfs09I/vrAzoqCz4hIFDvpkprVcQvsFu8I/nK8cKaS5x1sDUok+wOBgTcrV
         ggNY6JQLQgImY2741lSEyub80t6ZJj7yd1T+GFLGCQ0Sx0lKwJM1nCnloJ/5yB+1qJ
         5zzLjIOAXBKJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBDE9C73FE2;
        Fri, 19 May 2023 08:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add myself as maintainer for enetc
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168448442176.11174.1817196669995161023.git-patchwork-notify@kernel.org>
Date:   Fri, 19 May 2023 08:20:21 +0000
References: <20230518154146.856687-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230518154146.856687-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com,
        linux-kernel@vger.kernel.org
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

On Thu, 18 May 2023 18:41:46 +0300 you wrote:
> I would like to be copied on new patches submitted on this driver.
> I am relatively familiar with the code, having practically maintained
> it for a while.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] MAINTAINERS: add myself as maintainer for enetc
    https://git.kernel.org/netdev/net/c/3be5f6cd4a52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


