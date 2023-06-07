Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65D97252CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjFGEZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjFGEYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8232D7D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:20:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B69263A58
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7F54C433D2;
        Wed,  7 Jun 2023 04:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686111622;
        bh=uy9jfLLSMmjj2jVXVKRm0XjxRlU7y8rVj5QchtHRfT0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TGkBN/OIKF8DJydz2TCtcy5h7wKAMX0oNk1LQ3kulCPdOiOQeCXKYSZWBlB4Tq173
         t5l9g9isMnOccyMQzUa/XJgoA8vt8UdIctw8vpmSDaPw4aeXeCSedrB+5mE1rW6CM7
         AzEZJc0er1yhw/ogpLnZt+xWA8v2fPJ6L3zSX7O3eyygYz6QdkURc1YI4/n1w2Oywh
         7Sxzw828Sv34otVc7wGO/2PUXSJTPWeOjxaMAPFCCgeLT7g2HXnqZmlMuoDD7v9Czb
         rAFZS+Wt26XXocWgLqo4C8mmR6mxq1VHapl42yuVhFNoHhNpg8+4FzVfMegBVChj9n
         a28qG/G+kIsXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF2B5E29F3A;
        Wed,  7 Jun 2023 04:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] virtio_net: use control_buf for coalesce params
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168611162271.32150.1707955265186129057.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 04:20:22 +0000
References: <20230605195925.51625-1-brett.creeley@amd.com>
In-Reply-To: <20230605195925.51625-1-brett.creeley@amd.com>
To:     Brett Creeley <brett.creeley@amd.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        alvaro.karsz@solid-run.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net,
        xuanzhuo@linux.alibaba.com, jasowang@redhat.com, mst@redhat.com,
        shannon.nelson@amd.com, allen.hubbe@amd.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 Jun 2023 12:59:25 -0700 you wrote:
> Commit 699b045a8e43 ("net: virtio_net: notifications coalescing
> support") added coalescing command support for virtio_net. However,
> the coalesce commands are using buffers on the stack, which is causing
> the device to see DMA errors. There should also be a complaint from
> check_for_stack() in debug_dma_map_xyz(). Fix this by adding and using
> coalesce params from the control_buf struct, which aligns with other
> commands.
> 
> [...]

Here is the summary with links:
  - [net] virtio_net: use control_buf for coalesce params
    https://git.kernel.org/netdev/net/c/accc1bf23068

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


