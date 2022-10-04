Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2945F4891
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJDRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJDReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BBE67176
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47F82614F6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16844C43152;
        Tue,  4 Oct 2022 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904846;
        bh=l4lQkgICGyCY9A8jhU0YL/qR3r5j4aDtBeB9oBPcvRk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JRmN7VeD/Ge/QsQsU8ObSGCxRZbVdn5wEdryP/PgGJSJ4U6oDHL1ejsU6im+luzGr
         aIR+oOWrQ7AwrLbe0JHqBG3cnebaqDRTEKg3B5p4PJ248sO11VCgPjSzLMwDFcxsqX
         WfX/axLBPOP4trK4auem6fnIX/GUTU8FzvmztvLzuEoxmSPxX0IB9L6v6pSdl9rAug
         lPFCwyKk+WzKd47BAmRvtq0vAyuB8JOcVFEbQtzmNiB4V2DeNM+BKEaMwxf281XfTY
         PIJjUiJvhUp1KPYXZSOB74eBVpW3Zejs8GH4zXFgeq8BUOhUfBsp7KYFnZBbHIWDcN
         NIrihjqY23Cpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06AA1E21ED6;
        Tue,  4 Oct 2022 17:34:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzxDHp4CEWlZwtmE@zn.tnic>
References: <YzxDHp4CEWlZwtmE@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzxDHp4CEWlZwtmE@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v6.1_rc1
X-PR-Tracked-Commit-Id: 30ea703a38ef76ca119673cd8bdd05c6e068e2ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3eba620e7bd772a0c7dc91966cb107872b54a910
Message-Id: <166490484602.22164.14891012234561993694.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 17:34:06 +0000
To:     Borislav Petkov <bp@suse.de>
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

The pull request you sent on Tue, 4 Oct 2022 16:28:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3eba620e7bd772a0c7dc91966cb107872b54a910

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
