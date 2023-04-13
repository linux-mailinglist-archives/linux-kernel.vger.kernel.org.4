Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC246E186C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDMXk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjDMXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583AA10DF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 996F46428D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE7FAC433EF;
        Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681429218;
        bh=V0CTI6o+YvR2IX7R2wrETiBS2lq5Y45MatYg9uYcBOs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JG8Fy8qRxJ9y7/5GPehWNCw75bSr3YKUXfWq8jZbESZ5WNz41I5czIOhDjZb3Rro7
         RXTHdaa5a4A8WVNAO+rmGpE1KJmoWdUvUhp08HjqHtji4RX1mHHT47mau7rBtqa+ho
         LFWczpYkoimbFRpW9U5Yvu90n/Xg2aiU7BvU5NDrF+wQaYBJlpB18mr7je1rB7Kqw1
         /7Wc9+hw6n27tVa9hOFAPSVEbSvANzfCsK1hAgQhCTkbK5T3wi5x6qX520L2AvqEWv
         v36CQvtILgyWbLYD8mj5C6xuM3xLcCBvs71emVZwF52zJoyk0lbCpus+jXXHlH3sI6
         VIn0/NyQ0vGCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABD42E29F3B;
        Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix passing relative address when discard
 zones
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168142921870.31957.2906267812232353546.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 23:40:18 +0000
References: <20230406221104.992322-1-daeho43@gmail.com>
In-Reply-To: <20230406221104.992322-1-daeho43@gmail.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        daehojeong@google.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  6 Apr 2023 15:11:04 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We should not pass relative address in a zone to
> __f2fs_issue_discard_zone().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix passing relative address when discard zones
    https://git.kernel.org/jaegeuk/f2fs/c/1ac3d037bee9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


