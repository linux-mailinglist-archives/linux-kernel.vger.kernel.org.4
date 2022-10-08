Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF055F860B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJHQac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 12:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJHQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 12:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48B040BDA
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 09:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7330D60A52
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 16:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43588C43470;
        Sat,  8 Oct 2022 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665246613;
        bh=X6PbMzMCwVuUJzWZeMvUkhLu8Rm4K+QULMd5V0LXzxc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sidzigieXkWqjH61Pxo0+pe5Ks2KzvLfVW3qTQyt1PaO4eHc36MAxNd8jcEG+0NAx
         f4qSw+r14S2M3kmBtfoj83veB6zJTdynFicarcnaIelol8vczKVWeQc6FfoPnPvvnQ
         LopG+TYV3/UqDrXZBHpFnyXG57h3LhGpQtqFu8ezOkGFCkzF8o2OsEAaqEfkddKVau
         InbIAVjoZ4RKxaTRYbh1btQcXKiGgWFLTQewfBkhk+gCzxoRcOMkoEmD8RxcVZq7Q6
         WbMSz9K38rZZ+fC+L97+NInJdhZKBVbNF9rJCUWxV/begKVXnSCf9xbL5OjbU55U9N
         pmbUzXrUFAPsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32BF7E43EFB;
        Sat,  8 Oct 2022 16:30:13 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0GQwYdy+s8zfd2g@kroah.com>
References: <Y0GQwYdy+s8zfd2g@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0GQwYdy+s8zfd2g@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc1
X-PR-Tracked-Commit-Id: 7cd04013fbf3e6dcb67ca6b59aa813269a2ad9ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a09476668e3016ea4a7b0a7ebd02f44e0546c12c
Message-Id: <166524661320.14582.3287888847808038334.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Oct 2022 16:30:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Oct 2022 17:01:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a09476668e3016ea4a7b0a7ebd02f44e0546c12c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
