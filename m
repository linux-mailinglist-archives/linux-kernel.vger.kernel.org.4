Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302997379C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjFUDkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFUDkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D2184
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 20:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE2E61451
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFE75C433C8;
        Wed, 21 Jun 2023 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687318820;
        bh=kIQtz9Eg6xo2Q6gKhfYrZttxKJ8I2teKzoggQfft2+c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Tg9uuv6vZsv5q1MvFUBuUObbzC1yY17D5u8pEUuPptSQ0TBuy3Ay4LGbprGEm68/G
         WdHGE7aMbpVkeEInyAS9ujbjJlmCvSY+8ayqlnDQ6dQN7aZcvcFGn8oHvkVHcFOPPQ
         QTcxy87aihXdJiwF5opvuxYqGLokcMBbzU7Y3aOrxxcYejKOdrIEJs1IH4rsUj6FO+
         p4GmUCNE9p0Jd4xBl9eUvzKHXfZV+5qvyw0P/eHPGu0EphCUvSekRGPm2DTyyXnBZi
         hleZnsHihDWxzDevopXQN8bGPRRf9PIH+CafAt0vEAxeLCZ1jo99Py2d/CHMb83n5X
         ya8lEKih4TpmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1264C395D9;
        Wed, 21 Jun 2023 03:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] Revert "net: phy: dp83867: perform soft reset and
 retain established link"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168731881984.8371.5821575043669064961.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 03:40:19 +0000
References: <20230619154435.355485-1-francesco@dolcini.it>
In-Reply-To: <20230619154435.355485-1-francesco@dolcini.it>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        francesco.dolcini@toradex.com, geet.modi@ti.com, praneeth@ti.com,
        netdev@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 17:44:35 +0200 you wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This reverts commit da9ef50f545f86ffe6ff786174d26500c4db737a.
> 
> This fixes a regression in which the link would come up, but no
> communication was possible.
> 
> [...]

Here is the summary with links:
  - [net,v1] Revert "net: phy: dp83867: perform soft reset and retain established link"
    https://git.kernel.org/netdev/net/c/a129b41fe0a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


