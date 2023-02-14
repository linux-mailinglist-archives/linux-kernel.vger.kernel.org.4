Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB5696C32
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjBNSCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjBNSB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:01:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD33298F7;
        Tue, 14 Feb 2023 10:01:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C6AAB81EA1;
        Tue, 14 Feb 2023 18:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF43CC4339B;
        Tue, 14 Feb 2023 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676397713;
        bh=mShHt9sPk0VfV4I9dLJ3sj8GiybcrrOIvMLtKpEeJSM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P4eqU0UkPtTJXBn5h1S7cX+jFTmOYXL4+V+pXT/VPA+kkH9XedALwLfbm3iveGQdS
         5lh2wkh2dxrUi4w4nqgEfeY4b4UgrEjyF/qPpmIrQQ8Dk1Y/+XP6jkL6O4jwL7Nyam
         M0qxLTbdoBLr7VtQDUjiiEHzkdVc2aCINmo5MjlAL23j7O4Kwr2aHKTZuF37MPh1Zi
         an6PJcConZmIriEQ4wb6wpTvzW58RGRMsnz+ubYKBpymj5voOAgy7Cd+YGexo+JAX7
         C9q1WCiAZpZ07ZtcoImROmWD5kfX+QsKnZAEh768oMPrXvUd7GGuRoh+lRoebcNn8P
         UCBwamNpjpmGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4F4EC4166F;
        Tue, 14 Feb 2023 18:01:53 +0000 (UTC)
Subject: Re: [GIT PULL] Additional power management fix for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h6j8mphAxBdCWYVbbaYXO9Et+u82nWhi0hY5sNvkMCzQ@mail.gmail.com>
References: <CAJZ5v0h6j8mphAxBdCWYVbbaYXO9Et+u82nWhi0hY5sNvkMCzQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h6j8mphAxBdCWYVbbaYXO9Et+u82nWhi0hY5sNvkMCzQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.2-rc9
X-PR-Tracked-Commit-Id: 6f098cde9df2c86d60db727d6270272751943674
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1c04510f521e853019afeca2a5991a5ef8d6a5b
Message-Id: <167639771379.29113.11403918779831606950.pr-tracker-bot@kernel.org>
Date:   Tue, 14 Feb 2023 18:01:53 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 Feb 2023 15:19:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.2-rc9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1c04510f521e853019afeca2a5991a5ef8d6a5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
