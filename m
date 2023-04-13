Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936D26E1873
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjDMXkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDMXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4252A10CC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C464E64298
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD47AC4339E;
        Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681429218;
        bh=mLppmDZWTkjo/jvIXTtESwl04zJe3TFM/Gu0KBcnsyg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kw36A7ZPnPaYaqCH1/go0ObWYcvaL0SazYqlfRkttlSN5TIUXjelC+EYXqbZ6848B
         KDoeuiDIPiIVI946fupYZPvxoLw/KSkwLZMQCjvyigxvFG8+LJsfXeQJ9CiBK3yg1u
         99XcVUSyv8/KRUewj8PnI5QMQEg9B717BglTZLem6pYpHxIjJ9rYnD7GfnPfUPpWK7
         8zTLvhIo7bLxkJsKPNVh7ZhgUbGmgrXCfMAuy/1YS9UH42P/o7t5D0B5+AV3EI1s1v
         hYOjex9/wLOtxhR0TEwmu0xqKPHYL+a6ed1n0bQUVs1ydJ6//h5ORXsriZNjY94Yyr
         l2r/X6uVTgoYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7060E4D003;
        Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check return value of
 f2fs_do_truncate_blocks()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168142921881.31957.8288025446972589519.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 23:40:18 +0000
References: <20230405144453.930311-1-chao@kernel.org>
In-Reply-To: <20230405144453.930311-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, daehojeong@google.com,
        linux-kernel@vger.kernel.org,
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  5 Apr 2023 22:44:53 +0800 you wrote:
> Otherwise, if truncation on cow_inode failed, remained data may
> pollute current transaction of atomic write.
> 
> Cc: Daeho Jeong <daehojeong@google.com>
> Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to check return value of f2fs_do_truncate_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/b851ee6ba3cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


