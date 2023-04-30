Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D586F2A96
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 22:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjD3UIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjD3UIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 16:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8A110F3;
        Sun, 30 Apr 2023 13:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97BDC60FE1;
        Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D851C433A0;
        Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682885290;
        bh=op58binEAahF+yc+T71IimAXjyBgeeH2CliQs28CTqE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ubpuv9/w0JJPUxYPdH5qTP0pSFsOUIg740lypse+Y2Vdk1jtZ6nrl2yvQZQvLLh+O
         N30WoyKqx3to9r9/dFoIJpU1h1b5SeGbLXwS+lCCTfDxlkg7E5WRnYLug67OVvLIbH
         GpdKO36+yO/EmoJqgBjyyTrbqs08bQm/I/JDE4hBqRAEIwTPErOIRAW8AqKVl91BP8
         cLGaPrrx5h4zyPfRIOqVNwAtzyOaXoHmAfUj4eItj0Q75+USjG4oB3mJvuUzSyFjX/
         2tO8Ns/1yO/aYOrJ+dBAPfAnE0bnWG//5CfRboj6crpvDj1Tj40nxcmmVLeUOTCK2R
         AP9bhLMXUTZWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0DEAC395FD;
        Sun, 30 Apr 2023 20:08:09 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQ-8VRCeFx64KvC7VTA8rm4ryK_PjQi=Cs+wvrer+q6QA@mail.gmail.com>
References: <CAK7LNAQ-8VRCeFx64KvC7VTA8rm4ryK_PjQi=Cs+wvrer+q6QA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQ-8VRCeFx64KvC7VTA8rm4ryK_PjQi=Cs+wvrer+q6QA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.4
X-PR-Tracked-Commit-Id: 9892bd72efdc9daa7c07ca9f427ac7e5928c7704
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d55571c0084465f1f7e1e29f22bd910d366a6e1d
Message-Id: <168288528991.32747.12412722271054068714.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Apr 2023 20:08:09 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Apr 2023 21:21:44 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d55571c0084465f1f7e1e29f22bd910d366a6e1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
