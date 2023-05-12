Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F467003C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbjELJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbjELJaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9D187;
        Fri, 12 May 2023 02:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E83C86543C;
        Fri, 12 May 2023 09:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EC64C433A4;
        Fri, 12 May 2023 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683883820;
        bh=GOib5xDboOL+OocGTqcarLYmtaflxqQ5c3wg76X73VM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Lj7gWufICQu2qXASnBaRBvQX3NwxzTIoeoZThHj6nQe6UDHuk7nM6bCgQVD56JMyU
         /lpObAmOQZ/wEQIKAnjTlRHcUSqQ2mtY88xBBnFT36uICennrSF/VTAgmfYVLvmKdQ
         FH6aURQHXfI2I/ll3A3/gNp4vzJz9r47EIMXjgR/yTfh8MvQ7e7iSViAp00VPKncbg
         s9OG6m6AIrpXQB6Jw02fHOXePgGGSs6J8HS7KOI9xEHp0tft6gjFxG7u+Ky/znh4TT
         qwt82lm2X98/+H01U/wBPWCfdwBqHpuc5/jXcUxf6F6uUM2GJUZXpobFfQ73W2mGb7
         1JHnF345cDzBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24B3AE26D20;
        Fri, 12 May 2023 09:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: liquidio: lio_main: Remove unnecessary (void*)
 conversions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168388382014.13251.7736537992939255219.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 09:30:20 +0000
References: <20230512024403.691018-1-yunchuan@nfschina.com>
In-Reply-To: <20230512024403.691018-1-yunchuan@nfschina.com>
To:     wuych <yunchuan@nfschina.com>
Cc:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
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

On Fri, 12 May 2023 10:44:03 +0800 you wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: wuych <yunchuan@nfschina.com>
> ---
>  .../net/ethernet/cavium/liquidio/lio_main.c    | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] net: liquidio: lio_main: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/d3616dc7793f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


