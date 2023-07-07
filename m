Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2FC74ACAF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjGGIUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGGIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ABB1BE9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800AD61866
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3F3EC433CA;
        Fri,  7 Jul 2023 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688718020;
        bh=dcFwVT6awVtN3kz0ZqEErQqasS4zVzfMUWn04fZgPTU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DL9K3X6IKXpDAlUHzYKUzv0IcFTupBd/YUpTLKDAgyf3acXFBQiShxYdjyIceFimE
         WwPKjrZPrPOshnRwGuy1H/EoZpjfn8mZl5SN7Gx2S6gaSy/3PD5UQgKD32zrD0u/DB
         ZDBGtGPNzlwTsHSplmD8CZSHpZZy6ps6Y5TMoaUC391/OTBHraEPiKIMqIK8uSQ9DF
         ION3SE+uzpAVKk61wa9vcudR4myItxbMA4iPRhK6G/YRnh/zaVfGZ7cB3qbDTaY7if
         CbH6dOZrsd6QIIS7WqNusvVYKcYPHrnc4pv4Rn+G8hfWPbf3lzL9n0WvN6EcR4PerN
         kERQjtIPekYAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3F8FC4167B;
        Fri,  7 Jul 2023 08:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] udp6: add a missing call into udp_fail_queue_rcv_skb
 tracepoint
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168871802073.22009.17793808873391205698.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Jul 2023 08:20:20 +0000
References: <20230707043923.35578-1-ivan@cloudflare.com>
In-Reply-To: <20230707043923.35578-1-ivan@cloudflare.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
        peilin.ye@bytedance.com, rostedt@goodmis.org, petrm@nvidia.com,
        nhorman@tuxdriver.com, satoru.moriya@hds.com
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

On Thu,  6 Jul 2023 21:39:20 -0700 you wrote:
> The tracepoint has existed for 12 years, but it only covered udp
> over the legacy IPv4 protocol. Having it enabled for udp6 removes
> the unnecessary difference in error visibility.
> 
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")
> 
> [...]

Here is the summary with links:
  - [v2] udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint
    https://git.kernel.org/netdev/net/c/8139dccd464a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


