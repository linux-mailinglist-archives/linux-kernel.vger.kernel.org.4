Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51A264A9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiLLVwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiLLVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:51:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3081A23B;
        Mon, 12 Dec 2022 13:51:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1E53B80E80;
        Mon, 12 Dec 2022 21:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 826CBC4339C;
        Mon, 12 Dec 2022 21:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670881895;
        bh=PXg7tM5qcKG/Qx8t2jRnJ/qhsvOgMCw2AcVGwN9Xrmo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vOTyJIXZsubHCprA6BatUWw+QAVTumP+UStzPww1EBfdLWkoSdwZAyJpIXFE0UBbH
         11RP+lg4YFMcaI61+vD3wiLyeFQWdBS8Pe0eDj/4VlrrkZsnzZS6cVrgeQgvzkaB/O
         T1qFnewhfEvY3wrknxPEfjvUpISgoF1TzejHnu4Es71S93WoDbH+EN4+Zdu2wKT6p2
         2iLBuCNew4pe+vkEFbjFKzsfzarAVL8elHGEm9jbT4HE3gdsNj0cVOOCZmztHdqjwA
         LDdNC2S+r+lxv6BuVwkr+DvSln8cPHJB9M9w15F6LAnkTbLPjCeOXIS0+zqC/uz69k
         hCYmHsKQXcm8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D772C00445;
        Mon, 12 Dec 2022 21:51:35 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j=CNHAC-H9ci6qpTEeG4R1TD78oQWoKZXALN4TzPZubw@mail.gmail.com>
References: <CAJZ5v0j=CNHAC-H9ci6qpTEeG4R1TD78oQWoKZXALN4TzPZubw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j=CNHAC-H9ci6qpTEeG4R1TD78oQWoKZXALN4TzPZubw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.2-rc1
X-PR-Tracked-Commit-Id: 75b15aa0d83ec835082129b62e8cb9a44703ad72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 691806e977a3a64895bd891878ed726cdbd282c0
Message-Id: <167088189544.24990.4287959833150930516.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:51:35 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 18:33:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/691806e977a3a64895bd891878ed726cdbd282c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
