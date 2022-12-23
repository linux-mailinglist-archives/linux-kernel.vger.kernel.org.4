Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F526553D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiLWTXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiLWTXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:23:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3A21DA7B;
        Fri, 23 Dec 2022 11:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEBD260B80;
        Fri, 23 Dec 2022 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B0E9C433EF;
        Fri, 23 Dec 2022 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671823382;
        bh=t9nJ7BAp80MwMz28J3ss7X9MjMt/WsYHLRSyz0EiNPo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tRntEyVbRNATg6w2YTL0LeX0B+w/AV7qwkcvxCZ+QY6zOJXDnjkVDp1dvsOGuo31c
         CrtsQ30WHPFxfW53shlAJGdKg4gq+NuK0WgZV+wtIPO9aMNGwewpHrSj7mBEpELPBt
         7tWId9PktF44KE/Ha+ndTgmRwD9eoLvAC1KnA3SnToDw3gk+W+u+/D0VOVMEmyTIRQ
         WjR5ztdc4/Bc0Kvq1YM3to1UZYZEemxFyuKHpcaUgpeeZ2Wtq3ym5YUsV7OY6ba4rm
         c2ZDlUWcjOZp0OXdEKpPnwbTA7Gih985P4BmjV+P16qvoEiPbnjtYnUwwddEWmLLUw
         UR5q3Appu5Skw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 186CEC00448;
        Fri, 23 Dec 2022 19:23:02 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221222144648.db034ee4087ea4bb126545ec@linux-foundation.org>
References: <20221222144648.db034ee4087ea4bb126545ec@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221222144648.db034ee4087ea4bb126545ec@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-12-22-14-34
X-PR-Tracked-Commit-Id: e96b95c2b7a63a454b6498e2df67aac14d046d13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 699aee7b47dbb1d3c30bf24f3c905eff366d9571
Message-Id: <167182338209.13713.15691286079310687616.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Dec 2022 19:23:02 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Dec 2022 14:46:48 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-12-22-14-34

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/699aee7b47dbb1d3c30bf24f3c905eff366d9571

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
