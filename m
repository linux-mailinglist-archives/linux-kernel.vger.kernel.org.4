Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B516F52FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjECIU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjECIU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CE74C1D;
        Wed,  3 May 2023 01:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56FB62B8C;
        Wed,  3 May 2023 08:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FA0DC433D2;
        Wed,  3 May 2023 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683102021;
        bh=iBRLUxOOLNDNJJVdCjPD7ZNfD+zJIZUk4GzFTWLqUs8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PVYEay/UZjdHAp4AUWK8+KJR69U9ycokpfc847p5wW8y6euvymhYIdjErvJwOBaF6
         8lwRBlGeZGrCUeHxPsy8r+XKWIM2nKMUwyuPMDG10FEzUjPabUL0Qj9X5pxceMKVBT
         quHh/aOhUTCnyUe7lczgyClbLYpcxHzv3RXBAsjbKVCAY+OkD0H09x2rBcZuy/r5O+
         4CGDykW7TuAm6HcezGjVympOsWZeY3cZQ/cIWrRAFKjwoJn6K3LtqJEDFC9ihqAdHI
         zgT3PvTPibyQuxRv1ZZbW+zjchk/vNohyQz2sp020CoDdFPTLBAeL54ozEao9njR7e
         2QdZtkEOfkNXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B928C395FD;
        Wed,  3 May 2023 08:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8152: fix the autosuspend doesn't work
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168310202104.22454.6926310039404404080.git-patchwork-notify@kernel.org>
Date:   Wed, 03 May 2023 08:20:21 +0000
References: <20230502033627.2795-413-nic_swsd@realtek.com>
In-Reply-To: <20230502033627.2795-413-nic_swsd@realtek.com>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 2 May 2023 11:36:27 +0800 you wrote:
> Set supports_autosuspend = 1 for the rtl8152_cfgselector_driver.
> 
> Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>
> ---
>  drivers/net/usb/r8152.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] r8152: fix the autosuspend doesn't work
    https://git.kernel.org/netdev/net/c/0fbd79c01a9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


