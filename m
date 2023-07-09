Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD5874C6DE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjGIRqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjGIRqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5D2120
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA61D60C02
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CC6FC433CA;
        Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688924795;
        bh=oA9ahBY1MQJgkvVoHm5KboW3jKAdO3eM5t2kJMSM/lo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a96PdzVqwyDfvm4OET0WzFAj1sOh7z8C1xfPyw3sX536aZRtdca3umBBt7Ep9eGsF
         PRSIO6XBBWJ4lkYNW7I/bd2WNM9GQvH0p9ceIJ2pqlWR7d5af8d6obaPjs7n6RpcY2
         iHWe2O2peVZGMhOiVLHhHx8BL64001AY9jvKYgCDz7jKauNDM5GaOsy0Nrw02dWyCt
         EwRfJ3AFTAdMPSlPaiqiu8kJuisrABtPsvktOkpVcISiTY31ViH88sGBGw1qW6jlqi
         SmfQkOKfu4LNPIy0+1p7Z08z/GCtVY2iu6SfZ0oegyEp9yhEsaLeEZ13K/RvbxVxbu
         tLL1D+RkS+2iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1ABB5E537FC;
        Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKroEFssSwC0Lnn8@infradead.org>
References: <ZKroEFssSwC0Lnn8@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKroEFssSwC0Lnn8@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.5-2023-07-09
X-PR-Tracked-Commit-Id: 8ac04063354a01a484d2e55d20ed1958aa0d3392
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f71f64210d698f603ab119740d1656f7bdfd3171
Message-Id: <168892479510.9789.6171708898049821666.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Jul 2023 17:46:35 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Jul 2023 19:02:08 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.5-2023-07-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f71f64210d698f603ab119740d1656f7bdfd3171

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
