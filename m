Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2504B6EEBB9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbjDZAuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbjDZAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:49:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D5C19A53
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03D2A62931
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 669A0C433EF;
        Wed, 26 Apr 2023 00:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682470179;
        bh=eCbfVqwNE0EJt2oBf6tZ+otxgY0IszuAIAtzqQEmGaY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tAgV3w5haxOc6S/kNbvUfHMMU1E1v50e22Ovfvi9h1tDHaHVfd+knXKcpqsjFFbvY
         MycjfwDQf4g85JUpQAqgveboMWe1XnkWyZYFKmvH+8DhFMNJiUIoRHix8xlSBL/bEb
         af7C/ueUuUQ/TxvFZ2dH3JyjQa3LQIbkorTX55M0E92Qdh4XdM7O+7azcgBj3D+02w
         EHuQHCsFAR9d/gyTLV6/bNf+q12NJnCLUF0ToDvf6R4AJsyVBZb4sXGpKXgJkfq6I6
         6Q3QHkgu9fId35Dt0b3t6RxMmZuJUzr/j7imb0vrvtb1gxqqWeQ4NeVelh45D9DdN2
         Kj2XDRI2PS3nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 565DEE5FFC6;
        Wed, 26 Apr 2023 00:49:39 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230420182923.0dabff59@xps-13>
References: <20230420182923.0dabff59@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230420182923.0dabff59@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.4
X-PR-Tracked-Commit-Id: 7227aacb62aeb59b007a6d3489b11f78fa332696
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb8322d714ea98fdc620d682fb517b50ea282aa5
Message-Id: <168247017934.10866.2461783282598090002.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 00:49:39 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Apr 2023 18:29:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb8322d714ea98fdc620d682fb517b50ea282aa5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
