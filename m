Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9321270B9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjEVKUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVKUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80EDC5
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6591C61E9B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C25E7C433EF;
        Mon, 22 May 2023 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684750819;
        bh=xATejqLjLdR36XYrNaqrFRCmOlFpZ+Hjn0L2Iczb1Qo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U/O1r0Gj+/eY+Vrs0cZ5ZUIOYQC6DkvghaBk2L0YurqXFFQG45NHyi9IbXXzC10Di
         fBDoAW2na7LCnRuIjQGUMjn8UC5x/SJb85vB+o/I+7yrQA/iLRL+uJ/LxZ7kxDII+O
         LCYduQq3wnAYH3qas3oRt+ePWfOc4cj9ERCLtLgOezcIzaRK31O2AZqN3RNvdi3QIi
         NMy72jNNHOQB7ZyKv7cxZUKiO2owCRBrsPrKtSiO1wz98gtE1yXo/0L97ou58Qrkdk
         ujIMs5PB0TtCtk3tvimf8njCxu0a9oDxvLgPTb62dWrk7m3t5jvYGjFON5pNMvpr9W
         KUsMKlkwc07fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A794DC395F8;
        Mon, 22 May 2023 10:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next] net: fec: turn on XDP features
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168475081968.10880.17796761787043008652.git-patchwork-notify@kernel.org>
Date:   Mon, 22 May 2023 10:20:19 +0000
References: <20230519014825.1659331-1-wei.fang@nxp.com>
In-Reply-To: <20230519014825.1659331-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, simon.horman@corigine.com,
        lorenzo.bianconi@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-imx@nxp.com
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
by David S. Miller <davem@davemloft.net>:

On Fri, 19 May 2023 09:48:25 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The XDP features are supported since the commit 66c0e13ad236
> ("drivers: net: turn on XDP features"). Currently, the fec
> driver supports NETDEV_XDP_ACT_BASIC, NETDEV_XDP_ACT_REDIRECT
> and NETDEV_XDP_ACT_NDO_XMIT. So turn on these XDP features
> for fec driver.
> 
> [...]

Here is the summary with links:
  - [V2,net-next] net: fec: turn on XDP features
    https://git.kernel.org/netdev/net-next/c/e4ac7cc6e5a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


