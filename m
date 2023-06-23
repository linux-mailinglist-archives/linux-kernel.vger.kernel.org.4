Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE073B5F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFWLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFWLUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C715B7;
        Fri, 23 Jun 2023 04:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED58061A2D;
        Fri, 23 Jun 2023 11:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F0ABC433C9;
        Fri, 23 Jun 2023 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687519220;
        bh=HE9jkOtOoyDv0Q75oB+XoqEDHM4V4Xs9EiPT4vC6Om8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RZCSBXHo8Y7px28LcuhKSF2i2zvdLL25rGbmWQw8k4HTrkRgXmtC4mcKyHv6LY1Mi
         JynCQ3M6h0qgbHSQJl6LWlq9Q0qUT3GZawHLeVzHrJZMFMJxVn93Nci7xLlCW1LHp0
         VP/zwkclE+Bk0gKZYXKOSSInCAbUg3o2UPGk00m63+8Ah2QVpcVcdzSXODpWBHvgLw
         vZmp16UN3NLFebnuvDqy7TaRZyJev0mV2jkHp7IyG6fs8Bsz98Mky4fEY9nfLQRQYl
         61RxxhVDXb1nCgspRFAHJTocJp/I2cReOcO21/FraJfkNH2+ApEyBhkc1Cz2r23TwE
         FU3n07sFA7/Tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13A6BC43169;
        Fri, 23 Jun 2023 11:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: altr,tse: Fix error in
 "compatible" conditional schema
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168751922007.31575.12644715744862183773.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 11:20:20 +0000
References: <20230621231012.3816139-1-robh@kernel.org>
In-Reply-To: <20230621231012.3816139-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, maxime.chevallier@bootlin.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
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
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Jun 2023 17:10:12 -0600 you wrote:
> The conditional if/then schema has an error as the "enum" values have
> "const" in them. Drop the "const".
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/altr,tse.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: altr,tse: Fix error in "compatible" conditional schema
    https://git.kernel.org/netdev/net-next/c/faaa5fd30344

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


