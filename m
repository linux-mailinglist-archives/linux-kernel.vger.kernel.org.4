Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E1E672B94
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjARWrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjARWrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:47:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0425FD60
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:47:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7530461A91
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2063C433EF;
        Wed, 18 Jan 2023 22:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082027;
        bh=YqiJBkk4vXrY35wwsqWw6QLVFDYpdLBs7QP0W2Wb+Do=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VOgMwwf9ws5mHIHWsNhvKY442xfXS30KF9XIOu0C7Zhqq1CoP7Pcp89FAR9GTYUHq
         h7I/0UqLiqPqUbcMqA6WPJrwBuHumOh46pvjEszL+eG41HQ6CxolydhfNx7A2RrRBp
         IEgaQmGggn0k1q/NJOHdlvOo7/OMaMVobbi6BhzZ+CPArT5RS16urUYygTX4FxxW9c
         +JgI6faqHE49CfdKRi8qql+USy3c86bC8oxZ4D/siZ2s662kgPREtGOeDFwuNfGRn0
         mjuc5V+h/PGKQVzuVMhvV5PotDM4hnZViRNn74WtwSe/upXKfVJceNAHR8KrWjmNM3
         Mq3WOwifaYZGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7D9FE54D2B;
        Wed, 18 Jan 2023 22:47:07 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2301182112010.1734@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2301182112010.1734@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2301182112010.1734@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023011801
X-PR-Tracked-Commit-Id: 3782c0d6edf658b71354a64d60aa7a296188fc90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7287904c8771b77b9504f53623bb477065c19a58
Message-Id: <167408202781.14684.16244991430784033080.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Jan 2023 22:47:07 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Jan 2023 21:17:00 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023011801

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7287904c8771b77b9504f53623bb477065c19a58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
