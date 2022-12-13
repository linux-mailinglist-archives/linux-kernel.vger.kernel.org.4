Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93BD64ACA1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiLMAw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLMAwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:52:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181A6167F9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:52:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9F43612DC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 124FBC43392;
        Tue, 13 Dec 2022 00:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670892741;
        bh=gVuZMpmt/mLtWmmjH6Eyk06rwPfcBQSDgwGkWSwUchs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M35TQBdUVE+Is5dYGFDDTcqVYW7tsEeUbKIQd2ybw1lTv1qlsHz0LiflznefaWGmL
         efjvqMm/Sj0VIKncogoDbavlPr598l1pUnIf8LyhldAkpz8fTolb2efJMSuYICFaYH
         mLlWRsaP6w6FO9VTazkFnD0r/RaR/i09kKi3y65jHONQg5IHUBRfAFtTg0nRvYJxjC
         zQj9aQ/M32HSFy7PEHiU3O0HhEjRfVo1Tbq+TWD6obHmWB4ZZXWE8tiGK3idBVRMkN
         2wBzV4t//eI8Cmsixvke/w8nsSNIeO+ctgMYgneqZh+PNe8wXhFahFXcFeDZ1Epxd5
         x4gNOhUkRFjRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0FE4C41612;
        Tue, 13 Dec 2022 00:52:20 +0000 (UTC)
Subject: Re: [GIT PULL] ktest.pl: Updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212173018.3c55203a@gandalf.local.home>
References: <20221212173018.3c55203a@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212173018.3c55203a@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v6.2
X-PR-Tracked-Commit-Id: 88a51b4f2e65ca4378a81ff0925fad076e82e177
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 535ea85de3dabf8c04e88b6e968ff793b7e58da9
Message-Id: <167089274098.13252.2250151949773536194.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 00:52:20 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 17:30:18 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/535ea85de3dabf8c04e88b6e968ff793b7e58da9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
