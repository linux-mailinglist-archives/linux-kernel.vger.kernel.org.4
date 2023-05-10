Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1B6FDBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbjEJKkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEJKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9888535B3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D72A63D04
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67E41C433EF;
        Wed, 10 May 2023 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683715221;
        bh=hXXfTYfIfdfbstZ9WJjnJFY6BKlXJ+cnTyT35FzKEPk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AAQkYRfb8vh6wAkda5fpGUHKX4QLCJWdEybteuE07R3k/FC5t+ye7nlBWQChvwGLu
         mq078viMR9ylZ/bi4BRaooFy0oClEq24/xv0Ca99IX1nWMTyRTZc5F/29CdoAm/YoT
         SBM3eX46L6XO4FlYEpL0V0ZQLg4ebVFXbgMtnRA8Z9DNWLQIsDoYsB379MHrzO4RSa
         4Ds1F0zEDCO+WHok9sTnfWUYjBlUvqEKwXcNokmTsHcaR8B9oHHhxYfDfNM6j1W206
         OUcPsdZyMWhr2Vyfe8cX6eVs7ehU86DUrNcWM/pxr/r27jkJ21cABIr9JoiShjxUiq
         9nZmvXzMJWyng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BC87E270C4;
        Wed, 10 May 2023 10:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: liquidio: lio_vf_main: Remove unnecessary
 (void*) conversions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168371522130.27469.6976975356086997885.git-patchwork-notify@kernel.org>
Date:   Wed, 10 May 2023 10:40:21 +0000
References: <20230510060649.210238-1-yunchuan@nfschina.com>
In-Reply-To: <20230510060649.210238-1-yunchuan@nfschina.com>
To:     wuych <yunchuan@nfschina.com>
Cc:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
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
by David S. Miller <davem@davemloft.net>:

On Wed, 10 May 2023 14:06:49 +0800 you wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: wuych <yunchuan@nfschina.com>
> ---
>  .../net/ethernet/cavium/liquidio/lio_vf_main.c    | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next] net: liquidio: lio_vf_main: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/6096bc055572

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


