Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2A5F94B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 02:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiJJABF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 20:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiJJAA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 20:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23AB6C135
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 16:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5B3A60B85
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42458C43470;
        Sun,  9 Oct 2022 23:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665358402;
        bh=bavVQczmDu4/yKqPgz2UePu5lHKGTeC79Pyq++06U6A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qLGpLqYkBRd9Ew0kJta1y9lYjyMihnKEDDsAYhVfwC2tXnSmVfoci9qt5bIJBVbM0
         +kxzNYUtigEUaYT1zCM5pM3PlI+A7Iit7z/mtasNN47hbD6JqGhyjsIJ+NVY4yWtUV
         BDtK0yT73uS3dZaFJXfLgMM2ojDViHX2vu5DDzsuF9dqSyWPtSjYHnbHegq2EYbt9s
         tG7oHtCoNvA0BWk2F8dGmNl7hzlsiHxGYlWB58fI6SflVlo1pqqsyGYL4HpEOzhRMV
         INyCm7gIDxWEHW8n6L363o7NcWwqFVaWzMl/kE+zFm7T1Drvb1sgqRhfYPich3aTQX
         GdeZPAAtzlmRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2498BC73FE7;
        Sun,  9 Oct 2022 23:33:22 +0000 (UTC)
Subject: Re: [GIT PULL] ucounts: Split rlimit and ucount values and max values
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87k05gwp2h.fsf@email.froward.int.ebiederm.org>
References: <87k05gwp2h.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87k05gwp2h.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/ucount-rlimits-cleanups-for-v5.19
X-PR-Tracked-Commit-Id: de399236e240743ad2dd10d719c37b97ddf31996
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 493ffd6605b2d3d4dc7008ab927dba319f36671f
Message-Id: <166535840214.20820.15770609372354796080.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Oct 2022 23:33:22 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 03 Oct 2022 16:54:30 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/ucount-rlimits-cleanups-for-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/493ffd6605b2d3d4dc7008ab927dba319f36671f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
