Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF4701E30
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbjENPzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjENPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:55:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2345A30D7
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 08:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 660EB6181D
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 15:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C057DC4339B;
        Sun, 14 May 2023 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684079730;
        bh=63J6yXLgsTKwEbIscV1N5Z360oQz169ntzGrh72Rdkk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EoiQgfB6M4kzUUrG7EcriA5sHdqsMcxOScsIDk4oQa8Z0B0TRus5b9EBSXsYhl+2V
         oZC3gmU9hwFJBG9B6sAYw/t64KTTv/Nz0tXLxUZ94O7j3dgwU1eCeVAF516kLnltFx
         68o/9Ih65D0tkU4bawtTKCGUBoPJyeGMLc8HZ5FK1FipfjKPym40HhunUDQymio8/N
         KKHlKhzZX6X56YSdXyEgZX4B1xiG39yQ6xS1kD6C1bX67vbCJKzapoXBSq1rnLO1sE
         wweBOu+ee5mZFg2cR9/3zVTDd1EqSO+zsaDNDCw2fg6X5j7WCBYiZV11L6JYhsqWto
         cQJ0aKvMcz5uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8CF4E270C2;
        Sun, 14 May 2023 15:55:30 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230514115312.GDZGDLqDPvR+M8m+1M@fat_crate.local>
References: <20230514115312.GDZGDLqDPvR+M8m+1M@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230514115312.GDZGDLqDPvR+M8m+1M@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.4_rc2
X-PR-Tracked-Commit-Id: 0019a2d4b7e37a983d133d42b707b8a3018ae6f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3b9e8e4c84845d09dbba49f664fc8407f18a3dc
Message-Id: <168407973068.9046.2003021199473202346.pr-tracker-bot@kernel.org>
Date:   Sun, 14 May 2023 15:55:30 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 May 2023 13:53:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.4_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3b9e8e4c84845d09dbba49f664fc8407f18a3dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
