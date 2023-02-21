Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5650069D836
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjBUBxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjBUBw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:52:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15835189;
        Mon, 20 Feb 2023 17:52:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1C4CB80E5E;
        Tue, 21 Feb 2023 01:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5763DC4339E;
        Tue, 21 Feb 2023 01:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676944366;
        bh=fv3qodycJj9UNRkpwOvoyfOnB5Yl4H5j5KP2cQ5gPn8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GxoHntHur+UmXTKgdY/sP+3oxqCtNqjZ4sUcQlMuNSfJKIE8ktBfPdbEs0z/H8bVR
         iYYBjWv81uidhbQNB2j8wJVVPRTKqf2SzpG+T4CeZ9Bc2XDrJUcdw65y0gNKfRGz4/
         LBSI1pGq3ljW4cI9VbjoSeieP1Z0KdCNvQ6RndTKV6i6ja2uKlbB2gqMoDicsLTh4/
         OS72ux4wvAl5j6PrHfIZN003M68d78Y96ftohgBtxY1xZIELDFnDMrsGi4O562bGPe
         tbCXIVozEOK1R8rcyOxMRBNWjeleaXhOqrU4G8RG6n0Axe0fXFb5S6iVMyAHpl34Cr
         U6T6d5guIN95Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4174DE68D20;
        Tue, 21 Feb 2023 01:52:46 +0000 (UTC)
Subject: Re: [GIT PULL] perf event updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/NpFhW0JUQAmMn3@gmail.com>
References: <Y/NpFhW0JUQAmMn3@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/NpFhW0JUQAmMn3@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-02-20
X-PR-Tracked-Commit-Id: c828441f21ddc819a28b5723a72e3c840e9de1c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2f0e7eee1344eb9f91b22bc72d9eb0a52b849c9
Message-Id: <167694436626.8087.10663939862415611519.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 01:52:46 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 13:35:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2f0e7eee1344eb9f91b22bc72d9eb0a52b849c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
