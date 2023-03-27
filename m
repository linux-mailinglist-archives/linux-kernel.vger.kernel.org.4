Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379226CAAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjC0QtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjC0QtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:49:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC38E2D40
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6344AB817AC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 166ADC4339B;
        Mon, 27 Mar 2023 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679935753;
        bh=rNL1rLg8B2aGmbPYXXGpJmZP8QCaLpvsaHJwl1UIo5I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pRjGnv1m7ql1SO0zy+RhufcHQ06MPmq1ZmxcTZRUA799Tcz/qMcNerUqwlpwE0B5K
         jHLyC82T50aY0/warWB5jD1ZCSYWzF8a6kCLrI/9S6uAJ3Z/Rgr/Eb8AGYZ5G6Y5wE
         zkDV5m9HT81NrN4DV9tPD/S+H6vsWdKV8gm8JXmrvNUOWujL8OEkwNRHSIivML9OS1
         xpD61Sn4S+cfaKKsp3dD+2SdE+KCFx/LrWpwX743m9SyVqM2lSRhVd7uc/flMQFa3t
         syBrlGlN0LQDl1sjA63jLSfYEOWPVcookFFY8HKyyDHupXbKLKeUWSBq7Xx4AXmvmP
         Nf397iAsh5KWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01FC1C41612;
        Mon, 27 Mar 2023 16:49:13 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230327101605.5cfd4f66@xps-13>
References: <20230327101605.5cfd4f66@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230327101605.5cfd4f66@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.3-rc5
X-PR-Tracked-Commit-Id: e732e39ed9929c05fd219035bc9653ba4100d4fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc5d1a9233eef4a3656712994e5bfa0c0470ebfc
Message-Id: <167993575299.25802.11476218664320326531.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Mar 2023 16:49:12 +0000
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

The pull request you sent on Mon, 27 Mar 2023 10:16:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc5d1a9233eef4a3656712994e5bfa0c0470ebfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
