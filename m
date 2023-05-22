Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFA70B9EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjEVKUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjEVKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0156CDB
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86F4060F01
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE9F6C4339E;
        Mon, 22 May 2023 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684750819;
        bh=h03m6soAV+h3GUoc3/t/hNO1ViBXrCNtWN99bv0Qm6k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Kn7dLDaJlkUl/ZShPV9DnFLWXwwd/GZLb/Aj3qU//UD2HGxzc5PjTWN0ywhCYqce5
         ztmniwrr4TGp7apkBvnVqNjuDXRVnjjPfhcgfB2bigkP7iB7Scl4+bzkHAOeHdoPTl
         VADwOUp6U23SjO7e2FcYYgAsmqiXNe2UOY71N80QoJFopWiqloMpF+CnMZluCu7/ZD
         A+cyusn/dFJhQTNACDYk/nh7r56SFzrW9odOeMxNYAtKX+XKlGd1JGsSQzio5ogVu4
         vV89k6QMzEvBivLn+fW4ERhUjqKTSN8chi1OcTX9wYWZzCAj/0LeQBrfBE4D1i5bw8
         AX6/u33wNt9aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0C0DE22B08;
        Mon, 22 May 2023 10:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next] net: fec: remove useless fec_enet_reset_skb()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168475081978.10880.9020985051472472031.git-patchwork-notify@kernel.org>
Date:   Mon, 22 May 2023 10:20:19 +0000
References: <20230519020113.1670786-1-wei.fang@nxp.com>
In-Reply-To: <20230519020113.1670786-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Frank.Li@freescale.com, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, simon.horman@corigine.com,
        netdev@vger.kernel.org, linux-imx@nxp.com,
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
by David S. Miller <davem@davemloft.net>:

On Fri, 19 May 2023 10:01:13 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> This patch is a cleanup for fec driver. The fec_enet_reset_skb()
> is used to free skb buffers for tx queues and is only invoked in
> fec_restart(). However, fec_enet_bd_init() also resets skb buffers
> and is invoked in fec_restart() too. So fec_enet_reset_skb() is
> redundant and useless.
> 
> [...]

Here is the summary with links:
  - [V2,net-next] net: fec: remove useless fec_enet_reset_skb()
    https://git.kernel.org/netdev/net-next/c/2ae9c66b0455

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


