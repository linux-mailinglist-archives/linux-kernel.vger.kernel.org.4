Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7759971A008
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjFAOaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjFAOaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9391FFC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A49612A1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90331C433EF;
        Thu,  1 Jun 2023 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685629819;
        bh=2eT6v1/C9jazgiPlmc7EA3TKFRAj8z2AYljVkDk7Xds=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=N+Ctla4de7wScrzh+1XaCSrzFpax6DikzdHp7zgitOiXL+/pC3aDU4R0qTS178IAl
         BvdGmSUxeOcje3vO8nKzUEhLAIxCjF55NwsprsDVdeviCTdhRm/1wGXhBa92tYpapN
         6qesW+UnZ6+z0lw1mYvbIndqpG43o0Wzox9gUrXOOKUJfuK4iUlofOUDiCJ9d1gjtk
         KcSs51FQHfJwb22FPeJKiIs11NZCMaDA9ZpGrSNnt8sfIY1cGjGnrPfFlVzVa56Usb
         6m2ipZxj30q/Xw+TLQl/7TRnT2SSapN1waVRNph2dBUHBE8Q4saQF5NRxElQoxiOtT
         PDi95CNMK7ChA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 797A0E52C02;
        Thu,  1 Jun 2023 14:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Increase wait after reset
 deactivation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168562981949.12126.5921188118385782118.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Jun 2023 14:30:19 +0000
References: <20230530145223.1223993-1-andreas.svensson@axis.com>
In-Reply-To: <20230530145223.1223993-1-andreas.svensson@axis.com>
To:     Andreas Svensson <andreas.svensson@axis.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kernel@axis.com, baruch@tkos.co.il,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 May 2023 16:52:23 +0200 you wrote:
> A switch held in reset by default needs to wait longer until we can
> reliably detect it.
> 
> An issue was observed when testing on the Marvell 88E6393X (Link Street).
> The driver failed to detect the switch on some upstarts. Increasing the
> wait time after reset deactivation solves this issue.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mv88e6xxx: Increase wait after reset deactivation
    https://git.kernel.org/netdev/net/c/3c27f3d53d58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


