Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0042E5EC6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiI0Olw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiI0Ol2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:41:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3911C770A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8687B81AD7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E561C433C1;
        Tue, 27 Sep 2022 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664289424;
        bh=jQQR5S3NFeN5udTX8flDsKgHoNCgPjncDfZPbucpLYY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dkgaUyDUgXFbVF8HrG2AcQF+TRH0sTstityCqjZTh6rc0BFF9ORXweKtlPCPnpCwh
         Pv7ZsvDkodHXdeBMnkFAVVQmk4q3XmaIT6hXpQhLJJmJFVj8qlGq3X9eRL+VohBnAT
         sNj0Bjj4oSCf/eeuJ6y0UslaDEc962sPDLZufXZr6l7te8uZqwQ/ljFpGO4P7qxdhi
         RO6j5TDuq4PJDtMRrHXKyVP2NdBI8kKBU/3LAT/+8GRQF/ieMTSHL+3+4InB+iB5gH
         VVgEUz6MA0eeEv2E8ZhyxdBje2zdRKPqPoOpA9P7Y+BAkFXFGvuHSSLcw9zYxGXK0n
         +TNR2rPyZ0QuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89934E21EC1;
        Tue, 27 Sep 2022 14:37:04 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.0-rc8 or final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87zgelfcdz.wl-tiwai@suse.de>
References: <87zgelfcdz.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zgelfcdz.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.0-rc8
X-PR-Tracked-Commit-Id: c35fbea48659ec99a4f532c9ee9e8692405afdd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46452d3786a82bd732ba73fb308ae5cbe4e1e591
Message-Id: <166428942455.13436.281055190392989930.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Sep 2022 14:37:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Sep 2022 10:30:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.0-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46452d3786a82bd732ba73fb308ae5cbe4e1e591

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
