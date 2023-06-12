Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130E872BEF8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjFLK3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjFLK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81593FCA0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B541D62351
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18DBCC433EF;
        Mon, 12 Jun 2023 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686564020;
        bh=hS6sKBbcl05rL+Hg5OoAlAezSooKe8fyP7LRjxSpgrY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Hl6ZddyhO0nweJnDSt0RKJ1VCG8zttVlQUUOMUQCM7sOzABx5wrTJb3BLO9B7w4ty
         mz8g8FJSz6rkD6PxTGLmhGCke2u61qkw8fKIO7dcSj/YkAyYPD1BMjXVcLAEqzSUos
         OteBGu2LZfK0AFsI4mEOivKHiOxATElKrn2W/J2q4bb/fxFMS6OrZGlRFr/gU/e6iL
         BKrympG7nGIhRA2jpsXR2U81TiOlfOH0RMb13yAE9MaGf/aZ+fIbKaFvlq43cEOB5f
         tFPLxize7aWp4+1zoVhVm+1zBZln39w39VnEtvPPIdlOkAja1Dyt9qoXDmsyls9jBv
         yHbWOViegDrFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC34DE29F37;
        Mon, 12 Jun 2023 10:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mdio: mdio-mux-mmioreg: Use of_property_read_reg()
 to parse "reg"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168656401995.30960.7828853186504997403.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Jun 2023 10:00:19 +0000
References: <20230609182615.1760266-1-robh@kernel.org>
In-Reply-To: <20230609182615.1760266-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
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

On Fri,  9 Jun 2023 12:26:16 -0600 you wrote:
> Use the recently added of_property_read_reg() helper to get the
> untranslated "reg" address value.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/net/mdio/mdio-mux-mmioreg.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] mdio: mdio-mux-mmioreg: Use of_property_read_reg() to parse "reg"
    https://git.kernel.org/netdev/net-next/c/b30a1f305b7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


