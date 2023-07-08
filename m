Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D8874BEEE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjGHTSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjGHTSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FE6C5;
        Sat,  8 Jul 2023 12:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF13360B05;
        Sat,  8 Jul 2023 19:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54DA6C433C7;
        Sat,  8 Jul 2023 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688843913;
        bh=tUMyF/RclLjl2UsVeCpITpIjhfXwNNjD4nGhB2Sa6ew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XUwGJ+nrG7PuxSegtbKcQT06A94fcgPMQOWMYKnSLAMvo0mV8DcKbObL6aMJAbVbY
         oVYQ8DW5a9Dq9u8Da9OCG5MuxTb7G8NmCammQ+rhoWKYv64R1DSA8TrXYKQ5Ppq3Z5
         04oBa3iLbynpwkXkPg6ibS/Ue1KoVUKd2BI6MB9Sj6YypTEuD6CuogasxZRd8mMWvm
         PujkGvH7R9S53FrJE1zOPfZSOot6QoJ4W9fWrfuEegbgeEbsgXNqr3K8DqvVs/4VTi
         4fshjLljf6jMEmqLui67ai7ql+l4spY+B/AfImcb2KdXI+e5KNxKm60JH9qBATRSWS
         3ASEPKKbMKy0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4375EE53808;
        Sat,  8 Jul 2023 19:18:33 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.5: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230707042644.94061-1-namhyung@kernel.org>
References: <20230707042644.94061-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230707042644.94061-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tags/perf-tools-for-v6.5-2-2023-07-06
X-PR-Tracked-Commit-Id: bcd981db12e6d26111609802fc7c358f30a8c72a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c206353dfdf026dafd42679cf82d6f0a89781e36
Message-Id: <168884391326.19389.5936226842804001389.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jul 2023 19:18:33 +0000
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  6 Jul 2023 21:26:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tags/perf-tools-for-v6.5-2-2023-07-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c206353dfdf026dafd42679cf82d6f0a89781e36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
