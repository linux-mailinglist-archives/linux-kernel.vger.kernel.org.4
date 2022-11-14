Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9D7628AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiKNUq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiKNUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:46:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673C621A7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:46:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E046B812A7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 20:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4D7BC433D6;
        Mon, 14 Nov 2022 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668458810;
        bh=pfkQzpXnox+/vFrlO3KBNC9jm1ZIhKQub9+94Y9WFcA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JO0FkJWsJT5s6PpKG4n5RDYweK2mremdHMoNAIks8P/kdDU+HqFwaMttAPzfSm3ci
         v7ce7YYsfBQvW8nq9GzE4YL+xI14dQ2pjrgOpqBdoCpui6BaVQcxBkMAjuy0+ORQ9n
         9Shf2GSHuKwPpUJcwjRq1WwSSvzmKIhDPH4aTYcOuUAhhtmefEXockAtp7nLCo4PY+
         3OSK6Y1gOqiMJ1cKA+dDHmAIyWzAPEwPRKzhZYJ+69L7WNsqhA9KKDqzbyCpx0PNzk
         WlNSH7+GQ1F149x2TMOJtNE8RZ73Ph7kikut93jbLNmAeCWL8czcrUKFZiO8IUYfak
         06tty4q+fYe4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2BDCE270C2;
        Mon, 14 Nov 2022 20:46:50 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for v6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221114101140.339e0d2e@xps-13>
References: <20221114101140.339e0d2e@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221114101140.339e0d2e@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.1-rc6
X-PR-Tracked-Commit-Id: c717b9b7d6de9e024e47f7cd5bbff49f581d3db9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9584987fe71ea9d6a5813f61be6aec4616978af9
Message-Id: <166845881065.1688.10656738432182515658.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Nov 2022 20:46:50 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Nov 2022 10:11:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9584987fe71ea9d6a5813f61be6aec4616978af9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
