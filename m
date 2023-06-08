Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79D372763D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjFHEkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjFHEkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD1619A4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70D2C647BD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA59CC433EF;
        Thu,  8 Jun 2023 04:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686199220;
        bh=e8Mw65X/s+JZVAbLrMwXWRjvc4i66hhS4wxDwoSE9l8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SoHqRRH/Vgrpag3GNkMp74659/3WX1h06SHvdA/55/8gc5HL2y/CqYWtiHZmUhbXr
         xhqQInXLbxHQyBQcRYKttvM7aVMOLcyqPKeFcDjfBfi/fUqKuHw17OqP4kQpVJqzcE
         fmty37nU946M0WpPIwTrLhgEQHP8Lvs33cpUi+tWg6Ut01tJpzO8sgQJhlKXdbvJCA
         OJEt7+R0KFzAO6USOAx9a1Tni1a6Gg91pxeb01vfayTLTt2qfpK5MuJnC254eXLAdf
         hMw3Y92Az88EpcEr35y44gjO1TmsJnPs3dvkuFVKCURFBr5pf/Gv9GN02YpLoEXAE+
         4+pJSGTNGhWfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2AF7E87232;
        Thu,  8 Jun 2023 04:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8] net: dsa: mv88e6xxx: implement USXGMII mode for
 mv88e6393x
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168619922065.15359.12044448295442540915.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Jun 2023 04:40:20 +0000
References: <20230605174442.12493-1-msmulski2@gmail.com>
In-Reply-To: <20230605174442.12493-1-msmulski2@gmail.com>
To:     Michal Smulski <msmulski2@gmail.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, simon.horman@corigine.com,
        kabel@kernel.org, ioana.ciornei@nxp.com, michal.smulski@ooma.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jun 2023 10:44:42 -0700 you wrote:
> From: Michal Smulski <michal.smulski@ooma.com>
> 
> Enable USXGMII mode for mv88e6393x chips. Tested on Marvell 88E6191X.
> 
> Signed-off-by: Michal Smulski <michal.smulski@ooma.com>
> ---
> Changelist (v7 -> v8):
> 1. added comments related to the link bit of lp_status register.
> 
> [...]

Here is the summary with links:
  - [net-next,v8] net: dsa: mv88e6xxx: implement USXGMII mode for mv88e6393x
    https://git.kernel.org/netdev/net-next/c/4a56212774ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


