Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440BE6FD3E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 04:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjEJCua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 22:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEJCu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 22:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55BA2D57;
        Tue,  9 May 2023 19:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C39B638F7;
        Wed, 10 May 2023 02:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58910C433AA;
        Wed, 10 May 2023 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683687026;
        bh=V/s57uoRYEm3pt8pyrooJhQRvtvYvdzEJkOWGFvknYA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jJ8DYJTM7t85KbCetZz9MeOS7h5OZrVbjms6jCiXUsnqU7pQZ0QkFfbFYCJad/oJX
         I+MmejcG9Ls09bnlclIqZx86Sg0/+PzGkBwsuUXVD8mp1umEDtOKHEh0wMvfPs0iEQ
         g2u5wsE56LPVd72UzACZY3QnYr9i02W/dw4Ywz+GnlsnuaYQnEITkdABWW4UdHmG3N
         TH/kdtXPis5wOBKrSzYelKI2fZ6CHI4p0Cmjv+jC4T5RgRyXvIH46BD+m7WcvY/gB2
         kuLrmJ1uMkr9B8SRoRJYtb3U3c/JYIgOEIwoiRzJ3yBfZsxpy9b1USfj8q5+KlAl8a
         JAXkOv0uTSQyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42745E26D23;
        Wed, 10 May 2023 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: skbuff: remove special handling for SLOB
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168368702626.23144.11127488053640074262.git-patchwork-notify@kernel.org>
Date:   Wed, 10 May 2023 02:50:26 +0000
References: <20230509071207.28942-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230509071207.28942-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vbabka@suse.cz, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue,  9 May 2023 09:12:07 +0200 you wrote:
> Commit c9929f0e344a ("mm/slob: remove CONFIG_SLOB") removes CONFIG_SLOB.
> Now, we can also remove special handling for socket buffers with the SLOB
> allocator. The code with HAVE_SKB_SMALL_HEAD_CACHE=1 is now the default
> behavior for all allocators.
> 
> Remove an unnecessary distinction between SLOB and SLAB/SLUB allocator
> after the SLOB allocator is gone.
> 
> [...]

Here is the summary with links:
  - net: skbuff: remove special handling for SLOB
    https://git.kernel.org/netdev/net-next/c/559ae55cfc33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


