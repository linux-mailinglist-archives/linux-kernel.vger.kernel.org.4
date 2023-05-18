Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4237077A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjERBuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjERBuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38F102
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB2E364C51
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B11B9C433AF;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684374621;
        bh=38bOYjNs1Ei5s3rnORJ5Nb8u0FgNezxRrYWUA2SytAU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Q1gogNMXzC873yWXitUSskmlkpMHUqrU/so15BeMInd63O95Z0PiQIDfc/lgwKtTv
         gVQ6yF2uolqfyJNpi2V7prfOB0aY4S3tclkU6T022njCExi8BNh6eOCDQr+Drw9El8
         b5tTfGVnZbj+WcQz+nyrZuxmb8Rzt7BzIDWtAgERR47rdL683Q67i6WPm4y+DhjSiT
         oydUe7rv37Kk0vNjrPrysEIAqxHaurhb9h4BX4u7m0jm9+X9R9IY4q/lGwLJlsjrqR
         8cFXhYDKGF6HKoBDAYeMd2HLdwp7VAsB5cIz6lXb6TNRjl3TIh2aHIp4mSd+ObbWij
         IHDi/2STeNaqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93F5CE5421C;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: Fix over-estimating free section during
 FG GC
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168437462160.19511.13019487085074367761.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 01:50:21 +0000
References: <20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5>
In-Reply-To: <20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5>
To:     Yonggil Song <yonggil.song@samsung.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, sukka.kim@samsung.com,
        beomsu7.kim@samsung.com
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 12 May 2023 13:16:10 +0900 you wrote:
> There was a bug that finishing FG GC unconditionally because free sections
> are over-estimated after checkpoint in FG GC.
> This patch initializes sec_freed by every checkpoint in FG GC.
> 
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> ---
>  fs/f2fs/gc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v1] f2fs: Fix over-estimating free section during FG GC
    https://git.kernel.org/jaegeuk/f2fs/c/62c85994b958

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


