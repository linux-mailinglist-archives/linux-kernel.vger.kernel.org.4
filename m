Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40DC6BF054
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjCQSFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCQSFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:05:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C104D41B;
        Fri, 17 Mar 2023 11:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1012B825D6;
        Fri, 17 Mar 2023 18:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BBEFC4339B;
        Fri, 17 Mar 2023 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679076336;
        bh=az8nmkBCcqi3PsA/EfMdDq7Vjwa1APyXtwaGbFfVvCI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W9COpszKR2LWWjFRXuV4QM5UzHE3Zj/ovvn6n7g8oo0OYDlXKnHeIDeSD/m2zHGW0
         4YOOI1ldjTBE0i/RFnaZ4dVfhF1EU+LXL0KfVcNhhqmkXLeTGcdq2VPCkkjYJUA+1U
         lY+U095kaWhUMWunAkk+5ayZrsWhCcLe3sE/QUrfIDhmbJ4STJLSdJv7koSKa5yDX6
         5U4eEej8gsXGWi1GxKpY2ImHW7RkRec9tseWQl9at3KiSUQ6Vwa5p8jdeZq65zlz8g
         E206oEOxgm7814CZoreidecxYhHBGBfb+PIGjMwtPEkBOYqKxwfJOisKv0SvAs9ifv
         cy/4ZtqWRjq6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F3EEC43161;
        Fri, 17 Mar 2023 18:05:36 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0haUo_G041D4N7D++MBOHDX=z04sagWMs7BEmV0sjYUDw@mail.gmail.com>
References: <CAJZ5v0haUo_G041D4N7D++MBOHDX=z04sagWMs7BEmV0sjYUDw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0haUo_G041D4N7D++MBOHDX=z04sagWMs7BEmV0sjYUDw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.3-rc3
X-PR-Tracked-Commit-Id: 1fa9d47baa9e61ff973e03f0ef26f5b78d545e37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02ef7d39fd552cf9e1de58a3003f77e743d1fb6b
Message-Id: <167907633619.25430.2425855293318268059.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Mar 2023 18:05:36 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Mar 2023 17:12:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02ef7d39fd552cf9e1de58a3003f77e743d1fb6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
