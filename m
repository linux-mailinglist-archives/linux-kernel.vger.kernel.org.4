Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A267379CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjFUDkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjFUDkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A0418C;
        Tue, 20 Jun 2023 20:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4420D6146B;
        Wed, 21 Jun 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60F3BC43397;
        Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687318822;
        bh=cHs6l9Wn/trqdIO7Zr4Fcl4039VfY2j7Men0yugCZeE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HF6mOMwqZ2gY6bVO7ezyp68CC2wQ/qhiqRzVwiGcoqm34vx84Yl8eys8BQ5Fxr80A
         Y77PKy1/YWCzD306jd/HuY8W7FzyUlv291JoMV4vfbh7npiSDVe9JsQW78hxUyjKXJ
         De4oEeIdbZMpQ9IBEBIgycIpfFPezv4GBh68pnXsC1RXBzFXE5xBEP4O6+VXLpFeX4
         6Jlvpf2/JlqGRheHGqJwqmWBtHWLMecM83p50T03vTiR1NUqBhtd/jOYf2rlfBCu1J
         2G0E5K/C95kQr7YnvK7lNk3FEW6LJ9Yk1zJCoAGC9KHa+gHb5yanTNnJFm367F6MX9
         P4ktl7g7SVOFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 333F5E2A036;
        Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mctp: Reorder fields in 'struct mctp_route'
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168731882220.8371.6776678967932751934.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 03:40:22 +0000
References: <393ad1a5aef0aa28d839eeb3d7477da0e0eeb0b0.1687080803.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <393ad1a5aef0aa28d839eeb3d7477da0e0eeb0b0.1687080803.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jk@codeconstruct.com.au, matt@codeconstruct.com.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
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

On Sun, 18 Jun 2023 11:33:55 +0200 you wrote:
> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size of 'struct mctp_route'
> from 72 to 64 bytes.
> 
> It saves a few bytes of memory and is more cache-line friendly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - [net-next] mctp: Reorder fields in 'struct mctp_route'
    https://git.kernel.org/netdev/net-next/c/066768b7305b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


