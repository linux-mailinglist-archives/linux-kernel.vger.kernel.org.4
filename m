Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A0464ABB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiLLXpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiLLXp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:45:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D4EE07;
        Mon, 12 Dec 2022 15:45:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8B2DB81015;
        Mon, 12 Dec 2022 23:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D6D8C433D2;
        Mon, 12 Dec 2022 23:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670888723;
        bh=DV6kkMjg6wts/eVwIwH45XSekEDS0cLnyHaHiluBHec=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RcvBOvrjtbcDNSVb6plQRnBkY1WgygAbIsWwF11OuBO5r/dydDZImckY7mEBamiET
         59l64I5Sr2ZHAvGginticxtbUZTsmaqr17/Qypllw9d7TJBj7QUwaJicR7tEZffKf4
         isA8yoQw2/+mdyJsfkO8rHJ9aV1XCf2ZD88x11cneQn1ksPS6kWMfkJWnexHUJYKHa
         V2p32wO30ZxBs4luTwkDu1MUqWHpi10w0EIUbQX+dT1l8zdHtbrOplfM9kg2HzcsOr
         hT9whA5v66BtHMfYxSDlV3THebxY7rJV/3vQvsInmTwi+Wtvy443lrseuKMbXuQ3VB
         ZJK035DCvv5sA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78852C00445;
        Mon, 12 Dec 2022 23:45:23 +0000 (UTC)
Subject: Re: [GIT PULL] perf event updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5eQeR2tpZ/Bos49@gmail.com>
References: <Y5eQeR2tpZ/Bos49@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5eQeR2tpZ/Bos49@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-12-12
X-PR-Tracked-Commit-Id: 17b8d847b92d815d1638f0de154654081d66b281
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: add76959575736c194b3118d96e43f8cd7bcec82
Message-Id: <167088872348.9522.13892979199477218831.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 23:45:23 +0000
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

The pull request you sent on Mon, 12 Dec 2022 21:35:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/add76959575736c194b3118d96e43f8cd7bcec82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
