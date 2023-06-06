Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429027240DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbjFFLa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjFFLaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30741F4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC06962527
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 148F8C4339E;
        Tue,  6 Jun 2023 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686051021;
        bh=+GThaHVT+qaHI+cqd/x4rjJc6jDzm//8cY4CxzFrVMs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DjR57w2DwR9WcAARvuk9aItCNQDcNLUxYK+aG1inaYVmeTKhpdWXbDctklWE0dFVf
         SYf/8vyhYerC3Sk8+r9Wdpg6zqKlisF3K6UNHIiOLqrNw1ClhfY7Y4VZg1ZwagNwmw
         7Zk046y8tSxONzO9q8wvm4DhGyrUfDTwibU5YZ3hES/H3IRG+vCwkNFhzfd3L4swhd
         aMtl0H0ea55ghsRKFK/pAwCqPG61AEr/AIoaSC5rg6wGOMfO3TLdZ+gT2rrJ6vQ1KE
         h/QeEYsLGVbAlYy94v7+HpKsElJ4UHKGxPAGwGmvXOAmh1LcQ1nSaxDHyqZ70JJ+I0
         FWLRazqu/HEKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3B5FE29F3A;
        Tue,  6 Jun 2023 11:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] mac_pton: Clean up the header inclusions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168605102092.13924.10367724282967389042.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Jun 2023 11:30:20 +0000
References: <20230604132858.6650-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230604132858.6650-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  4 Jun 2023 16:28:58 +0300 you wrote:
> Since hex_to_bin() is provided by hex.h there is no need to require
> kernel.h. Replace the latter by the former and add missing export.h.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/net_utils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v1,1/1] mac_pton: Clean up the header inclusions
    https://git.kernel.org/netdev/net-next/c/8d2b2281aea9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


