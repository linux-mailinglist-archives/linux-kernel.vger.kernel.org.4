Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68C369E732
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjBUSOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjBUSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:13:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A33F196BE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:13:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41E99B81057
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9262C4339C;
        Tue, 21 Feb 2023 18:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677003094;
        bh=6rutAQVUZtbn/fpGSqc5Qg+DaNcRCr4v4SCvVNJes/4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OXY2O3hlWl/sVAA00IeCrdUMj/KggGl1sKSqjIUFthhdpSd8EWK3DL51xL968kp6U
         8c+oRFGndJqCMEt2E4dGC6NE2tUtwYdsxDBRr7tsjUh1yhB807tzlNk6jmXscYwAHb
         a+e/9QK4tokZqAoCe4tyXKeNrFD/VIfCQzPLUCH++qo+l4BtdgaOGFY4loTkSLMyM9
         l445/qWbxo/6UddCD1FCMMZcX9+d9GFBb9iAB7lYX+UbnP1MJjgKMk4nSVzr5i4Y7q
         Td7jUmOdkNu7CerkOevcwONYqfZKQnhyYhk4mDXHSFIu6IMRttgtvf0NBmeFynN8d2
         yTPahKeuqkwUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4258C43151;
        Tue, 21 Feb 2023 18:11:34 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167689254948.295764.12646261972310217217.tglx@xen13>
References: <167689254797.295764.1600565060995031919.tglx@xen13> <167689254948.295764.12646261972310217217.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167689254948.295764.12646261972310217217.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-02-20
X-PR-Tracked-Commit-Id: ab407a1919d2676ddc5761ed459d4cc5c7be18ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 560b80306782aee1f7d42bd929ddf010eb52121d
Message-Id: <167700309486.29984.13816159601986316463.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 18:11:34 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 12:32:53 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/560b80306782aee1f7d42bd929ddf010eb52121d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
