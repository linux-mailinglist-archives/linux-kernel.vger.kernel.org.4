Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9C74CE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGJHa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjGJHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAC1FE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D9B360EB3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7D0CC433CB;
        Mon, 10 Jul 2023 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688974221;
        bh=a436BPex8yFqy/L54ZKP9O/09Ee0pERO8Iq8NR3gjH0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pRzZqhd2EZL6B1PtUJV7+R9YFHLCkohbAWz4E2lB9iHmxmeU5d5JRh4sOm2xyoI/r
         YGMcY41LROhfAIxY73b9rSyGb6IdgtTkgPfqp5Flvzn2kHZWJiAnINx1zgjIu6ny7i
         /KqeZOi7STqsbudb01Q5nyZFjSZ90JSbUUkaPqqxrZ8+AUQ9ESYRRSyz52UrRHOA2K
         W2yf5hr6fvy/5m2a/wIzf9zP3xv299Hbtf5uK7v1thXnoyffhnxRlvdKQ8l2uGkE6G
         TVnpdsLbboEpWyM3cFmBSfFoZmcGFMhVHgLKPPT9zdgOfGYoegq9GFbqqG0NlhoNVM
         fUEmoEu2LTWvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF000C395F8;
        Mon, 10 Jul 2023 07:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: qca8k: Add check for skb_copy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168897422084.937.5935526114341397652.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Jul 2023 07:30:20 +0000
References: <20230710013907.43770-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230710013907.43770-1-jiasheng@iscas.ac.cn>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ansuelsmth@gmail.com,
        rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Mon, 10 Jul 2023 09:39:07 +0800 you wrote:
> Add check for the return value of skb_copy in order to avoid NULL pointer
> dereference.
> 
> Fixes: 2cd548566384 ("net: dsa: qca8k: add support for phy read/write with mgmt Ethernet")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - net: dsa: qca8k: Add check for skb_copy
    https://git.kernel.org/netdev/net/c/87355b7c3da9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


