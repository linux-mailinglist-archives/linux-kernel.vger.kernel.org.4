Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFB973AEDB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjFWDAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjFWDAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD1A2680
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 076646195C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5752FC433CB;
        Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687489222;
        bh=KfwjvmV5ejMTSyciHWdK1aLZdnKh10wfFkwKw4zVjnc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hjKuxmwPzsUpnRrUeHjOyk8Mom0nqgqtMix2E797mb3zGWrE/unhWSd89bM0+IsTs
         GTbhIR5ChaH1VmhpyyX/fdkOwZHCDa+CrlUvcZ/Q2m3oWpyTt1/r6Yo+09860ozJ6U
         gTHiSqTmLWjLD8CnlcW3RtNgfaeazZ0MBskXkp3cCs98V/Mb+WgotDadTJpZNHtRNh
         tzCONnbXesYhUlABkl5JtWK229akCd90n19jWhubVfPdhEdhoPw0hq3FrcXkWTeYuF
         QFphEd33qJixdQE0Pr9id8t3+gq0lu6qMa8hB01bTCOZVkGn2vL/t4+68bx9yUaoZo
         rQDvyFYlusQLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DCD9C691F1;
        Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for additional modes
 for netdev trigger
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168748922224.4682.16332057188108766374.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 03:00:22 +0000
References: <20230621095409.25859-1-ansuelsmth@gmail.com>
In-Reply-To: <20230621095409.25859-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, pavel@ucw.cz, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 11:54:09 +0200 you wrote:
> The QCA8K switch supports additional modes that can be handled in
> hardware for the LED netdev trigger.
> 
> Add these additional modes to further support the Switch LEDs and
> offload more blink modes.
> 
> Add additional modes:
> - link_10
> - link_100
> - link_1000
> - half_duplex
> - full_duplex
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: qca8k: add support for additional modes for netdev trigger
    https://git.kernel.org/netdev/net-next/c/2555f35a4f42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


