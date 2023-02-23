Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725B66A0FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjBWSrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjBWSr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783541588D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:47:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D08F16178E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D062C433EF;
        Thu, 23 Feb 2023 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677178032;
        bh=9netTejITnaJeChhecs8w62xAThFIJsSj5nq4DBdF4k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PIBRFRwHpemRoiB1BUGMUmG+g+J1MI0pXG6HKFwq8HH9xpJjqeAvow65EelTKOb5J
         KBWK2MKsYMLDSqvbeDrK6TT3bX9hWuIQDnMosZQkc8QvZWmvfIAqKnAQxkxQXIRXXK
         UWC/Jyma2KJQ0iS9XXJANQBGzqqdt8Fp9pr/2rez/vROHlR50KxZ5EFsvsi2pU1ozE
         d22opDec+uF1bssG97S01F912Q+eN4Z0KHnqlNPwQmKnDCb/GnV0//RKWNJDtJapjO
         pKFYgCIo1qVkAgS5Nu1s5VBP0WkFM968XDqv5bbeD0fHiTgVTK5NW8A685HA/kdggy
         F/7BolNHRS8jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BE80C43157;
        Thu, 23 Feb 2023 18:47:12 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222015659.GA1344672@paulmck-ThinkPad-P17-Gen-1>
References: <20230222015659.GA1344672@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222015659.GA1344672@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2023.02.15a
X-PR-Tracked-Commit-Id: 9ba7d3b3b826ef47c1b7b8dbc2d57da868168128
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 192a5e0a19712a079f456954c203ce9dd2b889fa
Message-Id: <167717803224.14005.17441734840716637794.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 18:47:12 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, parav@nvidia.com, will@kernel.org,
        stern@rowland.harvard.edu, kushagra765@outlook.com,
        jonas.oberhauser@huawei.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 17:56:59 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2023.02.15a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/192a5e0a19712a079f456954c203ce9dd2b889fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
