Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE2F7154E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjE3FU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjE3FUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E108FAD;
        Mon, 29 May 2023 22:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74863620FE;
        Tue, 30 May 2023 05:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2835C433D2;
        Tue, 30 May 2023 05:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685424019;
        bh=wZZq4xCSbnEzSxxDzNSdM/f6gmgE/fPraERIcsOOXSY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KPdzcVFcU1Dj/iaZ6ZXL7f7Y77v6LV9i2v6bsRwu7tfn6E9qvSTUrN0ngTBezl5Z1
         iZopWniLKkd1Bz4DdXk3p+TeiOxJVgqCkYIA037TAXLnZbGfAhZBCC/2wgO7dfdR/x
         RXf8rhJw9CVe9qTjzDZb5x/MrkmmnOyghBYODzsFJuoDHqUfx3C3sdMwASvK6G1uE2
         pw1YnrBMvMjfb8FRRhjfeAtjObVyrw71UTthasvqlKjWt7RwCUy/M+jlC/wtskFbJJ
         npLPR3O/G3votTZ1nIcY8/VXnAqUqVBLi8GG0Vz0n+POshW3jB1di7pz8I7eg+0WKj
         1wU6EoXTCPwkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EA69E52BF7;
        Tue, 30 May 2023 05:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168542401964.30709.17776180857500968814.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 05:20:19 +0000
References: <20230526-bm818-dtr-v1-1-64bbfa6ba8af@puri.sm>
In-Reply-To: <20230526-bm818-dtr-v1-1-64bbfa6ba8af@puri.sm>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc:     bjorn@mork.no, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, angus@akkea.ca,
        bob.ham@puri.sm, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm,
        stable@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 26 May 2023 16:38:11 +0200 you wrote:
> BM818 is based on Qualcomm MDM9607 chipset.
> 
> Fixes: 9a07406b00cd ("net: usb: qmi_wwan: Add the BroadMobi BM818 card")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/net/usb/qmi_wwan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818
    https://git.kernel.org/netdev/net/c/36936a56e181

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


