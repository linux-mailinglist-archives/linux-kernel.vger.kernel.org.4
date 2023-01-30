Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0565681F46
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjA3XDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjA3XDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:03:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654A30298
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:01:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7959661307
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41BC3C433B0;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675119618;
        bh=xc/KvQ4qE0zaYQjdK4Tv1DHZUeHVYvXu8EZbsocIWMI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dGpGBnSMfW8ed69u0Uf/Jclr2hr47Yn9jb4pQPEFKNbbRpQGGYAiFfvcaCXk6NNZ7
         1lU4LBBOupaNXs8O8cFCMzXsyUIZQFKCTcftkCg5Ulru6ffLLiqnCCvaV91K8l/LEO
         awZcyX/x6wz2S8N5H3v0ldnmzLOMLu+kJyjgBIOkEds1mzpVOzRXcTMXwNcZAYdu82
         opqGaeee5mJjjtQ7okuYJFpgoFrQxLjb13OdBGoXQGxwbosicx9EfPJZSzX5MryoTm
         r09zs4g57gIuUtkbxLJlAoRNHtHy1S2/0Hw2miEHVN8Mi0kz9uzMRoVOOWeiYqA0QM
         Zw54fyIIL1GCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F006FC16ABD;
        Mon, 30 Jan 2023 23:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: drop useless initializer and unneeded
 local variable
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167511961798.12751.8349285057815304075.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 23:00:17 +0000
References: <20221222081855.81553-1-frank.li@vivo.com>
In-Reply-To: <20221222081855.81553-1-frank.li@vivo.com>
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 22 Dec 2022 16:18:55 +0800 you wrote:
> No need to initialize idx twice. BTW, remove the unnecessary cnt variable.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/iostat.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: drop useless initializer and unneeded local variable
    https://git.kernel.org/jaegeuk/f2fs/c/c5f9db2548d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


