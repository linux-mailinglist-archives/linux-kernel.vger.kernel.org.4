Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6AD6FDC87
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbjEJLUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjEJLUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804F9A1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1692E63603
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27B70C433D2;
        Wed, 10 May 2023 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683717620;
        bh=aAiABVe/+jQPNgVvSNDYPi3rJPOkVw4Hn7VlJBkYOp0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ggW78f1jvMlj+g6ucphQ8qBTUbfE388mRy8JKipLthn2MKD7CDUEFZIs+ASIvlRgW
         X99xQPHqTyvOhlYBx8Y6ktHTP0QNdgYyMYbgn3biguOo3vIrvnbs+W3/42eK4BORRW
         tUYW/Mz1SB3Q6UpjOBYhoD1FGrT3OnQmO72A1Wwwj0MSm2iBXQGeChs0uqylJfSro2
         XS4GRNomv5/gz1Knpd19pOKtoxhmBwc5Qyvue7wOTvkMZb7fXDtSx3wZmTHBOc5CCC
         Y0qmaEwo+ywE5oqnSvFEb7iY20EVhkx7LP9PAbYamGQzKzBL/iXpdJHkfmIq4Jo435
         Cyj9D+Dun+/pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D3A4E26D21;
        Wed, 10 May 2023 11:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: mscc: ocelot: fix stat counter register values
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168371762005.15306.4629499713441955918.git-patchwork-notify@kernel.org>
Date:   Wed, 10 May 2023 11:20:20 +0000
References: <20230510044851.2015263-1-colin.foster@in-advantage.com>
In-Reply-To: <20230510044851.2015263-1-colin.foster@in-advantage.com>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.manoil@nxp.com,
        vladimir.oltean@nxp.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  9 May 2023 21:48:51 -0700 you wrote:
> Commit d4c367650704 ("net: mscc: ocelot: keep ocelot_stat_layout by reg
> address, not offset") organized the stats counters for Ocelot chips, namely
> the VSC7512 and VSC7514. A few of the counter offsets were incorrect, and
> were caught by this warning:
> 
> WARNING: CPU: 0 PID: 24 at drivers/net/ethernet/mscc/ocelot_stats.c:909
> ocelot_stats_init+0x1fc/0x2d8
> reg 0x5000078 had address 0x220 but reg 0x5000079 has address 0x214,
> bulking broken!
> 
> [...]

Here is the summary with links:
  - [net,v1] net: mscc: ocelot: fix stat counter register values
    https://git.kernel.org/netdev/net/c/cdc2e28e214f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


