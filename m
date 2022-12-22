Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD17C653AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 04:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiLVDHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 22:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiLVDH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 22:07:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8A222B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 19:07:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCCCA619C6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 410A1C433F2;
        Thu, 22 Dec 2022 03:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671678448;
        bh=pL8TGbJuaDsf8InYJjy9E1Fx8f3ELhuw5t5HWquwNjI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fZkSg4Zfl5ge/R/q2JjCnSMaxBd1Pn9LXOhQVwM/r7C2N9dLWh/5l9zXmmx3uHeXl
         MtCtcbhWEgV950cLXdXYTsQSai2z/WZpenPnJoCFi4/Q4gaIucvwOoP/pInUyN8y0a
         LIYJQlcb/fVw4u8WB5QXA02G0yLeKlwWgJ1fZGfLifxmUvmIOM7QXdM+bpapCw8XMh
         kPhJnkqDuw1Her6w/oWgD7wsr4n4ofUqHLjg2QUpaZ++6JNhmZVjb8RnjpPsgF+C7+
         utkXGhZ2w2AnRIIaiLFtolqWcGXzxCso+EsfDFmpAsP/RIg8lJVcSe034G6Cwkc2wA
         QdfCB5bfv4fRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FE46C43141;
        Thu, 22 Dec 2022 03:07:28 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/rv: Move monitor structure in rodata
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221220223759.7ed245ca@gandalf.local.home>
References: <20221220223759.7ed245ca@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221220223759.7ed245ca@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.2-1
X-PR-Tracked-Commit-Id: bfa87ac86ce9ff879c5ac49bf09c3999859a8968
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
Message-Id: <167167844819.12654.2840751595953151065.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Dec 2022 03:07:28 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alessandro Carminati <acarmina@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Dec 2022 22:37:59 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
