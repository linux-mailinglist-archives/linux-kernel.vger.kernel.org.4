Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028CB681F45
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjA3XD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjA3XDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:03:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97892CFCB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:01:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80539CE1A96
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DFEEC433AF;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675119618;
        bh=a6ZQ/b0uXTbL1kCWSrh6VhSJzA1LEtVN1cuA2y8NfJc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j//+z8dCXXmcQfDGsph4mKLYBfMhUwHH9AqaCM5HzPmZctdWu9TeMlwVD3v04s65d
         O1LuMuTRqnhS8GNfh01nVJu7Icsz6ahzc8n4yj7awxMJD9ywOdK9OV+RCN1Dl+nBZi
         mYoTBte6azOq1KsCgJBPaCu4vn+5JV1i+vKBt2TbBrvTLmhaB6p1ZGcTFA7dquGTeR
         2YeETPvht/KzGnIebAdkwUkTOw+rjETCyj+TFPJMEdHS4cJy1pDFJJ/UZ2w36OJAtK
         ik7IGit+BhCfaHRSC7N7aSNKfNPtRoHQ9D275nnwnu29xiv4/FR7OM3QhCCAbzE148
         xasfar4xhDYdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0315DE5255E;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: return true if all cmd were issued or no
 cmd need to be issued for f2fs_issue_discard_timeout()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167511961800.12751.17604829596454297245.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 23:00:18 +0000
References: <20230112191404.59020-1-frank.li@vivo.com>
In-Reply-To: <20230112191404.59020-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, 13 Jan 2023 03:14:04 +0800 you wrote:
> f2fs_issue_discard_timeout() returns whether discard cmds are dropped,
> which does not match the meaning of the function. Let's change it to
> return whether all discard cmd are issued.
> 
> After commit 4d67490498ac ("f2fs: Don't create discard thread when
> device doesn't support realtime discard"), f2fs_issue_discard_timeout()
> is alse called by f2fs_remount(). Since the comments of
> f2fs_issue_discard_timeout() doesn't make much sense, let's update it.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: return true if all cmd were issued or no cmd need to be issued for f2fs_issue_discard_timeout()
    https://git.kernel.org/jaegeuk/f2fs/c/255699a4d876

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


