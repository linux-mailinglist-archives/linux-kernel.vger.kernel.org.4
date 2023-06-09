Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE127728E01
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbjFICa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbjFICaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D43330F2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92B1465328
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02B0FC433A4;
        Fri,  9 Jun 2023 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686277824;
        bh=oEpczABkS2ipZs7ltYGF0878TRFi/7OjvRhGSGsRzZc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PkeaKUmFt82nQbA+X4l66LTWlJdPM2GuCmtTuc2G37uqY4+jddIqn+06rIkVNG8tp
         rjOgPIJv5tWmoZxXbACW1/vrtjqY7xQ2sJ4NyRz8E802CDRZCgQuGqMCyDGntzOE4P
         JS8Zxh3Oe0DS/gtG6D2JgErwoPdimBZGuevHPVP+n4RjOXg8K2JcOIyS3HyywLsgTN
         XJqI5CkgTHnXbxdhhm2aqKE8po6tnV/XIu9PvATxkJwWrH3IvrDkY9RCcoMWnlgiqv
         fdy1uS3wZyGPeFgJ6AnLCfwqZes+dxHedk3eNksNW5Wp/Q33PP9cBO3E02gmrbEosw
         we45VEjujhnQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0675E29F3C;
        Fri,  9 Jun 2023 02:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: pch_gbe: Allow build on MIPS_GENERIC kernel
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168627782391.6230.2148656230557724849.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Jun 2023 02:30:23 +0000
References: <20230607055953.34110-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20230607055953.34110-1-jiaxun.yang@flygoat.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
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

On Wed,  7 Jun 2023 13:59:53 +0800 you wrote:
> MIPS Boston board, which is using MIPS_GENERIC kernel is using
> EG20T PCH and thus need this driver.
> 
> Dependency of PCH_GBE, PTP_1588_CLOCK_PCH is also fixed for
> MIPS_GENERIC.
> 
> Note that CONFIG_PCH_GBE is selected in arch/mips/configs/generic/
> board-boston.config for a while, some how it's never wired up
> in Kconfig.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: pch_gbe: Allow build on MIPS_GENERIC kernel
    https://git.kernel.org/netdev/net-next/c/c8cc2ae229ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


