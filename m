Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C377732718
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbjFPGKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFPGKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A3B5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4907661A34
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78507C433C8;
        Fri, 16 Jun 2023 06:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686895820;
        bh=jD3AU92UzyQ5ezkTkzaT1Fd5mSwYhBVbDdASoMQ+rPY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rYWY22Hs5TddIzVxqUKwh+DHiPhECmVwxuTZl/aiKpn4LnGgGycdY5VMDTE97IorZ
         BQzApCs5Tv+yRSQMEEuj0Jv5DkKjYkldYBmSSl59aVC7Y6X1I7oo8BkUCQn58k4pV7
         /Bio/HRshfSnYD9GqAfkuqETBW1rDgi+l0z02rs4JF8oJgOJCLP+5tZLapvMhmf1Ar
         BDhDNChCLfhxI6VNz7Al5DnanNQN+3Cux9CdbxuUTf879K4RjSpuK6f4LKO1/T/IPr
         OujNJgQYbe3P76mI+KexBpdW5F0iMe1KAF6++xy0pXr9Pd8QIGJvjwzn8PsuNrw7l/
         d4E9nCPmMuuXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54002E49BBF;
        Fri, 16 Jun 2023 06:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: litex: add support for 64 bit stats
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168689582034.4933.8219800852271272267.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Jun 2023 06:10:20 +0000
References: <20230614162035.300-1-jszhang@kernel.org>
In-Reply-To: <20230614162035.300-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgugala@antmicro.com, mholenko@antmicro.com,
        gsomlo@gmail.com, joel@jms.id.au, netdev@vger.kernel.org,
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jun 2023 00:20:35 +0800 you wrote:
> Implement 64 bit per cpu stats to fix the overflow of netdev->stats
> on 32 bit platforms. To simplify the code, we use net core
> pcpu_sw_netstats infrastructure. One small drawback is some memory
> overhead because litex uses just one queue, but we allocate the
> counters per cpu.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> [...]

Here is the summary with links:
  - net: ethernet: litex: add support for 64 bit stats
    https://git.kernel.org/netdev/net-next/c/18da174d865a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


