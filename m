Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E6670479F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjEPIU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjEPIUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C86146AE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA10562567
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54011C4339B;
        Tue, 16 May 2023 08:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684225219;
        bh=krJvGApWpDZE3wULpmNNLp1qsJHZ8ewLviLisENMOPc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TuQ1kOb8g/GV0jTEdzVrCm4bUfPJsrkbzzxnp2oTHPmkjnIvvLVKt1UCkolL/zhoP
         OW7LjblHxqrGO41f/gA/vr59fcA05d0kT/7S9d2moXyoNah/GWd+NGeBU64PN+Wmi7
         8Dj9PBgTi5U3slZfOuxGOPZtgtZv1912ce6ebMoeAdqHiT++vIBgV5MUK+BgEss9A2
         0C1P52izX8xAWIOpU8sRKTPgpcZsqqqCNODv23VITb/q/sC8nvZAN/G8SBjaaeuHGa
         p3+qxBJ/f6aUtJIuUrpNGXsR+8WuKjewh02nN/PSBfUq7dHXfVAZOi3xZyud5KC6ke
         lFFKbYcZRPHsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3782AE5421E;
        Tue, 16 May 2023 08:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: skbuff: update comment about pfmemalloc
 propagating
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168422521922.26974.9051827263547501041.git-patchwork-notify@kernel.org>
Date:   Tue, 16 May 2023 08:20:19 +0000
References: <20230515050107.46397-1-linyunsheng@huawei.com>
In-Reply-To: <20230515050107.46397-1-linyunsheng@huawei.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        asml.silence@gmail.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 15 May 2023 13:01:07 +0800 you wrote:
> __skb_fill_page_desc_noacc() is not doing any pfmemalloc
> propagating, and yet it has a comment about that, commit
> 84ce071e38a6 ("net: introduce __skb_fill_page_desc_noacc")
> may have accidentally moved it to __skb_fill_page_desc_noacc(),
> so move it back to __skb_fill_page_desc() which is supposed
> to be doing pfmemalloc propagating.
> 
> [...]

Here is the summary with links:
  - [net-next] net: skbuff: update comment about pfmemalloc propagating
    https://git.kernel.org/netdev/net-next/c/8b33485128ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


