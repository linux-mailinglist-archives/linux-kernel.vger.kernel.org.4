Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117F4700211
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbjELIAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbjELIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D810A17
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E672653CD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C736C433A4;
        Fri, 12 May 2023 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683878423;
        bh=h1PIBDDkN9KYnWVwY4ASDt+IVOga5TEjRfO84XcCOH4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OnJNS9oN8Dkrt7nSKwcADAtlseKmjllGV4YxFjyvpXr4fBqMomxIPXb3j27x5XCvM
         gL2Pk5OjOW4fLFYrbUvh1QsnWa56Oj8Bcg5r1Y/nTej/RMXbnJrWol74PcbL5m8CTZ
         drFWOqHaDDtYjD8rwl1UJq6uTCW/GShHsdhH6FE6WbkIiAMWbJPvtYfVN3istIJL9H
         A/XfLCfonXsrNM4eXolMNVLYtWvqvofGQFFuey7NU6e4IFJWwq8WwK16H18mbNozft
         K8JVPW1snnCKDQ0RNpJ0VItXwAymqIfynxsmfFThbeOF6qgOenYxpQXKQHCf8GXaCR
         XUKkesUtvjyDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89CF8E26D2A;
        Fri, 12 May 2023 08:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipvlan: Remove NULL check before dev_{put, hold}
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168387842356.16770.3411961008492273688.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 08:00:23 +0000
References: <20230511072119.72536-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230511072119.72536-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, abaci@linux.alibaba.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

On Thu, 11 May 2023 15:21:19 +0800 you wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warning:
> 
> ./drivers/net/ipvlan/ipvlan_core.c:559:3-11: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4930
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - ipvlan: Remove NULL check before dev_{put, hold}
    https://git.kernel.org/netdev/net-next/c/0fae8847563b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


