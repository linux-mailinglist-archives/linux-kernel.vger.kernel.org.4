Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9B5711D21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 03:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbjEZBwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 21:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjEZBwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 21:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0246189;
        Thu, 25 May 2023 18:52:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C112164C27;
        Fri, 26 May 2023 01:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E294C433D2;
        Fri, 26 May 2023 01:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685065941;
        bh=WZkzC8eOvIL1gDqVA1b/tL0KaoLdWVjEve/8h6k7Msc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NoObV04Y3bYaU+Zc++EiVq/dvsHpdl2UOiHQdPKbtzALzBcVB4qkRwalprrAy6wSZ
         gPEhq8lfTPOHZi9fzq3Emozh8dpE258uMoQvls1ITkAM0x2cO4Wpwz7tTg6LJagBJv
         27IkayWLCuXJl3+wExj1zC8q11DDKFNWb2YeAAPr7P6ODXrtb1Z9EFk3FwMdVDFmoM
         J4IRwn8V8xrdtbTAj8ZoQ4je7982Dslj2Slr6TvV8jIXdPO0dLiFu4ls32uL4mVsPD
         JmGmWwqFrkdT2rEUq9ZVH6KvqQV2LttziihiyoDdvs5LnbKIkTJRcxyfM/rheJ7JXj
         KpHfvkwrUNfjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B912C4166F;
        Fri, 26 May 2023 01:52:21 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZG/bQ/x4YOSPEdu0@p100>
References: <ZG/bQ/x4YOSPEdu0@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZG/bQ/x4YOSPEdu0@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.4-3
X-PR-Tracked-Commit-Id: 61e150fb310729c98227a5edf6e4a3619edc3702
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 192fe71ce5d17b184423b96d76ce648e1b848db4
Message-Id: <168506594110.25050.18436345272585659427.pr-tracker-bot@kernel.org>
Date:   Fri, 26 May 2023 01:52:21 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 May 2023 00:03:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/192fe71ce5d17b184423b96d76ce648e1b848db4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
