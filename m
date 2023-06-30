Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A5D744552
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjF3Xkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjF3Xk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3487297C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F82661835
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91B75C433C9;
        Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688168423;
        bh=UmejxkXIML2SmVsndrL54sLN4+SWqQuPNnFV/KUaB6o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R/ng6125sVXVQLA3NmLTUpjyqJyZolsiY5eQVI5/in53F6U5f6m1XxTAf29tOJSiR
         A9puuBQ2CXSvDvq+c/7nd7Nwsk0Zx2Zq0kQKlNVc1eeOHnb+7kF2c00LgoU4skbctj
         uI1m+3AePHvGBDE/c70EIob2WFLtN1TXLc9trVwiuXpeQlr6qwK4i5NbpD/fPH63l7
         ncwKnaINd5rOx70V1fK6+Bi5XP1ZF3QBhH3Tjg/JREwrg/6Me2uWYVQlAdbwLLOnr5
         7Ej2e37GCjSjNdYQWokTr2/q2tMfJXQfnxVTNA3MITD/3ld2Fps7zlIKtETmwYphwT
         W/Al5VNca742g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B06CC691F0;
        Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH RFC] f2fs: only set release for file that has
 compressed data
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168816842343.31915.10115139157095674.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Jun 2023 23:40:23 +0000
References: <20230627122153.1557656-1-shengyong@oppo.com>
In-Reply-To: <20230627122153.1557656-1-shengyong@oppo.com>
To:     Sheng Yong <shengyong@oppo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 27 Jun 2023 20:21:53 +0800 you wrote:
> If a file is not comprssed yet or does not have compressed data,
> for example, its data has a very low compression ratio, do not
> set FI_COMPRESS_RELEASED flag.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
>  fs/f2fs/file.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev,RFC] f2fs: only set release for file that has compressed data
    https://git.kernel.org/jaegeuk/f2fs/c/87a91a155902

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


