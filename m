Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF56A7077A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjERBuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjERBuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E3E2D7D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E7C164C40
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91D37C4339E;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684374621;
        bh=6P3qFN0pUzsg+xFu4WJdAzDQLrByxRzOzEBQ1mm69iI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hEt+kkNHD7RrBapnZKztBgIsBPqHhgP2MomnRfGqFj3hKRc3miQkfc6rRfFdU9J26
         qdlA18xP/UH4EEAEf5DE4n2x64CDpN9gyuLBA+1zygYU90pWGkWooyQqjoUOgxMvsF
         AoskRgD8OUs6EKebgYbrqGv+Mfe2S4zjEgzJlBakfEE5Omu/qPjmdESbtd6m4MG9jw
         4Lt1szILdr6bo4JzgDqAfesBdU9YC+PblEdsMvQ3MoHKNrTeEltpNOqPtWunOzNlYq
         Gu+/LwHBpChhxuvFnPPXp4bluWjH0L77l8Y8iSkBE3A1pdp3WFhWe3jM4DBoYdwb9c
         yO9VzUiXCngLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7642CC4166F;
        Thu, 18 May 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: fix to check validity of
 i_compress_flag field
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168437462148.19511.5245634211423194029.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 01:50:21 +0000
References: <20230517034139.12879-1-chao@kernel.org>
In-Reply-To: <20230517034139.12879-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

On Wed, 17 May 2023 11:41:39 +0800 you wrote:
> The last valid compress related field is i_compress_flag, check its
> validity instead of i_log_cluster_size.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - rebase the code.
>  fs/f2fs/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: compress: fix to check validity of i_compress_flag field
    https://git.kernel.org/jaegeuk/f2fs/c/8a0dbd506b6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


