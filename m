Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908C764F98B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 16:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLQO75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiLQO7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:59:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60D515823;
        Sat, 17 Dec 2022 06:59:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 922FDB80066;
        Sat, 17 Dec 2022 14:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56C74C433F0;
        Sat, 17 Dec 2022 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671289181;
        bh=PtlEX1lav2/DIeMqNcGXCsW+FiY/EjlguDEL1ddMbkc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T6m6G7ckApd4w70jBGTT41rcTphPUWjrd2U30A+0NCEmTdpBn0RBZBzCjboM4QPSv
         PyLCoWSoWqLKnjFBVilc1+NfoUT6mSzOaAvObirdtSFXnVYrgft5OceSk4PUtGr1MN
         4UxIlTtURRoAxCue9HXkZK8PR5488CINa9WStuzzqjYElw3UInxtl2pYFp4Y/C5kcu
         hsmeY8a65UbdN7qynz6Z9fLsX4qvU5yeVn0HSadW5Ra/zwTxoPux9IxNZERbDvqCIa
         7Krllf9RVb0S2T4ywYLODPSWRLiW33NvyCFOZ28PIpdhilMtA5nEgoN7RourHN1gmH
         O5BCJTJnYMD+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D58FE21EFC;
        Sat, 17 Dec 2022 14:59:41 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221216211508.dxifq5nrw62jh75g@mercury.elektranox.org>
References: <20221216211508.dxifq5nrw62jh75g@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221216211508.dxifq5nrw62jh75g@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.2
X-PR-Tracked-Commit-Id: 104bb8a663451404a26331263ce5b96c34504049
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b220f31147d7b5b504c1d27ae0d631f5bb1964af
Message-Id: <167128918124.4586.6375104042563826855.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Dec 2022 14:59:41 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 22:15:08 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b220f31147d7b5b504c1d27ae0d631f5bb1964af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
