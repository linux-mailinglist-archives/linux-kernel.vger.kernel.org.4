Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0920A708333
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjERNue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjERNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFAAE7F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A507C618E5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BD7BC433EF;
        Thu, 18 May 2023 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684417821;
        bh=xQnRUgm4BT1roPqWoEGi+8IoUWJ7NajMkCHHNn7QrFY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZFXMxhgAT8gehaRDAJHcj5yHl+czmf6jM6lI5jqvUNhzqNkBP8RIlKxXXs/iFDxzn
         FoEhidDmUt5rDDqi2KsOoCLMbtB+bV1Royjg/uYv/kedKb30wvfgbuU7ilaPSh7d3p
         tpiv2/wYKrsD0vY5PfaBLtfBgcTRqM2CnbZgb6L0HFRdI7/w6pSXk9n/jX1KxVUzbY
         BSW42XrgzNoybKBgbCykurAe9/Hf9cnTX35+Bx0SKKfuYaa7vpllHPhsYkcIYYSnyz
         HF84mbEYXyMVw3f/PEhcX1Z2+b94SNtvSlbxb885EFS+EaTS5XfCQJatZm8eiRP4QM
         NJgWA+JC1TVtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5AB6C32795;
        Thu, 18 May 2023 13:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] net: lan966x: Add support for PCP, DEI, DSCP
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168441782093.32049.16346050469371833886.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 13:50:20 +0000
References: <20230516201408.3172428-1-horatiu.vultur@microchip.com>
In-Reply-To: <20230516201408.3172428-1-horatiu.vultur@microchip.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, UNGLinuxDriver@microchip.com,
        daniel.machon@microchip.com, piotr.raczynski@intel.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 May 2023 22:14:01 +0200 you wrote:
> This patch series extends lan966x to offload to the hardware the
> following features:
> - PCP: this configuration is per port both at ingress and egress.
> - App trust: which allows to specify a trust order of app selectors.
>   This can be PCP or DSCP or DSCP/PCP.
> - default priority
> - DSCP: this configuration is shared between the ports both at ingress
>   and egress.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] net: lan966x: Add registers to configure PCP, DEI, DSCP
    https://git.kernel.org/netdev/net-next/c/1fd22211354a
  - [net-next,v2,2/7] net: lan966x: Add support for offloading pcp table
    https://git.kernel.org/netdev/net-next/c/a83e463036ef
  - [net-next,v2,3/7] net: lan966x: Add support for apptrust
    https://git.kernel.org/netdev/net-next/c/10c71a97eeeb
  - [net-next,v2,4/7] net: lan966x: Add support for offloading dscp table
    https://git.kernel.org/netdev/net-next/c/0c88d98108c6
  - [net-next,v2,5/7] net: lan966x: Add support for offloading default prio
    https://git.kernel.org/netdev/net-next/c/f8ba50ea13fb
  - [net-next,v2,6/7] net: lan966x: Add support for PCP rewrite
    https://git.kernel.org/netdev/net-next/c/363f98b96a43
  - [net-next,v2,7/7] net: lan966x: Add support for DSCP rewrite
    https://git.kernel.org/netdev/net-next/c/d38ddd56d90e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


