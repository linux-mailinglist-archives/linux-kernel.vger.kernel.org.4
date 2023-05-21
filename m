Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4370B09A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 23:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjEUVFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 17:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjEUVEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 17:04:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861D8E;
        Sun, 21 May 2023 14:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E0A061044;
        Sun, 21 May 2023 21:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FCD5C433EF;
        Sun, 21 May 2023 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684703089;
        bh=DkGQpLOt+hWu0WQCzLJouI6MlIltmC9SOTub9Y7Rivw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bKnl67MuV+k8/pbtDY+KcNkWvMCnt5WcwgxyupJQUxKCoLp3DYV+yjy3QdjqVUYht
         /9HiMIv2n4H0V4M4mUsi9w7jywqtcI7SuVS5rfXEpICuAJ32fUpGAozGDuHccFgVGH
         0n5r+VooNrLnV/fuf+NwUWOQ3qUsAXf9Itqc+ULkJw9lMq3l7B1RZ/MfqmKLNM0/bH
         h6LIyAr1A4YnpVvp+RTXIhZ5GE1Dzm1/6EC5JgwjvEcAP5cZ9xhHcdxzHxNucFCAOF
         j+lAKllN09GD5KdD/QtmEc6nl17U8GCTSa4BIuXZBQxotHOIRQa5uFakp2lQPzXcSh
         HSflITKc+Y1zQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B81CC3959E;
        Sun, 21 May 2023 21:04:49 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230520184731.1690465-1-acme@kernel.org>
References: <20230520184731.1690465-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230520184731.1690465-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.4-1-2023-05-20
X-PR-Tracked-Commit-Id: 4e111f0cf0ee973ce7e7e012b4ceb07867d2dae5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c47d122c5ba5f3b3371cfe051d770b5bbd591f6b
Message-Id: <168470308949.10838.382383903499705129.pr-tracker-bot@kernel.org>
Date:   Sun, 21 May 2023 21:04:49 +0000
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
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yanteng Si <siyanteng@loongson.cn>,
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

The pull request you sent on Sat, 20 May 2023 15:47:31 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.4-1-2023-05-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c47d122c5ba5f3b3371cfe051d770b5bbd591f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
