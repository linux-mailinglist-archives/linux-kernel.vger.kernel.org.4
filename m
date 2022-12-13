Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA5A64BDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiLMUYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbiLMUYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:24:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE2C27CEA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:20:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79FAA61532
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3477BC43398;
        Tue, 13 Dec 2022 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670962805;
        bh=FIFYxRafz/IoKAee6YwLUlifVFEA8reoXarVh2nr+1U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nyxMQcPibklqnByu8vJmjftZ2He9bPhSKA9QhsNbdXLpik9LN/Clpgtpm6HjM0++l
         NykS96YZq8Pwv42oJjG2ufEI3eqxzBGU+tNWyS4qHdsW5YJIzr8oPtslBunSZOZTFb
         kimpAwcPWQOnEQR6Ov56XCCGcHi6fD2qKTus8GDd7Sut/WaDtzoKc0bGh7BnyNNZNQ
         q2fgVF5QkZ1a76uk77v8ZpmIrxBmE2q1u7ihUP5emn3Lr20bNLfxY6Vz9ma/ERaQXz
         ec4rnqyBKU5kbd0w+b/4fD5ulgH+ZF+EOyNbIgsBCtZz4PxU8v71P7ReZqsYRfIw+Z
         ZIanav6DnwmUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 229F2C41612;
        Tue, 13 Dec 2022 20:20:05 +0000 (UTC)
Subject: Re: [git pull] drm for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txGCMqyriq_xiwgFCUBa-PpHvSuRQuptAHusHcjpH+zqA@mail.gmail.com>
References: <CAPM=9txGCMqyriq_xiwgFCUBa-PpHvSuRQuptAHusHcjpH+zqA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txGCMqyriq_xiwgFCUBa-PpHvSuRQuptAHusHcjpH+zqA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-12-13
X-PR-Tracked-Commit-Id: 66efff515a6500d4b4976fbab3bee8b92a1137fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a594533df0f6ca391da003f43d53b336a2d23ffa
Message-Id: <167096280511.13378.2856917258516541935.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 20:20:05 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexdeucher@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
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

The pull request you sent on Tue, 13 Dec 2022 12:56:25 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-12-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a594533df0f6ca391da003f43d53b336a2d23ffa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
