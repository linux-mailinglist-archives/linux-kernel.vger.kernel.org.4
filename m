Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5634D739703
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFVFul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjFVFub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB6D10F0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 399E661774
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A483C433C0;
        Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687413029;
        bh=ZJBDTdxoCUFzklQsIykbgqj0gcKDQuMJw2gc275O1rA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=If+9svqpC5kpJXtOXBDcnXn9UKBF1ZFz162Yu0YMVLkXKe9H7ydacHbNYGo5N2ijT
         jPSZlMhAhvqN5xrJ0xEfC4A6NkJcuZaJjAS36bY5iU5B3/qT+U59p5TBY0cuYnwOPG
         u+MwD0nvOJFxgSbJ5WXa0yfGjRcnJX1lp1pd3Ru2XCk2oIX14AWH+7sdtI3ghxQLoe
         Vw777uNdiOpMD6i5ntVG9VtSTJjX6gHppcV9P6Ma92IZZ0GdpcpaUCzUvMizIlrNFI
         s9V24Vrb8Meez6b20tS2syLvBIWu/ltSxnlykqNkdQyLhTkmsVz61zAEL8e6kAuzKm
         yika2o/f0+F3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E2D5E4D027;
        Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] inet: Cleanup on charging memory for newly
 accepted sockets
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168741302944.1197.12962837950149301693.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 05:50:29 +0000
References: <20230620092712.16217-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230620092712.16217-1-wuyun.abel@bytedance.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 17:27:11 +0800 you wrote:
> If there is no net-memcg associated with the sock, don't bother
> calculating its memory usage for charge.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  net/ipv4/inet_connection_sock.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net-next,v2] inet: Cleanup on charging memory for newly accepted sockets
    https://git.kernel.org/netdev/net-next/c/53bf91641ae1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


