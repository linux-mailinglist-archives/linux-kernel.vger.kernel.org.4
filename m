Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5FE68AC2C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjBDTzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjBDTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:55:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2904A2686F;
        Sat,  4 Feb 2023 11:55:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF40CB80B66;
        Sat,  4 Feb 2023 19:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E3ABC4339B;
        Sat,  4 Feb 2023 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675540508;
        bh=6m29Sf7npCc/uPtLyJukglsUgzrcjmdjODnW12U8il0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fUQTOpBG1eFjWzXfcxishpYQEpLuSCsRL8Y5w5vVFewPXycjwgWfPS7TLpaQ3WLfp
         9qhuIR28CKhvaBNFupZEAnahoZirfQoyakS9ukoCriQY3B9ndbmnRGV1rfoHeoZmre
         X88If/iOs8UJGdeMzvWloJo71hqi32+m8v910CxbV9V6yeG8F7JRJIc4xSBbC8PUEq
         ZWzzq+5ppRULVv9RclzU5VLyyLVAG6Ve0+Owo7ZGYzYM0zbG1LfWZu9holUk99zVKg
         0s4ieXH3co5iS0bWW8+OKapvmKOm/a7kxBPnTcYsmDSDysppASYuo64ODHXXx5m0g6
         QZg8m21KPP6mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68423E270CA;
        Sat,  4 Feb 2023 19:55:08 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y95ubeJ0b96rw/rS@p100>
References: <Y95ubeJ0b96rw/rS@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y95ubeJ0b96rw/rS@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.2-rc7
X-PR-Tracked-Commit-Id: 316f1f42b5cc1d95124c1f0387c867c1ba7b6d0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ab2ba494db2dbfbb541ae27f69317e1c089ea51
Message-Id: <167554050842.7014.688752023257968052.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Feb 2023 19:55:08 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Feb 2023 15:40:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ab2ba494db2dbfbb541ae27f69317e1c089ea51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
