Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77A16260CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiKKSD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiKKSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:03:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5420563BB0;
        Fri, 11 Nov 2022 10:03:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1AE2B826C3;
        Fri, 11 Nov 2022 18:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92671C433D7;
        Fri, 11 Nov 2022 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668189780;
        bh=+f0h4Qhh4wuT7imWh2jrAJvBiSiNN77peZRU4IakahY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AtcfWvXlV7+tpPU8DBEdp8ktP6v+t7Kb8r2EiGdobMNgIdgCB6Wtbv+1ew9rh7E0P
         VJ1Hrg1rCk7wwQoMoien2Gh5laHgTzpdlZVZVIVUOlJR6dTmRzg4lVtH6KO0tSS6sY
         knQoP8nSyH5RTNcDHpWboQF/0fqfKz8YWH8D/3jLhUTd+iMLG0/bP2u/YsPpEEw1bb
         TFq5U0mt83nNl8XvYzMtwlVpW/jq5eX8WxECO2z3TM0NMFOjgkcvrYDplEveooEHHT
         BRcRFxgXExOwyRJeS6D2n4Em1NONYEV4FZ8Qhsc1kLzZhQx4Zop904/aLboLIHIZhH
         gptn7ROx4y70g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80BDFC395FE;
        Fri, 11 Nov 2022 18:03:00 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.1: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221110172831.369713-1-acme@kernel.org>
References: <20221110172831.369713-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221110172831.369713-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.1-2-2022-11-10
X-PR-Tracked-Commit-Id: 94d957ae513fc420d0a5a9bac815eb49ffebb56f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb037f16f7e843722db5f0275d84b3f738d5649d
Message-Id: <166818978052.15878.10606140585889084138.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 18:03:00 +0000
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
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Donglin Peng <dolinux.peng@gmail.com>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Nov 2022 14:28:31 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.1-2-2022-11-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb037f16f7e843722db5f0275d84b3f738d5649d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
