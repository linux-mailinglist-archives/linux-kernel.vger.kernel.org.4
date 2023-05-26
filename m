Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7A0711EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 06:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjEZEK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 00:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjEZEKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 00:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D49612F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 21:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9974F64CA9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 04:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03A6FC4339E;
        Fri, 26 May 2023 04:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685074221;
        bh=BBsw3NbG1iCxV5k48iC96IVA5u9+JQQ+YqZt6BPd1wc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j5fCHo5gIHDYrHoqJF9kDR8IOiCo9hJ2Kibs2o47OVdKuS5+6xo4PaeRmZA3lIimW
         JYQ0plVsHQrqjUfFtrKmFTv+NcGpLbohasWgi/z+rY6cJpeQoVcjsEyiWRma4UVdEo
         IFHOgTnAPgaZdyxD0cXU0tok/C1K9r956QyeOW6S88Vfwt6DfpkH4RhIXOeBMnLSXI
         Rysg7AMAer5egsgxLgN/6N9f6RVNiiZzQMEgsS/Ciy/2FKAyLFzb6jMkwMzWBtJtlQ
         f9hYWY8c7EgfQ8Wxc042yIWLwYQxR4OXVugBNCqOr/lgeUeulgjZp97nwPdl/OzwTM
         0TTaMVJupfEIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D481AE270C2;
        Fri, 26 May 2023 04:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: mellanox: mlxbf_gige: Fix skb_panic splat under
 memory pressure
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168507422086.22221.10561998805446517156.git-patchwork-notify@kernel.org>
Date:   Fri, 26 May 2023 04:10:20 +0000
References: <20230524194908.147145-1-tbogendoerfer@suse.de>
In-Reply-To: <20230524194908.147145-1-tbogendoerfer@suse.de>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, asmaa@nvidia.com, limings@nvidia.com,
        davthompson@nvidia.com, netdev@vger.kernel.org,
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 May 2023 21:49:08 +0200 you wrote:
> Do skb_put() after a new skb has been successfully allocated otherwise
> the reused skb leads to skb_panics or incorrect packet sizes.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
> Changes in v2:
> - moved skb_put() after dma_unmap_single()
> - added Fixes tag
> - fixed typos in commit log
> 
> [...]

Here is the summary with links:
  - [v2,net] net: mellanox: mlxbf_gige: Fix skb_panic splat under memory pressure
    https://git.kernel.org/netdev/net/c/d68cb7cf1fd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


