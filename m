Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6240C74FDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGLDaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGLDaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA707E5F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76003616CC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C52BEC433D9;
        Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689132623;
        bh=A+gRtdAZ8mcZuB+d+24Fu1Ezj/v+F1WcLq9RyyvBDwo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LV1Ge056ckaYBdltXFZRoV0e2ZF1/AlfYgYrgxMXQMZzkhJ9b3Yhe99+v7fttKqSM
         Vc6rqo0JL7zOaTad5u42O/SkZBiu3u3QZO67bvWSCXjp/eZCHf02MqYPuFfY23zyFR
         Ft73qCkSJGQusyNKXGyq8b5vye53J3vwJ0oWJu/2f7Jmbz58bcyVby5YVqrKoDnS5z
         x8Kv6N+JKllpSmIspjL/vWg+VrHpQMMHlmdZHKPTaXww9qkBVfcHanXvqu1kL7Ro01
         Jp2t6ATOWog91p8x5bFyCfNxgKVG7boVifXvGiRwLQssLPV49vi219tFclBchs9RSY
         cWEJuIGbMpE2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6455E49BBF;
        Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next] bnxt_en: use dev_consume_skb_any() in
 bnxt_tx_int
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168913262367.27250.294062569408176677.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 03:30:23 +0000
References: <20230710094747.943782-1-imagedong@tencent.com>
In-Reply-To: <20230710094747.943782-1-imagedong@tencent.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     michael.chan@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        imagedong@tencent.com
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

On Mon, 10 Jul 2023 17:47:47 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
> to clear the unnecessary noise of "kfree_skb" event.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
    https://git.kernel.org/netdev/net-next/c/47b7acfb016b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


