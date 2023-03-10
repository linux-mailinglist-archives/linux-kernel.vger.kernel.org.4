Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0236B4DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjCJRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCJRBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:01:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F97F138478;
        Fri, 10 Mar 2023 08:59:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3923361C4B;
        Fri, 10 Mar 2023 16:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91C8EC433EF;
        Fri, 10 Mar 2023 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678467490;
        bh=HvKSjgc8xm5MQmFtQ0pWjPznonliO0hZJ+o3bPqEMRE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oNustNJPDyJG5lmwwzSlQfknYoCWqPoeFi5XdOny69w7QyfZwOvRB59ipqhVcsMwX
         kyFumFgJ3YoBbn2Iefj4HelryLJwqlJcEm//2sIWQlJofvotYSQ382peRxy7LKxfTI
         oyDKmH+CdxwgywDvWwtBm8vf+kOcTfK9ZXFIbgUXsOOwYJ4nJb6bqe5LXW92ySdtFd
         Z2IXTEVDX6CvyDgTb6Qlvz43KwuVB2ov9sZovYIfX0WFvi7AYwuI25K08TPeVHCl28
         4RJJyVQgl5mbETYPeV8yd3xR6lnMTre35Wf7gPzAWz/hTgkIyGLnHwIlGYkvrqejv5
         P1yuvNgeSX7WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F9C5E61B66;
        Fri, 10 Mar 2023 16:58:10 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230309211346.904516-1-acme@kernel.org>
References: <20230309211346.904516-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230309211346.904516-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.3-1-2023-03-09
X-PR-Tracked-Commit-Id: 5b201a82cd9d0945d70562974ea6ad8e3b1861b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49be4fb28109b86a8ffe117415c306389a394cb2
Message-Id: <167846749051.19444.13219709751894919700.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Mar 2023 16:58:10 +0000
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
        Changbin Du <changbin.du@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  9 Mar 2023 18:13:46 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.3-1-2023-03-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49be4fb28109b86a8ffe117415c306389a394cb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
