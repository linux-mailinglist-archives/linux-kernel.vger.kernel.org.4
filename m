Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B187067A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjEQMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjEQMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24591BDF;
        Wed, 17 May 2023 05:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 646BA64651;
        Wed, 17 May 2023 12:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1790C4339C;
        Wed, 17 May 2023 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684325422;
        bh=DGwZ31ewz3iZy+bN5cHOTTQlTzO3tq2EEIqygqEMHpc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pEKCKpRz4A9B/BJTkW3/C9M2X3L89eArCswRne63auv9SEs7scRv3CyQswhqdD1tS
         0TZayz1DbLH3rlWvEfDrDrwIIzuUMVV9n6MQuwIf9KFl9wP7hCfgZYnecvTT7cMDzA
         iG9ksP3mRa8+BS2YiarFJ4BwOmb4p5Qr6FHfQgcLMNNtYBrm/c861EHddxWDmFX9pA
         cHKRg0FVVdzlM8T0FX0DDVETzGJsVs8ibm4VfPvoN5p6d6LKxJ/3aqdCUwKZYsPIzv
         3MzgP6kbo+Ss9KckdDVoGfUtyq6fllW4UMjstraHckxBYSKLy+oq3lS8DE7grx4GrO
         ZEl5eOjg3/Pkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A529DC4166F;
        Wed, 17 May 2023 12:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next v5] dt-bindings: net: nxp,sja1105: document
 spi-cpol/cpha
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168432542266.5953.1478389436139674022.git-patchwork-notify@kernel.org>
Date:   Wed, 17 May 2023 12:10:22 +0000
References: <20230517082602.14387-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517082602.14387-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
        vladimir.oltean@nxp.com
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

On Wed, 17 May 2023 10:26:02 +0200 you wrote:
> Some boards use SJA1105 Ethernet Switch with SPI CPHA, while ones with
> SJA1110 use SPI CPOL, so document this to fix dtbs_check warnings:
> 
>   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: ethernet-switch@0: Unevaluated properties are not allowed ('spi-cpol' was unexpected)
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v5] dt-bindings: net: nxp,sja1105: document spi-cpol/cpha
    https://git.kernel.org/netdev/net-next/c/af2eab1a8243

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


