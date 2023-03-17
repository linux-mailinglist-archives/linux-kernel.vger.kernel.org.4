Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437326BEFDA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCQRjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCQRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:39:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950D7D508
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA396B82665
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 699E1C433EF;
        Fri, 17 Mar 2023 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074730;
        bh=Dbutxdfd0A1bvEpqs4wNgSHDpQrkwQ9Ec9HoUhD+vKw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RGBOwNjSAn1nkggvj+hc2CA7kQSaqPPbKefmRaQWzAfDAfWpRkrN2y0kAxD7Q8Uu6
         khrLxKLQLnC9ZD9TOkR0yJxodmDLBdMv91WLVl7HU6AdInsnU8UQ1z1GbPSH7oYVfK
         ico7XRrLIa7SAmAW2lAKzUfX/sjFsh28wEoBujlT/rUtxknjS70hV6KmpSLlGUIrHR
         Rt9fYoWteSsg/pWVS/i0QJGZTYMXySN1z5DabFR3Aq17vnoraSjCfqnOpwr/vmX/fr
         Bwu4y9ENjT2K38As0Cta1gA27Ucw6X3vCDi8526t0xTTDeQeXokT3SUjTTR6OCHPtW
         mr8k52WI2yvyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59546C43161;
        Fri, 17 Mar 2023 17:38:50 +0000 (UTC)
Subject: Re: [git pull] drm fixes for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyVZZgr8S+Bfx6cyF2ied2btog7Y6FkDoteF+JFv__rgw@mail.gmail.com>
References: <CAPM=9tyVZZgr8S+Bfx6cyF2ied2btog7Y6FkDoteF+JFv__rgw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyVZZgr8S+Bfx6cyF2ied2btog7Y6FkDoteF+JFv__rgw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-17
X-PR-Tracked-Commit-Id: c00133a9e87ea5324d0b883d801eb6656f26739b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cf5a401c87178237c5b782c44578c26690a802b
Message-Id: <167907473036.9394.17253234522073737974.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Mar 2023 17:38:50 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Mar 2023 17:59:36 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cf5a401c87178237c5b782c44578c26690a802b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
