Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526D8639CFF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiK0UuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiK0Ut4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:49:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB6DDEFE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:49:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC03160ED1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B7E9C4314A;
        Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669582194;
        bh=pzaDp5IbK8+/319XmhPmITMB26QHkL9WUifhU4719wA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ULBBd0oY9drF/c4UUlHKHHkDZjPB5xhFGODgHCl/53hRHxIk957xCKV5Pds7X1msW
         hGaJ+CaAmpHeTErn+TKWhOu696K9IyIMvZC3I+wk3DrUaoir+VZN+yjflS4zYQYIv/
         kY4XEWHZ807Dyi2ltVW6sZYHXawLHLBlcguJWqOWBjF+2KXBBnuhq+GJ8D6yEXYtl2
         hCbaFh5n1arhcCGUhK1a7Fy5vOO4F2KsGwx/ldvHZFV8R9lcy2Njzy5kl9ot8uNy09
         Oj//AkwmQiDitQ7td/hgAaO+WHZoUSiv6GDYurJ9YxrSZsNkc7GgIHau3Qcc9UzdV4
         vSngA1lRkmyUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35C9CE4D012;
        Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4Ns3bc9AF2L1Bw7@kroah.com>
References: <Y4Ns3bc9AF2L1Bw7@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4Ns3bc9AF2L1Bw7@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc7
X-PR-Tracked-Commit-Id: 8ac3b5cd3e0521d92f9755e90d140382fc292510
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db3182484f9fb472137cc9a3c41b3d69530b40ad
Message-Id: <166958219421.7005.4984122785017078415.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Nov 2022 20:49:54 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Nov 2022 14:57:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db3182484f9fb472137cc9a3c41b3d69530b40ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
