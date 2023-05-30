Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87747171E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjE3Xks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjE3Xkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B5113
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06CC63311
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4622AC4339C;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685490024;
        bh=+sbfkCGq8BzDi8rChbGwTkXONATdk9LCRY+eodRnV0w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g1JrjJCqORaffZCMuSSK4lselvoVdajwPAeQiPwwg56+GkiItHICjCU0Y5Eq1LslX
         2v47elE9rVKBAOxt1z23IY8iSClg2jh/2hwIksqcjFvP2DzBxlbtewEfdW4kf2o5k8
         WHvZN5tuE+QN7GqdCE16Putyv9cl0P6rsb0R2lh2wwLC9+6SWjmyHg48wJZbHPeI8y
         AdOsV+XXRfQ3d8nS4iK8Ypnc6FsZk6ElH8eLiWMbipwLV+HayNI6QJbNCwSXDrKDmI
         GutIS2X5TOcog1gA50jJ8+cE1juQKiatFdJb8LGgtSTe7S+ee1iKVSOA1yPaow3Xw1
         flYMIpVZQT4JA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EBBBE21ECC;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up w/ sbi->log_sectors_per_block
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168549002411.8773.18270821240993946589.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 23:40:24 +0000
References: <20230523123521.67656-1-chao@kernel.org>
In-Reply-To: <20230523123521.67656-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 23 May 2023 20:35:21 +0800 you wrote:
> Use sbi->log_sectors_per_block to clean up below calculated one:
> 
> unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/segment.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up w/ sbi->log_sectors_per_block
    https://git.kernel.org/jaegeuk/f2fs/c/584212446615

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


