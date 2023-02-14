Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A990696C78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjBNSKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjBNSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:10:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3612DE67
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:10:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAA91B81EB5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76D66C433EF;
        Tue, 14 Feb 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676398228;
        bh=hjZ67XNKi/w+9jxZRZs54E81083oaVh693j/6bpGlMc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FAU0YGBpbga5nkL/MO8SQMnRjVQALM9zhJTZ4lYTLzzINdtFcn/KUe08+IBPVktG5
         A7ELJM9YvXyMG11Aqo4UkqNE+zUefX7+uLZpdrknXaYWDKjV1TF9btjfIMQ60mCr3/
         3ocPz1mE9Pm1AjgJpkztqtawXIF+slfZRhVilG4MaWP+8mNG5ZULANvJ4CEL3H4uRb
         1VaQhBqrBrYmSKaZ0+yk6fZwouI9mmCAk6hhC3eXPnePTQUSggb2H8rbxQyn0oa6Mi
         Tp30bg+x4ij1IlCuLqXw13Cxk2HdWVg8x/8ltsFY/63ix5uyOAL/j4l4o85netX54s
         DEVU94fra1oFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A9BFE68D35;
        Tue, 14 Feb 2023 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: synchronize atomic write aborts
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167639822836.3874.17414617616074524611.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Feb 2023 18:10:28 +0000
References: <20230209181819.2333522-1-daeho43@gmail.com>
In-Reply-To: <20230209181819.2333522-1-daeho43@gmail.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        daehojeong@google.com,
        syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
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

On Thu,  9 Feb 2023 10:18:19 -0800 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> To fix a race condition between atomic write aborts, I use the inode
> lock and make COW inode to be re-usable thoroughout the whole
> atomic file inode lifetime.
> 
> Reported-by: syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: synchronize atomic write aborts
    https://git.kernel.org/jaegeuk/f2fs/c/a46bebd502fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


