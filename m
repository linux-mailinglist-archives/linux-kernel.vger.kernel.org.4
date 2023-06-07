Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA772675F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjFGRaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFGRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F9D2110
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03D1A64208
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CFDAC4339C;
        Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159025;
        bh=zE2IShqugBtrR3++gA9RJ6k/KdgXrKYy2Y73L97WYt8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lmWWZ0AsdDibxt7VYxODpXfI87U1SK9ss1XQzpQ7+xMcj5uZ7uoYRyjcg6lNCK4wG
         qwsIgkWeHVW7v+C3CGH4eCZS6jYTFaa/AbF/C5dMTEs2WXryr5I3JT+1fUqlMsXAxT
         EK4L490mLGBHvFS9oCnVoCqyCH4lv+/nKu54bbC5EFe8rjWAaHNNG8WhEjn/a0pL0N
         GFIR906MK7H5Xihn04o29SjDG93FVgl6NDiuMI/E7uETzuqZ750lTdNG5yerSbhbks
         kTAy44M5Fo/2hcQc8/ra8MpfCtRe6aAbvudRryRrErcOcUApmLoafUsWyF4VlsJGfw
         T/W0afM9tHlKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3910AE29F39;
        Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to drop all dirty meta/node pages
 during umount()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168615902522.7521.11156422070450767318.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 17:30:25 +0000
References: <20230528074713.1682062-1-chao@kernel.org>
In-Reply-To: <20230528074713.1682062-1-chao@kernel.org>
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 28 May 2023 15:47:12 +0800 you wrote:
> For cp error case, there will be dirty meta/node pages remained after
> f2fs_write_checkpoint() in f2fs_put_super(), drop them explicitly, and
> do sanity check on reference count of dirty pages and inflight IOs.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/super.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to drop all dirty meta/node pages during umount()
    https://git.kernel.org/jaegeuk/f2fs/c/50cfdbd772cf
  - [f2fs-dev,2/2] f2fs: avoid dead loop in f2fs_issue_checkpoint()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


