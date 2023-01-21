Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF767685C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjAUTXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjAUTXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:23:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768E928D26
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:23:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0769B60B50
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D8E1C433A1;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674329018;
        bh=wDfxcBvF5tK0g/1mSWb64UOPRKJpQM0RgmA30MxX9+w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vPS9EmG+UYrXwMrQSl0lmdoUDevL1hDx01qN9GW38G6wnrnBrbEb8giXn8ixqjqPl
         Uwr3xpMGGBJJzkJ2OZLQYFFkM/gmLc4qFZ5Dy6etncTJLcw5o47x0WYwPPfb1P1GCR
         YSvhbsASlK653h7H1AeBC4kJ9OJKrnCMiYqEuChAaiwpBvoRqKbcd6GEYAbupFFKRv
         kEfTTpQUL8/hmOeniwqzTMn+ypekd7G0yJkNE2YFPiUxxG+uuse7a097qWC1p2p/8G
         C53mzzBdARAd0Dubd1pm2YohseNg5cPVCnwDyLJA6QKDzANH8G+ZlsvUP/iw7uHcoM
         PVgfVSgl913TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 561E7C04E33;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8wE+Zifm+0wcajr@kroah.com>
References: <Y8wE+Zifm+0wcajr@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8wE+Zifm+0wcajr@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.2-rc5
X-PR-Tracked-Commit-Id: 739790605705ddcf18f21782b9c99ad7d53a8c11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c88a3114706429c9edf89e0bf2cd6757270c00f8
Message-Id: <167432901834.17568.7267749958025064125.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Jan 2023 19:23:38 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Jan 2023 16:30:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c88a3114706429c9edf89e0bf2cd6757270c00f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
