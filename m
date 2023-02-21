Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17169E5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjBURZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjBURYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:24:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D39EEC53
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:24:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E27EC6116D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEEA1C433AA;
        Tue, 21 Feb 2023 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677000284;
        bh=vUfuxyyjt+YqgOPoYLSWlrjERFWPPXAeyJTncl8p08E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P9f2pz5F8aGOlMj8//+LQthaPygSpQZ1gkffAIT91Yp3X0KGuehQPN5IvMKeYBW7z
         caUch/cQOC4P1sIK5qI070cHOC5jy7WCQgNztZPjLtlM6wCHaeftxcVS6rehgAhwLG
         +beckCz77p10WFo5WNsLK7lYMUp9SYzreqHyIUB+HKwsIQxLWwhHvjnrJBncfjIUok
         GxRIlIGM3XgZkvCP7MQm7JvcuqjVg89hodU1JYfYXYy5okyCYuycMa8O2goS3KTQ4A
         Kz/w5I+o0whr1CDaONS3Ee9wutWeIk7FgudyoHlGp758ITwE9TCbRpdsiD6WnHZpXo
         Cx/S2t3t8HPhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D420C43151;
        Tue, 21 Feb 2023 17:24:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86/vdso for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/O7WByYDrjPy6sC@zn.tnic>
References: <Y/O7WByYDrjPy6sC@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/O7WByYDrjPy6sC@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vdso_for_v6.3_rc1
X-PR-Tracked-Commit-Id: dac0da428f8dfb23666ab4ea54a7768c152b857a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f0b0903fde584a7398f82fc00bf4f8138610b87
Message-Id: <167700028464.32027.4945247071877943768.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 17:24:44 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 19:26:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vdso_for_v6.3_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f0b0903fde584a7398f82fc00bf4f8138610b87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
