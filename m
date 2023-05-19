Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA80470911C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjESIA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjESIAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B7ED
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A4F654B1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB058C433A0;
        Fri, 19 May 2023 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684483220;
        bh=7j28Wgv4KxUFWnjJf9HVtsdsEmY2QwncuWnjcX3Ksmw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cHgkDNpM/b80Zz6Uh15NXUtyPo9HwYnzUlruTLIKCCDUC2/sYl5Z2lQQj/Rv5zVrg
         cR9vMCEIUJqIhKE18XyTUxvrTJcJujUR2KudPcG+niaZlCnVpede8Njuwnl0Np6+yr
         qKgDTpnThnB9w15nM3mloeOQ1fdSry+kpQT7+uBVDae3oxE78i8Tz/NBcMGs+gjJuy
         CmXW/lKq38j8JkSqxRMab6GX+tInv6MjmBOZA/iel9141ozN5PTvpFLdOfFgn4mbdI
         mfvqGpr7pscCe53NacSNEkSjlrqBa/TcOYmRdbVqDP/AbNPWSNQaNS43bj7H566ITO
         7yUeJL3X6IAkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8387C73FE2;
        Fri, 19 May 2023 08:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Fix TSOv6 offload
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168448322074.32188.3680270753072564621.git-patchwork-notify@kernel.org>
Date:   Fri, 19 May 2023 08:00:20 +0000
References: <20230518064042.3495575-1-rkannoth@marvell.com>
In-Reply-To: <20230518064042.3495575-1-rkannoth@marvell.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, sbhatta@marvell.com,
        gakula@marvell.com, schalla@marvell.com, hkelam@marvell.com
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

On Thu, 18 May 2023 12:10:42 +0530 you wrote:
> From: Sunil Goutham <sgoutham@marvell.com>
> 
> HW adds segment size to the payload length
> in the IPv6 header. Fix payload length to
> just TCP header length instead of 'TCP header
> size + IPv6 header size'.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix TSOv6 offload
    https://git.kernel.org/netdev/net/c/de678ca38861

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


