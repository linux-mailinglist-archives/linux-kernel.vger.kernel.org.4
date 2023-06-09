Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DF4728DC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjFICZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbjFICY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C9C2D4B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 446E56531F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A947DC433D2;
        Fri,  9 Jun 2023 02:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686277496;
        bh=MiFfb6W4vnvURKlH04KMHTqs85qyDTvhLLZ/eyg75oY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PUjGCdyUlspEvolr3xBcDcNptQIu0NYio+Cvch0JxJhIUlXJGrJ2GbZCR41uz44kh
         pTn1x4OKObN2v5AFTn1ytCk62Lbn8ER61pgDQMv29HtCn5MXx/xUD6f3b29sJt7+HU
         I8zovNqVp1GLRUUC4uR1Q8tFzyvIAwp+jyTEMnEYwjUPgbwoDuA+nbV+mE24FNvo16
         9dOUXvPh+BrPWABsK+mtH1JYnNUEDAY7/WYuZf842cUPCRxS2VHN90P/EcrnpSpB9h
         Nwr4zDotSa1gYjvGFsJmB/286rpUksIGOWa3TQpwE/3gMcJmeIWgsnHeaqKkn4GoXb
         NiidtkUe+H8wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86290E29F3C;
        Fri,  9 Jun 2023 02:24:56 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tweJxBYq_08o-ZtgXRgdRQYZCbFiN+VdunddCaA+UwSEw@mail.gmail.com>
References: <CAPM=9tweJxBYq_08o-ZtgXRgdRQYZCbFiN+VdunddCaA+UwSEw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tweJxBYq_08o-ZtgXRgdRQYZCbFiN+VdunddCaA+UwSEw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-09
X-PR-Tracked-Commit-Id: 986c34b495810b38f365bb71665b77de60f15b2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33f2b5785a2b6b0ed1948aafee60d3abb12f1e3a
Message-Id: <168627749654.4066.792406602015930825.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jun 2023 02:24:56 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Jun 2023 11:39:32 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33f2b5785a2b6b0ed1948aafee60d3abb12f1e3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
