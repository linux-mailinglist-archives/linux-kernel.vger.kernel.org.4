Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FC4681F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjA3XDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjA3XDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:03:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D23A1F5DF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:02:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 07A92CE1A94
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D1F6C433A4;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675119618;
        bh=CMt3YGmi7TPBDuXz+slvY6FzDAJYXbHGEJa3D+ssLbk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CvMC3enDwkkDBfmWDU4trVuWWgsNR91OAe0a6yxskuwlBq7evvN+vz4CoBdhmSl7D
         hENXOlvZLw5PwYgvnGXnn3yTwqeljgy8o0Wb14A8EpoHupbuzIgBCgym6DlJqyN06B
         ZQFX44ooCjUK0K7lt0S9z96LIUzbS/hKWtkvRrq3rHBSNbX+4G9I+t38Dt047sajVF
         Erx6y8s+pmx84Iy9KEN4KsO0iKQ6nlBpksXw/jr4aDNF+7vCotgquEPsQT6VpzoPqu
         mAyBa/d0JmH5xuN2qhKZiuENZTFrn/zNf9hTTaE6SWgJUD9WEszwPK/LT4hjFr4DMV
         vUeWlHIt0bdoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC415C04E36;
        Mon, 30 Jan 2023 23:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on extent cache
 correctly
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167511961783.12751.11163869544099252869.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 23:00:17 +0000
References: <20230109034920.492914-1-chao@kernel.org>
In-Reply-To: <20230109034920.492914-1-chao@kernel.org>
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  9 Jan 2023 11:49:20 +0800 you wrote:
> In do_read_inode(), sanity_check_inode() should be called after
> f2fs_init_read_extent_tree(), fix it.
> 
> Fixes: 72840cccc0a1 ("f2fs: allocate the extent_cache by default")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/inode.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to do sanity check on extent cache correctly
    https://git.kernel.org/jaegeuk/f2fs/c/14c42b75ee14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


