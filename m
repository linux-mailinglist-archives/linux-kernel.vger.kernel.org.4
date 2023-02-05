Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C246068B195
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBEUgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBEUgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:36:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C859C18152;
        Sun,  5 Feb 2023 12:36:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C410B80B90;
        Sun,  5 Feb 2023 20:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 302CEC433D2;
        Sun,  5 Feb 2023 20:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675629379;
        bh=RZ0uaiSEsTTUg5fxqP4r3pZY+VrH0bjbEHxU3kOCjEM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GWFfIg6xlrV/YptLiB/gYg7EaJF93sv2Z5Bz8p33W9La1UGFvqU2L1bi6HZTyvG3m
         n22jzueJdNqCkfp48pT19TwYbOBSFM6rzi1lckgJVzbgOUum+Nw2b0u8mO4vkWcIiz
         m5CuGX9wd74k9nE+zjFx7ccir6vCDZcEXs16M3vPO1at0u59GcTMX7MzhiXoV/91W4
         3LFV/TPAZUNlvyBSlVQ2ZFAD89uM/ozAAjH3BCgvpHyYA9nxGxyKWiho4t/S7wno25
         7r2iPDxzGxVBR4hQP2QPG2T9OJUt0QRGG0XHb9b67ji3lBHJsUwhZvCs4P9VxxBPCb
         jX0mbPTBj/Wmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F315C4314C;
        Sun,  5 Feb 2023 20:36:19 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y9+Yv1CQKNP0Bwqq@kroah.com>
References: <Y9+Yv1CQKNP0Bwqq@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y9+Yv1CQKNP0Bwqq@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.2-rc7
X-PR-Tracked-Commit-Id: 226fae124b2dac217ea5436060d623ff3385bc34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc0ce181af6d1989192b973eae5f916cb6ce47f0
Message-Id: <167562937911.30640.598800892367481298.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Feb 2023 20:36:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Feb 2023 12:53:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc0ce181af6d1989192b973eae5f916cb6ce47f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
