Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85BF6DBE47
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 04:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjDICQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 22:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDICQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 22:16:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7F44C33;
        Sat,  8 Apr 2023 19:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F7C614FB;
        Sun,  9 Apr 2023 02:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B56DC433EF;
        Sun,  9 Apr 2023 02:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681006565;
        bh=lRaUnK3rFxhiE/FGgXclZPawqjtKIK8fELo7dBRfPPQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QksYBv6gEuUgLjJ31qNORsPFkAezMbzgIXZZwN4iqoeVhaRjW7JUcXmPdVydsZt9d
         ul7M5/v+UKHmcEVts0UkEHGq68nBXE23aGotVkRYcK4SYh+emPAh5U7U+yAheRajGC
         lGnaOMe0tGrrgUDv1YOIsK1P7j7Ntmy+LBZRcuD2S21Fbm+0H/y8PX5D8qo2uGI8vI
         sBlDFm+UIBapRVTTyT6RYr+l/FXtMI8aRih/mPvYreeK20euREX6SAAwCHSmXPHs4r
         0QFBnRy8AWWz3FJL9kmq3+h7tXTLY+aN7cELhMHS/ntgDUIeFwFvey0HyZwq/fu5kP
         a+eo+ynHNV1FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19C10C4167B;
        Sun,  9 Apr 2023 02:16:05 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtknshEDr33kiExGDqrMhqVR+Et82vigWEBkD128U4v8g@mail.gmail.com>
References: <CAH2r5mtknshEDr33kiExGDqrMhqVR+Et82vigWEBkD128U4v8g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtknshEDr33kiExGDqrMhqVR+Et82vigWEBkD128U4v8g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc5-smb3-cifs-client-fixes
X-PR-Tracked-Commit-Id: 4f5d5b33fc400911d6e1f49095522b361d9cbe13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdc9718d5e590d6905361800b938b93f2b66818e
Message-Id: <168100656509.9119.15974096020575173546.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Apr 2023 02:16:05 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Apr 2023 18:34:20 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc5-smb3-cifs-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdc9718d5e590d6905361800b938b93f2b66818e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
