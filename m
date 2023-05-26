Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B289712E98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbjEZU6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEZU6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640DE1AC;
        Fri, 26 May 2023 13:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C08E46155B;
        Fri, 26 May 2023 20:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34AE0C4339B;
        Fri, 26 May 2023 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685134709;
        bh=gMRoNKLEU3gIKJLumTlFfMLU3SUr9JyLXH4EFcfqjqM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qQymOyDZFf9Lt9nwaNy68w/d5XXYx9xswPeIcAk4SZYe7LWpW6XbyFe7wTL1kwnYg
         3BwlJ9M0Fr0T1Smfo/p8xzz1XJgssvo6q37OPb0hO0DzsOuMgpDe0F5PLGjLZi92Mf
         RVE+3QGXVrtNBeapusS8YdVHV5I47s2moz/orL8WDFxi5OF5KnIHhq8fkYjY9dIEL7
         FvA9KfXj0P7FjPdZw5ja/mEANAeRGZOxj8A2iSyWGA6ef255DkofMdFN8ej4F10c+9
         zp8tVTlBBLRqXwMdERtaa6u+Eiq4uR474E/Cid5upNrGtjjBZbq8W0BhcnA6fdJvGb
         tTIO6ykpE9WpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 106F0C4166F;
        Fri, 26 May 2023 20:58:29 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gh2RTNjJ-YQAv8pdrOYJjjdj4dcp7+8EnUAYWiP0BVuw@mail.gmail.com>
References: <CAJZ5v0gh2RTNjJ-YQAv8pdrOYJjjdj4dcp7+8EnUAYWiP0BVuw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gh2RTNjJ-YQAv8pdrOYJjjdj4dcp7+8EnUAYWiP0BVuw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.4-rc4
X-PR-Tracked-Commit-Id: 5f7fdb0f255756b594cc45c2c08b0140bc4a1761
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77af1f2b9a2464e4bce20cfd32bfb2390c67de7c
Message-Id: <168513470906.2904.18094565219968509548.pr-tracker-bot@kernel.org>
Date:   Fri, 26 May 2023 20:58:29 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 May 2023 18:33:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77af1f2b9a2464e4bce20cfd32bfb2390c67de7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
