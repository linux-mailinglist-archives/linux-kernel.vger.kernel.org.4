Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7984C64E5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 03:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLPCKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiLPCKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:10:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E04F5E0AB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B24A8B81D19
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 572B9C433F0;
        Fri, 16 Dec 2022 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671156615;
        bh=r3sBrHx/zaZovOEhaJd9mvTdncuUw416tDea/t1E2P4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eRelWOqhsMjhGHdx5I7PthSgg+sdKixgI0C2XoNkm7Boa0qLebQb0frCG1o5b0DyA
         21wpModoMHivszyW/YpfMd4AmLgQ6FZyeGfQvs+0MlzvBGpO7H2rm5ozAzGDqFCpvq
         5m3jxUdaKLyfYc0ZxFoBGQGXI1auVoDGAd+zzJNmiLm2DHU1g1bNBCdiLDWxy5WDQV
         y4Cy5dvPk/KJ+cEkiJB9rYxhf3NWRMk3WtF0ZnhlrP0NhdXTQ7yV5nOSUhsdGwHHNO
         9ua1bucDy/kHagOiHUBuyHJNCC6DOMa7ok99Zbc/TLnsgFhZucaejOtZ8BI/k6ikzp
         kcYhhVYI6E8bA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43B1DE451BC;
        Fri, 16 Dec 2022 02:10:15 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221215202548.554bd268@gandalf.local.home>
References: <20221215202548.554bd268@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221215202548.554bd268@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.2
X-PR-Tracked-Commit-Id: eb9d58947d40699d93e5e69e1ddc54e41da7e132
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe36bb8736ee9e38fa6173e1271ed8c5cf7bc907
Message-Id: <167115661525.4870.17704962676478167558.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Dec 2022 02:10:15 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Song Chen <chensong_2000@189.cn>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Dec 2022 20:25:48 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe36bb8736ee9e38fa6173e1271ed8c5cf7bc907

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
