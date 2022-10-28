Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F5A611C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiJ1VLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiJ1VKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:10:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F469ECF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D2C1B82A8C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21110C433C1;
        Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666991449;
        bh=wf/8jsLnB4pzjsM6ppMfJLA/5kw2a4UPsAVbd+cvZ1k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qukH1UhyYPtl0Rf60dX3kpfGl1T/2eGHJXavcWAmLZZ3ay2o+TVrG5tlTO62dBjyl
         WO/KTkRPDbKLSLkxxNRf+09vBvHMYK7nxOmCdMI2UXIdLvKDHlHnEx6qZKkfGxZEAD
         2Kfan1CADmknBUn2gyXHmzp+mbbvzgmJS9IDRk84Onc94pdHL1gdzisXEtKbbw+FG4
         +2AEYY3F8hF2DfmLH3VMbusDEctE2FfLbsKJKtws8gO9hNTq75nlvTC6mCcGDyEI0j
         uENUmRYA7rLuuhI4iJra5/p1naItD073YDvocnS+m92j4cLbnPY+sKZcgHu9mGmpNT
         O2p5+j3WS81Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DB55C4314C;
        Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz-_RXszedVsU-Wx64==1dihXzoMLzT6ghOD8ATwJ8rWA@mail.gmail.com>
References: <CAPM=9tz-_RXszedVsU-Wx64==1dihXzoMLzT6ghOD8ATwJ8rWA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tz-_RXszedVsU-Wx64==1dihXzoMLzT6ghOD8ATwJ8rWA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-10-28
X-PR-Tracked-Commit-Id: b2196401949ed2517bec676928f837e6bbd01a65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3493d682516e2b7ef69587ddf91b0371a1511d0
Message-Id: <166699144904.13387.15685587718628402711.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Oct 2022 21:10:49 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 13:53:24 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3493d682516e2b7ef69587ddf91b0371a1511d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
