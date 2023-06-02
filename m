Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDF371FE3F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjFBJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjFBJuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CCC194
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 931D664E1E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED17AC433A0;
        Fri,  2 Jun 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685699422;
        bh=L3swWL81NtAeDCamv4M+sMVmKw9hGFmx08P/E6RkN7w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HJe7c0ykLh3Jdw3R3w77PCzrO5ptXbZgG4LpDv00IgBGBp/5EFCco/duj+I/QLCO1
         y4l5X6Yo5Joo9lx2ySRsQPR4euJTs+DV/u0C8tbMDs6XyS0z40b2pm9K1cEdFluNb3
         vkkgPjsmBEww0g4Vl1ia3yfqyXUyq7tgRrUsUkCOnTKKGuOR5jSGehpaS/FzNu8zek
         pGB48V4796uNBs8uOLGd0YoBKLWaKipVRGZVZBZB7DdZqwo5829XJqcVJozuTpYeq0
         1PPsvzjxERbtvzBiWtcm8pqJ+kAfyuRrXYAnJ8jV2yfyYCyH7j6YFq6IxcaXN3hjyp
         kfIU1qLAiZEbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D676CE49FA9;
        Fri,  2 Jun 2023 09:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ip_gre: clean up some inconsistent indenting
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168569942187.12617.14650074465441446732.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 09:50:21 +0000
References: <20230602055925.26078-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230602055925.26078-1-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, abaci@linux.alibaba.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Jun 2023 13:59:25 +0800 you wrote:
> No functional modification involved.
> 
> net/ipv4/ip_gre.c:192 ipgre_err() warn: inconsistent indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5375
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - ip_gre: clean up some inconsistent indenting
    https://git.kernel.org/netdev/net-next/c/a92fb5c03404

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


