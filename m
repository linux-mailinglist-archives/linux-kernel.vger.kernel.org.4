Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1C6A270A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 04:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjBYDkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 22:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjBYDkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:40:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D65B6EB34;
        Fri, 24 Feb 2023 19:40:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 346B1619CC;
        Sat, 25 Feb 2023 03:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CECCC433D2;
        Sat, 25 Feb 2023 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677296423;
        bh=PVmZHIicn/RdailN6+/WGuKSmh+NZNSCT27Jb8e0zY4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r7RQGzVdUZj2IjrMeKOqDJnuODaBG9nGBopU7EyGymw96SGu3zxlHg4+GcF5EUIMD
         yZ2u5Wz73O4Ti5JNfISEsM6KzQnhbick5wuTi5bt1NEK62MezSaxpz0fduGN03hT8P
         dcwLoOscJeLM8fLZKIAE8rMsuLsubzJerbfnj2aHSBzm0hxJKT/ITMo4nnWJFvizxC
         E8a8DVLI0fFtRw04yv4Amking+QaecVoVs9pEhyGAUmzpGtLgQuGrtQ5htv08kfxt+
         8myn6tkPuSLFFx2N2qhaqx6zyfM7qhbI2R2g2WRzYWy9PGNUfwKt562B5+blAidaW0
         MJ/JfjmhUD31w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89E65C43157;
        Sat, 25 Feb 2023 03:40:23 +0000 (UTC)
Subject: Re: [git pill] vfs.git alpha fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/gvQh5+4k8y+IdF@ZenIV>
References: <Y/gvQh5+4k8y+IdF@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/gvQh5+4k8y+IdF@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.alpha
X-PR-Tracked-Commit-Id: beb9797ee8b0c19598ffccdfae24afa6e0066f6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10cc5d483ebc00e82d9a38d3419b2edc8b79b64d
Message-Id: <167729642356.19216.15347998468562553343.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 03:40:23 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 03:30:10 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.alpha

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10cc5d483ebc00e82d9a38d3419b2edc8b79b64d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
