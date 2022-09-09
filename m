Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EDC5B36E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiIIMAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiIIL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:59:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F64A5AA17;
        Fri,  9 Sep 2022 04:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06F26B824F9;
        Fri,  9 Sep 2022 11:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B35BC4347C;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662724793;
        bh=q8qb4HTSazpfnRVzkkknH5aVK2E2DTfL9RYzfyWoZaw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g9UjVZMQfSgWjmklKORT1Jjqb6MDPR1R7dNF0UIRuHld3PJXuyXV6FIwgB3zRIPVY
         dQos3TuNQ3e9P9XJh5D0sLfue4j2kqv13jz9Wj/QA1Nfwti7sJbijFwUjuplg78Y+f
         aMll3qFANoWZSq2sEzJKzBtuv64m798eByustrrPZZdg9Bo4XyhsB0rxIszY/LYDTU
         alSnXYDeiEUjlBeBCtBFgJAM01PcRqJr+ZZXucggo4fY3TPrJcc1B2Si7ggLIJT3vh
         WKKop8d+NkZd4CLmslNku3ZdMWhWVXxkslBPx93lV7X68GazII6Z+7AHtBvZ324bi/
         mRDgZ8Zncp3og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82BD6C4166F;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.0: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220909001054.1415163-1-acme@kernel.org>
References: <20220909001054.1415163-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220909001054.1415163-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-09-08
X-PR-Tracked-Commit-Id: faf59ec8c3c3708c64ff76b50e6f757c6b4a1054
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8a450a80ef1c858c3095180f75284873d8297e8
Message-Id: <166272479352.31182.127311350797922431.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 11:59:53 +0000
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
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Hongtao Yu <hoy@fb.com>, Ian Rogers <irogers@google.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        =?UTF-8?q?Tom=C3=A1=C5=A1=20Trnka?= <trnka@scm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Zixuan Tan <tanzixuan.me@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  8 Sep 2022 21:10:54 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-09-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8a450a80ef1c858c3095180f75284873d8297e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
