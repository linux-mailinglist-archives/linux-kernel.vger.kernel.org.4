Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8B713950
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjE1Lqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjE1Lqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:46:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D32AF
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 04:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A9DE600E1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 11:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1721C433EF;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685274402;
        bh=mA+PKFe5HPkfemcAhlqNMNhiGFX7mATR2DiidmgTAB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Be0HenrOyan8IAEHcLnSVWsLpT73mLnT98UED1mqM/W3FXAVwIp7tyhUDNtOv+TlW
         7FTXTnA5WSo5Wh+p/pZe89aXNnBO4ZuXnOG0DRDiSNMITo887a48M/1fxJplI5vG4v
         xdrP93NDp9ChySh+3KE6aS/jj42MtSLh8GhOZgK6G4CZRGJJEtBnljHHaisN8B7nYG
         p5WGejwun97rD3K5V8+4OFvA+Q/T8kZPVAgAGRKlQJlAt5Q7T9uhazYZA2XX9mtWKF
         3mnMAeU19+z/nCMONzXh9LnN8xaf0rtO1Ze7Agd4vPmRME72oGshsh0d1nsXdAcJwQ
         hAbCaiNrEA7oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8635BC395DF;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
Subject: Re: [GIT pull] core/debugobjects for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168526035687.3457722.2945763857032013034.tglx@xen13>
References: <168526035526.3457722.14103350194452732675.tglx@xen13> <168526035687.3457722.2945763857032013034.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168526035687.3457722.2945763857032013034.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2023-05-28
X-PR-Tracked-Commit-Id: eb799279fb1f9c63c520fe8c1c41cb9154252db6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8f14b84fefd8669cbcbe4fee3f61a44be904993
Message-Id: <168527440253.32373.16399932767466547756.pr-tracker-bot@kernel.org>
Date:   Sun, 28 May 2023 11:46:42 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 May 2023 09:52:57 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2023-05-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8f14b84fefd8669cbcbe4fee3f61a44be904993

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
