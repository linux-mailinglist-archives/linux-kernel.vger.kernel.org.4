Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777D064F1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiLPTo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiLPTo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:44:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834BEF02D;
        Fri, 16 Dec 2022 11:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 010EB62204;
        Fri, 16 Dec 2022 19:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5240AC433EF;
        Fri, 16 Dec 2022 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671219866;
        bh=BnRJbEfJx/6QLKG3XPWjqmbM1QmHG2gW+vKqM0IZHA8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oK7rjJCzkla8X7CqLGe1tBoiIJkkioH0bi7PAwhusitdl/uQHFn8XyxPN4Atyaex0
         +U3HU/TCp9EpEp+0rC2q00kb4FETPwhHjxzZ2Cx9OBCWTbKdI0X2X55aOUwbhJhtgu
         CN4XWEo9Ac7TljnrpZinEzGJM98ImUNMhbZg8FAbTbKPMzgiTnNB7T1jA9KciUY6NW
         kTJ6FOmHnOYQ7iYkGVjwRIYyIzcb8+6zT46g1REoV1uzKPpc7vzj/GqB9YSeY8JGmS
         VwkbRf7g7Mc64h8W1fI6QjPoSYfIpnRt9Y5ieA9fzyB1wEMKU/12JJbwAIDM7sWkgu
         3faw00kJJQSDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F244C00445;
        Fri, 16 Dec 2022 19:44:26 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.2: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221216143609.186415-1-acme@kernel.org>
References: <20221216143609.186415-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221216143609.186415-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.2-1-2022-12-16
X-PR-Tracked-Commit-Id: 4ff17c448a7b0f437a17622d67f1c5c609c3a0e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa4800e31c547ed00681318335ca2298c4bca33a
Message-Id: <167121986624.10318.16082027521907568745.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Dec 2022 19:44:26 +0000
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
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kautuk Consul <kconsul@ventanamicro.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikita Shubin <n.shubin@yadro.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 11:36:09 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.2-1-2022-12-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa4800e31c547ed00681318335ca2298c4bca33a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
