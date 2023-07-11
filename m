Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2652F74E9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGKJAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGKJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E63E6A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 617A26140D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBF1BC433C8;
        Tue, 11 Jul 2023 09:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689066020;
        bh=RCLjMFeBr3MHz6ulYH079oF/FbTASlDlAGn68crW1L8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D7zado8ilp1SxdOt0GztgsUQhZnkedIPhx6PriO3SCdX8DAL7qyy8xdvmmeNttMTW
         cSkCy+yRKqqD7BCj/HO9R5bHmmMG2SuOgQnSq1SCkomVDxbM+Kj9+LaQjLK0QnYd6S
         QgISuTTyIVEhw8lzozQALT5DydMU7HAircLl97317AF97E1niGCyWitP8aPZzkGYRv
         l+1BLYYBNWNl2p+URdguknEFqQx/qkPSJP8j6f7yFo0u+qHVK5fGr2EYYKtlOqcSgG
         XXAeYOiCHq/zvNPthQpdpS2bCTQFu4i4Hpyla7YfnkeKdW5RVeO6h00CsJqCN9qP8S
         5MJL+dwVso3OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F714E52BEF;
        Tue, 11 Jul 2023 09:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: Removed unneeded of_node_put in
 felix_parse_ports_node
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168906602064.21384.13815055106752556798.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Jul 2023 09:00:20 +0000
References: <20230710031859.36784-1-luhongfei@vivo.com>
In-Reply-To: <20230710031859.36784-1-luhongfei@vivo.com>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Jul 2023 11:18:59 +0800 you wrote:
> Remove unnecessary of_node_put from the continue path to prevent
> child node from being released twice, which could avoid resource
> leak or other unexpected issues.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>  drivers/net/dsa/ocelot/felix.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - net: dsa: Removed unneeded of_node_put in felix_parse_ports_node
    https://git.kernel.org/netdev/net/c/04499f28b40b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


