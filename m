Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439A86F9B21
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 21:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjEGTPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 15:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjEGTP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 15:15:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D8283ED;
        Sun,  7 May 2023 12:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7720761CCA;
        Sun,  7 May 2023 19:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5168C433A1;
        Sun,  7 May 2023 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683486918;
        bh=YAOjSl2tP3Lsjq53byiNRcsv+04kVsi3QCikhWAwCZc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QTJZ3A6cgnh5Qs3v3yYt3JQc6GQl7WLinApgolw7sJLMN6OY5qsyy2FklX7hAXhJe
         JgP38iMViok0I+TYW+aPY239Ntr20EMtPmB9Yu5Iacqdg+0oYbqxCZ6dtdOJm5zeuX
         lHYuzEean2N8otxaXZf0mJMtEnnZx3t2DgBlwPfwU+x4fq3Qs1XNHIlLZ/iq9w0Wu7
         m9PuOLWBuNRicnRr0Q5qabKbaJGgCJNWJeKMSIJzd7zq8ELeSDZjBNEc9i/G4k3kbt
         yNCIPnl61i/XrxdTpomzimTAh3v6LnehUBUAgtx/14i0J5idvo0rTceztQCxJHD/Vi
         8Y4XQgL4vZJdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C01DEE5FFCC;
        Sun,  7 May 2023 19:15:18 +0000 (UTC)
Subject: Re: [GIT PULL 0/2] perf tools changes for v6.4: Disable BPF based features in the default build
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230506212758.1201184-1-acme@kernel.org>
References: <20230506212758.1201184-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230506212758.1201184-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.4-3-2023-05-06
X-PR-Tracked-Commit-Id: 9a2d5178b9d51e1c5f9e08989ff97fc8d4893f31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f085df1be60abf670315c11036261cfaec16b2eb
Message-Id: <168348691878.15765.10014396260629780426.pr-tracker-bot@kernel.org>
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
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  6 May 2023 18:27:58 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.4-3-2023-05-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f085df1be60abf670315c11036261cfaec16b2eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
