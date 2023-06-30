Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDECD744551
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjF3Xkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjF3Xk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93E62D50
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4606861838
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94705C433CB;
        Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688168423;
        bh=W0fQjv0ep+Qe26cn8QnkVVT2df49/M4iytcJ2vTwNJU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mzkw6nJ+d4pb2/B1TPMpQ6h4tzqE7rbdjUM8YmEMOCnT01IeUxM4Hzk4mHAazSVGF
         cDKMjj3DMu2lQKK+D2VOQt/quQidghPReFENu3uCnym7rzvE1Iaf/6aSwLbMvjjIsv
         DZ56aHE7KwZ+UFHgSvkRcReVomyqN60vPoJcUNIAgKLUSwWNEZSF+cckY85vzdJKJN
         yIMYAEFWK341koYhVON+sG5eHw2xXqd4KB3LV8xLOnbCGxxjupiW1khvAXfUV456pm
         LR+d6XSTP28wDd9FOWquCxf3RNIL5MG5lUn+zTRoZPdz6CWmKomdx7kSahLug/rCcj
         z/UEHbDpu7p9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61669C395D8;
        Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error path handling in truncate_dnode()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168816842339.31915.12136963256323192911.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Jun 2023 23:40:23 +0000
References: <20230629014102.3057853-1-chao@kernel.org>
In-Reply-To: <20230629014102.3057853-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, 29 Jun 2023 09:41:02 +0800 you wrote:
> If truncate_node() fails in truncate_dnode(), it missed to call
> f2fs_put_page(), fix it.
> 
> Fixes: 7735730d39d7 ("f2fs: fix to propagate error from __get_meta_page()")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/node.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix error path handling in truncate_dnode()
    https://git.kernel.org/jaegeuk/f2fs/c/0135c482fa97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


