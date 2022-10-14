Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58775FF437
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiJNTpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiJNTot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:44:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B213CE1A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5EEEB8241D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 19:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66217C433C1;
        Fri, 14 Oct 2022 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665776683;
        bh=cRhyyG0TAV2ttRqV34DFWDMFjy9wzrETPovfb4xDjGE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fdkGBs28NAcg3G/KYpCLBmeo9gJQ4Xng/PgYTWyAM90C5bpIgtGCQmYtVYcPLCXiK
         3BslisnxlnYDe8G1yqaIwkRrksxC6FRgvBuuZHhOi6clIkz3dyr9olK8gqlgdhCpXM
         4i3tp/jo7PfJuqqiqEzGJq822VP/7bGyxrAM7LmmwVEKdLsxti3hWJ01SppZqnVyZx
         e8CTWFUxfX0HgYi475uKP8XyZ2hv7VMpZxWf3ZOIwh8447uHBmVy323UMvNr6U0ySh
         G6yTWUtMnFsog+rv9EZmyGNeSGkVVNedxBFKD6D0aZgdQNqYdiMdUEKBk/P43W16U3
         1zXJqB5wAH6sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52F53E4D00A;
        Fri, 14 Oct 2022 19:44:43 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0m3wla/xisWPOkN@arm.com>
References: <Y0m3wla/xisWPOkN@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0m3wla/xisWPOkN@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 0e5d5ae837c8ce04d2ddb874ec5f920118bd9d31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1df046ab1c6520911774911f8c710ca8e981305c
Message-Id: <166577668333.9115.8508332485606060661.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 19:44:43 +0000
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

The pull request you sent on Fri, 14 Oct 2022 20:25:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1df046ab1c6520911774911f8c710ca8e981305c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
