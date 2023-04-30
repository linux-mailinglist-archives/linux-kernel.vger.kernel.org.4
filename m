Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9910A6F2A98
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 22:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjD3UIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 16:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjD3UIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 16:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75AD1704;
        Sun, 30 Apr 2023 13:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D70F360F07;
        Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44845C433A4;
        Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682885290;
        bh=ACFD4nFAhLOtt1ILRC7shd8FfWrC+EiL4EOG0rhTQ9M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jVViklDqHNnpgWWam4Jf++qNyZlZ5/pe2nV5+YdnMcbqS5cHpOSL4LewerMpb1REd
         kHO0bwwvP9VSEiRFejskDva5vRWWfiLS0wq6tlmjm0FbnXGf8pAy2+aX+PdWQScBNv
         9Z+YqmHFHf9UM+/mab64WstSLUyBWPXpuvRsZbThRV40v0KxGcuRZrD92gkF7IIUvY
         haJqeUjDAYfaJpzClMpJLK6F9vgTRJnZF50X3V3Z3tr5hg1xp8bCSOXAbSLY6goHL1
         XETqhFmWgAjTmDjnD2BCb6zpxkFRCdRMvmX05b6tSd3OugiADQ+vLjNBslALsNpeTM
         6MO2Nzxfc1nEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 316B0E5FFC9;
        Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 6.4 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01682795822-ext-1971@work.hours>
References: <your-ad-here.call-01682795822-ext-1971@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01682795822-ext-1971@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-1
X-PR-Tracked-Commit-Id: 2a405f6bb3a5b2baaa74dfc5aaa0e1b99145bd1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10de638d8ea57ebab4231ea077bed01d9bade775
Message-Id: <168288529018.32747.4661589673096626414.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Apr 2023 20:08:10 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Apr 2023 21:17:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10de638d8ea57ebab4231ea077bed01d9bade775

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
