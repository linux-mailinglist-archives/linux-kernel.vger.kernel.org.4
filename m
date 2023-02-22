Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACA869FCB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjBVUGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjBVUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:05:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9374027D62;
        Wed, 22 Feb 2023 12:05:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84742615C7;
        Wed, 22 Feb 2023 20:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03155C433D2;
        Wed, 22 Feb 2023 20:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677096305;
        bh=4yo9aOb6AU9Imim8TKub/87u1nN1urjy2/r2pWE3YYY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aFpYOVKObre/VtORKH/7U0d3SB1noM/e77qER2vWW3JwW+6nmCAK/cIEyzGJ2ACnf
         JkxOeafzPHpL0YOMnJY5ua7W7CRYC6L3GmhJyk1/CA5shS37OoPtlMxCAXu3AwlNZV
         Jvs5ItxCi4flol6wtm58ac3KPUBdwFMRvmq7ilY2tU3AxxI3XOjnCdA+sYtD5TSKoN
         zNX8I/mRgXBn9AywaWS11Vk4Sj0kSazxIqnNg2CbjG1MWzgAi3pBgB/SMdQiE6js5S
         /yU7XOfM5mVWikJnyB0rZHiTL9c61KYXhYt2nvxKnqSMPZOL8xQzPAW+Ic5zcZKeeD
         us20kEFGXcO1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E50A8C43151;
        Wed, 22 Feb 2023 20:05:04 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o7poe490.fsf@meer.lwn.net>
References: <87o7poe490.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o7poe490.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.3
X-PR-Tracked-Commit-Id: cc29eadef921fe52aa58f32536a93d9ea0ca3eb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70756b49be4ea8bf36a664322df6e7e89895fa60
Message-Id: <167709630492.7475.11131050222713822696.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 20:05:04 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 08:38:35 -0700:

> git://git.lwn.net/linux.git tags/docs-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70756b49be4ea8bf36a664322df6e7e89895fa60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
