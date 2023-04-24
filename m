Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768536ED417
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjDXSKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDXSKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16E6729E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4732D627FD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9694BC4339C;
        Mon, 24 Apr 2023 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682359819;
        bh=K9tNHJzMGBqsZycX/xsTz73dgSOGSW5hOL6e8j1XH9A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gePJThZsgqSjZHL+qhbsoACUtLJUrJVkMxJq8Z1ZIMrhiNxJVFeTyuiPAWYnBq4XG
         ixU3Zcw91ucVX/T4WUTmQO4jKuHFXChTbuxEySoAf3VcFHfe7Wrf8halgzNogf1pUW
         F1QveXsnu5YLomXK2mKPpU757eJPXC5nTXVQ4+YsCTdrvQc36/n0xGXYfFmmM5CUJW
         DwMMZNQMcNmv3Rjqlk+wkHumwQKXuSxuGsEz6saDr1MKxMcBu8QjItJLWuw+0kH9sU
         5SJJ6BjvlXXtNqM8D2K09iUuQUKUzmEQUEGDS3GRgOFWt6DOVAJAKq4QvD167c//Ya
         QQayw6qmtpquA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73FA0E4508E;
        Mon, 24 Apr 2023 18:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: use cow inode data when updating atomic
 write
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168235981947.17900.2626518679840712384.git-patchwork-notify@kernel.org>
Date:   Mon, 24 Apr 2023 18:10:19 +0000
References: <20230424154348.22885-1-daeho43@gmail.com>
In-Reply-To: <20230424154348.22885-1-daeho43@gmail.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        daehojeong@google.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

On Mon, 24 Apr 2023 08:43:48 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Need to use cow inode data content instead of the one in the original
> inode, when we try to write the already updated atomic write files.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: use cow inode data when updating atomic write
    https://git.kernel.org/jaegeuk/f2fs/c/591fc34e1f98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


