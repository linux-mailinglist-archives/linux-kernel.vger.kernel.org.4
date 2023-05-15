Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B386D7029D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbjEOKAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240368AbjEOKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5E9DF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21579621C7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DBD4C4339C;
        Mon, 15 May 2023 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684144821;
        bh=brZAg4HC4B8ZDhw3xpm0FIi3+HADqPvhBqK024DoW0o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ifwiRrAzeEipVB0vFTCa9KtcHSjnF+4J8oeTfEF2v6F2idA2vJq4M3qFoNDe9vTWe
         dGZbTNZkpKXUracoYTAZc+BJUV9xcr+giLRqPWC+ICn+O7d34kGKM3IQZ0LQA0y+Jk
         6z36lh2asYcrEp0LP0KyEX0FF5RXNnNieajh4vsIVD9Ug/2N61M3wYIq6f27rPFbA+
         V+G4des8h8s5fXPcTzVs8tRUm0i+xnRY/gW7aOFMqD01QCC1lQKjO6raOpZvaygHqn
         3uawOnwLTQ2UHTZFpBo+VrfXGdZzNGiQFrrrpzoBPAETmdHFzpnj0qtppktJCKuNl8
         ICrXXeD9pD1MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6059CE5421D;
        Mon, 15 May 2023 10:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-pf: mcs: Remove unneeded semicolon
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168414482139.15349.3751374833607911323.git-patchwork-notify@kernel.org>
Date:   Mon, 15 May 2023 10:00:21 +0000
References: <20230515085645.43309-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230515085645.43309-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, abaci@linux.alibaba.com
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 15 May 2023 16:56:45 +0800 you wrote:
> ./drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c:242:2-3: Unneeded semicolon
> ./drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c:476:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4947
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: mcs: Remove unneeded semicolon
    https://git.kernel.org/netdev/net-next/c/d1e4632b304c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


