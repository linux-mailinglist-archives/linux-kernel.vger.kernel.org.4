Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D6866670C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjAKXSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjAKXR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:17:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8A3AB22;
        Wed, 11 Jan 2023 15:17:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07D93B81CC9;
        Wed, 11 Jan 2023 23:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1B3BC433EF;
        Wed, 11 Jan 2023 23:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673479073;
        bh=qY4nUy6FQS12cdvVu+txdn54pNJ+w5Y0Ppt/hK/dhFU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vInkCHxmFJjs2rufJlSJxbtOg9wFFTYmyg8OC6Tq3VeOXbftEH0ZPmnplzD31KMwb
         C1A0nciVvMrigSasqHPWW6AMjGZhMP50Wf9R3eifPlPxJeKJBLlZ1c6zwH4E7gfI52
         KFG3uXMCn3L0K9a488xXzj9H7OOrcArw9bOpFzHSX3VBQ9Zemymo6I36ZAO4+R+egO
         HF0hYOdQDfM+Vux17ajHAEwkawJZh9ps6sc+fzEYXEiEZkh4s0kNmEAAWnuDrtYWY2
         kN6Mcx/4VOlXBWCcRADR2w/i1AwdbQNR6o2F9+2rTjLFp/BrqttuvmklbTcgstmz1A
         tgQ9iwfobXQ9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C703E45233;
        Wed, 11 Jan 2023 23:17:53 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.2: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230111174331.984275-1-acme@kernel.org>
References: <20230111174331.984275-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230111174331.984275-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.2-2-2023-01-11
X-PR-Tracked-Commit-Id: cf129830ee820f7fc90b98df193cd49d49344d09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8f60cd7db24f94f2dbed6bec30dd16a68fc0828
Message-Id: <167347907356.14575.18351582562297563998.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Jan 2023 23:17:53 +0000
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
        Dmitry Dolgov <9erthalion6@gmail.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Jan 2023 14:43:31 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.2-2-2023-01-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8f60cd7db24f94f2dbed6bec30dd16a68fc0828

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
