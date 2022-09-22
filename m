Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D615E6A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiIVSPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiIVSPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6339AFDB;
        Thu, 22 Sep 2022 11:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF67863731;
        Thu, 22 Sep 2022 18:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37EAFC433C1;
        Thu, 22 Sep 2022 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663870506;
        bh=0w5r8c2GQVfQbllzZuIxC91o+h0ZL3f6nzlOqmGqhf4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I/1VoYwfl3vW8PeRHEjRHcATyG2Jie+Aw3RP5hmhDLtRMAu/3TM77w46yKG114ABS
         Kit9yxwQF3DDKG5xe2UVr92DFvGkv6duZxlJi6mWH50jc00W1Zj8DwWQj2YqS94OHQ
         IvS52P764xCE1dFcDpwRBJ2KBud0eutUfpOK93y21itU3SzFCxtKkw4zYZ3Jz2R2Wl
         scf/CXuAlqfQbmJFNDu1qw5fp4naqRhWmUDpf01JkUKJlBMwIhjufYiOU7/Lc/Sq+p
         YRDve/v8T0p5GKNfyGZ/mk9FMwBrxqhMZhnJi6O3JsopzYKiknPjFNy8PzpIP1424r
         i+2jkwu0+YdVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22FECE4D03C;
        Thu, 22 Sep 2022 18:15:06 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.0: 4th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220921222600.29851-1-acme@kernel.org>
References: <20220921222600.29851-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220921222600.29851-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-09-21
X-PR-Tracked-Commit-Id: 999e4eaa4b3691acf85d094836260ec4b66c74fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9597f088c9fc0a9a1de402426f57ff0a18cd069e
Message-Id: <166387050613.24554.2874622269056594079.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Sep 2022 18:15:06 +0000
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
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        Leo Yan <leo.yan@linaro.org>, Lieven Hey <lieven.hey@kdab.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Sep 2022 23:26:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-09-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9597f088c9fc0a9a1de402426f57ff0a18cd069e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
