Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450BA6F0C81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbjD0TVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbjD0TUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE1F524B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF5063F6F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A436EC433A4;
        Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623220;
        bh=gdnDOxO912H1PJy0SeuOChABydoVlqNfcDDJhpOrjr4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FH5T3FjrCghFJaMhOUyq1J/rLluFGSVSKl7o8ITcPBspeCpwh6zzNNocqCyz3cRTc
         SON4kPTvADLs61/P2XVmztvXvXh+rdDfjOVS4lhh5ol4DS2+oxFZN7emz1lC76qauE
         Rb3F8nJSE5R5BSl06WGqEHiHjU+5BWjT/FG+jeNzKVT/7rCLBJOYzOqp2wzGFYKslY
         EmWsTsdEYpTo3nJvPAz+j4sLsYdI2SFP8r6TCX/ZhPGg/agS/dQDCXJjEKF5EukKnW
         dn621wANzU/+9q+ZEGu4Jt8DUCvTH2v4N8/pqE1zLrGJrMNYBBnWlo1Gn4gDukuPYO
         wVUmisWTwAChw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 935D5C39562;
        Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEqE4wCJDnMJbJRU@kroah.com>
References: <ZEqE4wCJDnMJbJRU@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEqE4wCJDnMJbJRU@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.4-rc1
X-PR-Tracked-Commit-Id: 2025b2ca8004c04861903d076c67a73a0ec6dfca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cec24b8b6bb841a19b5c5555b600a511a8988100
Message-Id: <168262322060.21394.8514134127702511263.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 16:21:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cec24b8b6bb841a19b5c5555b600a511a8988100

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
