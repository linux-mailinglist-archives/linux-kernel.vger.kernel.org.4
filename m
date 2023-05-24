Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDED70EFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbjEXHu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbjEXHu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F498F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51BF963A46
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A45A2C4339B;
        Wed, 24 May 2023 07:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684914622;
        bh=bVpio6PzGQyQVs77Te6EMaxzOPI0zNz4x4en9a0dH4M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SMgk5r6xJuF0yG0qtBs+p6AC/3CAmCw55sZ/kWZLbh3lXnHjr/T1lfIx+s/t3Nj4S
         ZgeIZQsKjAiCBBNQWuUSan7orCmDi8HkwLZ4zWYBHax/7OLfD7Lt7/unGAZBHgB5ea
         PojKGd//zijzqKufR3jpA/CrNWiX7sJ1Ew7XY2AEBFOF9U4XA8KG+2T3uHb8w9K9cQ
         EaHJl0d+8u3Ma+Gv1KSEbiZsoLeVgeE7uPfFV38EYXGdj3ZqmCgvvGxyw+jjwFR6hc
         qAAEV6dPw28vPhuWZ4/ZnMMewSR1zWGYaFtku+l2gJ+ym8KScA8n3PiBsIgicRy8fJ
         vye6lfBP5FLqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8213FC4166F;
        Wed, 24 May 2023 07:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: Fix out-of-bounds access in ipv6_find_tlv()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168491462252.4606.14185635484952180767.git-patchwork-notify@kernel.org>
Date:   Wed, 24 May 2023 07:50:22 +0000
References: <20230523082903.117626-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20230523082903.117626-1-Ilia.Gavrilov@infotecs.ru>
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, vyasevic@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
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

On Tue, 23 May 2023 08:29:44 +0000 you wrote:
> optlen is fetched without checking whether there is more than one byte to parse.
> It can lead to out-of-bounds access.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 3c73a0368e99 ("ipv6: Update ipv6 static library with newly needed functions")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Fix out-of-bounds access in ipv6_find_tlv()
    https://git.kernel.org/netdev/net/c/878ecb0897f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


