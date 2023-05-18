Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB417077A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjERBuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjERBuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60292D7B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 439CB64C3C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88C84C4339C;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684374621;
        bh=PFLd06VLQ2WY4f0od9Bw+0zPyizf71LbrjLVpikaTxU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Oi7OaKnixLsqk6cPpAvFNChdY9ez48wdye36EGfL/1CPlQWvZWC/DBS9A0gOnggLx
         OwL/6Z7KWlStThqe45n15z7Xj63GzKtgZzn+VG3mYAIvQaNxj5W2dNJrRPLz4CQhwK
         jpdNKEMLapcRG55difbO9dUpxfJbU/RfIMk+883gBB/xDfcfHaL9mxe6ckVSxpXH28
         QweyPv1phRCeapRY51ldw0fyCi7JLXr35uDl5NBPazCtJCwuwTnX/i62+jfJNkxAAo
         LI06zZgJG8WS1fYN/3BP1n1B4doMhmL6+EyKke/+DSzKnDPi6afm21iFl3GC6A4Jjo
         yBET1x1RpzNhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D584C59A4C;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add sanity compress level check for
 compressed file
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168437462144.19511.3082830529196956881.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 01:50:21 +0000
References: <20230407183148.23231-1-frank.li@vivo.com>
In-Reply-To: <20230407183148.23231-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, terrelln@fb.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
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

On Sat,  8 Apr 2023 02:31:47 +0800 you wrote:
> Commit 3fde13f817e2 ("f2fs: compress: support compress level")
> forgot to do basic compress level check, let's add it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/inode.c | 106 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 77 insertions(+), 29 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: add sanity compress level check for compressed file
    https://git.kernel.org/jaegeuk/f2fs/c/8328548780c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


