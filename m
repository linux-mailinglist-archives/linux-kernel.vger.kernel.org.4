Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE75F639D01
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiK0UuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiK0Ut5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:49:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354CDEED
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:49:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59BAEB80B55
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AA41C433C1;
        Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669582194;
        bh=aFdXULQsYxCyHaEV/zh7R10XVIXb/mAtz/DZ5wkjH2I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QiFYQfm0SvXkqm6MmyICDqutwj3c3rpHAOId/n1WRRDZg0Kqk9T88H7NQ9C0a8q/2
         kPp0pQ50rf0PhykpmVoBMzk9YEDqka3AcQIWPeZ18gd6HIfJTj4eXaxzAavGJXkYiV
         wIQOuSUidTmLOyD2Qzuj/G3PUFMtG3MV/Mgvd/zEor5dswnKJ75JCOrkodg6Ib/1D3
         2xbrlL3AdJbKPjPmpKNsDMfacXMBSCDVGexoE2xxebqdLSMnwJ3hylbufFrasi5YK8
         QvgfFEg0s3+4+yy6+VNcfVRUXc3jHYKEbwHWBCpKTEKYMz/uPOZN0VHV22R6loS+dv
         NldvsEQcutKhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F08BEC395EC;
        Sun, 27 Nov 2022 20:49:53 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4NAIQk1VAPoC/vx@zn.tnic>
References: <Y4NAIQk1VAPoC/vx@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4NAIQk1VAPoC/vx@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc7
X-PR-Tracked-Commit-Id: 030a976efae83f7b6593afb11a8254d42f9290fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5afcab22179e4b4668e2df4759cfd71f09d2b503
Message-Id: <166958219397.7005.10642720848601002452.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Nov 2022 20:49:53 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Nov 2022 11:46:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5afcab22179e4b4668e2df4759cfd71f09d2b503

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
