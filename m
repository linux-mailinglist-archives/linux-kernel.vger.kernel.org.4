Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8B609512
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiJWRTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiJWRSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:18:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EC75BC90
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:18:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B390B80DB7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E0FEC433D6;
        Sun, 23 Oct 2022 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666545525;
        bh=e8pYZ0qwa6UXmJW7a2McGXGg4gnE6gGWYNQxm1BixUo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LHUCWxVP2RiTqdcuZDG4hreDSZiskvV8vOetjAUna29UeWF2bk8tQWggf2qV/kO/y
         1pvBwP+dXS5IukjsfIrNDV7FeOWL/IJ7Yf80MIiw1rnF1j2+nxrXXkEMuRk/kjELIZ
         YqzpylCmKUGHieC4g+hqCs3bylsohmIE8EA/ttHIfeZuMaEJSyRsd9pWB49rhWMk/h
         EutKfMU6+V0ctnex4p0jhicU8YUvYQH+Mcs9afyAPya3WTh3diIhs547rgpeKJMPSJ
         oOmG20hT0Maz5WzV/YSoxdHe2KMBzdvt04PWPsBluMPIR2yWf6n9Zi3xEonaxrWC+9
         3hU3hmhS1P9Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0438EE270DF;
        Sun, 23 Oct 2022 17:18:45 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y1UQGmB6adKx6+80@zn.tnic>
References: <Y1UQGmB6adKx6+80@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y1UQGmB6adKx6+80@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.1_rc2
X-PR-Tracked-Commit-Id: 230db82413c091bc16acee72650f48d419cebe49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6204a81aa3f489e4fb43288d95d27c069bad4e1e
Message-Id: <166654552501.1521.308540173080058323.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Oct 2022 17:18:45 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Oct 2022 11:57:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.1_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6204a81aa3f489e4fb43288d95d27c069bad4e1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
