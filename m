Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD17A64EE73
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiLPQCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiLPQCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:02:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7970BB5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 241B76211F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EABAEC433F2;
        Fri, 16 Dec 2022 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671206422;
        bh=l6F3gIMGyMpVxvLXaSn8LDi2KRUZyx8s5o1RM6TIjaY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LF9M35CkMuPw0C4jN7etDsPL723h7v3jl1irmg7pZUZXODqvWumLm94IYm01pTupF
         tO+TDvyzTCJzJSocCAfrMXOHSMgzjzGw0PeznkfxBzd6KtRMErhGcuKW6wDdVtyKg1
         RC6jlKLWOio/ZTN/SZiu3i4PS2SmYU5vTCwKMGQbZsq1T+YKdOPedYxgnrXZydXH2K
         aTYRyt4/WhQpdIh026RnBef3l0jHDZu72xX05zMmwLZpxiUfn4K4y7Tg5+8URlBnFK
         jVhy4wlXvi5xOtEapP7XKoMNl7AWND0KYBFhfosR2oqlL/tk79nMsMcBXX/11OBja6
         PYLIkqtMcA6Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8CA5C00445;
        Fri, 16 Dec 2022 16:00:21 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5w0IMxCYe2wyD1O@kroah.com>
References: <Y5w0IMxCYe2wyD1O@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5w0IMxCYe2wyD1O@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.2-rc1
X-PR-Tracked-Commit-Id: f18caf261398a7f2de4fa3f600deb87072fe7b8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71a7507afbc3f27c346898f13ab9bfd918613c34
Message-Id: <167120642188.30725.8021662862848935213.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Dec 2022 16:00:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 10:02:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71a7507afbc3f27c346898f13ab9bfd918613c34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
