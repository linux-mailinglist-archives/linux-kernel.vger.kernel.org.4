Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5208464A4C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiLLQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiLLQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:31:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9292B48F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:31:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A467B80DAD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A0B9C433F0;
        Mon, 12 Dec 2022 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670862668;
        bh=UVy/X2xXRYIrCuTETU+xYcww4kutig+6b8E8FUcuC+k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NO89au7KQqhOfl/EQTFrmyATi1lYylGPjve3AI2YHq1hvVFTw+bQaZSGqirBAk/Pa
         x1ee4+1HeQKF9HkzI1aOmCdwbyyBuhMWKGRID2LvL2wqs9PkutUp6FSkvzjjXN7/vY
         XCEIaA2RhHq7TmucboLrsxc3Bvia9kAhY78UEEbpsss2rm1aY28dWYmH0osG6O5NTZ
         krAw6UvFmiVZxO1fpyw4GuQX7onWNkVO5pNVsPlP4lQYrrf+rGBMG2HtYKpzp3T0YI
         k+kKUdLcwp23IdBwEn6xXrP0mX2fqN+qWve1C++SuKuy7SlmuZXiTINAKXM+IUKuI2
         8tQBjFBBh+j3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19808C00445;
        Mon, 12 Dec 2022 16:31:08 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221203011549.GA1815917@paulmck-ThinkPad-P17-Gen-1>
References: <20221203011549.GA1815917@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221203011549.GA1815917@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.12.02a
X-PR-Tracked-Commit-Id: ee5a86f451f7cc8a904fcbc4f3dece023d36d6e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5517a2eaec8f525506867988adc6cfe1c414c90a
Message-Id: <167086266810.18680.9364659172030802300.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 16:31:08 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, stern@rowland.harvard.edu,
        paul.heidekrueger@in.tum.de, sj@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Dec 2022 17:15:49 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.12.02a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5517a2eaec8f525506867988adc6cfe1c414c90a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
