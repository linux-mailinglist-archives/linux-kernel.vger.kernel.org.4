Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0168B66ABE2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 15:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjANORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 09:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjANORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 09:17:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D44F7ED5;
        Sat, 14 Jan 2023 06:17:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B788660AFF;
        Sat, 14 Jan 2023 14:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15016C433D2;
        Sat, 14 Jan 2023 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673705831;
        bh=76Eo+v4Q7tefkzplW7b6RVNNI+llnGU5klxSKe8aQZ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tE9f03bHnBqkglKj0CoNQe1f2lAkWz0Ns3U6iVniY1Q9H9CG89Xz9jRPeqL+VQX2d
         bjgahF9iiFGwmSCEuqz3ZmiX2XIbR0BqiPWWBU1LIOUy9YfZkAcybtdVrESw3SLUAC
         u1xaaMyVWMv+a3tPAMj0Opu4aVVJtYAYAx7H6h7Z9AwLpfI2jTmEewX0dlOlTCwwr0
         DcT2G2rj2B6kMjCipquIzs5U5UZYo+KifUgW9ZBGQwE/whBd/Le+WwS7eOApmx9oVT
         AOrsqREpFNEyXL5aTYfQNu3BBc2S0JVoujbROsfBopOzwZ0jkKyln8GxGlMg1pEX1s
         on2woGOQ96W6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA268C395C8;
        Sat, 14 Jan 2023 14:17:10 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <dae9db6e4507011bffe3beef9528c3dd7ee363a9.camel@HansenPartnership.com>
References: <dae9db6e4507011bffe3beef9528c3dd7ee363a9.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <dae9db6e4507011bffe3beef9528c3dd7ee363a9.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: f58c89700630da6554b24fd3df293a24874c10c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e768130857d08a6765f3287ad3f89c1b7d50e53
Message-Id: <167370583072.24149.7151261857788868933.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Jan 2023 14:17:10 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Jan 2023 08:48:52 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e768130857d08a6765f3287ad3f89c1b7d50e53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
