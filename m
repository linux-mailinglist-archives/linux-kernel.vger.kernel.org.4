Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7720674CE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGJHae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjGJHaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF4BFF;
        Mon, 10 Jul 2023 00:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89F9A60EB2;
        Mon, 10 Jul 2023 07:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFC2DC433C8;
        Mon, 10 Jul 2023 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688974220;
        bh=k8S+XQdm0KzUrGBLne+9DyHVRuTDstYpbvtQ0noJ590=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RKyFsBIj/7Wo3/nXOaNhvtnz3KiiyUJDWv/oy5w/m/5FVe7j7OwYg9nvcxkjTEnIJ
         9JGFcGdsNvTQoD6GSs26xmpxykczewA5VYvOlphazo6qFNOnwuTukJSLVvT9qrMz1I
         o5YOwHTPTyFydfwH9AY/Y80+YttkyQE1nikCb1FOHkeiCXAzrvmU/rfdwUpWQIn6Hj
         FqE4tvevhSMewqxO8fhqkAvAE02gfssF3SZkSXb5hVtrDXMecqTIcALVziQfXiJ1WF
         KFLPx1UcyLdFaBvryF1DpUrJV1lIBHBbqwOceonPPMAwVaL7yTm/EdX8POR5nWe4cC
         dfs85IdWFVK9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6462C73FEA;
        Mon, 10 Jul 2023 07:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sched: Replace strlcpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168897422080.937.17969927233857784911.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Jul 2023 07:30:20 +0000
References: <20230710030711.812898-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230710030711.812898-1-azeemshaikh38@gmail.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
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

On Mon, 10 Jul 2023 03:07:11 +0000 you wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Here is the summary with links:
  - net: sched: Replace strlcpy with strscpy
    https://git.kernel.org/netdev/net/c/989b52cdc849

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


