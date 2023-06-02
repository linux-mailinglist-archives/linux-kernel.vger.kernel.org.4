Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03FD71F974
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjFBEuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjFBEuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4486A107
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC9F764C1C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D416C4339B;
        Fri,  2 Jun 2023 04:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685681420;
        bh=rKUrvROCJrrMmfkN3sXGykdMoT4O9rrI9krcIvWypeA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KUuqS6WxiaBJuPxnHkHFhLKG1tzwLqI+Pb/vECSheeLf/vV/ppOWOX4XEnG9lkRD4
         YddakJdZt866NP19NdK4pJBq2dxWej76At3kBExWHIa0us7AFEFSGXvqCURN25l7cM
         pBH6mIwnygkKPNB+T1iS1MxmG9YQWjw0fjLPI51dx3xC9dLZufSqChWvA2YmfzPcJ8
         Mc4LncLJYzMahpeLaPFwzguAg3lBmYhPTeNQy0ScWfZsL3YTadeaWgMoc00NSJruja
         NyDQb1RCVQthf61LK7alTpk2DDOdz3bHJmMhgUVpzebmx9jrwGdrDW3Yat2ew40Yui
         ykm5gpeB7Zheg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0CD3E49FA9;
        Fri,  2 Jun 2023 04:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] neighbour: fix unaligned access to pneigh_entry
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168568141998.21492.1839866290257514531.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 04:50:19 +0000
References: <20230601015432.159066-1-dqfext@gmail.com>
In-Reply-To: <20230601015432.159066-1-dqfext@gmail.com>
To:     Qingfang DENG <dqfext@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, yoshfuji@linux-ipv6.org, nakam@linux-ipv6.org,
        vnuorval@tcs.hut.fi, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, qingfang.deng@siflower.com.cn
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Jun 2023 09:54:32 +0800 you wrote:
> From: Qingfang DENG <qingfang.deng@siflower.com.cn>
> 
> After the blamed commit, the member key is longer 4-byte aligned. On
> platforms that do not support unaligned access, e.g., MIPS32R2 with
> unaligned_action set to 1, this will trigger a crash when accessing
> an IPv6 pneigh_entry, as the key is cast to an in6_addr pointer.
> 
> [...]

Here is the summary with links:
  - [net,v2] neighbour: fix unaligned access to pneigh_entry
    https://git.kernel.org/netdev/net/c/ed779fe4c9b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


