Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D0663452
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjAIWvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjAIWvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:51:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0114007
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:51:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B5BD6146B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93548C4339C;
        Mon,  9 Jan 2023 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673304674;
        bh=h+iiKLAD2ZwZBw70kcUmUatKrdf5NqD82EAD0hWiZDU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AjyM8QoRiCKmERTPbHCu2uHJVOaGCzb5QdeuK9wryHRj6f1sj6lmWgi/0Wh6AThgs
         bhbtVwRC4J74y8Et1PSLB3jPhkzY47kYUWeS1INlirT8H5mOo/nFQbbQ5wbPXZ7/2O
         3CCXAh0YrsEJ0AV67zrG+8QkUyPKHc0501IQeebT5b+8aUk3Rp7dQe+No5uP9F0NeJ
         eMm3R3tvFoQSKtoZkPXoiQOZOSqWX5XjBShR+INJjlWNnGQr5R0SRJP1ba+Kcp6SNY
         MgOiTydoGpu3nsRs4EPcExWgs7g4EElwDRM+e3qBXS2hF37vNmDacNKRB9mg752Fk2
         zpcQ7YTNROVuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F196E21EE8;
        Mon,  9 Jan 2023 22:51:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unused PAGE_PRIVATE_ATOMIC_WRITE
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167330467445.13717.4062379234560738217.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Jan 2023 22:51:14 +0000
References: <20221220115602.6715-1-chao@kernel.org>
In-Reply-To: <20221220115602.6715-1-chao@kernel.org>
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 20 Dec 2022 19:56:02 +0800 you wrote:
> Commit 3db1de0e582c ("f2fs: change the current atomic write way")
> has removed all users of PAGE_PRIVATE_ATOMIC_WRITE, remove its
> definition and related functions.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove unused PAGE_PRIVATE_ATOMIC_WRITE
    https://git.kernel.org/jaegeuk/f2fs/c/b3107b3854c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


