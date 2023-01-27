Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D067F032
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjA0VOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjA0VOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:14:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8EB783C7;
        Fri, 27 Jan 2023 13:14:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E973EB821E1;
        Fri, 27 Jan 2023 21:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C1B0C433EF;
        Fri, 27 Jan 2023 21:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674854074;
        bh=aTDZ+XKoF3xdRrGU8ruppha6VU6GWXE+OuyMdY3RBOU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J6VPvky7FItaqyR71cdiVzUZa+gJtr10qo1CZFVDTGWGqpQ+JKg79kt+9gUQybHCh
         wYRt5F52N54JFFNHpRVcCBZmVx/um8DHDc5LVJY9WynGwusxW3BYGOu9zuU2e8cqeL
         t9ARg8WSCzG4SZi3Jk2G6++xer54ALhdtsb6PHWG30DVStoV83TyZEpkl1ldyWSOmz
         ewn2RhqUsjOOi/V+RcvD3mWMububYm1v6MJGwmc5s6OHN2ra85pipWuovYZ07OmlMO
         sUPmcYnzRl3OgVNCRungvHx/5FDzGttm9makQ7J84MwXQk69RBTJ6UovrfMcG0XJpg
         HIzHHUSnWOX+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81A2BE52504;
        Fri, 27 Jan 2023 21:14:34 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gFS6URrN3fe4p6fv5oGL34XuT7-xGNdLnYELZOgfwjmw@mail.gmail.com>
References: <CAJZ5v0gFS6URrN3fe4p6fv5oGL34XuT7-xGNdLnYELZOgfwjmw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gFS6URrN3fe4p6fv5oGL34XuT7-xGNdLnYELZOgfwjmw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.2-rc6
X-PR-Tracked-Commit-Id: acd7e9ee57c880b99671dd99680cb707b7b5b0ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 274d2f8b0c032ca3c1ae88194b75edd2669368b0
Message-Id: <167485407452.14056.18295878093691467732.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Jan 2023 21:14:34 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Jan 2023 15:47:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/274d2f8b0c032ca3c1ae88194b75edd2669368b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
