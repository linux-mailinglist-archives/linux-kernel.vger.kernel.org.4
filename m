Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11596A9F70
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjCCSpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjCCSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:45:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBB05D768;
        Fri,  3 Mar 2023 10:45:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBB8AB819F0;
        Fri,  3 Mar 2023 18:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66119C433D2;
        Fri,  3 Mar 2023 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677869071;
        bh=GZGciyiwzmZQWG/mK9QVZOZFUUT/jgYkBxxNq1W8ynk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sBz8qFMzxek7WdSf1w+jvUpUyqGwbU7Ays9R3pk5ePE23lfaiq81ntf3y2MMQa5UE
         sdZ3Ama/wM/swKRPAsmzEUN7xucjU0suTOBlaWl0SX5X8SBbUAlMNxSKmMZFSRNgbt
         9/erzXhH9NbtEVqAeug23Z0AxlDbkP7bc+/vsryJM6JgaWcp1sVTbMqsmFmZIVkE8b
         JGmn1iup+mmzUlG0JDz54vTeZVO4zICSwTTDJwLUv/U2Q/b1C8ZONqW0hk6aC5/28O
         WQO99GDtgm/b7h1wD6wOlJZuz9j+QdNLFfxHt/5cFWCDjFTM9GE0QGdhAxPK1/8+mD
         DnweiR83Wkflg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A620C41679;
        Fri,  3 Mar 2023 18:44:31 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jaLbB5Ems_SNY_Q8nnkMw7__68_J7=mXJUj6acmYmEEg@mail.gmail.com>
References: <CAJZ5v0jaLbB5Ems_SNY_Q8nnkMw7__68_J7=mXJUj6acmYmEEg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jaLbB5Ems_SNY_Q8nnkMw7__68_J7=mXJUj6acmYmEEg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc1-2
X-PR-Tracked-Commit-Id: 1467fb960349dfa5e300658f1a409dde2cfb0c51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a3f9a6b0265b64c02226fcabb5e9a958307913b
Message-Id: <167786907130.30023.1790088931397920249.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Mar 2023 18:44:31 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Mar 2023 19:17:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a3f9a6b0265b64c02226fcabb5e9a958307913b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
