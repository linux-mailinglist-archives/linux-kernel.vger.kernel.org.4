Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5575864BEF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiLMV4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiLMVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5D25E9F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:54:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94BB61746
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A519C43392;
        Tue, 13 Dec 2022 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968442;
        bh=RfrCutkX+aKF8HeG3Dzpm8Kdjml1XOsgRuEHvXaHJ2M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hwbes2MmcmKXUZ5oVksFodXzvtuKx6vV2mLRJYD9BZeNBnBFkKaSAgS6ahxzQsHKx
         cznQQzPRHtGapnR+2ACxnP5C0OtA/LbdpmRiuoFycKEbKjc6H1dEtY/jCseMWFkI5K
         RYBVNjhuzJ5kJWJrEeYlZFLpOuQHlTGeLkh4zf1VTL+QRPrtzO+ibDj/GSZJ05+Jt7
         MoQMrgMIzTV7FBBssEsFZ1jDJTBsJX60bXFzks2H1Ay8TEX6x4IISstiaChKwV2hRw
         5ksmB0cHU6wVRKdR+7mgka2suwXXWd5rsCJ0DpzBkRdoSD7440RFY0oDI9dOnTD1dd
         xk/NNOFik6CGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1869CC00445;
        Tue, 13 Dec 2022 21:54:02 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2212131449310.9000@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2212131449310.9000@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2212131449310.9000@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022121301
X-PR-Tracked-Commit-Id: f722052c990b6a67d0dc0a13862b32ddbf567b95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2043f9a37d163ef4f572992bec7cdcdf54d965de
Message-Id: <167096844209.13204.1194778283720130086.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:54:02 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 14:57:56 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022121301

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2043f9a37d163ef4f572992bec7cdcdf54d965de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
