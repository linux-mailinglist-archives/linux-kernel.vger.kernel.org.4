Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D0716F91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjE3VTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjE3VTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823A5C9;
        Tue, 30 May 2023 14:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B2A6338E;
        Tue, 30 May 2023 21:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDD1EC433D2;
        Tue, 30 May 2023 21:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685481569;
        bh=MP7q+lNYKFJ63yY8RKR7AjDujqQD2VMMzCdtQ8ySDRo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VtraeqWqAqCvsEQnCUwmchC9VMEbXYWMDVwYImuLb8QtBDpQ5xah8UKxVLxh60hXg
         XeM+T4w5LPVfwZxXowB5FxgkgvNEE/+zyLXzue7jKT6++bq14ssoaK8xT+kSIuaKtA
         P41jViKgDP/1wLjLTSFjQ2yBMyhaRErdoDslffq14B6VDSrO8psIifn777byCRL+5n
         oSKORrOfv+ZkSiDsNS8/r6mVwKZJFaMfszgGaDPwv/GjdMy7IuttslbLCESKG8LvG/
         WxAx9UM/RQdtxjEHyplQQCqRtIqSyEZ7p92v30wUMTVtPAJ2aQwqSfptLRNwZGHnAp
         Y8iRSAS0wa8Iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BDB6E52BF5;
        Tue, 30 May 2023 21:19:29 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.4: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230530200210.2103158-1-acme@kernel.org>
References: <20230530200210.2103158-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230530200210.2103158-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.4-2-2023-05-30
X-PR-Tracked-Commit-Id: c041d33bf7ec731bb71f47e4d45a7aec9e40b1b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afead42fdfcae714fb6ac41a5c323629cdb6f9ee
Message-Id: <168548156962.4416.477884658906599496.pr-tracker-bot@kernel.org>
Date:   Tue, 30 May 2023 21:19:29 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 May 2023 17:02:10 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.4-2-2023-05-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afead42fdfcae714fb6ac41a5c323629cdb6f9ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
