Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DC264EE69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiLPQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiLPQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:01:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A4A70B8E;
        Fri, 16 Dec 2022 08:00:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5505562163;
        Fri, 16 Dec 2022 16:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27299C433F1;
        Fri, 16 Dec 2022 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671206410;
        bh=QKBX8e/smCfnaCFSynF3es/bTxDiYc9fMRghta9Ho3Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q0Qt4IwD04kzuHje76vY+cfIQEBsYfkcq8F/EN6NucxfkeN3fAgpmRXzVVLFw2s4U
         U9GH1rFNwIBVWWbWgNCbQqg2iLg1Km42IETJ/5SPjcv2hKKDpQ5fKQQ1yD57mC/fz5
         mh5haRXxUwcVG4FQwXzsO+NZVgQzKALh1IXjPZkVkbqGO07UytsdVZtojFdVUum5Sm
         rNouuV3uHiRWyNEcmX8AIX/tZu5rlm9QXTzm6zu/QCsq/23DfB6vQ6ymdPjULKUlS1
         2DhqTXtOmdZ6vZxpM0/KOa2xNvZPIO5ZcWHTSnDwQbosQwbPHp2OCrTNVRYZ9UVdP6
         Thc0vNA+bQ+ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D4B2E21EF8;
        Fri, 16 Dec 2022 16:00:10 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5wv/NvQl6MfRTSu@kroah.com>
References: <Y5wv/NvQl6MfRTSu@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5wv/NvQl6MfRTSu@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.2-rc1
X-PR-Tracked-Commit-Id: 6373ab4dfee731deec62b4452ea641611feff9b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd6f9b17cd7af68b6a5090deedf1f5e84f66f4e6
Message-Id: <167120641002.30725.12650684841124129905.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Dec 2022 16:00:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 09:44:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd6f9b17cd7af68b6a5090deedf1f5e84f66f4e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
