Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127C4714157
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 02:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjE2ALO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 20:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjE2ALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 20:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22787B8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 17:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C5260BEE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BCFAC433EF;
        Mon, 29 May 2023 00:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685319071;
        bh=63hQ2WLDoWWC5Pz/mOa8TJJ4lnb1Cuun8voMWjta4RU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HXDZQHOSIMcJo92m7A4X0Pe349uxUzrATmb0TL75u4dHCZ/cRMra0mKUE4pZ56JsB
         DTJcq7XUEqiFMRFQnpp584fwT4aJTj+5yiCGJ2xOZ+xrkJ647iiMxPTjj5rGiSbO3n
         r7cMqmPvqYgUFlaqXuNAzgkCUU7SqjsP0Pz7JR9pP8QSLu9uiEhs0zMioVbiVL6jJm
         NXrJIthRFyo3/6nrq9LPoc2oqE3xJ+87eGJNZPhwXR+qHHycgR8L6tMsy0a8DyPhFY
         oREYEFyb9K4T0tOGaEPrMYRCPZJmci3EKoxj0WOXfM7QMZ4xGLGVcXoffgo0wS2Uhp
         3Sv9VSLRhiMfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AE12E52BF1;
        Mon, 29 May 2023 00:11:11 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHOUGa/W46wBDwmv@matsya>
References: <ZHOUGa/W46wBDwmv@matsya>
X-PR-Tracked-List-Id: Linux Phy Mailing list <linux-phy.lists.infradead.org>
X-PR-Tracked-Message-Id: <ZHOUGa/W46wBDwmv@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.4
X-PR-Tracked-Commit-Id: 2a881183dc5ab2474ef602e48fe7af34db460d95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e338142b39cf40155054f95daa28d210d2ee1b2d
Message-Id: <168531907129.13206.12583291061164513017.pr-tracker-bot@kernel.org>
Date:   Mon, 29 May 2023 00:11:11 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 May 2023 23:19:13 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e338142b39cf40155054f95daa28d210d2ee1b2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
