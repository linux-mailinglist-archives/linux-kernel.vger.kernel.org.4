Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4D65A612
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 19:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiLaS12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 13:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiLaS1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 13:27:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA57EC3;
        Sat, 31 Dec 2022 10:27:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6882DB808C6;
        Sat, 31 Dec 2022 18:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31F9BC433EF;
        Sat, 31 Dec 2022 18:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672511242;
        bh=fFVzLp/hMVufNUYRf4SvA+hxNaHYHNGfWb3C568M5Rc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mYrTG/HQ6bEnWJx8wnta7tVJ9xEK92Lp9oxZ7GPm700X3IJOqCqg19CAbcDNUcTVF
         5Oq5Vv6A2F0GB1wWR5UzdRp93N3JIG5cORNO+OZjrLEn8BABBdRJx41eGRSGfpreWk
         GnAvm8cbXCXjPVCC+92fOqQh20xHJY8lWFmSDZFleIoZWWuv6Yata7uRHLiuuofCXY
         /i5K+OnbuaL9VOXWwQo48Hxfk5JiWKKAmc8YpI2KGqsZS1K411F0tfKEmJXCQ+EhnQ
         9Ju/j1i7+81O0ty9oYxm14cYJpctZsi2vRBaWfayA7lszftz7/x7HIYoM0ZG8oQGci
         T7A+79DyuHBpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AEA0C43141;
        Sat, 31 Dec 2022 18:27:22 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.2-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQ66CwHVH+vvqkaRqEn8M46bOSFhyEAOdQfcKeWLxUTUA@mail.gmail.com>
References: <CAK7LNAQ66CwHVH+vvqkaRqEn8M46bOSFhyEAOdQfcKeWLxUTUA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQ66CwHVH+vvqkaRqEn8M46bOSFhyEAOdQfcKeWLxUTUA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.2
X-PR-Tracked-Commit-Id: 6a5e25fc3e0b94301734e8abb1d311a1e02d360d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4cf7c25bae5c3b5089a3c23a897f450149caef2
Message-Id: <167251124210.7119.10098922203239177606.pr-tracker-bot@kernel.org>
Date:   Sat, 31 Dec 2022 18:27:22 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 31 Dec 2022 22:22:33 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4cf7c25bae5c3b5089a3c23a897f450149caef2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
