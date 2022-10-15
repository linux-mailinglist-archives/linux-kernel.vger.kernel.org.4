Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB19B5FF7F0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 03:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJOBpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 21:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJOBop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 21:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA3A63A2;
        Fri, 14 Oct 2022 18:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0FB261CEE;
        Sat, 15 Oct 2022 01:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13BDEC43470;
        Sat, 15 Oct 2022 01:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665798282;
        bh=vVHGuInN0eBpbxhFFJ5OaIu1wSTQgv+E0/kGdeXq/VE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=std2aTyP7juiQ9HQORmBKwYdT1dVf3p/s8uezVkdU6b7OMQX3ifGVsfpkNfvDmRHT
         ny4xY34a6TaCz1ev3hx52dW4RKIWXjZ3Gk4LwwX2AnlIBTLgKzWJmqJicG5IidKoSN
         c20vMmhSpl4yNUKqXEUFMDV8wT2u7vBdXayQMuniBUCDxkNY+2ry8EQHqDm1yAzOO1
         JYBrzxOVZ9pDwd5gjd8kHMTMBNr6LvphxBxajpl1ZYmWGBNNg8yX+zMI0qtwXRHOIw
         QXJ67lT9igMzSAMwuHnGyBP+s/BxrLmAW0ouQ9EzKDn38BDIMW4MrmVnu3HXR5k1wU
         aAc56IsHxuErQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00478E270EF;
        Sat, 15 Oct 2022 01:44:42 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0nc49iertOPOB02@mail.local>
References: <Y0nc49iertOPOB02@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0nc49iertOPOB02@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.1
X-PR-Tracked-Commit-Id: e5f12a398371280649ccc9d6eb0b97fd42a5df98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7270c69a36efc61ed6ebd31a8a458f354a6edc0
Message-Id: <166579828199.8004.8199192112539505205.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Oct 2022 01:44:41 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Oct 2022 00:04:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7270c69a36efc61ed6ebd31a8a458f354a6edc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
