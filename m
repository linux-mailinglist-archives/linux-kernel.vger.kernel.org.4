Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E236DE451
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjDKSwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDKSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A3218C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5569362B00
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7F51C433D2;
        Tue, 11 Apr 2023 18:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681239146;
        bh=1qRqsxxXCARfjg3zHR7UivBKrEJYxIuIqt9skWMfARc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JCCT4N50HMjpOF+qTFyv9E5RF2LaaDlzPp99XAVbT+yQovnVlMUMf+p2ksWNgIB7P
         JzlysGRy2T/FvYKTvnuiKnq2h58ZqAUp4pEgUgUYvcZ9Dtx8Yd7F0QvpKZ8atqUyzT
         lrvQCvOQgABuoQKLE5it0mr1PmQDkuR6OLr2BAWICpv6jOujjAoKHmKctcnY3phRy/
         N9//O+niB3MtetZIN1n7AMKVPXmd6RfdOzJprUo9DwyxwQqsjdKAPxHIWu1Ydab7Pk
         jZHuLZibPSLlVdHNkAlBSjeZZ78EF9ZIK0BWinDI8F5PT6+n41gs77mY5tEL8VnFE/
         P2931ccxxWnYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94BD0E52441;
        Tue, 11 Apr 2023 18:52:26 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for 6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230411161153.60998465@xps-13>
References: <20230411161153.60998465@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230411161153.60998465@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.3-rc7
X-PR-Tracked-Commit-Id: 93942b70461574ca7fc3d91494ca89b16a4c64c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 793cfd598370cf9440d7877ddddda1251307f729
Message-Id: <168123914659.3950.5554766066652449958.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Apr 2023 18:52:26 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Apr 2023 16:11:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/793cfd598370cf9440d7877ddddda1251307f729

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
