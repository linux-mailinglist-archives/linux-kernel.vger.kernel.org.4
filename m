Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC0D62FFB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKRWFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiKRWEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:04:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40D993702
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:04:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E3B0625DC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 22:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF485C433C1;
        Fri, 18 Nov 2022 22:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668809086;
        bh=6+mpPfvH3CFJbPiRSoqOLPeyKyWOLD8oFXh5W07iSc8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HscW2Rjxabl/xOxjSWSWAIo5BTnFuqsgks27Y40vuY4UTDCjFBSlO4LmhQInICYEY
         //Bdi+CUfOMDdzhdu080HWRZIdHhVTQ29i+CIJgyRbcbyBdEpDqJYoWCtZ4zfKVHck
         22pph04Aou/hueGbiLPp/Zy74sLMmm2Man9EdMX+MTvVKgOzW/qNd1wX1q3NtM3ILZ
         Cy6s6VrF2CrfCkNXZOzsAGgTxowUfowli2HutOrUe1+0kotUeXp+49Hhc4s7KDeS8n
         WZCvcxEZe+DuVK/dynmYvTb5QK6ejJ3fefDW0MufCUMhCT5rdAmOHiQRNI16AtAM3A
         FPf7DamJvbR2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C2F4E270F6;
        Fri, 18 Nov 2022 22:04:46 +0000 (UTC)
Subject: Re: [git pull] drm fixes for v6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tynM8qvm96FV9Z7+EO1u6p8zMiqG9JyaDqqPtzowx3nfA@mail.gmail.com>
References: <CAPM=9tynM8qvm96FV9Z7+EO1u6p8zMiqG9JyaDqqPtzowx3nfA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tynM8qvm96FV9Z7+EO1u6p8zMiqG9JyaDqqPtzowx3nfA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-19
X-PR-Tracked-Commit-Id: b1010b93fe9074f965ebf86e0e382a8a7a71500d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5bf1d8a23a683d56be574a934a8296912efc758
Message-Id: <166880908663.32251.5726882483287027993.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 22:04:46 +0000
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

The pull request you sent on Sat, 19 Nov 2022 06:35:47 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5bf1d8a23a683d56be574a934a8296912efc758

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
