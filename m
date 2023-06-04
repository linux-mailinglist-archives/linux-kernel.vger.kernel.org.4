Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EE97218B8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjFDQ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 12:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFDQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 12:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09599F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 09:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D45A61693
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 16:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B79ABC433EF;
        Sun,  4 Jun 2023 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685897926;
        bh=5nN02K2W4JaqvOzqHeM1LQ6Mr3+d2FfvlT3LaQF3nc8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qVsZFv/SArkF7y4/6lUWJUhgdNBkDdx1mxcFEm+64boAZ6uLpsetYU/JiUBcezikt
         ZwztTgpG5JuoBZijmzicQYmD6g96rBBS98wvktVs4S/78ebYW09M1KsNBLl4WA1MPk
         aJ35/B+qGKcPO9IW+Nv+qj1KymYqlv9o1vmDwYHmVdSWs/V3yemeUUQbWpS4rGfPxI
         GOXSa/wBSDMjfvwJKa+RC/d8A7s+1o3BBZHjILWEjFcg7IETvMx3K0WnWDd+sj1PJz
         ch7GUj1+/L3KpiwUQHhMO8NAIvwvald0l4F7MYsD0MZW8MK3yg4tRWBTl7WEKXtO9W
         hNPM7CnVJlPeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91F33E52C02;
        Sun,  4 Jun 2023 16:58:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sched: wrap tc_skip_wrapper with CONFIG_RETPOLINE
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168589792659.18651.9066532001099296041.git-patchwork-notify@kernel.org>
Date:   Sun, 04 Jun 2023 16:58:46 +0000
References: <20230602235210.91262-1-minhuadotchen@gmail.com>
In-Reply-To: <20230602235210.91262-1-minhuadotchen@gmail.com>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat,  3 Jun 2023 07:52:09 +0800 you wrote:
> This patch fixes the following sparse warning:
> 
> net/sched/sch_api.c:2305:1: sparse: warning: symbol 'tc_skip_wrapper' was not declared. Should it be static?
> 
> No functional change intended.
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: sched: wrap tc_skip_wrapper with CONFIG_RETPOLINE
    https://git.kernel.org/netdev/net/c/8cde87b007da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


