Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D9073CD33
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 00:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjFXWKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 18:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFXWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 18:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922EE6B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 15:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6149560ACC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 22:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFA51C433C8;
        Sat, 24 Jun 2023 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687644626;
        bh=Af1wluoPesxzfC6tKSmwNEv1detWSwXXYbav1TrsDwA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mh/fzCZcwqpyIeqjker9f2jPAVerk0DNhYcqeTejx//Fd3adpYJZPYA3REXj4jw2Z
         e8Chl6qu+5m9z9wym14l6m3te9WoAQkPi/8qAl8jpKO3QpBfnu229OV9rrVxxCq1TG
         2Ns2hK/IGLSIGRigP95uS9CtJXERnm+xRIgDOMb30Alot5Xc1hYzmjdl1FFD6Kon1N
         bflR1fXCpkHCgsGzyc/C1KHHF5mt2Q2uJHHdjoT130t2fk+zj0TZ+5t+7YWUT5hrND
         dl8i1AAmylMO/ud2zhYABP0TKTEjU5lui0WrV/pAYHQRyrRLOFVaKYj+XQyphZXQMN
         UIt4OA4yBg3fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4544C395F1;
        Sat, 24 Jun 2023 22:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: broadcom: drop brcm_phy_setbits() and
 use phy_set_bits() instead
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168764462666.18414.17822935967545944021.git-patchwork-notify@kernel.org>
Date:   Sat, 24 Jun 2023 22:10:26 +0000
References: <20230622184721.24368-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20230622184721.24368-1-giulio.benetti@benettiengineering.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, simon.horman@corigine.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 20:47:21 +0200 you wrote:
> Linux provides phy_set_bits() helper so let's drop brcm_phy_setbits() and
> use phy_set_bits() in its place.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> * fix code style and add branch net-next to subject as suggested by Simon
>   Horman
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: broadcom: drop brcm_phy_setbits() and use phy_set_bits() instead
    https://git.kernel.org/netdev/net-next/c/28e219aea0b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


