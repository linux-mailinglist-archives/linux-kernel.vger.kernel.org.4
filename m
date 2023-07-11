Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE6574EC23
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGKLA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjGKLAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D545E49
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B7C761482
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA507C433C7;
        Tue, 11 Jul 2023 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689073220;
        bh=6YYe+AM3PENlhMrs43LHH3XDqNI7URfdzWV63NIQAFc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eEWrEcHNb0dRGg5s4NUuQjPGRKN4i/ciaEA2TkEHO+xtm5M4382qGBEmsQg6gEgsl
         x1ng2O7qlqqnzE80GXtOyhdxUyIZyorTIEYZfkwkwwg5qHH2tD4QC8H7E4m+QAlX98
         ondbqZTI5jXfdsaVinjT+hbBVZZPgXIKkcNRnpAga/BUSlI5pU90Kv06HSoj6J/xEm
         Ii/JJfdxPazYL3yyO2MzlDsbu1Q99/sC4ulTp7jlO6Ky3PotEBgjVu3hq+EbcGByXE
         mkNY2rnX3hEarQav+ajs17HIk8OPVkjltPCQr5ay3qDBV1bMLit9vGkCJG5rknkyWq
         SR/Cv8xPXEBHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7106C4167B;
        Tue, 11 Jul 2023 11:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next][resend v1 1/2] net/core: Make use of assign_bit()
 API
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168907322073.9631.16368266166641321480.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Jul 2023 11:00:20 +0000
References: <20230710100830.89936-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230710100830.89936-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, brauner@kernel.org
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

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Jul 2023 13:08:29 +0300 you wrote:
> We have for some time the assign_bit() API to replace open coded
> 
> 	if (foo)
> 		set_bit(n, bar);
> 	else
> 		clear_bit(n, bar);
> 
> [...]

Here is the summary with links:
  - [net-next,resend,v1,1/2] net/core: Make use of assign_bit() API
    https://git.kernel.org/netdev/net-next/c/274c4a6d529c
  - [net-next,resend,v1,2/2] netlink: Make use of __assign_bit() API
    https://git.kernel.org/netdev/net-next/c/b8e39b38487e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


