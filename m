Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B57431CE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjF3Ake (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjF3AkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675FA1FDF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E70E26168D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45E86C433C9;
        Fri, 30 Jun 2023 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688085621;
        bh=BW9t0sP6KYmbIRVSLVOs5BM8DUSGY6Wm1V54pVZGmjo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GylnbmxmRL0m6gL8br0blgU8xuCnMjhXq9xFHpR3wq5RN9Dzgo0W6ASFxwP1xc7eA
         QfN+NRIRGSMMCPiiSA6+/bG1n25FP17iQTBdMgzCJ6FSnlVTPz2jVq+N8CnT4w0SqK
         4CIhn7JPdxK+0flcd5reNHcdUkF2ezGTLHUZ14tEnd6oPVRl6yiIElT86nyIh3nORP
         mN8+yalsskUutlPSEkLAkEQER6YpeeLJdaiKSWggO1FyJJfJUVMhsvSKfIekTt0j65
         VnW4fSdoXk/VMbOxCzpqwNuRIit7py54/2LJ0mr3Xp2pW43b4uZmq389L/agyjLeZ3
         /w4HpRg2Psekw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AAA8C64457;
        Fri, 30 Jun 2023 00:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: vsc73xx: fix MTU configuration
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168808562117.27871.13180013285945472135.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Jun 2023 00:40:21 +0000
References: <20230628194327.1765644-1-paweldembicki@gmail.com>
In-Reply-To: <20230628194327.1765644-1-paweldembicki@gmail.com>
To:     =?utf-8?q?Pawe=C5=82_Dembicki_=3Cpaweldembicki=40gmail=2Ecom=3E?=@ci.codeaurora.org
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org, andrew@lunn.ch,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
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

On Wed, 28 Jun 2023 21:43:27 +0200 you wrote:
> Switch in MAXLEN register stores the maximum size of a data frame.
> The MTU size is 18 bytes smaller than the frame size.
> 
> The current settings are causing problems with packet forwarding.
> This patch fixes the MTU settings to proper values.
> 
> Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: dsa: vsc73xx: fix MTU configuration
    https://git.kernel.org/netdev/net/c/3cf62c8177ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


