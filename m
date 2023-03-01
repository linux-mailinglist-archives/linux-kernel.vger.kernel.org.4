Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0690F6A6410
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCAANi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCAANh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:13:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC453756E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:13:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 844B361214
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4B02C433EF;
        Wed,  1 Mar 2023 00:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677629615;
        bh=MJh5PKsdcP4hnUw82O9EukuUPqZp4RRy7+s8heOUysw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C4hg/vbeSyuUotVloQCRCnLqcPRNV1R4l1H7HmguUiZPRp08bQ/sMyQjgeMTBQWKm
         +TaRHW8J/h8MU07Z7xjy3Phq+olP7CkjRYtzv2ardjSryFMX6M5C20P2awuh16idYB
         roGSXBR1HuNUt1+e2kxNCEYokI2LXFV7WOeMWoYCTYRDKBOM/IGCWYaaVWvojjUlzs
         hFmKz67nFJqhBOBhtX+ib7Lny3AA3vpAv3KZvUXvWEmMorwfKEA2y9EhbRZBfOzXhA
         HmBiWmsy57rgl1N2USSSyNqI4g0PGvgNSfvBSnzkrzAxruWrL8tAV3JUYMRVo3/bjc
         oiUik64Svro5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D40C2C59A4C;
        Wed,  1 Mar 2023 00:13:35 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/6KWc1az70PQB+/@mail.local>
References: <Y/6KWc1az70PQB+/@mail.local>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <Y/6KWc1az70PQB+/@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.3
X-PR-Tracked-Commit-Id: 510d2358c466bf6588034f0d3b2266eed2bc0a51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1899946aaf2566c577683ebe510a83c930cd3751
Message-Id: <167762961585.26350.17098698339265205379.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 00:13:35 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Mar 2023 00:12:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1899946aaf2566c577683ebe510a83c930cd3751

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
