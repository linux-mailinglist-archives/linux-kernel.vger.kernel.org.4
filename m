Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4498270D879
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjEWJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjEWJKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A606102
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 739AB62CB7
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD84BC433D2;
        Tue, 23 May 2023 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684833020;
        bh=zkDmgnsUslUo65iN/Jku30zughMB9z0sqwl+9thvuIw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Uv4engFN4DU+NQTuAZ3hn5YCOSaQsFK8NuM+DzqpZpla6yivdly0l4pKxbmcA5Y94
         0Vo0ii7yLw30lh5oF5tefbLhbt+g3vaaicFTZD/6pggb0wDOSfEcrRY/LuFmT5tH3G
         PPGBmYrcfZIoAiHx+WzAO/GcfZvCsDBwGpshiAmdFlMxEycfQfF8njUW8J1YmIizam
         Lk0yq/qg8fNTIe3Mwv+ldFz1KEQyFIYX4P6icGh+E2d0xG/hcLelJGsJlbLJ5AHY4b
         j6dFyz60WOQiFoXULDmo3JT50i62yqMTOs6884PHRyDHAWWlYkj+Iz/vj2lcu/yMIP
         INHpXFZ5yyFtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0C68C395F8;
        Tue, 23 May 2023 09:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] octeontx2-pf: Add support for page pool
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168483302072.12699.17624055821161782289.git-patchwork-notify@kernel.org>
Date:   Tue, 23 May 2023 09:10:20 +0000
References: <20230522020404.152020-1-rkannoth@marvell.com>
In-Reply-To: <20230522020404.152020-1-rkannoth@marvell.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linyunsheng@huawei.com,
        simon.horman@corigine.com, sbhatta@marvell.com, gakula@marvell.com,
        schalla@marvell.com, hkelam@marvell.com
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

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 22 May 2023 07:34:04 +0530 you wrote:
> Page pool for each rx queue enhance rx side performance
> by reclaiming buffers back to each queue specific pool. DMA
> mapping is done only for first allocation of buffers.
> As subsequent buffers allocation avoid DMA mapping,
> it results in performance improvement.
> 
> Image        |  Performance
> 
> [...]

Here is the summary with links:
  - [net-next,v4] octeontx2-pf: Add support for page pool
    https://git.kernel.org/netdev/net-next/c/b2e3406a38f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


