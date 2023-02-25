Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5CD6A2BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 22:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBYVKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 16:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjBYVKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 16:10:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91FD50D;
        Sat, 25 Feb 2023 13:10:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45DB360B71;
        Sat, 25 Feb 2023 21:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92DACC433EF;
        Sat, 25 Feb 2023 21:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677359401;
        bh=wDVLpDjIrpWsznA+1JoGcjHXYimjYcDICbATIDeJJOc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rdymdsIocq7fe1sjeJLR6mFSpuZRH27f523si1Zc517vOLcP87URujopoWV51pFvu
         VLEgYhY691SywmXevfsQ/JPcg8AMLzri93eldUwsQpOygvLbyRI9njzb5BiQrbvTgM
         7/RlYzj646Wo37zN2uCgxZ+pvXSIy557I/ReFret/shZoORAeL3vrH+qTVmczmAkG4
         vqVSRY8S0mFgPi0oeO/TDo0cUZ/gvRypSH4ZAwQ5K6c2dU3t/tywUMxONOvDloyaKI
         Ku3GOwI1VfphwGPkFOyqhKJcQcQ6jO5OW1CNGHWg6i3Y+7dSXaZWWoPpwqRYkAhE5F
         UBdlLDSCXonaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82043E68D26;
        Sat, 25 Feb 2023 21:10:01 +0000 (UTC)
Subject: Re: [GIT PULL] flexible-array transformations for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/fnjS5eHNauiUUR@work>
References: <Y/fnjS5eHNauiUUR@work>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/fnjS5eHNauiUUR@work>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.3-rc1
X-PR-Tracked-Commit-Id: b942a520d9e43bc31f0808d2f2267a1ddba75518
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 472a2abb7af5067c45db25fb59c17e828af07886
Message-Id: <167735940152.13638.6438592560424960765.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 21:10:01 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Feb 2023 16:24:13 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/472a2abb7af5067c45db25fb59c17e828af07886

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
