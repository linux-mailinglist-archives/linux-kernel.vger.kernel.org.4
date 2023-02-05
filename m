Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3552F68B197
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBEUgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBEUg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:36:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01DA1B578
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 12:36:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87FBAB80B90
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 20:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A94BC433EF;
        Sun,  5 Feb 2023 20:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675629386;
        bh=+ObriJlg4Q3TEfYv2frySvAzipy6038r4RX3ifEzGSM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=psqNUbbbn8QoyPq4Kz1U1QXoKKduLFYPjYEkSapmZwN6ewIofSPFpuenrHTQkS12e
         h97/vvj+OYAwWs5SJYNms8aD28U+Lk6UVBiUcoDulmkjyWENqk0OxqGYIlxeGBSM8g
         LSwvBBsDs4qDI34yTSpOqMw0XsBItMDm5L8FYQk4X/cKX1v65QncJ1ibyMBEh4T/Dq
         lIIO82M9SGfhhkI0HvMdQ+XYNroaN2643HvCt8jnNWwcOh6pay8u3aKvTzzY1KVvaG
         UAqF61aeBp5UJNIMkQ8V/lWIe5Yh+QCO1v/oSTOugTW0/xAz7OCxu2Ga+h2Mb4cX0F
         W8xAxD00YSv0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2921AE21ED0;
        Sun,  5 Feb 2023 20:36:26 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y9+Yq7H4bnlWW+k3@kroah.com>
References: <Y9+Yq7H4bnlWW+k3@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y9+Yq7H4bnlWW+k3@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.2-rc7
X-PR-Tracked-Commit-Id: d83d7ed260283560700d4034a80baad46620481b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3feaff4d9492aa05b94167e170858da81159654
Message-Id: <167562938616.30640.12735904562437383180.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Feb 2023 20:36:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Feb 2023 12:53:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3feaff4d9492aa05b94167e170858da81159654

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
