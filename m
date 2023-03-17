Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911B86BF052
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCQSFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCQSFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:05:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6585D367DD;
        Fri, 17 Mar 2023 11:05:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED481610A7;
        Fri, 17 Mar 2023 18:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D92AC433EF;
        Fri, 17 Mar 2023 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679076335;
        bh=9QSB1PiXIAm1gt9SBmK8Jm1YhKADFlfSB/xSxtNIRvY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qpbOUgRW4P0C37WxHmGwimGg6FyFOWzW8Gaw2e8x/I1g71HVerr4pyLX9qa+/tMpZ
         5crYrMcKjNbUh9ysDCtK+M6soZCBRm3bpZNuJgVjHjdG+oo6Bccpa7WGzEZVn/aIL0
         dyWrdM3Ic/LXGXm4/v6rPczn86Py4osKtJMTi2T5JfOatcd7xqgFu0GB+pzyTw2UpB
         UfAgRT/Ist4dzvqo6LrPtXjC6Xap1lROb+427H2ogwyMfLfcaBCIX6DG0j0Gjuyc/q
         KInH8MA2eEQh4qX0js1jk4AiEYMFLMmp2gr81mxjLK4Y7rMDjunxs5RTNNuUKkkPLT
         VPcApZM8D7D5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4236AC43161;
        Fri, 17 Mar 2023 18:05:35 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gOXYVLXkPmk6_9r+Gwa+FXMdVXZBvjJsY--KW2MOC_tg@mail.gmail.com>
References: <CAJZ5v0gOXYVLXkPmk6_9r+Gwa+FXMdVXZBvjJsY--KW2MOC_tg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gOXYVLXkPmk6_9r+Gwa+FXMdVXZBvjJsY--KW2MOC_tg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc3
X-PR-Tracked-Commit-Id: f36cc6cd65204352815640a34e37ef39e56fbd42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abb02a824555c160dccc316971cbb802b3ebf4f7
Message-Id: <167907633526.25430.3224522014979511911.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Mar 2023 18:05:35 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Mar 2023 17:11:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abb02a824555c160dccc316971cbb802b3ebf4f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
