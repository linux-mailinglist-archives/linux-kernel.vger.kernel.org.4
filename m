Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F04652353
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiLTPAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiLTPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:00:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656A6E0C5;
        Tue, 20 Dec 2022 07:00:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01268614BB;
        Tue, 20 Dec 2022 15:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66C95C433D2;
        Tue, 20 Dec 2022 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671548404;
        bh=RhhYveTe4PV2aVo5QXa0aTaNJMH2Z/t2DTNsTsnzQwI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kv3Y/OJ3D4vaoY1GAX/sAd2EoCl9LL2vSOiDtcE6VkTdnQxOUOtbDzm4f2Q9iAFbf
         UEHGHpJkt/4sj0bGyBuy2biEc4Y7puC7Ws9Tzhtra2kxskx9QP0GDokinPT3qKbGJm
         /xWGsYZ9H0YY9IXzIak33ohIIFcVbTR3qycgJHDXNvEG6dMLfoeGwx8eNAUBRpbY58
         H7IfUJS9gM3gM9T8yo7TOoOg4drBPm2tIK9bkuK6DcsqPSXfkffW/+56uHTr9b2xS9
         iyl//KCfD/lnM1n2xDvWBabiEHEVGAaBjuRUL0Oi1fXh8NXQkRegLPYqLX2N4wM3wn
         3n4CBZzuwQZAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4405DC43141;
        Tue, 20 Dec 2022 15:00:04 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ac9f88a2-de77-d753-d1d6-210fca529c71@linux-m68k.org>
References: <ac9f88a2-de77-d753-d1d6-210fca529c71@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <ac9f88a2-de77-d753-d1d6-210fca529c71@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.2
X-PR-Tracked-Commit-Id: af5d74e32eb8e1b833f687047f0ffe3801d7229d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
Message-Id: <167154840426.23352.1774236829731804686.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Dec 2022 15:00:04 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Dec 2022 08:33:16 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
