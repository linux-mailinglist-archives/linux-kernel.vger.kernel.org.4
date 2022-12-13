Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7664BEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiLMV4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiLMVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE6C240BE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:53:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC4F8B815D1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85695C433EF;
        Tue, 13 Dec 2022 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968434;
        bh=cLlddvHWU23X13aAts2QggPdk3zUAczOx8CbDXULHHE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QNAZGfxiJo2+7D5/Y7nmU3TXv8CbE5+mKtZqnE5bGzp35vbXMZ/we0+XIn0XmY7pH
         QXJ+9JmiHOz04WCWrxe4TrdD6zZuv9c5JGS+xxKtMjKlwCpiTGVzMve/rvrheo0aB+
         Eoj4ltUs6NZVKV4D2CPRxz5UmiJLjzOOZFFxsip8TWa/v/WHiQOy9d0KkPPZVrVQyD
         pLsYK3uJzHqU0i8giD+i97XLqjo164t2iK92voUvhsV90W9xWJ95JuXL2bHOk8pQco
         CLbhuifSM34aiyoG/zHFD0NXeEoMdVF5+U3R+0forLDsF2Up64PViaKo4o5+QdZqND
         e6GbrRMo9odqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76A35C00445;
        Tue, 13 Dec 2022 21:53:54 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212103221.19de8d3d@xps-13>
References: <20221212103221.19de8d3d@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20221212103221.19de8d3d@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.2
X-PR-Tracked-Commit-Id: a34506e08db7ccce160a259e4b00b1e307486c59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e4fa020d574768445fca2d9bbfe473ec8bbd224
Message-Id: <167096843448.13204.8890042185437082505.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:53:54 +0000
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

The pull request you sent on Mon, 12 Dec 2022 10:32:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e4fa020d574768445fca2d9bbfe473ec8bbd224

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
