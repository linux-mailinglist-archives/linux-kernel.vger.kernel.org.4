Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F10626655
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiKLCCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiKLCCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:02:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E156AEDF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:02:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13D4E62174
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 687F5C433D6;
        Sat, 12 Nov 2022 02:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668218564;
        bh=63NilJfGca8xOAYqQvwQiNIrswZr6lvOp2WexDlyel4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pzbLPEjaaNb6OeVOiKa2Ufflv2giion5pucPy6U/g8fWBpcdnjMXErzk4C8yvjSD+
         8CR5TV1y2YHW2cGf44kx15GB1oeJfOyjfLG0BkORrBc+eb9rxj+z30/jgKelLtkXx0
         8VGPo83S1PsHkwF8Qi9Gk7DR/jjElAM9juWHnRkpjdI/mx4LffG8LAO5T9LoCyYnCy
         6zNDlJZkskWiCD4Isbm/bwd8IZchUPaDGqI8aoj7pMGcOR7DySEo4nMMsj4opl3vaR
         +SV+K3mn6uDXhzqQFGBeZ7gsputM1fDa+A17IkvYaw/eUDotLrsYW8ekFh+c0p/snO
         rv3CLpeq8rGkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55EE4E270C3;
        Sat, 12 Nov 2022 02:02:44 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y27V9E6qezdKTFQB@arm.com>
References: <Y27V9E6qezdKTFQB@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y27V9E6qezdKTFQB@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: acfc35cfcee5df419391671ef1a631f43feee4e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ad6e7ba98c29d61794a3f216414d8542a3e476c
Message-Id: <166821856434.28551.9925269338163369868.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Nov 2022 02:02:44 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 23:08:36 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ad6e7ba98c29d61794a3f216414d8542a3e476c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
