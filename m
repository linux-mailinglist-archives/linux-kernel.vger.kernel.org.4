Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70270D142
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjEWCad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjEWCa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468AB186;
        Mon, 22 May 2023 19:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C263F62DF6;
        Tue, 23 May 2023 02:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F6E4C4339B;
        Tue, 23 May 2023 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684809019;
        bh=mOgu4frtqhI9N4mfSs5wP3YED0cc9Wfb878RmgNMcYg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gLgKIiN+VcizpntoNUUhH3yKv6jVNzYxnvXcRyhXqEiiwo1DaZcNa3taEuO3+0lt6
         1nmqTj/SOcmuGJ3xsbcu+UAy0mFrcW9TmuJodj4cgD4WfvGIO6GZlhEJgxz1vsP5Ir
         Dd19ymE03d3a5LamXMv5MJgfv3aHlJgdNMNiXGB1lfNtFxL4+qjkHcoMjmKz4nlIWl
         yjrwZPLq7Vc3rxnxveEeJUr7V1kjyxdK4syFusvNglxJOwuEVTPecypygZCY7aowkX
         DRskeWIy0/KBcx7XZaoTa6Y2nwOgyl9E+3jmcTw0gwXtz2nVfcjA+EDfzrZeMwyeOM
         mLDVWasb9RDmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7CF0E22AEC;
        Tue, 23 May 2023 02:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] forcedeth: Fix an error handling path in nv_probe()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168480901894.21333.17606928497234759231.git-patchwork-notify@kernel.org>
Date:   Tue, 23 May 2023 02:30:18 +0000
References: <355e9a7d351b32ad897251b6f81b5886fcdc6766.1684571393.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <355e9a7d351b32ad897251b6f81b5886fcdc6766.1684571393.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rain.1986.08.12@gmail.com, zyjzyj2000@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aabdulla@nvidia.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 May 2023 10:30:17 +0200 you wrote:
> If an error occures after calling nv_mgmt_acquire_sema(), it should be
> undone with a corresponding nv_mgmt_release_sema() call.
> 
> Add it in the error handling path of the probe as already done in the
> remove function.
> 
> Fixes: cac1c52c3621 ("forcedeth: mgmt unit interface")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - [net] forcedeth: Fix an error handling path in nv_probe()
    https://git.kernel.org/netdev/net/c/5b17a4971d3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


