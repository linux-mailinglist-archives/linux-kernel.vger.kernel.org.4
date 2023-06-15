Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6008A73115C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245191AbjFOHuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245424AbjFOHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A725C5;
        Thu, 15 Jun 2023 00:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F658611D1;
        Thu, 15 Jun 2023 07:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3D3EC433C8;
        Thu, 15 Jun 2023 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686815420;
        bh=zun/Pp2HfNTP0g+oW4guAz8PIZ3oIfm+vw18roGseO8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UgBEUPJ9KKTaDkr6fhn2t0DbW7xtLhXwKn/LtT811TPANzY+N5CiZpd2v5giowQSx
         q/mteKWSgBURD0vL+xlvlCeNGXZZhbdq+AZpMXXzREgwLrKSsY/VDAx+LXUOTHsYMC
         iVWbkmENptppcaxsrvxco0eZaxsmU6I3jvOU1qbLQOHtjljT7SQIE7WI6mRaPgWGQZ
         3BKdTupcY0XXi6wRAO99Q8JztQl8tjer3xP4KwXMFhoYBvoiBOFY3uCcmqVgrIhMds
         vC5cG/nOM3h+jqW8SS7cP5N2GhOD3BvjTGDDyXSfaOlCQ0ABurD6LChkoqOuGVymrm
         txhmoMFSDYw8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD071E21EEA;
        Thu, 15 Jun 2023 07:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next-next v4 0/2] Add support for partial store and forward
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168681542070.22382.18369277791311849849.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 07:50:20 +0000
References: <20230613054340.12837-1-pranavi.somisetty@amd.com>
In-Reply-To: <20230613054340.12837-1-pranavi.somisetty@amd.com>
To:     Pranavi Somisetty <pranavi.somisetty@amd.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, git@amd.com, michal.simek@amd.com,
        harini.katakam@amd.com, radhey.shyam.pandey@amd.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 12 Jun 2023 23:43:38 -0600 you wrote:
> Add support for partial store and forward mode in Cadence MACB.
> 
> Link for v1:
> https://lore.kernel.org/all/20221213121245.13981-1-pranavi.somisetty@amd.com/
> 
> Changes v2:
> 1. Removed all the changes related to validating FCS when Rx checksum
> offload is disabled.
> 2. Instead of using a platform dependent number (0xFFF) for the reset
> value of rx watermark, derive it from designcfg_debug2 register.
> 3. Added a check to see if partial s/f is supported, by reading the
> designcfg_debug6 register.
> 4. Added devicetree bindings for "rx-watermark" property.
> Link for v2:
> https://lore.kernel.org/all/20230511071214.18611-1-pranavi.somisetty@amd.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] dt-bindings: net: cdns,macb: Add rx-watermark property
    https://git.kernel.org/netdev/net-next/c/5b32c61a2dac
  - [net-next,v4,2/2] net: macb: Add support for partial store and forward
    https://git.kernel.org/netdev/net-next/c/cae4bc06b3e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


