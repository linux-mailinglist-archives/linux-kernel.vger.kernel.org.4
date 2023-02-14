Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC22696C79
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjBNSKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjBNSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:10:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410DC2E0C4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:10:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E430AB81E32
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83646C4339B;
        Tue, 14 Feb 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676398228;
        bh=jkvp/0FdVuBITSbyQQFdytDTZtIkYXrWLGZGWL78WS0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AQ6rLaaiTAuk+GLEKa/5pxc/Q8WlxYlti1/1ehgzRZh8q7FolxNi0AToP4lJ7wrHW
         3+mz+UcVqwlloTztbVIdSivS0/9ZuA1djIcQVUJKashQLuFPO7BltsP4Drp8NxnJr2
         k6gAcmMkKyRXZVnianN7e/NjvFSTRkWoQvrnEvizpDbuzGgpmtO72f9J4LexHc8s9f
         Cb/ldJ1aoMJZxV/zOD+gJCj5hHrHBPBCRrVKAoBC8SmqU2oARSFKKWB1S0NHi+srjA
         R+8mOk4GxMNworc0MQi0whrrM65fTp0MvV0S7/o8SbPuE8lduGCKHwRsBEzNlS4TDW
         6C1aTRZxTdKlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 631D8C41672;
        Tue, 14 Feb 2023 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: export ipu policy in debugfs
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167639822840.3874.759826899218773944.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Feb 2023 18:10:28 +0000
References: <20230213141825.22858-1-frank.li@vivo.com>
In-Reply-To: <20230213141825.22858-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 13 Feb 2023 22:18:24 +0800 you wrote:
> Export ipu_policy as a string in debugfs for better readability and
> it can help us better understand some strategies of the file system.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> - remove unnecessary '\n'
>  fs/f2fs/debug.c   | 24 ++++++++++++++++++++++++
>  fs/f2fs/segment.h |  1 +
>  2 files changed, 25 insertions(+)

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: export ipu policy in debugfs
    https://git.kernel.org/jaegeuk/f2fs/c/f2e357893cb7
  - [f2fs-dev,v3,2/2] f2fs: replace si->sbi w/ sbi in stat_show()
    https://git.kernel.org/jaegeuk/f2fs/c/dda7d77bcd42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


