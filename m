Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2667868AC2D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjBDTzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjBDTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:55:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4957326879;
        Sat,  4 Feb 2023 11:55:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02641B80B68;
        Sat,  4 Feb 2023 19:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA1FBC4339C;
        Sat,  4 Feb 2023 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675540508;
        bh=FldBJKWZjJc2MehtJFsXjVUS+exJ/jedFp1XsCiT4z0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gscst3u09J1QJsWx30tZWYiye6Z7ppsjirOb/B6KbGnfQeC/pHkJ74dZPRzZqoNNF
         zqXzJk/VQXhokSDKZFkErh9XlthLCqOOJLpTuH8qJJ4NrAdA5/2sZE11U4JA/S1jHc
         70Iw5rXyZKM7obZyPnhP/uEuMJlK7EQd/wPbNcscvnAoP7r6EsoL0gITKqeEWzi5We
         /uYYr4tsY6s2K3/l4iwXrKBzGe5DMC9aoDg8g7/e8lA0M7+7AsIuBCRl5JSaO8Q2Hk
         FMk8qvOZ3pQk/+jDQqOPDxWFdsxZ/2TKsAFhaEmkTqoHrJS6qiLt6S74jPygbyZxGA
         b2CMpfi9gYM8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9145EE270C5;
        Sat,  4 Feb 2023 19:55:08 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARNwyei5pGmwR+iSLH733jAsaHet9h1dfWHF2x+Uhb=ag@mail.gmail.com>
References: <CAK7LNARNwyei5pGmwR+iSLH733jAsaHet9h1dfWHF2x+Uhb=ag@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARNwyei5pGmwR+iSLH733jAsaHet9h1dfWHF2x+Uhb=ag@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.2-4
X-PR-Tracked-Commit-Id: 22e46f6480e83bcf49b6d5e6b66c81872c97a902
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db27c22251e7c8f3a9d5bfb55c9c8c701a70bbb3
Message-Id: <167554050859.7014.272107243873428684.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Feb 2023 19:55:08 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Feb 2023 02:55:09 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db27c22251e7c8f3a9d5bfb55c9c8c701a70bbb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
