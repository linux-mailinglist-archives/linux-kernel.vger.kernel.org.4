Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7F16608BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbjAFVTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbjAFVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:19:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8324D81D59
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 13:19:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6479361F7D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 21:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC344C433F1;
        Fri,  6 Jan 2023 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673039944;
        bh=/8huUFCjuIyFqY1McKNe/kroodgfvyukd5xcoZ1Cqw4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q14wYnD7fFiYhHYzOOQhYA2juyOsLEkBjOIesuawGa03Iw1Il5BholfLSKtqHZYB0
         /UaCN4cbSkQwAiCjCxlzvF1XZMsuLI2NayGNywKfdxF7NqSMvgHBCHTXp6KOdPdv6/
         7Vvpt4ChKWTY9y86MBR6ma0VFeWk2/LPP16hDcVaF0bla16Eihpgb1ZWX8wCgDbfW/
         NteyFRMor0nxdAd8vSCjxRLJGAwDGoTrIYFO0afs+V6Za46DsrumqCeKyhmzhXnNAa
         p1n1tTl2TsaBRj2RMi3iBidZ6HkxHrqKnvka6lx96q9fWfQib/zpecPs3fMbY3Ln1n
         3D4sfVRcT4IsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A89A7E5724D;
        Fri,  6 Jan 2023 21:19:04 +0000 (UTC)
Subject: Re: [GIT PULL] perf fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7gMvFPLjvCv2Jx1@gmail.com>
References: <Y7gMvFPLjvCv2Jx1@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7gMvFPLjvCv2Jx1@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-01-06
X-PR-Tracked-Commit-Id: 57512b57dcfaf63c52d8ad2fb35321328cde31b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7a0853d650b381921732ff5bca618432a279033
Message-Id: <167303994468.10294.16435122099183401656.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Jan 2023 21:19:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Jan 2023 12:57:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-01-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7a0853d650b381921732ff5bca618432a279033

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
