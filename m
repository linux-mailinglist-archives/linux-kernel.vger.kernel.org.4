Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD50A66ACBB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjANQ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjANQ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:58:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3518A30CA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:58:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C28FA60BFB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 16:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25766C433EF;
        Sat, 14 Jan 2023 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673715521;
        bh=ys0fWZz1eoacTuHBDBBahYVuGFjQpnMyP6+JdJPTsNI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UB0iqWEyVMCkwaVjJtN25D+6uofgivMryT1XrOHBWDMW4Ra95KLN78++usi78o5Hj
         9m5oiI215KsMPW7nQNoJlRsjKdQilyaPrQUjQdEFAIiYmnasi9IIwccwGFywHVNBoe
         zUB7I25C0YOOSEQkgZG+eHrHtqZvnJ1wiwPk/6br2vAQ+50F3WbgPkOnZLO3mdumL6
         LTdtMiexhFcg4WoqSPEB44V/VPR6Uyq+UGm90/a0DuN9mjpOw4BzJmPmENWo5nkylr
         akk44EMAbpeX19HXFFitaW7kAmeAVZ8OxZX34xY9D256Kj1jE10M75se0gxVwN//K7
         2+DhkTavN5T8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 042DEC395CA;
        Sat, 14 Jan 2023 16:58:40 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8LYARivqaRbWWja@8bytes.org>
References: <Y8LYARivqaRbWWja@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Y8LYARivqaRbWWja@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.2-rc3
X-PR-Tracked-Commit-Id: 142e821f68cf5da79ce722cb9c1323afae30e185
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c698440524117dca7534592db0e7f465ae4d0bb
Message-Id: <167371552086.22078.6666131430289552808.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Jan 2023 16:58:40 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Jan 2023 17:27:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c698440524117dca7534592db0e7f465ae4d0bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
