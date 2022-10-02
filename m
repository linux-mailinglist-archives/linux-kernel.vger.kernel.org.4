Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D755F243E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 19:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJBRUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 13:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiJBRUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 13:20:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACB522BFE
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 10:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B73B5CE0A4B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 17:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81249C433C1;
        Sun,  2 Oct 2022 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664731227;
        bh=NjM2uYa9HjU7yIFWj0QUEhOy6GPdA196Q4vdgvLZTRs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UJ1dzYyP0seeP0qfK45Kj+wxl8882BTZ/dJE2qeGXVL3oDLI2kVeFJT8cQKwxxeNW
         UGFauFYNypn6Gf+7ZQJlVwVYxg/UxNtJ1jFEivThPwlAaTw0QUPJqECsZzx0Z6UDdl
         FhSQfU/3GM8qrWcpskhcT5XFgBzYXDN6MB3yHm9dkub11zyIHPh5JtpvKqRAxHuP9U
         VsBWgxVJ06Ok338pKLbFa0nSRAy5u/+sXygCMGgNl/LacPd21ApDwOipPZ/X+wyMPZ
         Z9gC74Ccth+x5V45hOlUtRMucNU4GxULP2BuYGFHegqZLybJl1ZSyjUuh2GsZfro/H
         iKV7l1bWCK9Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6613EE49FA3;
        Sun,  2 Oct 2022 17:20:27 +0000 (UTC)
Subject: Re: [GIT PULL] perf fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzluYmeYjbxCr8wd@gmail.com>
References: <YzluYmeYjbxCr8wd@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzluYmeYjbxCr8wd@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-10-02
X-PR-Tracked-Commit-Id: 6b959ba22d34ca793ffdb15b5715457c78e38b1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: febae48afe6063105a0fad83d8e12a6addda7c6a
Message-Id: <166473122741.23668.8808987139744278249.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Oct 2022 17:20:27 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Oct 2022 12:56:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-10-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/febae48afe6063105a0fad83d8e12a6addda7c6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
