Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067C6744282
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjF3Sqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjF3Sqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F98C44B4;
        Fri, 30 Jun 2023 11:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12716617F5;
        Fri, 30 Jun 2023 18:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EC07C433CA;
        Fri, 30 Jun 2023 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688150788;
        bh=T7ybqFyFiUslr054wZqbXdPX3yF+oM31UFo8WykZWAI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S8X1VrpJTjTiKAV167d+Li63yro2fVY2GkHB5EBe9PdpbOS6cuxg84vmL4O7NqBAb
         0Sa61LtRpPkyBOSZKs0kN+xGXjkAR2K8ROf/Fvh0UscX9QUK/jJkPtrNqdMVRgyKqo
         j+CTtjStN1Y7qBw+Other8y8W6YZ6DQuW+FKXHqGJgTIgDPRMTH9AZT3lqNBMZVD4V
         eB+xz7JrNcXEqwc1BTY/8gikItl4E++AjRQ6id3J7y4WIajNxb3Zvjs+8+R8Tsu7Lz
         mZRBqDOxL4ZCgwrQjnDInL6hfIXTkLYwtwVWkQqmPgwyJj3JwKFOULK5xXZEdWh1Vo
         zeNUKUhV5Kyzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D903C43158;
        Fri, 30 Jun 2023 18:46:28 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230628215954.1230048-1-namhyung@kernel.org>
References: <20230628215954.1230048-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230628215954.1230048-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tags/perf-tools-for-v6.5-1-2023-06-28
X-PR-Tracked-Commit-Id: 4d60e83dfcee794213878155463d8f7353a80864
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b30d7a77c53ec04a6d94683d7680ec406b7f3ac8
Message-Id: <168815078837.30480.2780099140157975141.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 18:46:28 +0000
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Jun 2023 14:59:54 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tags/perf-tools-for-v6.5-1-2023-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b30d7a77c53ec04a6d94683d7680ec406b7f3ac8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
