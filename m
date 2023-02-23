Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509B66A0FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjBWSrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjBWSr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E948B158BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:47:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3733D61776
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4C57C433A4;
        Thu, 23 Feb 2023 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677178031;
        bh=+EIZIzuGaCpUlRS/eMuDdUL9Ow/1BpH/bEcC6bcF04A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gGK5IHpynxiX68hEDybIh52gYjfK8t0hSPCYk88pIP3nDslTmBDkJBKkymOqxDUdH
         D9a+A5He+ki7xiXggbkmb3oNiWucKtFm0vns2Xloz30mHs2zinUQdeWUlHZ2eaEHiQ
         zqCimRBGZrKg7OUePBLy34BTWuFo7EKHq5wgBJbcACqqOB2BHBxa2y69IhW0r1EtG+
         /fIECOoQBbMeGIeERGEP2zXXN10Ew6fvUVSiOwRsGww5GgbWCSlszrFp0ZSnGJtU3p
         aShAuXsDrvJhDe9XkeSLceHZLCAla6b4ZxQU3WwQrPUOfvwv9rB/pHr0BbRdCKo/ys
         XgSBVJNUwH8iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FAB2C43157;
        Thu, 23 Feb 2023 18:47:11 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220154432.12eefbf6@gandalf.local.home>
References: <20230220154432.12eefbf6@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220154432.12eefbf6@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.3
X-PR-Tracked-Commit-Id: 7568a21e52f60930ba8ae7897c2521bdab3ef5a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b72b5fecc1b8a2e595bd03d7d257c88ea3f9fd45
Message-Id: <167717803158.14005.11709434256175318149.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 18:47:11 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Jianlin Lv <iecedge@gmail.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Song Shuai <suagrfillet@gmail.com>, Tom Rix <trix@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 15:44:32 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b72b5fecc1b8a2e595bd03d7d257c88ea3f9fd45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
