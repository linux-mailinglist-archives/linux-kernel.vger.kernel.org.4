Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D6713954
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjE1Lqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjE1Lqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:46:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C9C3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 04:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 703A46157A
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 11:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6149C433A1;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685274402;
        bh=DneKEqPV4a4LIrolyUH9dclWbidU7PDlGrIoxK/fDtI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=otogb2sLnjew4hJDJnjH0g10cgsbE1/zeyC8UZT9hQ8O4a0ZBlo9SyKP3PXceAvT5
         cFgIBMECWNc5TJOtz+EKJyZHvmVAiGeW4Oo2KzL8mIVvU5fahgaok8o4gI/RhIFzt9
         t3cNnjAZ4ooFG90oJKWyqqUlE1ePlTvl/MDrqY2i9Kv4mINj+WO15EJcGtO+n8+9y5
         FymRglWCYKJGFIghHuawPXcZD8XIbqz1rPEoeYs39Bg7dxxeFBEuMCAe8ufFpaa6L5
         FtVMoN3aLLtxMhzTwBx9UlyR6BskVaSKZ7DaCDS1cn72BOFhbaRbG1u5C+7MjfDvk8
         rv1ObvCWO77pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3797E49FA5;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
Subject: Re: [GIT pull] perf/urgent for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168526035979.3457722.10299010241065106864.tglx@xen13>
References: <168526035526.3457722.14103350194452732675.tglx@xen13> <168526035979.3457722.10299010241065106864.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168526035979.3457722.10299010241065106864.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-05-28
X-PR-Tracked-Commit-Id: 38776cc45eb7603df4735a0410f42cffff8e71a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d5438f4c6fdaa34c5d7de89a5331b8dbcd920af
Message-Id: <168527440273.32373.8475906670744880235.pr-tracker-bot@kernel.org>
Date:   Sun, 28 May 2023 11:46:42 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 May 2023 09:53:00 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-05-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d5438f4c6fdaa34c5d7de89a5331b8dbcd920af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
