Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B1869E731
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjBUSNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjBUSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:13:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E0B1707
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:13:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1CCDB81050
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84D74C433D2;
        Tue, 21 Feb 2023 18:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677003094;
        bh=IH97gGRY+m9XQYxdYTjWpq0zFNfvklLzWdo4BL2pO7g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NIh47NFQmioeLpfqI7vnLe5NSRxg1PSLzLoDtgAHQ8APk3Vrc3/Vh6fVpDJz8yuH/
         RVPjaDVN/NPr52xNZbZrX/9gg93qyzxREGi09jXnUejoWRKkCEb9de/v8jqRy6zlvh
         a+Hr2FkiZ/cwAnhe/C+Q8uHF0huZT3B4dad63/8M7i5P3T1P7mFg4bfMzHUC/KJZdU
         q2IT1GZfO+bDry1COX7hWj7+5sX69S7E5zxQ6TtT0rFvYpxHgdRcP+Oq1kpN5lbT5W
         QynD8EwbPaBRxhmA07EqIFtZ6DOA7hqnCjQOX+Q6USDVU4rcps+Hsr+mzVLak2WE5d
         JSbYVMjHoUxww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6585CC43151;
        Tue, 21 Feb 2023 18:11:34 +0000 (UTC)
Subject: Re: [GIT pull] x86/cleanups for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167689255093.295764.7287608125437351112.tglx@xen13>
References: <167689254797.295764.1600565060995031919.tglx@xen13> <167689255093.295764.7287608125437351112.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167689255093.295764.7287608125437351112.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2023-02-20
X-PR-Tracked-Commit-Id: fcb3a81d221750d2a54b4e3a82b3efbbeab8780c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 056612fd41fef88eef22a032021cc15ef98cfc34
Message-Id: <167700309440.29984.11523850701603438590.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 18:11:34 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 12:32:55 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/056612fd41fef88eef22a032021cc15ef98cfc34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
