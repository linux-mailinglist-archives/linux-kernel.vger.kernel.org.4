Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2E6F25C8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 20:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjD2SUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 14:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjD2SU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5B62D61
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 11:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5CCE60ADA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28DDEC433D2;
        Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682792420;
        bh=cMqk75XlAhvGuiBAFQCQ7NPSmhkybF9jgP3OfQpiZGQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cuqCyn4xL1giMl/zE3Ouof08R4RctYIcTMN7ynOnvRxZ48uK99+8kWrhPDPLwmqwS
         arL6EV2cJHpzpLeqiJW8ouuhrvykyKsWf/ifDI3SMGJ/pHldmWdQ+Vy4uE09pbwT33
         pvgqmIuID8jzNQ2wJTilsl8f8FwXjAvTjrvvl7d3cOOclpLxHA31C+M1OLRfOM0WHW
         AWIJo49FgCdtIqbOT/QIsIOmQRM7XUdaDX4V9Kq8JUb2Nh9cLcXGgemPibwSosMN3l
         6NriYQKW1KqOog6W8asZpiyHeEI9n/MW44zg+XW2OI31ZuK33xiSL0MH984SNiqOlx
         2UZ0SzJE7lIDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13225C43158;
        Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZErcro8_Ylius4wC@slm.duckdns.org>
References: <ZErcro8_Ylius4wC@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZErcro8_Ylius4wC@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.4
X-PR-Tracked-Commit-Id: 704bc669e1dda3eb8f6d5cb462b21e85558a3912
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd546fa325161fbe374480a5081b6ebb7d1bec95
Message-Id: <168279242007.22076.9300379175343395346.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 18:20:20 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 10:35:58 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd546fa325161fbe374480a5081b6ebb7d1bec95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
