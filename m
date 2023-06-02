Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CF371F981
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjFBFA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjFBFAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C31713E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 22:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D0D364C4A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED92AC433A7;
        Fri,  2 Jun 2023 05:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685682021;
        bh=pKGmAe66iVLtkWUtmlwgBrvTsp94xc4/jO8ObBITOyU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P/qG1Mn9OHhZoEFIa5G1BcJ947PXozhstqYoKzh6WY9J0C15t1yzlJpkiH41jE6bs
         u82zT1I7w9WK5oNQSzkuIdNMvUxoKZ56cHbDYWUrecp67ovar/YZD90jJoy+3zb/Wz
         FZ9cRE8gBy+9MTPtmWw1VNvJo0Oqdb5RvW5iEh4vlzR5w7iNULIyJEFA8e0aLLubt1
         P4Z3ARqVPkioKGrmv7NfbJOarfIQqXpRw64jCGGRGncRu6arR2+NJVhe7APNbRau3k
         IjOkfz8vIYD7PYEKkpLFbXR/4abguZQxWo0MobQMnT2SVrRzUY9ybzxJu4hIr6Cnsq
         OQm/5efmm5svg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1639E4F125;
        Fri,  2 Jun 2023 05:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: broadcom: Add LPI counter
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168568202078.24823.16258287038709902570.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 05:00:20 +0000
References: <20230531231729.1873932-1-florian.fainelli@broadcom.com>
In-Reply-To: <20230531231729.1873932-1-florian.fainelli@broadcom.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 May 2023 16:17:29 -0700 you wrote:
> Add the ability to read the PHY maintained LPI counter which is in the
> Clause 45 vendor space, device address 7, offset 0x803F. The counter is
> cleared on read.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/phy/bcm-phy-lib.c | 19 ++++++++++++-------
>  include/linux/brcmphy.h       |  2 ++
>  2 files changed, 14 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: broadcom: Add LPI counter
    https://git.kernel.org/netdev/net-next/c/e8b6f79b4184

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


