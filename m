Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB570779B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjERBuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjERBuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1F2102
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1040D64A1C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7717AC433D2;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684374621;
        bh=IfEqFTkpASofzO7ndZbO1NCaS7B5DFxc2BiF3SYjWLc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Dvb6W7aLIgL3+yq5/7ZQTfFNmQufoOmPx3/pitPdCb6u7Xh7/GK7N+4LOk/GOQITn
         nT7MTiES59w3AoFYrfSM+O0MkQ0hav5H+4S5lgZaCMHqTf3MxjKzbd6tQJTvwLqaLF
         mCjzrZ04B+IVmBlMP3ZmtJKPx5DT/81HX8oxt4YzHzeJA48LGhCWi9o+hNPD7MFQu3
         p3faPq0CBtqZRV3oa3SEZmiUo7ro8nZ7u6rrdfMF7oF8VQjrOruYFf0pXs2IspRGVS
         S+yMeSBrORecO9vbRJOpHlB7FDckLpClwJQEngHFA9fM8QjxHDXZPaOsRvrjrlxcjw
         qPcF6XbE1j9wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57FFCE5421C;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: close unused open zones while mounting
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168437462135.19511.5914214442392156234.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 01:50:21 +0000
References: <20230505204000.3604748-1-daeho43@gmail.com>
In-Reply-To: <20230505204000.3604748-1-daeho43@gmail.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        daehojeong@google.com
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

On Fri,  5 May 2023 13:40:00 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Zoned UFS allows only 6 open zones at the same time, so we need to take
> care of the count of open zones while mounting.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: close unused open zones while mounting
    https://git.kernel.org/jaegeuk/f2fs/c/0539a460e037

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


