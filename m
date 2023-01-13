Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150C1669950
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbjAMOCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbjAMOBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:01:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9AEE32
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:58:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC0AE61DDD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28623C433EF;
        Fri, 13 Jan 2023 13:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673618308;
        bh=4qfWw3Ez9GnDaJKDGYjaXMIltwVLJnzFcdlV4QOV+FI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Un1rcuHSpv+eNXJAjWe+uhCvJqiJ9boP/lfhwG+vPXvvN0qwK1tmDD1VzcYuVH2WW
         Arr/uAKaejjnn1p/JE3iFN2uEl9bMXJweZu4lbPFI7c970fpEDmwGCCSgCm0v7Oyjx
         cWRhXfM1OCo3M4oW3YddFPWOlPH8Oq4/qqNyWJhmvUjWq9bEm6lk6pn1Wwh/iCzAhM
         ihwZnLxbZrJXn6lO5Az125MYlmeocne2xgZ3sI+cSWdyeKI6nzHIGY8h/yZx8eFp7W
         HOlLtGp4YpslV9hPXR4eKiWVgQYBEgPt7QoBro9vid6/PBI0bVU0ewj3XoR6IP5C+R
         3YShO3wedzVBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14EC2C395C7;
        Fri, 13 Jan 2023 13:58:28 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyS7pXX12Ks+b=iSbUAdfLW=U-uGKo4SkKz6yGiCsusNg@mail.gmail.com>
References: <CAPM=9tyS7pXX12Ks+b=iSbUAdfLW=U-uGKo4SkKz6yGiCsusNg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyS7pXX12Ks+b=iSbUAdfLW=U-uGKo4SkKz6yGiCsusNg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-13
X-PR-Tracked-Commit-Id: e695bc7e542358978434c8489a5a164d2bbefae8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff5ebafd51ecc01014f1db510299eede60faf22a
Message-Id: <167361830808.16011.4014386693041843367.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Jan 2023 13:58:28 +0000
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

The pull request you sent on Fri, 13 Jan 2023 15:15:17 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff5ebafd51ecc01014f1db510299eede60faf22a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
