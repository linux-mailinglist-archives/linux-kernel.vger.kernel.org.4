Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8004872891F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjFHUAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjFHUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41CF2733
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34CFC650E2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AF5AC4339B;
        Thu,  8 Jun 2023 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686254420;
        bh=r2nSOFIBg+bHENR+qPBfGTBrMcI7iQtO19j1qupNUDQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ARcSQARBSf8Dq7RwGVfNSzZoTHG0Y9zO/WRlXJBu+lTzXRJ4Zl5Tc39zNYJjqIXEi
         DPmSnlyYjC5Ntbbb1R3GVKYPOD7mXV/Ur6cR0awZZHm1HM29mKdpC/ZIcCzffXirm4
         9TqK3gSb+NAfWbvHrItLeN4aIbAnE3r4crB7kB3tz/wzZRpMfLp3DYfRUb/7O68eYD
         GbQc9tcMouYX21KP3YSTB0QXnalrXNAUxHlLnDxEnGWezX1rIUz+cMiRUgzIsq2r1+
         NJwJRfNgT73/nh8QFniPaLVD5fta9LgXjLVXtb8sm8yUCMj21Y3dcMGTeT/BbiP+Bs
         VS5+M99u9xwIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CD9CE29F3C;
        Thu,  8 Jun 2023 20:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net] net: enetc: correct the indexes of highest and 2nd
 highest TCs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168625442043.20484.1204424752375765875.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Jun 2023 20:00:20 +0000
References: <20230607091048.1152674-1-wei.fang@nxp.com>
In-Reply-To: <20230607091048.1152674-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, maciej.fijalkowski@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed,  7 Jun 2023 17:10:48 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> For ENETC hardware, the TCs are numbered from 0 to N-1, where N
> is the number of TCs. Numerically higher TC has higher priority.
> It's obvious that the highest priority TC index should be N-1 and
> the 2nd highest priority TC index should be N-2.
> 
> [...]

Here is the summary with links:
  - [V2,net] net: enetc: correct the indexes of highest and 2nd highest TCs
    https://git.kernel.org/netdev/net/c/21225873be14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


