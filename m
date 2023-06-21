Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45F73866D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjFUOLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjFUOKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B101FD6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1F9C61537
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19080C433C0;
        Wed, 21 Jun 2023 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687356625;
        bh=3WCUOcr5UNscK3AWTclNUDhLVN3+J9o9BqthU//QGdI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QZ2rBM+CNeEZf0Dc9hWyC53QeatBgDD6fMFLu03inGDH2VZJjaOleP21agcMwNimJ
         NTFYFDLXCA2abpE4WVl7Xw7OY5J99+OYi6jZ6xB9ZbiZF7xT8l1efy/mtPmGhnbIJv
         5buXcEmsY3NLZKV/hxu1XAz8nYp3KDRX/ZUBPPCK6c/vDyAbXjn5zuR7gBqlNBNjna
         XJPjTGan3egQmS16PHsDqzTRPTcXIqZQuRLjtwPwpAzIiM/2eyRPfxHF+7a289iC3s
         SJZZHZrVk1jr1/oSotL6dCWKg4sF3rFtPBswX6tHb6WyvVbwWz+7w5PjJFxRdGTpNl
         P31VQ+TgZGJOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA07BC4316B;
        Wed, 21 Jun 2023 14:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: micrel: Change to receive timestamp in the
 frame for lan8841
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168735662495.3443.6450450622724986833.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 14:10:24 +0000
References: <20230615094740.627051-1-horatiu.vultur@microchip.com>
In-Reply-To: <20230615094740.627051-1-horatiu.vultur@microchip.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Jun 2023 11:47:40 +0200 you wrote:
> Currently for each timestamp frame, the SW needs to go and read the
> received timestamp over the MDIO bus. But the HW has the capability
> to store the received nanoseconds part and the least significant two
> bits of the seconds in the reserved field of the PTP header. In this
> way we could save few MDIO transactions (actually a little more
> transactions because the access to the PTP registers are indirect)
> for each received frame.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: micrel: Change to receive timestamp in the frame for lan8841
    https://git.kernel.org/netdev/net-next/c/cc7554954848

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


