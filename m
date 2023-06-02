Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC2E71FE73
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjFBKA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbjFBKAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A72180
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2788C64E2D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78986C4339B;
        Fri,  2 Jun 2023 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685700019;
        bh=FKQFA9YyHsqaGBGUWB0EFoK6lSWvks20FcE63BHWbWE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rT/wtFKHIhvvbEFXZfHoyLloY+H8mg+rD7Yg1jnkzgKUMBRP5IDciCWAfw/84HdUn
         UJq2dZYkzJXyEvd8PlrlJqdY5Z9vbwE7iV9BvZTwLR5kb59gNxELugaYJPhEgeYslT
         MWDddRgE/EDZsnuTEHu9dV79/55TO8IkiO/BzLUfSZVYXBllU2tyem4bC1aFgyjPhK
         rC2JwZHLHaIUV8ojJ8QTsK2lQXe51zIj6Srn3fPq1Kgy6D8H5rIpgocFFjrhRTx5D6
         XW8ZIujqgw9frwLYJmSmCdVKJdpzUUrUNqxWoWRl4UM49ICk8OMCJMgvXDnsz9A+go
         Obt7OBo0Ot8tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C95EC395E5;
        Fri,  2 Jun 2023 10:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: qca8k: add CONFIG_LEDS_TRIGGERS dependency
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168570001937.17073.11024207858113974677.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 10:00:19 +0000
References: <20230601213111.3182893-1-arnd@kernel.org>
In-Reply-To: <20230601213111.3182893-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ansuelsmth@gmail.com, arnd@arndb.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu,  1 Jun 2023 23:31:04 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without LED triggers, the driver now fails to build:
> 
> drivers/net/dsa/qca/qca8k-leds.c: In function 'qca8k_parse_port_leds':
> drivers/net/dsa/qca/qca8k-leds.c:403:31: error: 'struct led_classdev' has no member named 'hw_control_is_supported'
>   403 |                 port_led->cdev.hw_control_is_supported = qca8k_cled_hw_control_is_supported;
>       |                               ^
> 
> [...]

Here is the summary with links:
  - net: dsa: qca8k: add CONFIG_LEDS_TRIGGERS dependency
    https://git.kernel.org/netdev/net/c/37a826d86ff7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


