Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EE064A9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiLLVwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiLLVvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:51:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39611A21F;
        Mon, 12 Dec 2022 13:51:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D926B80E7A;
        Mon, 12 Dec 2022 21:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E697C433D2;
        Mon, 12 Dec 2022 21:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670881895;
        bh=Mus2vRcAVcKRytoodjd+fdhpdDlJWkZJZ2VP6lCZOSc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IICUzn5j5iUUr+u2kdsOiNG0jmrYWaWnmOM27kZgZ+PT02uhpzzGzupx/KYrxfe0I
         gFSF252AkFmWIKi/o60j9gIFoQfBX17O3x8jONgM/fH58nHDKy8P9+G5Oz7zAbfFi5
         50+62ldMZM3BozxeEHuWG1+A485ZdffGm7t+qXYbYG9Mb/mZRy+kmTGmbJhDofUra3
         xvSl5ttJ9baGwRiBsfInKdNnnTNu9ChT7vPCWOjG2viLbqi0RYArw1/oWqEm8oMPdG
         C7mLvHy/uHJK5OO/zA0nlkFpIcio3afsqyMeSn9y8bK8Yj6cB3I/znnLYYEBazryAS
         opJL6hyohHFsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15D2EC00445;
        Mon, 12 Dec 2022 21:51:35 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hWMeHrg-6eBdFUJXbv__mNw+byREMnHUiuy=Ktw7ttxw@mail.gmail.com>
References: <CAJZ5v0hWMeHrg-6eBdFUJXbv__mNw+byREMnHUiuy=Ktw7ttxw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hWMeHrg-6eBdFUJXbv__mNw+byREMnHUiuy=Ktw7ttxw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.2-rc1
X-PR-Tracked-Commit-Id: ed6a00471dd444af085164f987e3d5e8145da35a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 045e222d0a9dcec152abe0633f538cafd965b12b
Message-Id: <167088189507.24990.14857486376032531094.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:51:35 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 17:52:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/045e222d0a9dcec152abe0633f538cafd965b12b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
