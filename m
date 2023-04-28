Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20606F1D57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346135AbjD1RXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344932AbjD1RXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528692735
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E267360C17
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DBB4C433D2;
        Fri, 28 Apr 2023 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682702588;
        bh=pIxXldhIVCFITNZpg1X4EvRspJJLg+Z5HO8QseFiJq4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZBsHXn+9BEYfAqGErhCpXi/lbJ1JITwkzfA9gS5L9cMwojupVRuRX5zMtND32MiWB
         LJHQXslFn4RxWRRAITai30DeQBFTIFP3vGFovCsPWDpPwzO3u73WNwIzGNSumZOHAN
         Ss0GgOhpt7VKLsfkoqbImONDfmtAgQu95FoBXhxU9TsUjDzbMkYeWLhGnRGIti33yX
         HSYjUp+jZQ1LMR/hvb8wGXbAxZk7sX3oEDUBWhq2T7jdmHOPmhis/ATNJUXxuFYzNq
         XH96vElngT6iia5jg+DkxoJ/aOGzrZ0+hOQxEOpAzm1/k/iYsuv9OHBVhWWenNz0NM
         li5ooXWC6EGnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3ACBEC3959E;
        Fri, 28 Apr 2023 17:23:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427150153.GBZEqOYe5N/NbeqsaQ@fat_crate.local>
References: <20230427150153.GBZEqOYe5N/NbeqsaQ@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427150153.GBZEqOYe5N/NbeqsaQ@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v6.4_rc1
X-PR-Tracked-Commit-Id: 5462ade6871e96646502cc95e7e05f0ab4fc84de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 682f7bbad29c0e5f59929ad69e1ed8525feb96d3
Message-Id: <168270258823.30920.552717903676897261.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 17:23:08 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 17:01:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v6.4_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/682f7bbad29c0e5f59929ad69e1ed8525feb96d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
