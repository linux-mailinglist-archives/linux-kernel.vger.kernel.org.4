Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0F5611C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJ1VLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiJ1VKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:10:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6008E46C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AACBBB82CC2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BBCDC433D7;
        Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666991449;
        bh=pw60f0IAv98N0+nNtxaxF5MxJoI2yGT2FSyL8PfwSXY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PL3v11kvkPYrZHmoqSL7wcfLpvNkufXlfgQ36oqC6wTQ58qDveTHBC2KG5BjWmRFR
         UtFHU1ialEQRRpBELv58Cd0SlZup7lfIFXgOxfORqNQ/TfD4p9bX6GUkiSVY45Ha1b
         sqcjyy6DKoeUj/JSPY+Eo9MG/Db81YqfkyPRmQraAxIHbkv0RL11eMcOWqN3G9tMdc
         tTr9SSAsH64neh+bsggOfHAfyPu3OdcEK97S/AROiiatpgRKiOBwG8/+wgP40W88um
         7Xct+JBfkC7VT+k5prhC5sRHSGRjg19ivRM3MtrhvDTWnzQ5/Wlnc4z6lTBJ+nM2kU
         tg+7KRK04Ecig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4695EC41676;
        Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for v6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221028113111.20508656@xps-13>
References: <20221028113111.20508656@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221028113111.20508656@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.1-rc3
X-PR-Tracked-Commit-Id: 05e258c6ec669d6d18c494ea03d35962d6f5b545
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eb824f68d8c33e05f2003773f44ae2eae5892d0
Message-Id: <166699144928.13387.8911392429273513864.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Oct 2022 21:10:49 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 11:31:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eb824f68d8c33e05f2003773f44ae2eae5892d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
