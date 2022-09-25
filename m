Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908EC5E9094
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 02:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiIYAxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 20:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiIYAwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 20:52:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC060402F3;
        Sat, 24 Sep 2022 17:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C50461141;
        Sun, 25 Sep 2022 00:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B386C433C1;
        Sun, 25 Sep 2022 00:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664067170;
        bh=VJGw4DlD7o9xJMKcIWi3/sObkKUpIYXppTls52ZfQcs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gmFEKts/R1ngzQrTUc+omf9tXmKRVahfqOThN7o5eY6cD9n72z4yJzvDmmX//wn0J
         1HnS3rDJ62CNKmDIn9JzSh9s/wtc/ISm78EEBQignoR1e+DWe7Lo29/3xrlLWujecd
         b2AZy9YcHlEmT1pAkRG5tDve1tauWzsT5bHo734XHgGGN/oHWQFMNDi+7iu7LXJQZU
         aCMU3yWAfFwwdnKwLd9mhPeCSR1qvYNLwanxhvjxbhSuL6NRddhO2AY+IXvNLtGDcx
         L92C4gS/piKfyB2r0hWKbxaIQITwgzieK+wqByeBbocu9yzz+CFt26IFyTa5qqMhcl
         tW0zL2JiAM9Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EE72C072E7;
        Sun, 25 Sep 2022 00:52:50 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gwRVKR+4neD7xH+CCpnr6HQyvdJ14vjj7S4nMTAabRAA@mail.gmail.com>
References: <CAJZ5v0gwRVKR+4neD7xH+CCpnr6HQyvdJ14vjj7S4nMTAabRAA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gwRVKR+4neD7xH+CCpnr6HQyvdJ14vjj7S4nMTAabRAA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.0-rc7
X-PR-Tracked-Commit-Id: 9614369a042a3a345ef7e2997c277aa8a271b8a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42f9508b3bcb4214491a327238170963a59a309d
Message-Id: <166406717018.14733.14177268921435033758.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Sep 2022 00:52:50 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Sep 2022 17:48:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42f9508b3bcb4214491a327238170963a59a309d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
