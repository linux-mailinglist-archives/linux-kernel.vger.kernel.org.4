Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBB5745732
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGCIUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGCIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8AE47
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5392860E8D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7E17C43215;
        Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688372422;
        bh=GAdkZrdoKWD7YyzDP8ANymefO04wUe7jKXHOYI0JvAo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JOvpxdIGeaV0pdDRSr0O5u0avi/sD+ggbLk1bJO5icXqWRlhcCGWiUmErpMum5SN2
         UmenbWL94IdusSUdkoxIcOmb8uFVJVDSvRrFWDFyvfuKGj4+UkEdb4O3cBOZ67sFOs
         X4k0VsnwUdlE7L4UN+C8F0yolhb5FkqbVPq8VmNtHUDZ/4LiOlYT0BbrXwvjut4iM/
         4b8kECPQ41MhyrEat0zPWUnaBjOG4pdlfO5HN36CjEZqu2SFZVWKbS0mZOLsJjF1u+
         N3qbafx/sjDRzdgsXrMPXwWN+uhFVVLMVKjGBV08nyDdUK55oh2E/ECNlxWn8+0PaN
         V2s7G2bqmU4OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D0ACC691F1;
        Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: keep ports without IFF_UNICAST_FLT in
 BR_PROMISC mode
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168837242257.9798.3078714826638477204.git-patchwork-notify@kernel.org>
Date:   Mon, 03 Jul 2023 08:20:22 +0000
References: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, roopa@nvidia.com,
        razor@blackwall.org, idosch@nvidia.com, mst@redhat.com,
        vyasevic@redhat.com, bridge@lists.linux-foundation.org,
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

On Fri, 30 Jun 2023 19:41:18 +0300 you wrote:
> According to the synchronization rules for .ndo_get_stats() as seen in
> Documentation/networking/netdevices.rst, acquiring a plain spin_lock()
> should not be illegal, but the bridge driver implementation makes it so.
> 
> After running these commands, I am being faced with the following
> lockdep splat:
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
    https://git.kernel.org/netdev/net/c/6ca3c005d060

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


