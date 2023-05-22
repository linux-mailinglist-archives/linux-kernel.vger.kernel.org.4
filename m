Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA670B9EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjEVKU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjEVKUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FBAD2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77BB861F1F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF184C4339B;
        Mon, 22 May 2023 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684750819;
        bh=PV9zecWy4/YM6WwOgR+pxHNR54i6kDfQ45MfSYPZp4Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D0sL1PcEOi/4T8VJ/5N/rXNmWIeUsNmT7p0CsvZSlEHsN+PPDm1r8p8soY7PHuc8r
         nQwc9ldAEskiMHUgXC2e03E7YwGDauomYkmMDn7W9rxb5n55ygCQ3V3FbxFEslYjtY
         SzBCPDMRKzxC+kdlbIumE087pW18AktZ5aH+DYKcC0y3UAGPx3rzT9e/jNYXP0uU7l
         Jo5OdCVpiGhhf5EZF9LTIfvlpOvam51WJfxCD1SqwsR6k7dFO7IF2r1lR4ppjLwFP1
         trQ+yG4D9RPGUe0Vj/hR9Dlza9xxgLpPAH8cPFasvJ7d678clgUcTe0UbwYc9jbh93
         /OCBhGE0DPcvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3674E22AEB;
        Mon, 22 May 2023 10:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [net-next] net: ipconfig: move ic_nameservers_fallback into
 #ifdef block
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168475081973.10880.7575726899017008344.git-patchwork-notify@kernel.org>
Date:   Mon, 22 May 2023 10:20:19 +0000
References: <20230519093250.4011881-1-arnd@kernel.org>
In-Reply-To: <20230519093250.4011881-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, martin@wetterwald.eu,
        arnd@arndb.de, chenxuebing@jari.cn, gregkh@linuxfoundation.org,
        saravanak@google.com, netdev@vger.kernel.org,
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

On Fri, 19 May 2023 11:32:38 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new variable is only used when IPCONFIG_BOOTP is defined and otherwise
> causes a warning:
> 
> net/ipv4/ipconfig.c:177:12: error: 'ic_nameservers_fallback' defined but not used [-Werror=unused-variable]
> 
> [...]

Here is the summary with links:
  - [net-next] net: ipconfig: move ic_nameservers_fallback into #ifdef block
    https://git.kernel.org/netdev/net-next/c/dbb99d78522a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


