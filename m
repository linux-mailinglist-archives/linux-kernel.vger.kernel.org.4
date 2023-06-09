Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2EC72973A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbjFIKnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbjFIKmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F34211C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6DFC656BA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18FBFC4339B;
        Fri,  9 Jun 2023 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686307221;
        bh=bmK7GKeO4yAe5dnQNCi7jMw6V0mfDeaNUKDOcDc3dxY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qU1V8FRqnOYgyaieKTIipkBuLAJHN9paGU5VZbJhSDuzOqoaLM4Ij0S2RpxJj7/7f
         VIuMWFDHDDE4N9kEIit+ckAmRyhdnFyXd3u9M4Az4R8n0FknG4eqefoKsGB+aw6d5W
         PuK2wUlbS/Fnib0oRs/L+jm6eL5rrCs3KHl/W77DhYYniTW3gCpPyhj5jbhK27PaOg
         yHtscMdqnhSmwzi8bvzgAzzfk+nPa3a3ddNpdlFJJrlQbwae8Cso5YjtkHZL+Cb7vo
         puy6t1qiK29rMJLVBziiNdTEisS7/C25puZL0Q+vTKkKA2G7hL3LXMySzfnVP0X0UN
         H4fwht625m1jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7AD8C395EC;
        Fri,  9 Jun 2023 10:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] tools: ynl: Remove duplicated include in
 handshake-user.c
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168630722093.15877.581453069789899655.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Jun 2023 10:40:20 +0000
References: <20230608083148.5514-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230608083148.5514-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, abaci@linux.alibaba.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  8 Jun 2023 16:31:48 +0800 you wrote:
> ./tools/net/ynl/generated/handshake-user.c: stdlib.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5464
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  tools/net/ynl/generated/handshake-user.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [-next] tools: ynl: Remove duplicated include in handshake-user.c
    https://git.kernel.org/netdev/net-next/c/e7c5433c5aaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


