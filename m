Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E612273466B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjFRNka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 09:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjFRNkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 09:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0981AB;
        Sun, 18 Jun 2023 06:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24B5960ED3;
        Sun, 18 Jun 2023 13:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E30DC433C8;
        Sun, 18 Jun 2023 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687095620;
        bh=3ZfdVHlvWNk4QSgyJ/JM9b/WhTMvolihQEHxoUoZ6WI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FSNXu9IxG8HHlo3Q3bHO/+wYR6f5hmyP6lit/1BvnN/YM3KS0qhf8rSZxOCVyyZQX
         A3biijXH0y+nklROibUpIKSx111pD/yby0WnMFStfqLkFzmmzqeidiBlPCSwKtRAVI
         jGcxwtCh6US2vnyvgcto1NDqoc1u6YsRU0Ju/+N90ChKZknCNPAPNoOHD4U9XfaI+J
         CpvdzCANorGsUEwftwsrbey7ZJxJPKb3pMIfubv3lXpJzQLP7i/TFh7f5YMY737UI4
         VuIY6KGCuUqgg0dTIij7aYtH6ZOU9SdmYkuteL4RGcqZfgN9QWAO4ZfstQkxtOp365
         BFwjWLrOgO1lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 507FAE49BBF;
        Sun, 18 Jun 2023 13:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: phy: gpy2xx: more precise
 description
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168709562032.22941.5957562536489573890.git-patchwork-notify@kernel.org>
Date:   Sun, 18 Jun 2023 13:40:20 +0000
References: <20230616-feature-maxlinear-dt-better-irq-desc-v1-1-57a8936543bf@kernel.org>
In-Reply-To: <20230616-feature-maxlinear-dt-better-irq-desc-v1-1-57a8936543bf@kernel.org>
To:     Michael Walle <mwalle@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, michael@walle.cc, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
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

On Fri, 16 Jun 2023 12:45:57 +0200 you wrote:
> Mention that the interrupt line is just asserted for a random period of
> time, not the entire time.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: phy: gpy2xx: more precise description
    https://git.kernel.org/netdev/net-next/c/264879fdbea0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


