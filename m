Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5972412F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjFFLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbjFFLkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:40:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1D5171A;
        Tue,  6 Jun 2023 04:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C936763122;
        Tue,  6 Jun 2023 11:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33BA7C4339B;
        Tue,  6 Jun 2023 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686051620;
        bh=F96W65/kp0pYuxxub3VzJI+MDAnRLbTnnznxvpKHbnQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IEaSL9UXuY+op75LnSh73czdwfJgcmNpzWjRo4mwvEQ8QZi53N4sYyQRTi1Ifih7R
         58dtQnjfS9jKjOvvl61yclRbQDz78AEKRlVXI7jODvYzPAHvV0wyUp5jdy3tTn/jHX
         rnKYXgFbny/uY+jev89RaLvEy/nlfEyaaNq+I9eD9MQNYwyWccTZfxa9zf8IlA2Go8
         qTact6BV/DNFJlpwSuPkkTa2EJxCzVz0ez+f10KssV9Bq6lgSE+BoLQUNzNGRkl5Sg
         fIy2wo78bgxS5XfQnjHFtFgHdCrnuvd+8sFNrV27hP2/76W8H3BYDe5gBvh5sB51Ku
         I0E4qRvHAF+LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15F68C4166F;
        Tue,  6 Jun 2023 11:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/pppoe: fix a typo for the PPPOE_HASH_BITS_1 definition
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168605162008.20364.14177645531084252768.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Jun 2023 11:40:20 +0000
References: <20230605072743.11247-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230605072743.11247-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     jaco@uls.co.za, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon,  5 Jun 2023 09:27:43 +0200 you wrote:
> Instead of its intention to define PPPOE_HASH_BITS_1, commit 96ba44c637b0
> ("net/pppoe: make number of hash bits configurable") actually defined
> config PPPOE_HASH_BITS_2 twice in the ppp's Kconfig file due to a quick
> typo with the numbers.
> 
> Fix the typo and define PPPOE_HASH_BITS_1.
> 
> [...]

Here is the summary with links:
  - net/pppoe: fix a typo for the PPPOE_HASH_BITS_1 definition
    https://git.kernel.org/netdev/net-next/c/ae91f7e436f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


