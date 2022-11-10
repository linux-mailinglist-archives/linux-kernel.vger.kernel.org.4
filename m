Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB676247DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiKJRDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiKJRDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:03:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D427559A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:03:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2F02B8225B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 918BBC43470;
        Thu, 10 Nov 2022 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668099808;
        bh=2zWxq9G5Z3Qp3UzMKSgVQ9gzABJTLOb3y0n5WgERy5s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OF4DMbfwi5brYE1WFxI21tBJd8Cj+5msDSIib/7r15XtHYHU7B5Q01F4yZ+vsmaUN
         uBgYJ59VPpDO71i8RYMC53qxUZJdIF0NqdkL5VF4g6Elqe0fDt2aCTQo7cG71/hN5L
         GImaAF34Jx7WlQOYG8Yw33zHnw3uS00HzZoLxJ1jkY6mlbkISE1zHTx5B3tn7z6tgO
         EArIG2nj9502Was9dzbp47okAxbdiCylrYY9fQYZQNE3CB3eazP+r+Z4MQZ1IY426m
         W7m3wq8jMvOXm4egtP5KsAwXNXpBiWtIXOZn4nYZ9AkGD5nvofuE/chdqi9mcOLXKG
         4S1jDiHh4Bk9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B32FE270C6;
        Thu, 10 Nov 2022 17:03:28 +0000 (UTC)
Subject: Re: [GIT PULL]: SoundWire subsystem fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y2zH4zDyx5kWaUvz@matsya>
References: <Y2zH4zDyx5kWaUvz@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y2zH4zDyx5kWaUvz@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.1-fixes
X-PR-Tracked-Commit-Id: 49a467310dc4fae591a3547860ee04d8730780f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f014699cca9a9a28fbdc06a9225b54562154fc20
Message-Id: <166809980850.1852.8104462134780924194.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Nov 2022 17:03:28 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Nov 2022 15:14:03 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f014699cca9a9a28fbdc06a9225b54562154fc20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
