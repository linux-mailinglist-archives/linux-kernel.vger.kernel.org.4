Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55AA6CA9CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjC0QAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjC0QAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:00:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00BF3A82
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DB771CE179C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 184B5C4339E;
        Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932820;
        bh=3jeLI4LTsYCp3kwhcKY9IHXINDekO/ssj9j+z4zwTcM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AOFGrERiZ5++Mmzzv1/b7Xrf8RFXCR6ji+7TXxR1hCG1tgVEbhTJ2PjnZyasg8R/T
         iNj9N7e5W61tE5wUPuoesNCa2QkBWpN9DA1kpdGNeR2MTFjbmNs0zgNGxD6GmXsac8
         g5jPWNbxAQCrkYHdMYVHjQT5XJJQRz3sSEhY4SjZNbRi0nCzoTUU5qGAtp+hXEos6T
         jW2neyw9s/9OndPyCLHTnPBmCQ/Ur+blSqT4gtUujlUsmysf7Hz93rcJfCVLs1l7OP
         suZccaQGIp1PJbebSVtmv76pim2KRp3IEzuf94HFepFJGwCs4iRDhG3KTBhLcniMYw
         jt+c48TiZdsag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3951E4F0D0;
        Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: apply zone capacity to all zone type
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167993281992.32120.15689550099953516838.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Mar 2023 16:00:19 +0000
References: <20230321231157.963598-1-jaegeuk@kernel.org>
In-Reply-To: <20230321231157.963598-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 21 Mar 2023 16:11:57 -0700 you wrote:
> If we manage the zone capacity per zone type, it'll break the GC assumption.
> And, the current logic complains valid block count mismatch.
> Let's apply zone capacity to all zone type, if specified.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 65 +++--------------------------------------------
>  fs/f2fs/segment.h |  3 +++
>  2 files changed, 7 insertions(+), 61 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: apply zone capacity to all zone type
    https://git.kernel.org/jaegeuk/f2fs/c/0b7d8adb1ba1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


