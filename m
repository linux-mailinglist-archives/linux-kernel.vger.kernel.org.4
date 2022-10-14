Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B4D5FE850
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 07:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJNFIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 01:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJNFH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:07:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8561946D0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD5AE619F3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 05:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3660EC433D6;
        Fri, 14 Oct 2022 05:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665724076;
        bh=il/daQCIXU6h5QEYCNazfQyvvr2abHO9phfMIk4SNHM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sePqRwZ9r/7/3u8OpkbJk6ogb84AgOGezhabwfi+tLMaLrNR1H4X+7Sx4BJfKpm29
         W7CCtx5RJyfT/GBxkM/4r1XPZd+Un5xfdyP+U2gSg1iXd7tAGy7fsBIUs4De0mvpIu
         hai9XVGjLc3h0jnbLMYqs3v8s4gk9Dsd/o1QZpBhM0OWai5OmHzAtmQE+lddj856/o
         G0Gug5PM57iL1dSyRhB1s/vShE/kprKMs+O8qUe9UaEFIxVGzztDLB4zJELSb1xDpT
         ctxQYX4HDkLRFEcKdEARKpPkS6JslQf5aDCw4rHsU8appRlVCz2nv7XRvNA9Pf7rOY
         jcxr4aGb+LF/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 251D3E4D00B;
        Fri, 14 Oct 2022 05:07:56 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty3DGWa8vnfumgSrpSgWnixWjikb6C0Zk_5bW+deKLVQw@mail.gmail.com>
References: <CAPM=9ty3DGWa8vnfumgSrpSgWnixWjikb6C0Zk_5bW+deKLVQw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9ty3DGWa8vnfumgSrpSgWnixWjikb6C0Zk_5bW+deKLVQw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-10-14
X-PR-Tracked-Commit-Id: fc3523a833c9c109e68209f1ecdd15864373e66a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c9155a3509a2ebdb06d77c7a621e9685c802eac
Message-Id: <166572407614.12880.13756363926335415143.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 05:07:56 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 10:29:19 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-10-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c9155a3509a2ebdb06d77c7a621e9685c802eac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
