Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DF66F7F42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjEEIk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjEEIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC19018860
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56DE163C6D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EFCBC4339C;
        Fri,  5 May 2023 08:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683276019;
        bh=8fXbeci8WYKmW3af+fjKatR4JfH4t7nFwFnFJBoZTPA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iv6kR8slYWL8t1iCLDS32c6addJ+miFQSlUk1gjDohzedqpF/FLosnNJ5YcBOUCk3
         uu7rW057hGGy0ve6T4G/FRejgzRhPFLbNXrt6eZJKGpk69qIAy28u0W1ziMFo6QpUS
         /5LVd5mSOzY8l25w2r495C7Lu+YPcrzxT6HjXmJqsiRq66ySnvZgIb4y/xRk76/RBG
         WkEHp4PCcLu7pGykudBQLJ7+klDRe+mA+sk4wcXJlKbY4nI3gcYjepD+2pkG6pdPIR
         H5CGcO/OHUco4+h3VR94LqgNXrRExz23E0xES+NE9IiIR757b+8T+fDk+OrWhriv0t
         k3wnV36zxcMXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DDB2E5FFCE;
        Fri,  5 May 2023 08:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168327601951.11276.17799441179157918753.git-patchwork-notify@kernel.org>
Date:   Fri, 05 May 2023 08:40:19 +0000
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
In-Reply-To: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
To:     Wenliang Wang <wangwenliang.1995@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        zhengqi.arch@bytedance.com, willemdebruijn.kernel@gmail.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu,  4 May 2023 10:27:06 +0800 you wrote:
> For multi-queue and large ring-size use case, the following error
> occurred when free_unused_bufs:
> rcu: INFO: rcu_sched self-detected stall on CPU.
> 
> Fixes: 986a4f4d452d ("virtio_net: multiqueue support")
> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> 
> [...]

Here is the summary with links:
  - [v4] virtio_net: suppress cpu stall when free_unused_bufs
    https://git.kernel.org/netdev/net/c/f8bb51043945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


