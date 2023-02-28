Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C499D6A501E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjB1AZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjB1AZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:25:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645761F4BA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:25:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EFF3B80DCF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8564C433EF;
        Tue, 28 Feb 2023 00:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677543933;
        bh=uqtNTePz6Sl/QcOVU1rzILaXe2O/AS0JXzjJgFAXFM4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OkDu04Ewa6UP2wE/Yxk3Zld2i6tQ0Rx6Od6q1jH2KFEtYYmBW813DtFbzXjtzDVpi
         Y+AEZV20U7E5D5Q6716otGKgvPppIv88p8C22llARbGHsOzuLYiUR4DVr2rhx2dgB7
         aO2+VinT/JIYefQppDMm8m19k5zQFA57NbXXQgZ10fjiVJW9FNQ4MJI3iqSIqb0BL+
         OqlduHVB0Suq+6ZmQ1jY1Oh/6pAQUBjOY8fKwBl7mAs4bidOUHiYXcry7UaG85fSYS
         l2bDrBWtZNSCDGcm6j1DGuAdnxzP8DmEl8zGOtR6MHBKCAKpH2Pn9VFrwEMOlSxj+E
         gSo9y6RoyrmeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF56AC41676;
        Tue, 28 Feb 2023 00:25:33 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs update for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/004is4VtYI7G2u@google.com>
References: <Y/004is4VtYI7G2u@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/004is4VtYI7G2u@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.3-rc1
X-PR-Tracked-Commit-Id: ddf1eca4fc5a4038cb323306f51fbba34ce3f4d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 103830683cfc8f43b15158b0a48014b6d6e83633
Message-Id: <167754393371.8193.15237019111319054864.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Feb 2023 00:25:33 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Feb 2023 14:55:30 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/103830683cfc8f43b15158b0a48014b6d6e83633

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
