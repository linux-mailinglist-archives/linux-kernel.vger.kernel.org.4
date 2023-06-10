Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22A072AE3D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFJTCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFJTCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DA81993
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E9A061AA0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 19:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ECF4C4339B;
        Sat, 10 Jun 2023 19:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686423740;
        bh=UKHPN9ydWII98C0KdgeIdXbjqqmr0bnqBO+zD2g7O84=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jbX8NmU30GUi1CKa9e/FlzO7Ah2wvxb1gRhXOjlMEJGE7VBvi+iZC7pE9Apg3XhpZ
         1CI5syTza239So6O/rDmSnp/KHf5DUoWgst8iNyvxPlO2KYH6TdKnlsUzCB2N+AdDu
         H3KY5QWG3+Xor6dshOTpoddg7TYsKWsNEAvdo0vCWZKUA5yZBga4oTL5BWRoy27fqM
         5w4UNjJ0xm/9vvm+/WSPFyOPRk9giL95+QbXCvUw/WCdJEes5sI07jejMqVXG0vJdB
         jYQv3Fwi9UHQ7G2D1ZaNgOcifBOEgiFS0Dh9turBO1/qfNN5fBANCRtXKEwkU51mbU
         K94OxGNW1xTcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B7FDC395F3;
        Sat, 10 Jun 2023 19:02:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH 0/2] RVU NIX AF driver fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168642374043.25242.6626382356488289406.git-patchwork-notify@kernel.org>
Date:   Sat, 10 Jun 2023 19:02:20 +0000
References: <20230608114201.31112-1-naveenm@marvell.com>
In-Reply-To: <20230608114201.31112-1-naveenm@marvell.com>
To:     Naveen Mamindlapalli <naveenm@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 8 Jun 2023 17:11:59 +0530 you wrote:
> This patch series contains few fixes to the RVU NIX AF driver.
> 
> The first patch modifies the driver check to validate whether the req count
> for contiguous and non-contiguous arrays is less than the maximum limit.
> 
> The second patch fixes HW lbk interface link credit programming.
> 
> [...]

Here is the summary with links:
  - [net,1/2] octeontx2-af: fixed resource availability check
    https://git.kernel.org/netdev/net/c/4e635f9d8616
  - [net,2/2] octeontx2-af: fix lbk link credits on cn10k
    https://git.kernel.org/netdev/net/c/87e12a17eef4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


