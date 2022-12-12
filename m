Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4879264A4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiLLQbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiLLQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:31:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AA7FAD7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD1FCB80DAF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C300C433F2;
        Mon, 12 Dec 2022 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670862668;
        bh=avnIWu1MB3HaLJrJ59na2PnsEW+5O3wOMFp9SHYqh58=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BS9TYTE+G5A01npFBpXEHNdJpKO+vyaR4ysiX7QCqWfLBZ6xnVs9Mz6+LrK1IaCaF
         yhmvzuDz+md1uN8+JG62tpfJnlVvTj2K01QsPPiJhEy45ZleepzZIicWdFAC+sVOMZ
         5CJ2VfqC5tPzA7DJLkp+2s5ftrOkjZqdHNBeWIuG+NHBZnOfiSMHBIN6REUlw/ZBQH
         QNqwCqNbuPSEGmNAxwKucag22ExpTZiCxYWo3YArvoHLB+MtoQNuv0f7PeJDkEYY6o
         s+4giDxosdOmi8U6hOl5O9ozsr5UQz6uUNJC5QbQ3y/mSZxSw4E+kJGtE6v5Y3+ddt
         uDECurHrZrEtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B1ABC197B4;
        Mon, 12 Dec 2022 16:31:08 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221203012343.GA1816460@paulmck-ThinkPad-P17-Gen-1>
References: <20221203012343.GA1816460@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221203012343.GA1816460@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2022.12.02a
X-PR-Tracked-Commit-Id: 144b9152791ffcd038c3b63063999b25780060d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f433cf2102fec78cf05ece06fb8e24fbfc6a64d8
Message-Id: <167086266836.18680.5671944128827662652.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 16:31:08 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, kasan-dev@googlegroups.com, elver@google.com,
        ryasuoka@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Dec 2022 17:23:43 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2022.12.02a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f433cf2102fec78cf05ece06fb8e24fbfc6a64d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
