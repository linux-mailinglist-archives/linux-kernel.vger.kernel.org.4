Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B1681F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjA3XEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjA3XD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:03:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D166530B09
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:02:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84DA0612EC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF809C4339B;
        Mon, 30 Jan 2023 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675119617;
        bh=8wG5NIsuKshWhb2XiCI9lAfT/vlNO8ZyFCtUknM3ANs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XzZUsRun1zvbD5R8j+IpZ8toL9en35Dt9IKNfR2Y7YJlT7n3yX/Aq0b5jjeNrdwLx
         jdReH5IJkI53OueNqokmBuWJtk0BIBcbMoDRaT392BmbTMDJQ7S/YZboVAxYqrlaXF
         0Coh2OZ/VrvCTijcH7ESr54u5+eijNteWokgV23L0dKiKNyp2wCq0Wcd9Q5lHtlxnw
         vbA8FgO4MJQgNY+u8Sy03eSaqmmjfHjIRu4UjsIdAt9glqbcLJsxpnHdmPTzfi4lkE
         D1J8ili7HsxUydzF7d9uolw1Lzm4H+/IQlrULkxWQHDOZ9KuzAl7uHMmmw79WKgE3B
         7eIgr9Twh5KOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5423E4D014;
        Mon, 30 Jan 2023 23:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: introduce
 trace_f2fs_replace_atomic_write_block
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167511961780.12751.1698186738415312806.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 23:00:17 +0000
References: <20230109034453.490176-1-chao@kernel.org>
In-Reply-To: <20230109034453.490176-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
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
    https://git.kernel.org/jaegeuk/f2fs/c/2f3a9ae990a7
  - [f2fs-dev,2/5] f2fs: clear atomic_write_task in f2fs_abort_atomic_write()
    https://git.kernel.org/jaegeuk/f2fs/c/0e8d040bfa4c
  - [f2fs-dev,3/5] f2fs: fix to abort atomic write only during do_exist()
    (no matching commit)
  - [f2fs-dev,4/5] f2fs: fix to avoid race condition of f2fs_abort_atomic_write()
    https://git.kernel.org/jaegeuk/f2fs/c/f4c49874a80b
  - [f2fs-dev,5/5] f2fs: fix to avoid race condition of atomic write
    https://git.kernel.org/jaegeuk/f2fs/c/f571253668a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


