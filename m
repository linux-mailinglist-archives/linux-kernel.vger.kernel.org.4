Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F10B7295C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbjFIJqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241846AbjFIJpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2191E46B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AF5765638
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67CA3C4339B;
        Fri,  9 Jun 2023 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686303622;
        bh=3bjWbKWtrsHkk6EM0tj/C2LQ5eyTKWUK+mavUr6mFsc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VB3EwScyKknbbzUtTQPqmFiIiKg8aSqPu7DRyxgJstCZYOe3XzfMIbxytqWbD5yz+
         QKzez8odxlhYphKM1djnA3r7CPvqLdVCoVtmKBQOzd+TSfKSq6JOik/YSJHs9bv450
         C6gDUaRFpQRPsLg2p9OXmqLX8b3YFeRQeMxjIkfmveV7fzvQLaG8vBGGtYkcpMqr72
         ZOK7LBfLtuj8sM+LOo/7Jatn5qPkRt+RrdbcNeUuloF5rtWRC5cBy9Wa/TwUP2wSuf
         BiD/4Wzh/AhpSLnq8IBN4elQtLkz7NMTKKv57y5ceIdwizKl7pdj71r2ZauhT3Fs/l
         XUycllgdUPGYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46DBEE1CF31;
        Fri,  9 Jun 2023 09:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] LED brightness support for Broadcom PHYs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168630362228.15762.16292127004844769678.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Jun 2023 09:40:22 +0000
References: <20230607183453.2587726-1-florian.fainelli@broadcom.com>
In-Reply-To: <20230607183453.2587726-1-florian.fainelli@broadcom.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, opendmb@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
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

On Wed,  7 Jun 2023 11:34:51 -0700 you wrote:
> This patch series adds support for controlling the LED brightness on
> Broadcom PHYs.
> 
> Florian Fainelli (2):
>   net: phy: broadcom: Rename LED registers
>   net: phy: broadcom: Add support for setting LED brightness
> 
> [...]

Here is the summary with links:
  - [1/2] net: phy: broadcom: Rename LED registers
    https://git.kernel.org/netdev/net-next/c/57fd7d59b1c7
  - [2/2] net: phy: broadcom: Add support for setting LED brightness
    https://git.kernel.org/netdev/net-next/c/bd5736e146e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


