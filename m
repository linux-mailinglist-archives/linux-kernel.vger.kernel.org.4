Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58A6C0367
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCSRPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCSRPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31241B330
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45D2961141
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4E22C4339B;
        Sun, 19 Mar 2023 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679246146;
        bh=fr/aXwokADsu7M0vSmABqwgw6drCuXwpXRlzBP4IdqI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jIjRN5bc1S0rEHeMVjGIBiEKvN8xScNrq6+OC36Eg34CD1rgpSnLolgzTuqb1IqZk
         A3HLYvGb811+vAdh5/OjMPL6zKRmKsLyK2aK5SX5Gipth5lewvab17SEfnaIoJ/Ulb
         /slQdULffHaBn1wtcEkwZ5fRaqeIJBKskD64VpEycmreSYWtcIDCT4AaQYjgiZbbaG
         oxe+r9IFOVMDVRDU0kfhb20bENaBVbNzWZUcGwdEw8uzdCYtEGAxBxB79TFSO/+Dal
         dTuAN1iMLa4ZI0i51MVNEI6Ad3+wffqJWRVQcUKsJW3YTyH/ZJm1VXy0KDRVd19mYV
         CWXBJuy6M5I3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DD04C43161;
        Sun, 19 Mar 2023 17:15:46 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230319125655.GBZBcGl5kNdF8qMFJU@fat_crate.local>
References: <20230319125655.GBZBcGl5kNdF8qMFJU@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230319125655.GBZBcGl5kNdF8qMFJU@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.3_rc3
X-PR-Tracked-Commit-Id: fd0815f632c24878e325821943edccc7fde947a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80102f2ee715ab07be476df443bba388d5458fd1
Message-Id: <167924614657.22094.14832009383341616147.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Mar 2023 17:15:46 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Mar 2023 13:56:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.3_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80102f2ee715ab07be476df443bba388d5458fd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
