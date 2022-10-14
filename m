Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2029F5FF482
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiJNUYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiJNUYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C05E19
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FBEC61BEA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 20:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CED0BC433D6;
        Fri, 14 Oct 2022 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665779075;
        bh=t5R3CkccOjCiOaVevMHGLbJ35A5eLCz3wo5M1pYBC3A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y8KE1Hc0+tNp9u3vs/mEm2BogQTCkLB74nvMByS936dPOgvx6+0zBo7NQGQ8+xy3f
         fJAy848wwVlY7VnR57E9NGcRvfQArm0FhxtrlN7lgpL53uu3T5/lkJuunCE2CQQDsJ
         xyr9Mgn8BdrKCJ4tzeimGztl6f/dhDT1xAo5ReAHNhAuaKZnswUSob6ehoDOj2MZa4
         PrI1X2CLNnuoKNdOE7tU/iRKey4INDxO0cf+9l4oFiISZsSVeRzZpWNOIjstUdhR1L
         +ipAcds4KPezHIwNJoLM74wyE1e6jmbTwwd3fV0GOklkSz+v0sGS+5DhKyOw/uXWUP
         VXV2KYTOgXANA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9418E270EF;
        Fri, 14 Oct 2022 20:24:35 +0000 (UTC)
Subject: Re: [GIT PULL] sched/psi changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0krqnKlHb/gp9Za@gmail.com>
References: <Y0krqnKlHb/gp9Za@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0krqnKlHb/gp9Za@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-psi-2022-10-14
X-PR-Tracked-Commit-Id: 34f26a15611afb03c33df6819359d36f5b382589
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd9a3dba185ce6701b41f0341470d3f53bbbbaed
Message-Id: <166577907574.10237.15189466398920835543.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 20:24:35 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 11:28:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-psi-2022-10-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd9a3dba185ce6701b41f0341470d3f53bbbbaed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
