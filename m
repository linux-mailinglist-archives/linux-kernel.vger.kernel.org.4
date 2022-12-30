Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF8659B88
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiL3SvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiL3SvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:51:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02E25F85;
        Fri, 30 Dec 2022 10:51:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 080AFCE1752;
        Fri, 30 Dec 2022 18:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 484AAC433EF;
        Fri, 30 Dec 2022 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672426260;
        bh=1gkjexlbXixD/Ce8m9KezHD+yhOtdTHY76LnIQuHK9o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PjMP7l74/gH0jQwNw8DM5o31c5fQ2WSLCjA5f1pgVfUq3g+EgmcWr/evqxAz7R9fO
         dkpff5MFeK8rxWb27pY+YYnKPDPlPOm9rZ0G6PY7jVYMOpnnjzvzgu1upAopGbiAY1
         Q0/b1HxHlFH6mRUcLV77dWQ2YNkK1zzMRs+Zn9rvpBU99OxPgb32cp3dfwqunW8XDX
         fcm8yHvzl1vi+Xb+fyvz0A33fKaL++WhqphCvcvNFbHAuRDGXZcn9K9/EWm8yRI/yL
         drz56D8WlXICaRMa4mXY1fhwOPZkDrCxLodNE1OTWv97dcwrhnnv8lcZLgFa7vk0Io
         sy3/mYgm9RFYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3172EC395DF;
        Fri, 30 Dec 2022 18:51:00 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.2-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iP4EgejNBO8EXejaSObSbpeuOh+vTz8CAvfu8bMXXTOQ@mail.gmail.com>
References: <CAJZ5v0iP4EgejNBO8EXejaSObSbpeuOh+vTz8CAvfu8bMXXTOQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iP4EgejNBO8EXejaSObSbpeuOh+vTz8CAvfu8bMXXTOQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc2
X-PR-Tracked-Commit-Id: 0948a9ef1d59d1bc7fae29f32058e463bbff4a6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8451c141e07a8d05693f6c8d0e418fbb4b68bb7
Message-Id: <167242626019.31406.3835683663655257393.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Dec 2022 18:51:00 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

The pull request you sent on Fri, 30 Dec 2022 17:34:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8451c141e07a8d05693f6c8d0e418fbb4b68bb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
