Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B27D7201EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjFBMVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbjFBMUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:20:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5394E7C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 151A864FE1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77647C433D2;
        Fri,  2 Jun 2023 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685708374;
        bh=Tob221A3m45GIyyZajyCi0Hv+Wx+6rRm67D2dy4z+5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mTD+VIhlgB6KyqFcSmnM8pDGxev7x+o/g1szMdFdp2EQgSPIbkgC8oMUOJTKRRYp0
         oZvjiwW9Srl69j6r5Z+m9hiJ92xX/hNTmfc3L2ryjCt9pjTXbIstkmaESDqRLGK8/J
         +TGUCiDUubT+0w+2aLYmsL6O1HQNj+BruGhc7fXJm1Fa9DDFGdj8selT32RneEZbhM
         qzW/BEbbKfH0Fb2zj2LkEj3pS4takYHBAV7fARaEof8UnU/oXEzCF95k9lQXrIXbc3
         2EN1PU6pfF82DohpDrpGLGDSrRHyrov0gaHReb6kzDWGN91n7ObuvNRnk2hWi3xSUQ
         M5kuShmJcdD7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63C96E52BF5;
        Fri,  2 Jun 2023 12:19:34 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyD7t3pBvY9PN5g8M3KN-y7i-cNHwtoR3x5-f=-U+fAEw@mail.gmail.com>
References: <CAPM=9tyD7t3pBvY9PN5g8M3KN-y7i-cNHwtoR3x5-f=-U+fAEw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyD7t3pBvY9PN5g8M3KN-y7i-cNHwtoR3x5-f=-U+fAEw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-02
X-PR-Tracked-Commit-Id: b6ccf213d95e9373ac1f7fbcb5de3b52eec0ddb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e99a74673a19631d4a23c7e1fe2f21c55471a5d1
Message-Id: <168570837439.24915.90131940673764589.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jun 2023 12:19:34 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Jun 2023 14:12:59 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e99a74673a19631d4a23c7e1fe2f21c55471a5d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
