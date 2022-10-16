Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92696003F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJPWkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJPWkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:40:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250F12A25F;
        Sun, 16 Oct 2022 15:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AD31B80D5E;
        Sun, 16 Oct 2022 22:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CB89C433D6;
        Sun, 16 Oct 2022 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665960041;
        bh=c+VdxN+cDg1DvHCy28UUT2zGtw5aX1tww6ulIOuLuu4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GsiLZhLgC86Gev06yzJngGDUm6GRNyOwyynzvDErF58mAGeItES1JX/UEIAMsi5Tx
         +q0sI1JRsPhD5Gz4nouUEIQpwIHz2U7VP03Wya9mlJoxYJE3A+KSK0lA5x+NGL6Ngt
         bypFRGA/PI6WVhg9EydrpeF6Xswqniw9M96lVpH/grOvQcMbI2wLrXbJMqWsEgnDLh
         j/Msq6+bkX3qrekIar2jFvcRup1szUBtAENWyIe3ayka9ZVlM3cq2JqgD+Ag1gki9P
         X6lXrGT5TSDEjKZZIcO2qVIWO8QuFCQmE/n1KOqGtw+RY58KyO1eIsODhqK4J7viK3
         FyUvDNmOJ/boA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE66AE270EE;
        Sun, 16 Oct 2022 22:40:40 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.1: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221016120914.624129-1-acme@kernel.org>
References: <20221016120914.624129-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221016120914.624129-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.1-2-2022-10-16
X-PR-Tracked-Commit-Id: a3a365655a28f12f07eddf4f3fd596987b175e1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8636df94ec917019c4cb744ba0a1f94cf9057790
Message-Id: <166596004094.22130.16038059958193786423.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Oct 2022 22:40:40 +0000
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
        Ammy Yi <ammy.yi@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kevin Nomura <nomurak@google.com>,
        Leo Yan <leo.yan@linaro.org>, Qi Liu <liuqi115@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Oct 2022 09:09:14 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.1-2-2022-10-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8636df94ec917019c4cb744ba0a1f94cf9057790

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
