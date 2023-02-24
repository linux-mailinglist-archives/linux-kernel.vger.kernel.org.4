Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2628D6A2396
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBXVQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjBXVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:16:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE25A6ADC6;
        Fri, 24 Feb 2023 13:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2DCAB81D3E;
        Fri, 24 Feb 2023 21:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B15FC433EF;
        Fri, 24 Feb 2023 21:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677273361;
        bh=DtTOwbJgctcgcTgsOtwzPE7/uhJV67BRa/Bf2v+xl+4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VhnArZJhUonp54ZBQ17HWTU0gjwopOemh12wA/F7vDYBQQqTq9GkOYn5+ZHpm8lfG
         wmyviNaZzmZRiFHmfV7QZBAnbjwLKSX5jS01/14UmaUvranhYmo768vppFY3k2mW8i
         GbkAOAS3WWkVFVIfQVDsG4Q8HVQFntVkFLq0g1evRpxNm0eBWfXs22c5HoJO8E8zc0
         E9IQ/wU8+vPcwviSPi87bXAxMZ09aoTUg3k/ZfGzyrHeG6aRsjxIS6KMMVNAmrt6dd
         0fkqxy6m2w3Ud2/sHLn9khQ2p0OS3DSQepKYuAQXWhQVbNpc6AFSxwK5URT5mi/lT6
         JGlr9MX/4fAXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 888F2C43151;
        Fri, 24 Feb 2023 21:16:01 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/iyrFP2wO97XvjD@kroah.com>
References: <Y/iyrFP2wO97XvjD@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/iyrFP2wO97XvjD@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.3-rc1
X-PR-Tracked-Commit-Id: 1243741f6b02b5f2c06bca910f894c333838f994
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72bffe7e1eb6cb82b90aa14cd786f3f5ede9e0ae
Message-Id: <167727336155.26367.8897217865852241190.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Feb 2023 21:16:01 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 13:50:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72bffe7e1eb6cb82b90aa14cd786f3f5ede9e0ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
