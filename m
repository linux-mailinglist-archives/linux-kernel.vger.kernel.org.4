Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9E6F7F40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjEEIkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjEEIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB071885E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A21463C67
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4AC2C4339E;
        Fri,  5 May 2023 08:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683276019;
        bh=s//jhL1QL9HBWOF95GECV05CZMiyv1ggxb0bVCpm1ps=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rck/zvnVqPoUSJIUpRWgIggMZNp8kSl4VQ51jhJBeE0rtlunACVirJ2T9iPMht89X
         UBuxGMN8nDjKmdhZlMs3n+rOklckcdVWtQkz7Wyr+7aWWPHOZOOSPqnyLhIKKa2lB3
         OTazGhgOI7YtObfODZZr/XO9sYeiOFl5ZFRbkevxV9TSbEXU8TLSpt1+LN2xgegVSY
         eI34KLTuLAXMxr/WtvQTxvaOGp/+HXiib1/9kB+qaAAkENxdwvoCPY05u2nFRXNkaK
         PcZHhoxZnAbLVoa1rpiCsfceosvMg/DLJF4+JbBZ4kEcCtRv4eK5mhY+WUQ9oIAc4U
         OAFhhpE91fSpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88919E5FFC4;
        Fri,  5 May 2023 08:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: check the index of the SFI rather than the
 handle
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168327601955.11276.10504111383601482585.git-patchwork-notify@kernel.org>
Date:   Fri, 05 May 2023 08:40:19 +0000
References: <20230504080400.3036266-1-wei.fang@nxp.com>
In-Reply-To: <20230504080400.3036266-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     claudiu.manoil@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu,  4 May 2023 16:03:59 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> We should check whether the current SFI (Stream Filter Instance) table
> is full before creating a new SFI entry. However, the previous logic
> checks the handle by mistake and might lead to unpredictable behavior.
> 
> Fixes: 888ae5a3952b ("net: enetc: add tc flower psfp offload driver")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: check the index of the SFI rather than the handle
    https://git.kernel.org/netdev/net/c/299efdc2380a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


