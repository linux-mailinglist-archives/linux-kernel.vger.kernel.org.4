Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C0A6F0C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbjD0TUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245161AbjD0TUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAEC269F;
        Thu, 27 Apr 2023 12:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FC9863F64;
        Thu, 27 Apr 2023 19:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89314C4339B;
        Thu, 27 Apr 2023 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623212;
        bh=S9TvSveIhpPgxxbmig84vXb4AlGlP4k37of9iTaCeiE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RVvhEKr2brA7UbvVMmCaTN6HNNKsnrUOx+dxEWQFaTPC6+PvvjbQZJeDqUm06jA5o
         /Xp4k4zLz9/SIIG49uZz7e7tXOEmmLDHcHPUqZ31SONnLq2TJs1IuwD/VHaktFPPN+
         kSUh0egP8uYgFYV/R0tf9IWIip2f9aA/2HkCeB7S5tqjDlPSFz3rRLrGq89ydmT3+9
         eeVdI1+Qq7vT+kDCHLGxMVQSqU5inbzVArJxY+jbb5HIiiKyDPVTdQpbeAygEOGClg
         mv2f5zbPjF/bKDKcZnseFex45Qgk8429WJbbHU4Zhx7mTtt0HNptEFKUrBIN3NIagq
         M8Omr/x4TdGXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 667F0C39562;
        Thu, 27 Apr 2023 19:20:12 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEqElASSM07hTjHH@kroah.com>
References: <ZEqElASSM07hTjHH@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEqElASSM07hTjHH@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc1
X-PR-Tracked-Commit-Id: 2b3174c96696cde676393474f0e01d0d108462f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b39667abcdcc754e32a0eb0df9cf49d45333d4ae
Message-Id: <168262321241.21394.717021532706292851.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:12 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 16:20:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b39667abcdcc754e32a0eb0df9cf49d45333d4ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
