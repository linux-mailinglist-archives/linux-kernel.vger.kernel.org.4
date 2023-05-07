Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E986F9B1F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 21:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjEGTPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 15:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjEGTP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 15:15:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B53C33;
        Sun,  7 May 2023 12:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C4461CC5;
        Sun,  7 May 2023 19:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEE20C4339B;
        Sun,  7 May 2023 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683486918;
        bh=uAkBkpziuUWcOgdfZLvVqNGAnIysDNBbHL+PBQ11zjY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YZVheqeHlApuC95UrfRFT36ijSQ3FpBqpfo7Do3pNzrD9iJkLAHKLHjhYIrutVeU3
         XqYkMNAYPYy8zJdfRDfGBNlkmTB/aZMRxuCFneFFHE0jfitvXwlLkbjGQi33y11It1
         h9pVIsJ2AoGShIO34+D2YzRPHkHEN/FBMta3WYXgf46HVuPLp79+wNOH4OxiQBLx0v
         yQrVximKokgxEi32POH6pu2e3AbTNPwUZ7+AUh2a1qgcmEEeye0Pg+GMI5607pvri2
         VDBffVPBrIseco3z7O0CPzl6q2ZhMsIU1tbNkIZi9dEYtIkxOQPr3wDOfo0A54j1hT
         8vtuILDvPeTxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9408FC395FD;
        Sun,  7 May 2023 19:15:18 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.4: 2nd attempt
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230505230831.1084855-1-acme@kernel.org>
References: <20230505230831.1084855-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230505230831.1084855-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.4-2-2023-05-05
X-PR-Tracked-Commit-Id: 6c73f819b6b6d6f052e8dbe3f66f0693554ddf48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3e6df97fa25ff310c3d5e7f1644248e072e3cb0
Message-Id: <168348691860.15765.16548461476435203750.pr-tracker-bot@kernel.org>
Date:   Sun, 07 May 2023 19:15:18 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  5 May 2023 20:08:31 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.4-2-2023-05-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3e6df97fa25ff310c3d5e7f1644248e072e3cb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
