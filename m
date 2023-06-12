Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D238172BAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjFLIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjFLIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB17A8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26A2A62179
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E3DFC433EF;
        Mon, 12 Jun 2023 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686559222;
        bh=6q6K/ZSldiMBwb306CxjURo/TgUUC6WeXGv1VOPDG7w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S9I4Os80qmax19hiJFQ9KqmzhmPnoAyBNVDAGFfPxKTBCh6HQ7c8XP9YymuAC8K8t
         0DIEgNK7OeQzjo9xnTrMEeZTZrEQxDj2boQLDnP6yIYUWIQHFL9acTwBQTzIATwrCw
         x+sJIKmcMhAxgtKAK7z/fKPj1A8sdIrkQbh153CLEp5sd6d+MnKIxqiaxQA6zeKFvb
         ItIiKmfpu4QPhLHPEHL97WQGo0xLDa8MQIJV9IvOdtNCspj3dBkBqA/ixbm3+rFD7x
         7o5M7RZ2Bh+5j3zGxWeS7zGj2nUq56HmPdvUjI+IgDenFOQya1x4LgQfPYKg6wc0Qg
         dz0xNciFNf/VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6478CE21EC0;
        Mon, 12 Jun 2023 08:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: act_pedit: Use kmemdup() to replace kmalloc +
 memcpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168655922240.2912.6853929575701794720.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Jun 2023 08:40:22 +0000
References: <20230609070117.100507-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230609070117.100507-1-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, abaci@linux.alibaba.com
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
by David S. Miller <davem@davemloft.net>:

On Fri,  9 Jun 2023 15:01:17 +0800 you wrote:
> ./net/sched/act_pedit.c:245:21-28: WARNING opportunity for kmemdup.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5478
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  net/sched/act_pedit.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - net/sched: act_pedit: Use kmemdup() to replace kmalloc + memcpy
    https://git.kernel.org/netdev/net-next/c/26e35370b976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


