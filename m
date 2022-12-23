Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41386553D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiLWTXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiLWTXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:23:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791801DDE2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1315F61B06
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 19:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7815FC433D2;
        Fri, 23 Dec 2022 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671823382;
        bh=Fxi2sOZjJhlKYb3m1ljiNiWIqh7FzU2mEUav2fKJ3pU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uRFFv3ANvv/4O6evGlCV1NMtOJgZhfh5wpv6eFpu0QJB7Df7dfBoY7GZLHw6N10hU
         8L+ChDKOFMin5wb8draTHpKEj4GnM3rfpSDb8OL+MZTzvnJY4KqviTPxyDIJ++artT
         yvTksPewMeeWNRMxP7Fy9+nB4DqubGyJauXHb6IKAyIytaGsLifv9hfIqFpFKDxSQd
         T4ym2naoJCXhOtwTI0D1piMaPxCyjnpu4L5vkcs65v29r5aqWS7rw9xBkpaAxnZsGL
         /j5URBMYKNYllVMKMFtlMO3bdE0zod9M7PfRWpjcwRMxGMh8WydvZsrqe9ZhVYStsv
         EpZF20iiiy8Sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66F64C43159;
        Fri, 23 Dec 2022 19:23:02 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tye2Py9FXHP5qcNnb2BEa0yWNe4KDdfh5Vxpr2YMDwDeA@mail.gmail.com>
References: <CAPM=9tye2Py9FXHP5qcNnb2BEa0yWNe4KDdfh5Vxpr2YMDwDeA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tye2Py9FXHP5qcNnb2BEa0yWNe4KDdfh5Vxpr2YMDwDeA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-12-23
X-PR-Tracked-Commit-Id: fe8f5b2f7bec504021b395d24f7efca415d21e2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55c7d6a91d42ad98cbfb10da077ce8bb7084dc0e
Message-Id: <167182338241.13713.3615144832427178391.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Dec 2022 19:23:02 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Dec 2022 14:02:33 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-12-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55c7d6a91d42ad98cbfb10da077ce8bb7084dc0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
