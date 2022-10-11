Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA745FBA44
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJKSYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiJKSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22B378BDE;
        Tue, 11 Oct 2022 11:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2653561267;
        Tue, 11 Oct 2022 18:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B266C43143;
        Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665512530;
        bh=Pg7LsPeRm+DrParGzVWTDfUCb4Osp6UwQq6LYQn9Eww=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cwp2hev6Cu1BQquMlWOhfF/uHt+R58+VAPN0KSgp4whYqocXk93wICWa3+8sgVG8g
         xEtiQrYAeQYA5ppsxDizjRB/MevOq9+SRaA/BX4pm70+E1twWDPCKAmuvc8dzPSp3y
         SlKK4DGp78C3yoEe7zsfdPn/6xXwYu6McqL9VHAeCq9RoIQkRo+m1zlEx6lNpwDrsi
         rQ80y6V4X19bVH6fyKwE1GaXgkCMlN35JTpFZqsVVRteY8KV5Mkinnj5zL8UuyFRje
         c4dl7Hs+K0Gm7ASFMhGh34cY/LeMxEqmD8Hru7SW5hVuXZVSQ3fdgNxWXxg2q9codw
         EWenTMQEeV1xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 794A0E29F36;
        Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
Subject: Re: [GIT PULL] bulk pin control changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdY1Z1xZQ2PDDn7gvbY4C04wbX9GwkDqGM-gzQsN+QkxdA@mail.gmail.com>
References: <CACRpkdY1Z1xZQ2PDDn7gvbY4C04wbX9GwkDqGM-gzQsN+QkxdA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdY1Z1xZQ2PDDn7gvbY4C04wbX9GwkDqGM-gzQsN+QkxdA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.1-1
X-PR-Tracked-Commit-Id: 9d157c89c5569f0ef560b7a5b2d7bf59ae98499c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 979bb59016aed7c7c58baca2307d9d13890cc6ab
Message-Id: <166551253049.20259.14807089664246189853.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 18:22:10 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Oct 2022 23:03:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/979bb59016aed7c7c58baca2307d9d13890cc6ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
