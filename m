Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681D8641FD6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 22:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiLDVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 16:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiLDVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 16:25:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B2013CD2
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 13:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E58EB60F0B
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 21:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D41DC4347C;
        Sun,  4 Dec 2022 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670189137;
        bh=Bi/TRXssAwVsJltOWPA8sXA9cwUUdSfeP8tnEuvZVPw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qRpKoCM4Uwv/DACgaT9hfy3vX7t87xeOQMYtzuw6bTVK2rfz9z4pt9xwnL3a7xSFN
         jIdEOSps113UvROo1YGZGXnsOpmQm9XZPR6MFiDAWKoLa56nzK0/qcllZUDOjIYCjn
         iX2aRfDW+f0BXT1PpNd2wo4Fo9UNhzfZm3opVOtadgqTtgs+v9jxYViBKsacTcIoEn
         mU2AjVtUH4R2pm1cqv76D16yoXMcyEex7rJUG0zHsg5dwvyrzR+Si07syK6ateaZHe
         oJuq9L/vUDQ9HjrLZ++JttOEKNsyT/rs3SXCHfcRMir80rw9lHMzBB81QE0P0KLmFV
         9QMKFSL6AhUsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A1EDC395EE;
        Sun,  4 Dec 2022 21:25:37 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for 6.1-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4yo4EiAIGASFgX1@zn.tnic>
References: <Y4yo4EiAIGASFgX1@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4yo4EiAIGASFgX1@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc8
X-PR-Tracked-Commit-Id: 517e6a301f34613bff24a8e35b5455884f2d83d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c3b5bcb484a659dd14466f92a073b57b2d3c1a5
Message-Id: <167018913723.1549.5949629667762666402.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Dec 2022 21:25:37 +0000
To:     Borislav Petkov <bp@alien8.de>
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

The pull request you sent on Sun, 4 Dec 2022 15:04:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c3b5bcb484a659dd14466f92a073b57b2d3c1a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
