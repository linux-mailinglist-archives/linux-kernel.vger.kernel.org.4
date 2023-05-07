Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C641E6F9B20
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 21:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjEGTPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 15:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjEGTP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 15:15:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAEE13C28;
        Sun,  7 May 2023 12:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2547D61CBC;
        Sun,  7 May 2023 19:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7865EC433EF;
        Sun,  7 May 2023 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683486918;
        bh=uqqu4+9EOa2w9xo8vDdNyUe++sZfhXyV4IMflcNTXnU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rvkNAxccLCkIxY9r1rPPCIxUpSOTSLsBv2kpaMpTfilQQKnaZTeBDDi0nUxqvMBrc
         84qnHusdlwpITdJiz1n1X8SsN+OkJGemPc05gJkhBdt8Q4+BMhkWJhU+cy5rEXfpN/
         Cib33XHFWSNq4rKFovVf9edMaPI88xGgsT2Kw/HyW7HoIgzis7O3YKK2yYVENPhS8p
         w65xifWFV22xVofMJw6Di+hTsd8OWptNiqcRiPNQj7uDpsiIkJfPmotV5QDXuYBhfT
         1GZ9I6QD9cEJZNfPX/yVoTg0YbKQuWmjsiefDV2/XtUevIngvXPK0+DBHoX4wr1ypk
         QN4F8TZy1IUWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61F80E5FFCC;
        Sun,  7 May 2023 19:15:18 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230503211801.897735-1-acme@kernel.org>
References: <20230503211801.897735-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230503211801.897735-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.4-1-2023-05-03
X-PR-Tracked-Commit-Id: 1f85d016768ff19f060f3cce014a43c761de8259
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecc68ee216c6c5b2f84915e1441adf436f1b019b
Message-Id: <168348691837.15765.8609071749059546846.pr-tracker-bot@kernel.org>
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

The pull request you sent on Wed,  3 May 2023 18:18:01 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.4-1-2023-05-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecc68ee216c6c5b2f84915e1441adf436f1b019b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
