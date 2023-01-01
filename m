Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD965AB2C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 20:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjAATac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 14:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjAATa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 14:30:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169BF2ACE
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 11:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3AC160DF9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 19:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06F44C433F0;
        Sun,  1 Jan 2023 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672601426;
        bh=iYiUrdUiKDwKkaDRbBfUb/wRK5AHn+//N77Ef4Amozw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g0kltRF4gVAGJ2Xska4Em0exdh/WN2FyMQ+rbuggt+sAD2+wMJV89sWQvy1qBG9K5
         WwCv6kjADJtNs+CGLoqU/XIRqj//Td1yyaMdiN+lZvKANuhblKOKTFQYFnC8t3T7fq
         0rkjV9PK6DU8RwP6+/AB7yy8DAfTeIz2z5CjD00jGgrRk9/ULKBzQbo5TsKBJGKsJP
         dUUEuFZipvq1aJksfH+TUzHIzJ1T2okNMuxxQR4Sw441GGwe8l+aluWOtJz0qP6pd8
         dn6cPLBVZUBW+y8IJq851wmdKDOlFzkGoa9wlVJ2QQgyD0lCS7QWAztvGoexDSnxZD
         kQiqVU7ZhLljQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2EBBE50D72;
        Sun,  1 Jan 2023 19:30:25 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.2-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7GhrV4YgFGdiHFP@zn.tnic>
References: <Y7GhrV4YgFGdiHFP@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7GhrV4YgFGdiHFP@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc2
X-PR-Tracked-Commit-Id: 63dc6325ff41ee9e570bde705ac34a39c5dbeb44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b129817aedb03d94fb960e7a34d0f5eaa20a2f2
Message-Id: <167260142592.13445.4577217298365560614.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Jan 2023 19:30:25 +0000
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

The pull request you sent on Sun, 1 Jan 2023 16:07:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b129817aedb03d94fb960e7a34d0f5eaa20a2f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
