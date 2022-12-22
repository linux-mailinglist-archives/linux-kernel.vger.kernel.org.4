Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2289B654695
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiLVT3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiLVT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:28:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1A6248F4;
        Thu, 22 Dec 2022 11:28:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B94C61D43;
        Thu, 22 Dec 2022 19:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D64E4C433EF;
        Thu, 22 Dec 2022 19:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671737327;
        bh=MUeB0rYcxx+chXDaIoYXhIqUO/+caG17xssga2eVpD0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dhQfy/UKl6qrhKXOwV2+vIdXIqBfTCtxmZkrw+UrXPwYWLPbLvGyXMbBjGPU8Sfd1
         bZhp79JPg5E+U0EOVltrb1NK7fmgegcHWLvFL+cyYFs7enMvznf4PiOi0I8o8OPm3/
         fBIP7p5Crm5SnZELuYBTHk7S+yYCPLPnhVZ4NnowG25oYK8aEMzP7W3tFkE/19Jco5
         IcHENmm5b6AI9T9JzUJPVHGGbO73qZfD67r1RjLPP+r9OhLgxrGtAPJMiXahW5CT06
         fsiaPujLXYJLGsgbxWoyKyu+VKpbtKLFt2rjxEdUTB1i8uF/ICmwElSV5ZRP391LQ0
         KNdwvg61CODlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C322CC43141;
        Thu, 22 Dec 2022 19:28:47 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.2: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221222164914.508929-1-acme@kernel.org>
References: <20221222164914.508929-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221222164914.508929-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.2-2-2022-12-22
X-PR-Tracked-Commit-Id: 09e6f9f98370be9a9f8978139e0eb1be87d1125f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1ac1a2b14264e98c24db6f8c2bd452e695c7238
Message-Id: <167173732779.14570.14395787931706934186.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Dec 2022 19:28:47 +0000
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
        Changbin Du <changbin.du@gmail.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Dec 2022 13:49:14 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.2-2-2022-12-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1ac1a2b14264e98c24db6f8c2bd452e695c7238

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
