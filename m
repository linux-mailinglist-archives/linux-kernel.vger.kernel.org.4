Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7E683620
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjAaTKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjAaTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:10:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E008B4B1B0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:10:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DB5CB81E6D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 476A7C4339B;
        Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675192220;
        bh=T5Q9H5prmUYFArKJ1FQOqQBqKy6FlsRc85z+zs30y7k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TH5mg2qUL915nqiJUlWFbRHI4zuQwAlCsXCT0Dgtuj50R3BTR74KgmiA+uArJ7L+7
         dG9i35UnGLjPW7MNCcz7woJaFio+D1AZQhqG+50rMVKQJidt32tr4vlBC0paaShQaV
         /xQu0OxZGvhshIaGxipJ2aA3GigBVufxNwN/iW2YTGkBHJOX3P/kJE8DYygmAQqZFw
         PgF+RZzmUCug0sEXRcNU6r8a1VFIC1TpaDoCuJqIm1m21SUCotqGWMGGpi311PjNNT
         3I0leHI9ZqFRJoerHKg6DWAdzH2FrrLLhdaNmWWhUiP9TQ4CYQCXRlF718CBCCcX9A
         iyE7vDs9TfQug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C5BDE4D014;
        Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: introduce
 trace_f2fs_replace_atomic_write_block
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167519222004.20142.6380905471543710449.git-patchwork-notify@kernel.org>
Date:   Tue, 31 Jan 2023 19:10:20 +0000
References: <20230109034453.490176-1-chao@kernel.org>
In-Reply-To: <20230109034453.490176-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  9 Jan 2023 11:44:49 +0800 you wrote:
> Commit 3db1de0e582c ("f2fs: change the current atomic write way")
> removed old tracepoints, but it missed to add new one, this patch
> fixes to introduce trace_f2fs_replace_atomic_write_block to trace
> atomic_write commit flow.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/5] f2fs: introduce trace_f2fs_replace_atomic_write_block
    (no matching commit)
  - [f2fs-dev,2/5] f2fs: clear atomic_write_task in f2fs_abort_atomic_write()
    (no matching commit)
  - [f2fs-dev,3/5] f2fs: fix to abort atomic write only during do_exist()
    https://git.kernel.org/jaegeuk/f2fs/c/ae267fc1cfe9
  - [f2fs-dev,4/5] f2fs: fix to avoid race condition of f2fs_abort_atomic_write()
    (no matching commit)
  - [f2fs-dev,5/5] f2fs: fix to avoid race condition of atomic write
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


