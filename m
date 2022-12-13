Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96FF64AD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiLMBko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiLMBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:40:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B909315FFB;
        Mon, 12 Dec 2022 17:39:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66094B80E06;
        Tue, 13 Dec 2022 01:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 350A6C433EF;
        Tue, 13 Dec 2022 01:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670895585;
        bh=AioFKuX4Kqb8Ho1KSS9vTox8+ppxZh2MT/ypovDKwvc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aj0hbIIZfS5sIY43UHiFhkdplu5mCZtlrlYAikSjn2MmArGAyYdBod8uyr+1lM+ad
         HTxlU6OUtgY8ImCmYxWtzE9/BLplrEENrTQVFw+wj/vZCHREYs+4BogEHhnDGreeDX
         UAcZ5vAH0bOYvrNO/YwVbanrQVmJvmluWlCj70B/D+ZreCC5kuWrIeU5YIOX/WkQYs
         WeY6W6St0Eu2Dj8KffikaMBq/DlKVe3qWW8lqgwtd7J+k41mGaGeGgIYjxEaO+cezf
         kzEbEco8VD/QYahNPGNNwT2UkntjHpfeCH8lwM0MCFRUhgiXrk64JaTwBxRhagCwvA
         SebFXYAMyKS/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21C0FC41606;
        Tue, 13 Dec 2022 01:39:45 +0000 (UTC)
Subject: Re: [GIT PULL] non-MM commits for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
References: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-12-12
X-PR-Tracked-Commit-Id: 12b677f2c697d61e5ddbcb6c1650050a39392f54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8702f2c611bf124c48b21b5c57bfc156cd11f4ca
Message-Id: <167089558512.7166.8847410452011826453.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 01:39:45 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 13:44:25 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8702f2c611bf124c48b21b5c57bfc156cd11f4ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
