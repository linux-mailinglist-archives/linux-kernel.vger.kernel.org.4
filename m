Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38A070779C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjERBu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjERBuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A274DE7A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3056A64C39
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F714C4339B;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684374621;
        bh=M4NXrzfMePAJlv1Nw6DolPKf3y7XiO8lOTzcegyQ7es=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XorD9/84Fr0zofRSfYcEuChNLaEVSU0TSFdjlEFOq+4SEGLg6YJPZ5bXIwkGdpL9c
         7LtTscgOvu8JBOW77P0v9lmvbQw6FtrcxnfEuR0wxvwKlFts+zF64DUnT2SB1Sk6zU
         v/mLQgbss4IilNiS2ASclvUYtDqKkkZ52T9x8YUxYmGtA8HvxvOrazplRoVu4LNg36
         xs2f3qhCqKhAp0ZmhuEdMWOR+I5yZ/4JjLvzklK8zjlebJqUvKqBBd8gERC/F3OglT
         tSGdEX/n+fjYB2ajGTwS+F3tsPGKJi01tnQPV7TqjGhkeuL+BbN4KhehXLHyPGwSOp
         ObgpAWl6v2mTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E009E54228;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: renew value of F2FS_MOUNT_*
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168437462131.19511.13978967731542088264.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 01:50:21 +0000
References: <20230517094250.1407910-1-chao@kernel.org>
In-Reply-To: <20230517094250.1407910-1-chao@kernel.org>
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 17 May 2023 17:42:49 +0800 you wrote:
> Then we can just define newly introduced mount option w/ lasted
> free number rather than random free one.
> 
> Just cleanup, no logic changes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: renew value of F2FS_MOUNT_*
    https://git.kernel.org/jaegeuk/f2fs/c/c235f42fffe1
  - [f2fs-dev,2/2] f2fs: renew value of F2FS_FEATURE_*
    https://git.kernel.org/jaegeuk/f2fs/c/a4ebabf341d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


