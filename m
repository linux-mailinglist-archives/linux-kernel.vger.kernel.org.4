Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A715FBDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJKW3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJKW3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:29:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173157F099;
        Tue, 11 Oct 2022 15:29:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C51AAB811BD;
        Tue, 11 Oct 2022 22:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8219FC433C1;
        Tue, 11 Oct 2022 22:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665527368;
        bh=W2WbCQE0t6PqKU9qAdAvO5D/Hb7sa8sdKSfdcfwYLRk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mlF0HUnV89LSwxf2b3/OP39sdV4wzSRBuvnv1BlIpuRyUzmLFkA9JbEPc3yY0BxRP
         QVBtw4maZn7+Ndj2zxpOEDyzu83Zv+5e7HxdNzST3J0mSoo9dabAs2mn4FY4j7WF93
         zUT2Gpqsnr669J4Fbg/3FIc0UCCL8yMbBL0/RpzrnDBF81wk46oAlhrneeToO2ExpA
         2uwvZMHWnYHFejL5TZgdk3oNIepFG/2O7VXnW6DgYNYmEcZZpTUIgLaPrIZQEx+yVT
         O2FWyvtDkDKNWlYrl7hTZmUJ3c0WgqFxrt7r+nkMJi1H0FubDk1K6RfEF9nyMKnX8K
         Gid6emNXnNgCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DFAEE29F34;
        Tue, 11 Oct 2022 22:29:28 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.1: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221007203153.228388-1-acme@kernel.org>
References: <20221007203153.228388-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221007203153.228388-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.1-1-2022-10-07
X-PR-Tracked-Commit-Id: d79310700590b8b40d8c867012d6c899ea6fd505
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d465bff130bf4ca17b6980abe51164ace1e0cba4
Message-Id: <166552736843.5559.17685157672560730621.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 22:29:28 +0000
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
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Raul Silvera <rsilvera@google.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Xin Gao <gaoxin@cdjrlc.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 Oct 2022 17:31:53 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.1-1-2022-10-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d465bff130bf4ca17b6980abe51164ace1e0cba4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
