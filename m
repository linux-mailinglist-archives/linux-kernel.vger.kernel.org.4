Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB364E0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLOSax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiLOS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:29:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69259F5BC;
        Thu, 15 Dec 2022 10:28:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E979F61EB7;
        Thu, 15 Dec 2022 18:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 548E2C43396;
        Thu, 15 Dec 2022 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128933;
        bh=1ThKZ2KV+vE+nqXAV/w9d1N2Ghsp/GX0r5pFgGEiN2E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TSU703zWVNj3cxFJiEnqcO3zBQnV13k4NSAmhACL/26+PNXVT7oRWatT7skJeT94u
         pLGJ9IJQXOW6WfWJW3Gb16akVv1KWMcQrlIrhLuyc4MHVA/tQUlegwcHNS8e4kWHwy
         +faTtERx+fu3WZ8dYxloJH6qGcPKgKqxjSJ5WJbj5NoU8Xy99uR7hlDsKwYo7JXn78
         yiIlZ0Ox+Nuct1tMZeSj1sYP27nxRNYMK+Bk1SgeikomfTjwsGbnt8eHEiUIYmN4aV
         ugpXXATU1B8khkEufvD14v3SAjY0oNOavDS+SQLLaHo441vVlsJM/aK2EEL/wFT3xp
         C5oN32JV9HpNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37E9BE4D00F;
        Thu, 15 Dec 2022 18:28:53 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hy7LXMyKF1H3Sh7ZKS8HyuMWPX_htN84wBYkRxxeNupA@mail.gmail.com>
References: <CAJZ5v0hy7LXMyKF1H3Sh7ZKS8HyuMWPX_htN84wBYkRxxeNupA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hy7LXMyKF1H3Sh7ZKS8HyuMWPX_htN84wBYkRxxeNupA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc1-2
X-PR-Tracked-Commit-Id: 3d03140c4844bbd128728e8a367bb467d95f888e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 057b40f43ce429a02e793adf3cfbf2446a19a38e
Message-Id: <167112893322.20649.9904351691496894542.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Dec 2022 18:28:53 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

The pull request you sent on Thu, 15 Dec 2022 19:07:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/057b40f43ce429a02e793adf3cfbf2446a19a38e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
