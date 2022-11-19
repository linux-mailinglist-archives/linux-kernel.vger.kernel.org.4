Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22529630FA5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 18:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKSRO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 12:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiKSROu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 12:14:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0E613F85;
        Sat, 19 Nov 2022 09:14:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CB77B8015B;
        Sat, 19 Nov 2022 17:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DEACC433D6;
        Sat, 19 Nov 2022 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668878087;
        bh=+J5uSA1BQyg8DsHHZNZzlEGqj7HfFYbE8y5JsatxasU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jn1dOnLQJI0BaBgwHAhxM9Cq4feESYbx2J15NZLPtUE1fDp4O3a521WjQ95LC9+j8
         Dnq2IL2CpDiliNlrjtN0jAXYlandXrArzvy49xQET+RjmHCZ2fCVkEjqP8G7BZdD0s
         gFBhbOYI5plL40tUSRMH3b6EUqhkdnpcBlBDElkD4RmCJ1btGK5LBTKIjAZSd3cwVn
         G18HStuzC66w0FLqG71L9rzoyWqMDsAElKNSB4azr/gbVKY+gAyRD6AsvTzkFW/dIu
         sovEHZT0gEw8lv6qP0MED7H6OcvTVZzJte5AGJA3R7Y+scpLFTLO3HZCUQbEuD1LkF
         oDd+9eVG8CHdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8B7FC395F6;
        Sat, 19 Nov 2022 17:14:46 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAR3ESoUBQ5HM3FCLT2LC8JPWstTO6aypnm09ayCFjknYA@mail.gmail.com>
References: <CAK7LNAR3ESoUBQ5HM3FCLT2LC8JPWstTO6aypnm09ayCFjknYA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAR3ESoUBQ5HM3FCLT2LC8JPWstTO6aypnm09ayCFjknYA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.1-3
X-PR-Tracked-Commit-Id: 5db8face97f81c9342458c052572e19ac6bd8e52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c67d863a9d60f8e2d563477ba2fd664122e0aae
Message-Id: <166887808694.22538.5890182436848871741.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Nov 2022 17:14:46 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Nov 2022 00:26:40 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c67d863a9d60f8e2d563477ba2fd664122e0aae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
