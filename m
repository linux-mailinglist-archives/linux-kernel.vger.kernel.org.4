Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB81F6F0C78
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbjD0TUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245138AbjD0TUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E104EF4;
        Thu, 27 Apr 2023 12:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEC2163F60;
        Thu, 27 Apr 2023 19:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B6BCC4339C;
        Thu, 27 Apr 2023 19:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623209;
        bh=llgbZY8QBJvHc8W2Po9uvZOLTiJ4fKPIqNmux7EuE1s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YCi6mS0OhIwH4k9UkAahoZK4W8wdx++nhRLE6B7O3ieP7h7NGLFiLUaJGZhKAAl3r
         T091CcW5jHGYWV8vUwiVSbCRNx/37Gfrz6iOPNTsumwGOjNIC67SuQmzinKFjju0rd
         TH/MZ9oTgxMuMpGWbRYDQwRKmZFG0/T1E3eLPpqJhyODkDprELypAPPpYy4QDL13Sa
         5MbWyt15ylxSI7RRHNnIa5s/f2DF2bwVDfVeHYaCt1jMlddFR8uBb6Z/SYUgpKTTl4
         efClEsVzpeThAv4R4dyPUHhNB5pmSkkmY6Vg0wyS1fSCKIoPoQ+qvxcDuYaBORf/C+
         ORBWj5E6yHKWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AAD8C43158;
        Thu, 27 Apr 2023 19:20:09 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZElwB2/zlXli1QwA@ls3530>
References: <ZElwB2/zlXli1QwA@ls3530>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZElwB2/zlXli1QwA@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.4-rc1
X-PR-Tracked-Commit-Id: 60ed3cd85b95184936bce70ed7f9e76a6a54a5e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 725a345b2ee3c24f9ac2078eb73667e22a1b7214
Message-Id: <168262320910.21394.8747899965112171337.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:09 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 20:40:07 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/725a345b2ee3c24f9ac2078eb73667e22a1b7214

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
