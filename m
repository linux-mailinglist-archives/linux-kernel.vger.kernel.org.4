Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3910A72D12D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbjFLUz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjFLUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:55:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC321211F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01FD26268E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 597FBC4339C;
        Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686603022;
        bh=jS12uuQxTqxQ2t3KIocRVKhkQuA+O7CPb1iTWoSgv30=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WRI8EtoL2MPrLFpeoKJZ29wGGmG+Dh5bghhGGgqft9ChJdDYf8d5kk9VrCz/EaSRa
         0u2hJvqj8O/k9v3KkdCzOlEFMR4++9KygLsbZZ5zdC3CihGH5bkyYY1CLblIMGVAaj
         4E3FGcIxCqU6QwWdhrSM7DcQwPCryJG8H/sDuvooAwWDAqvXU03TDAzPw/SyqU1EBk
         BPTDm6YyVtOT5aJ/MKXLSwaDr6hakV/cYy1Ue7+gQbFF9ZZbAVnn44P9sbvzytRdhj
         p4axVTBTuwjd5boN//Hxu/sDGatqb9hecA8F/mHWvWo257zyLoM88Ex4LmKU1p0n4O
         NswRCoy7gGM9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32E0AE21EC5;
        Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce F2FS_QUOTA_DEFAULT_FL for cleanup
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168660302220.10168.204042134009169734.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Jun 2023 20:50:22 +0000
References: <20230606061822.1179551-1-chao@kernel.org>
In-Reply-To: <20230606061822.1179551-1-chao@kernel.org>
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

On Tue,  6 Jun 2023 14:18:22 +0800 you wrote:
> This patch adds F2FS_QUOTA_DEFAULT_FL to include two default flags:
> F2FS_NOATIME_FL and F2FS_IMMUTABLE_FL, and use it to clean up codes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h  | 2 ++
>  fs/f2fs/super.c | 6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: introduce F2FS_QUOTA_DEFAULT_FL for cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/4138d5a9121b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


